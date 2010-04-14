class Facsimile

  Width = 1728
  Height = 2156

  #include ActiveSupport::Memoization

  class NoPhoneNumberFound < Exception; end
  class NoContentFound < Exception; end

  attr_reader :source_path
  attr_reader :frames
  attr_reader :mail

  def initialize(source_path)
    @source_path = source_path
    @frames = Magick::ImageList.new
    @mail = Mail.read source_path
    @tempfiles = []
  end

  def number
    n = mail.header['X-Original-To'].andand.to_s || mail.to.first
    if n.to_s =~ /^(\d{5,})/
      return $1
    else
      raise NoPhoneNumberFound, "could not find any phone number"
    end
  end
  
  #memoize :number

  def render

    if mail.multipart?

      mail.parts.each do |part|
        case part.content_type
        when %r'text/plain'
          add_frames text2tiff( part.decoded )
        when %r'opendocument\.text'
          add_frames oo2tiff( part.decoded )
        when %r'text/html'
          # FIXME ignore html, let's hope a plain text contained everything important
        else
          STDERR.puts "unsupported content type: #{part.content_type}"
        end
      end

    else

      unless mail.body.decoded.blank?
        text2tiff( mail.body.decoded ).each do |tiff|
          frames << tiff
        end
      end

    end

  end

  def write(path)
    render
    raise NoContentFound if frames.empty?
    path += '.tiff' unless path.ends_with?('.tiff')
    frames.write(path)
  end

  private

  def add_frames(tiffs=nil)
    return unless tiffs
    tiffs.each do |tiff|
      frames << tiff
    end
  end

  def text2tiff(text)
    pdf = text2pdf(text)
    pdf2tiff(pdf)
  end

  def pdf2tiff(source)
    dest = mktemp('tiff')
    command = returning ['gs'] do |gs|
      gs << '-dQUIET'
      gs << '-sDEVICE=tiffg3'
      gs << "-sPAPERSIZE=#{pagesize}"
      gs << '-r204x196'
      gs << '-dNOPAUSE'
      gs << "-sOutputFile=#{dest.path}"
      gs << '-c save pop'
      gs << '-c "<< /Policies << /PageSize 5 >> /PageSize [595 842] /InputAttributes << 0 << /PageSize [595 842] >> >> >> setpagedevice"'
      gs << "-f #{source}"
      gs << '-c quit'
    end.join(' ')
    system(command)
    read_frame dest.path
  end

  def oo2tiff(source_data)
    source = mktemp('oo', false)
    source.write source_data
    source.close

    dest = mktemp('pdf')
    system("unoconv -f pdf --stdout #{source.path} > #{dest.path}")
    pdf2tiff(dest.path)
  end

  def text2pdf(source)
    document = Prawn::Document.new(:page_size => pagesize.upcase)
    document.text source

    dest = mktemp('pdf')
    document.render_file dest.path
    
    dest.path
  end

  def new_frame
    tiff = Magick::Image.new(Width, Height) do
      self.background_color = 'white'
    end
    tiff
  end

  def read_frame(source)
    Magick::Image.read(source)
  end

  def mktemp(name,close=true)
    tmp = Tempfile.new(name)
    tmp.close if close
    tmp
  end

  def pagesize
    'a4'
  end


end

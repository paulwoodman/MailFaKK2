require 'spec_helper'

describe "text only" do
  before(:each) do
    @mail_path = mail_path('only_text')
    @fax = Facsimile.new @mail_path
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end

  it 'should render 1 frame from body' do
    @fax.write result_path('only_text')
    @fax.frames.should be_an(Magick::ImageList)
    @fax.should have(1).frame
  end

  it 'should add footer and header'
end

describe "text only as IO (like STDIN)" do
  before(:each) do
    @fax = Facsimile.new File.open( mail_path('only_text') )
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end

  it 'should provide id (even if no message_id in mail)' do
    @fax.id.should_not be_blank
  end

  it 'should provide filename' do
    @fax.filename.should =~ /.{10,}\.tiff/
  end

end

describe "multipart from word mail client" do
  before(:each) do
    @mail_path = mail_path('multipart')
    @fax = Facsimile.new @mail_path
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end

  it 'should render 1 frame from parts' do
    @fax.write result_path('multipart')
    @fax.frames.should be_an(Magick::ImageList)
    @fax.should have(1).frame
  end
end


describe "text with attached OpenOffice Writer Document (2 Pages)" do
  before(:each) do
    @mail_path = mail_path('oo_writer_attached')
    @fax = Facsimile.new @mail_path
  end

  it 'should produce 1+2 frames' do
    @fax.write result_path('oo_writer_attached')
    @fax.should have(3).frames
  end
  
end

describe "mail with word (2 pages) and excel attachment" do
  before(:each) do
    @mail_path = mail_path('word_and_excel')
    @fax = Facsimile.new @mail_path
  end

  it 'should produce 2+1 frames' do
    @fax.write result_path('word_and_excel')
    @fax.should have(3).frames
  end
  
end

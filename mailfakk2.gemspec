# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mailfakk2}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Niklas Hofer"]
  s.date = %q{2010-04-16}
  s.default_executable = %q{mailfakk2}
  s.description = %q{
      MailFaKK2 acts as a fax gateway. With the proper setup you can send
      an email to <number>@fax.local and it generates a multipage tiff and
      a callfile for asterisk
    }
  s.email = %q{niklas+mailfakk2@lanpartei.de}
  s.executables = ["mailfakk2"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "MIT-LICENSE",
     "Rakefile",
     "bin/mailfakk2",
     "config/env.rb",
     "config/forward",
     "config/procmail",
     "lib/configuration.rb",
     "lib/facsimile.rb",
     "lib/logging.rb",
     "lib/mailfakk2.rb"
  ]
  s.homepage = %q{http://github.com/niklas/MailFaKK2/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{email to fax gateway in ruby}
  s.test_files = [
    "spec/configuration_spec.rb",
     "spec/spec_helper.rb",
     "spec/mailfakk2_spec.rb",
     "spec/facsimile_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<andand>, [">= 1.3.1"])
      s.add_runtime_dependency(%q<mail>, [">= 2.2.0"])
      s.add_runtime_dependency(%q<prawn>, [">= 0.8.4"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<andand>, [">= 1.3.1"])
      s.add_dependency(%q<mail>, [">= 2.2.0"])
      s.add_dependency(%q<prawn>, [">= 0.8.4"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<andand>, [">= 1.3.1"])
    s.add_dependency(%q<mail>, [">= 2.2.0"])
    s.add_dependency(%q<prawn>, [">= 0.8.4"])
  end
end

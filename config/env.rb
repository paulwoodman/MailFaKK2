APP_ROOT   = File.join File.basename(__FILE__), '..'
require 'rubygems'
require 'active_support'
require 'fileutils'
require 'andand'
require 'mail'
require 'prawn'
require 'RMagick'
require 'tempfile'

require 'lib/facsimile'
require 'lib/configuration'
require 'lib/mailfakk2'

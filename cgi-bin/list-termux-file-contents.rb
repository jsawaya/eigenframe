#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

exit 10 if ARGV.length == 0

filepath = ARGV[0]
puts get_file_as_string(filepath)



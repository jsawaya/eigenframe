#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('filepath')

filepath = cgi.params['filepath'][0]
puts get_file_as_string(filepath)


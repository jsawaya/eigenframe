#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new

puts "gpg-import-key"

exit 10 if !cgi.has_key?('keyfile')
exit 11 if !cgi.has_key?('password')

keyfile = cgi.params['keyfile'][0]
password = cgi.params['password'][0]
puts gpg_import_private_key(keyfile, password)


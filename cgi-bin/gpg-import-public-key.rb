#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new

puts "gpg-import-key"

exit 10 if !cgi.has_key?('keyfile')

keyfile = cgi.params['keyfile'][0]

puts gpg_import_public_key(keyfile)


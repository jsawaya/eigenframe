#!/usr/bin/ruby -I/data/data/com.termux/files/usr/lib/cgi-bin/ruby-lib

require 'open3'
require 'cgi'
require 'json'
#require 'app-lib'
require './ruby-lib/app-lib.rb'

print_response_header

cgi = CGI.new

puts "gpg-import-key"

exit 10 if !cgi.has_key?('keyfile')

keyfile = cgi.params['keyfile'][0]

puts gpg_import_public_key(keyfile)


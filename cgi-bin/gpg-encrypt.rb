#!/usr/bin/ruby

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new

puts "gpg-encrypt"

exit 10 if !cgi.has_key?('keyid')
exit 11 if !cgi.has_key?('infile')
exit 12 if !cgi.has_key?('format')

keyid = cgi.params['keyid'][0].split
infile = cgi.params['infile'][0]
format = cgi.params['format'][0] 

puts gpg_encrypt(keyid, infile, format)

#!/usr/bin/ruby

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('password')
exit 11 if !cgi.has_key?('keyfile')

password = cgi.params['password'][0]
keyfile = cgi.params['keyfile'][0]
outfile = cgi.params['outfile'][0]
  
puts gpg_decrypt(password, keyfile, outfile)

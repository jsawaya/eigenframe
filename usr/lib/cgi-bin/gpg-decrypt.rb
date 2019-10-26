#!/usr/bin/ruby -I/data/data/com.termux/files/usr/lib/cgi-bin/ruby-lib

require 'open3'
require 'cgi'
require 'json'
#require 'app-lib'
require './ruby-lib/app-lib.rb'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('password')
exit 11 if !cgi.has_key?('keyfile')

password = cgi.params['password'][0]
keyfile = cgi.params['keyfile'][0]
outfile = cgi.params['outfile'][0]
  
puts gpg_decrypt(password, keyfile, outfile)

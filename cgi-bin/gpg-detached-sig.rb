#!/usr/bin/ruby

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new
h = Hash.new("null")

exit 10 if !cgi.has_key?('keyid')
exit 11 if !cgi.has_key?('password')
exit 12 if !cgi.has_key?('keyfile')

keyid = cgi.params['keyid'][0]
password = cgi.params['password'][0]
keyfile = cgi.params['keyfile'][0]

puts gpg_sign_detached(keyid, password, keyfile)


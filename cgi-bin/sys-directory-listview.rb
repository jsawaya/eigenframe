#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('keyfile')

keyfile = cgi.params['keyfile'][0]
Dir.chdir keyfile

#h = directory_hash()

eigen_listview()


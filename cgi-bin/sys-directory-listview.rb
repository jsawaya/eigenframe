#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('keyfile')
dirpath = cgi.params['dirpath'][0]
eigen_directory_listview(dirpath)


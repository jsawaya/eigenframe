#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('dirpath')
dirpath = cgi.params['dirpath'][0]

## this produces json text which is returned by the url request (back to EigenFrame App)

puts EigenFrame.new().eigen_directory_listview_http_cgi(dirpath).to_json.to_s

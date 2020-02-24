#!/usr/bin/ruby

require 'cgi'
require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

p cgi.params.inspect

puts "testing"

#exit 10 if !cgi.has_key?('dirpath')
#dirpath = cgi.params['dirpath'][0]

#cmd = "puts EigenFrame.new.eigen_directory_listview_http_cgi(dirpath).to_json.to_s"

#eval(cmd)

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

eigenframe = EigenFrame.new()

listdir_url = "http://localhost:8080/cgi-bin/sys-directory-listview.rb"
list_contents_url = "http://localhost:8080/cgi-bin/sys-list-termux-file-contents.rb"

puts eigenframe.eigen_directory_listview(dirpath, listdir_url, list_contents_url).to_json.to_s

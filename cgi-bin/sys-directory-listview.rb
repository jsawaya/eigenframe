#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('keyfile')
dir_path = cgi.params['keyfile'][0]

eigen_directory_listview(dir_path)

#Dir.chdir dirfile
#h = directory_hash()
#eigen_listview_files(h)


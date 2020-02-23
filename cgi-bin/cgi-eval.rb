#!/usr/bin/ruby

require 'cgi'
require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('cmd')
cmd = cgi.params['cmd'][0]

#cmd = "EigenFrame.new.eigen_directory_listview_http_cgi('.').to_json.to_s"

puts eval(cmd)

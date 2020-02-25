#!/usr/bin/ruby

require 'cgi'
require 'json'

require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

puts cgi.params.to_json.to_s


cgi.keys.each do |key|
  puts 'key: '+key
  value_list = cgi.params[key]
  value_list.each do |value|
    puts 'value: '+value
  end
#   fields = line.split
#   keys << fields[-1].strip if fields.size == 4
 end
 
 
#exit 10 if !cgi.has_key?('dirpath')
#dirpath = cgi.params['dirpath'][0]

#cmd = "puts EigenFrame.new.eigen_directory_listview_http_cgi(dirpath).to_json.to_s"

#eval(cmd)

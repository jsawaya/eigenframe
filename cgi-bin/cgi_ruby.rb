#!/usr/bin/ruby

require 'cgi'
require 'json'

require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

#ruby = "EigenFrame.new(cgi.params).eigen_directory_listview_http_cgi('dirpath').to_json.to_s"
if cgi.has_key?('ruby')
  puts eval(ruby)
else
  cgi.keys.each do |key|
    puts 'key: '+key
    value_list = cgi.params[key]
    value_list.each do |value|
      puts '  value: '+value
    end
   end
end
#!/usr/bin/ruby

require 'cgi'
require 'json'

require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

print_response_header

cgi = CGI.new

if cgi.has_key?('ruby')
  ruby_string = cgi.params['ruby'][0]
  puts eval(ruby_string)
else
  cgi.keys.each do |key|
    puts 'key: '+key
    value_list = cgi.params[key]
    value_list.each do |value|
      puts '  value: '+value
    end
  end
end

#ruby = "EigenFrame.new(cgi.params).eigen_directory_listview_http_cgi(dirpath).to_json.to_s"

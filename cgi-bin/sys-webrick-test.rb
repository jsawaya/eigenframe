#!/usr/bin/env ruby

require 'json'
require '/data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/ruby-lib/app-lib'
require '/data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/ruby-lib/eigen-lib'

puts "called /directory"

dirpath = "/data/data/com.termux/files/home"

#puts EigenFrame.new().eigen_directory_listview_http_cgi(dirpath).to_json.to_s

p EigenFrame.new().eigen_directory_listview_http_ruby(dirpath).to_json


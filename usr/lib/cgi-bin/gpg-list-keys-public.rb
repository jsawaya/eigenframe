#!/usr/bin/ruby -I/data/data/com.termux/files/usr/lib/cgi-bin/ruby-lib

require 'open3'
require 'cgi'
require 'json'
#require 'app-lib'
require './ruby-lib/app-lib.rb'

print_response_header

cgi = CGI.new
h = gpg_list_public_keys()
frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)


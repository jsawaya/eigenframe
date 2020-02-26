#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new
h = gpg_list_public_keys()
frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)


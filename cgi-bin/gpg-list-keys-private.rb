#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new
h = gpg_list_private_keys()
#output_frame_format(cgi, h)
frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)

#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/gpg-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('keyfile')

keyfile = cgi.params['keyfile'][0].split

h = gpg_verify(keyfile)

frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)


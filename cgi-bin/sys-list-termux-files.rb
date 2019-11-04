#!/usr/bin/ruby

require 'cgi'
require 'json'
require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('dirpath')

dirpath = cgi.params['dirpath'][0]
Dir.chdir dirpath

h = directory_hash()

if cgi.has_key?('frame')
  frame = cgi.params['frame'][0]
else
  frame = ""
end

if cgi.has_key?('format')
  format = cgi.params['format'][0]
else
  format = ""
end

sys_output_frame_format(h, frame, format)


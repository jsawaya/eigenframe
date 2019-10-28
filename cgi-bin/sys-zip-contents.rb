#!/usr/bin/ruby

require './ruby-lib/app-lib'

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('zip_path')

zip_path = cgi.params['zip_path'][0]

exit 11 if !File.exist?(zip_path) || !File.directory?(zip_path)

exit 12 if !cgi.has_key?('zip_name')

zip_name = cgi.params['zip_name'][0]

zip_file = "#{zip_path}/#{zip_name}"

exit 13 if !File.exist?(zip_file)

h = zip_contents(zip_file)

frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)









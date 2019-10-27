#!/usr/bin/ruby -I/usr/lib/cgi-bin/ruby-lib
#!/usr/bin/ruby -I/data/data/com.termux/files/usr/lib/cgi-bin/ruby-lib

require 'cgi'
require 'json'
require 'app-lib'
#require "/usr/lib/cgi-bin/ruby-lib/app-lib.rb"

#puts "Content-type: text/plain; charset=iso-8859-1"
#puts ""

print_response_header

cgi = CGI.new

exit 10 if !cgi.has_key?('keyfile')

keyfile = cgi.params['keyfile'][0]

Dir.chdir keyfile

h = directory_hash()

frame = cgi.params['frame'][0] if cgi.has_key?('frame')
format = cgi.params['format'][0] if cgi.has_key?('format')
sys_output_frame_format(h, frame, format)


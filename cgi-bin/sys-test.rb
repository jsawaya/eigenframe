#!/usr/bin/ruby

puts "Content-type: text/plain; charset=iso-8859-1"
puts ""

#puts ENV['PATH']
#puts ENV['QUERY_STRING']

puts "Environment Variable Hashmap:"
ENV.each_pair do |k,v|
    puts "key: #{k}, val: #{v}" 
end


#echo "Content-type: text/plain; charset=iso-8859-1"
#echo

#echo CGI/1.0 test scriptx:
#echo

#echo argc is $#. argv is "$*".
#echo

#echo SERVER_SOFTWARE = $SERVER_SOFTWARE
#echo SERVER_NAME = $SERVER_NAME
#echo GATEWAY_INTERFACE = $GATEWAY_INTERFACE
#echo SERVER_PROTOCOL = $SERVER_PROTOCOL
#echo SERVER_PORT = $SERVER_PORT
#echo REQUEST_METHOD = $REQUEST_METHOD
#echo HTTP_ACCEPT = "$HTTP_ACCEPT"
#echo PATH_INFO = "$PATH_INFO"
#echo PATH_TRANSLATED = "$PATH_TRANSLATED"
#echo SCRIPT_NAME = "$SCRIPT_NAME"
#echo QUERY_STRING = "$QUERY_STRING"
#echo REMOTE_HOST = $REMOTE_HOST
#echo REMOTE_ADDR = $REMOTE_ADDR
#echo REMOTE_USER = $REMOTE_USER
#echo AUTH_TYPE = $AUTH_TYPE
#echo CONTENT_TYPE = $CONTENT_TYPE
#echo CONTENT_LENGTH = $CONTENT_LENGTH

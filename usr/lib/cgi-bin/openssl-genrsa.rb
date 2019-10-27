#!/usr/bin/ruby -I/data/data/com.termux/files/usr/lib/cgi-bin/ruby-lib

require 'open3'
require 'cgi'
require 'json'
#require 'app-lib'
require './ruby-lib/app-lib.rb'

print_response_header

bitcount = 512
puts openssl_genrsa(bitcount)

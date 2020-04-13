#!/usr/bin/ruby 

require 'open3'
require 'cgi'
require 'json'
require_relative 'ruby-lib/app-lib'

print_response_header

bitcount = 512
puts openssl_genrsa(bitcount)

#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyfile = ARGV[0]

puts gpg_list_packets_hash(keyfile).to_json.to_s

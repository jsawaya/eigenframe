#!/usr/bin/ruby

require 'json'
require 'open3'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'
require_relative 'ruby-lib/eigen-lib'
require_relative 'ruby-lib/swipl-lib'

exit 10 if ARGV.length == 0
ruby_string = ARGV[0]

puts eval(ruby_string)

# Example:
#  {
#    "type": "SecureShell",
#    "is_eigen_response": true,
#    "ssh": "cd /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin; ruby ssh_ruby.rb 'p 1+2' "
#    ]
#  }

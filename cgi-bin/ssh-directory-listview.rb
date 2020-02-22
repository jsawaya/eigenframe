require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/eigen-lib'

# first arg is the path, default is home dir
if ARGV.length == 0
#  dirpath = "/data/data/com.termux/files/home"
  dirpath = "/home/photopgp"
else
  dirpath = ARGV[0]
end

puts EigenFrame.new().eigen_directory_listview_ssh(dirpath).to_json.to_s


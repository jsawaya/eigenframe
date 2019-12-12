require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/eigen-lib'

# first arg is the path, default is home dir
if ARGV.length == 0
  dirpath = "/data/data/com.termux/files/home"
else
  dirpath = ARGV[0]
end

listdir_url = "http://localhost:1234/listdir"
list_contents_url = "http://localhost:1234/list_contents"

#result = EigenFrame.new().eigen_directory_listview(dirpath, listdir_url, list_contents_url).to_json.to_s
result = EigenFrame.new().eigen_directory_listview_ssh(dirpath).to_json.to_s

puts result


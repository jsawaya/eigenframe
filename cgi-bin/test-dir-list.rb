require 'cgi'
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/eigen-lib'

dirpath = "/data/data/com.termux/files/home"

eigenframe = EigenFrame.new()
jj eigenframe.eigen_directory_listview(dirpath)


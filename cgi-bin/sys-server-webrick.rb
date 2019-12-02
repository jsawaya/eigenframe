require 'webrick'

root = File.expand_path '~/public_html'
server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

server.mount_proc '/' do |req, res|
  res.body = 'Hello, World!'
end

trap 'INT' do server.shutdown end

server.start
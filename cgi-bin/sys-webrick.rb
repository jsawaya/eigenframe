#!/usr/bin/env ruby

require 'logger'
require 'webrick'
require 'json'
require '/data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/ruby-lib/app-lib'
require '/data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/ruby-lib/eigen-lib'

=begin
    WEBrick is a Ruby library that makes it easy to build an HTTP server with Ruby.
    It comes with most installations of Ruby by default (it’s part of the standard library),
    so you can usually create a basic web/HTTP server with only several lines of code.

    The following code creates a generic WEBrick server on the local machine on port 1234,
    shuts the server down if the process is interrupted (often done with Ctrl+C).
=end

logger1 = Logger.new('ruby-webrick.log', 'daily')
logger1.level = :info

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
        @logger1.debug(request.to_s)
        @logger1.debug(response.to_s)

        if request.path == "/exit"
            @server.shutdown
            exit 10

        elsif request.path == "/test"

            #response['Cache-Control'] = "No-Cache, No-Store"
            response.status = 200
            response.content_type = "text/plain"
            response.body = "Hello World: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"

        elsif request.path == "/list_contents"

            filepath = request.query["filepath"]

            #filetype = request.query["filetype"]

            response.status = 200
            response.content_type = "text/plain"
            response.body = get_file_as_string(filepath)

        else
            response.status = 200
            response.body = "You did not provide the correct parameters"
        end
    end
end

server = WEBrick::HTTPServer.new(:Port => 1234)

server.mount "/", MyServlet

trap("INT") {
    server.shutdown
    logger1.close
}

server.start
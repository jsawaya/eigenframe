#!/usr/bin/env ruby

#require 'logger'
require 'webrick'
require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/eigen-lib'

=begin
    WEBrick is a Ruby library that makes it easy to build an HTTP server with Ruby.
    It comes with most installations of Ruby by default (it’s part of the standard library),
    so you can usually create a basic web/HTTP server with only several lines of code.

    The following code creates a generic WEBrick server on the local machine on port 1234,
    shuts the server down if the process is interrupted (often done with Ctrl+C).
=end

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)

#        puts ""
#        puts "Request:"
#        p request

#        puts ""
#        puts "Response:"
#        p response

#        @logger.info(request.to_s)
#        @logger.info(response.to_s)

        if request.path == "/exit"
            @server.shutdown
            exit 10

        elsif request.path == "/test"

            #response['Cache-Control'] = "No-Cache, No-Store"
            response.status = 200
            response.content_type = "text/plain"
            response.body = "Hello World: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"

            @logger.info(response.body)
            p response.body

        elsif request.path == "/list_contents"

            filepath = request.query["filepath"]
            #filetype = request.query["filetype"]

            response.status = 200
            response.content_type = "text/plain"
            response.body = get_file_as_string(filepath)

        elsif request.path == "/directory"
            @logger.info("/directory")

            response.status = 200
            response.content_type = "text/plain"

            dirpath = request.query["dirpath"]
            @logger.info(dirpath)

            #response.body = dirpath
            response.body = EigenFrame.new().eigen_directory_listview_ssh(dirpath).to_json.to_s


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
}

server.start
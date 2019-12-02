#!/usr/bin/env ruby

require "webrick"
require 'json'
require './ruby-lib/app-lib'
require './ruby-lib/eigen-lib'

=begin
    WEBrick is a Ruby library that makes it easy to build an HTTP server with Ruby.
    It comes with most installations of Ruby by default (it’s part of the standard library),
    so you can usually create a basic web/HTTP server with only several lines of code.

    The following code creates a generic WEBrick server on the local machine on port 1234,
    shuts the server down if the process is interrupted (often done with Ctrl+C).
    This example lets you call the URL's: "add" and "subtract" and pass through arguments to them
    Example usage:
        http://localhost:1234/ (this will show the specified error message)
        http://localhost:1234/add?a=10&b=10
        http://localhost:1234/subtract?a=10&b=9
=end

class MyNormalClass
    def self.add (a, b)
        a.to_i + b.to_i
    end

    def self.subtract (a, b)
        a.to_i - b.to_i
    end
end

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
#        puts "request:"
#        p request

        if request.path == "/exit"
            server.shutdown

        elsif request.path == "/listdir"
            puts "called /listdir"

            dirpath = request.query["dirpath"]
            puts "dirpath:"
            p dirpath

            response.status = 200
            response.content_type = "text/plain"

            if dirpath.empty?
                dirpath = "/data/data/com.termux/files/home"
            end

            eigenframe = EigenFrame.new()
            result = jj eigenframe.eigen_directory_listview(dirpath)
            puts "result:"
            p result
            response.body = result.to_s + "\n"


        elsif request.query["a"] && request.query["b"]
            a = request.query["a"]
            b = request.query["b"]
            response.status = 200
            response.content_type = "text/plain"

            result = nil
            case request.path
                when "/add"
                    result = MyNormalClass.add(a, b)
                when "/subtract"
                    result = MyNormalClass.subtract(a, b)
                else
                    result = "No such method"
            end
            
            response.body = result.to_s + "\n"

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
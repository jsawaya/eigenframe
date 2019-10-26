#!/usr/bin/ruby
puts "Content-type: text/plain; charset=iso-8859-1", nil

require 'open3'

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")
  return get_io_as_string(f)
end

def get_io_as_string(io)
  data = ''
  io.each_line do |line|
    data += line
  end
  return data
end
    
swipl_path = "swipl-lib/routes.pl"
puts "prolog script: ", swipl_path, nil

puts "prolog:", get_file_as_string(swipl_path), nil

goal = ENV['QUERY_STRING']
puts "goal:", goal, nil

cmd = "/data/data/com.termux/files/usr/bin/swipl -s #{swipl_path} -g \"#{goal}\" -t halt"
#puts "command:", cmd, nil
#system(c)
stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

exit_code = wait_thread.value
puts "exit_code: ", exit_code, nil

puts "stdout: ", get_io_as_string(stdout), nil

puts "stderr: ", get_io_as_string(stderr), nil

stdout.close
stderr.close

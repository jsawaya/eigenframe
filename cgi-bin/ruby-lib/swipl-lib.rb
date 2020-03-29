require 'open3'
require 'json'

#/cgi-bin/swi-routes.rb?route(nottinghill_gate,maida_vale,X)
def swipl_test(swipl_path, swipl_goal)

  #swipl_path = "swipl-lib/routes.pl"
  puts "swipl_path: ", swipl_path, nil

  #swipl_goal = "route(nottinghill_gate,maida_vale,F)"
  puts "swipl_goal:", swipl_goal, nil

	cmd = "/data/data/com.termux/files/usr/bin/swipl -s #{swipl_path} -g \"#{swipl_goal}\" -t halt"

#  if outfile.to_s.strip.size > 0
#    cmd = cmd << " > #{outfile}"
#  end

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
#  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "swipl_test",
    swipl_path: swipl_path,
    swipl_goal: swipl_goal,
    kbfile: kbfile,
    outfile: outfile,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }

end


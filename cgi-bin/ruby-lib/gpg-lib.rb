require 'open3'
require 'json'


def gpg_list_public_keys()
  h = Hash.new("null")

  cmd = "/data/data/com.termux/files/usr/bin/gpg -k --keyid-format long -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  h["command"] = cmd

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_string_array = get_io_as_array(stdout)
  stdout_string_array_selected = stdout_string_array.select { |line| line =~ /^pub/ }

  keys = []
  stdout_string_array_selected.each do |line|
    /\/\S+/.match( line) do |matchdata|
      keys << matchdata.to_s[1..-1]
    end
  end
  h["keys"] = keys

  stderr_str = get_io_as_array(stderr)
  h["status"] = stderr_str + stdout_string_array

  stdout.close
  stderr.close

  h
end


def gpg_list_private_keys()
  h = Hash.new("null")

  cmd = "/data/data/com.termux/files/usr/bin/gpg --list-secret-keys --keyid-format long -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  h["command"] = cmd

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_string_array = get_io_as_array(stdout)
  #  stdout_string_array_selected = stdout_string_array.select { |line| line =~ /^sec|^ssb/ }
  stdout_string_array_selected = stdout_string_array.select { |line| line =~ /^sec/ }

  keys = []
  stdout_string_array_selected.each do |line|
    /\/\S+/.match(line) do |matchdata|
      keys << matchdata.to_s[1..-1]
    end
  end
  h["keys"] = keys

  stderr_str = get_io_as_array(stderr)
  h["status"] = stderr_str + stdout_string_array

  stdout.close
  stderr.close

  h
end


def gpg_list_packets_hash(keyfile)
  h = Hash.new("null")
  h["type"] = "gpg-list-packets"
  h["keyfile"] = keyfile

  if keyfile.empty?
    h["exit_code"] = -99
    h["status"] = "missing parameter: keyfile"

  elsif !File.exists? keyfile
    h["exit_code"] = -9
    h["status"] = "keyfile does not exist"

  elsif File.directory? keyfile
    h["exit_code"] = -9
    h["status"] = "keyfile is a directory"

  else
    dirname = File.dirname keyfile
    h["dirname"] = dirname

    basename = File.basename keyfile
    h["filename"] = basename

    gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

    cmd = "#{gpg} --no-tty --batch --list-packets #{keyfile}"
    h["command"] = cmd

    stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

    exit_status = wait_thread.value
    exit_code = exit_status.exitstatus
    h["exit_code"] = exit_code

    stdout_stringarray = get_io_as_array(stdout)
    h["stdout"] = stdout_stringarray

    stderr_stringarray = get_io_as_array(stderr)
    h["status"] = stderr_stringarray

    selected = stderr_stringarray.select { |line| line =~ /^gpg: public key is/ }
    keys = []
    selected.each do |line|
      keys << line[18..-1].strip
    end
    h["keys"] = keys


  end

  stdout.close
  stderr.close

  h
end


def gpg_decrypt(password, keyfile, outfile)
  #  puts "gpg_decrypt running..."
  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  #  puts "command: #{gpg}"

  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"
  cmd = "#{gpg_sec} --decrypt #{keyfile}"
  #  puts "command: #{cmd}"

  if outfile.to_s.strip.size > 0
    cmd = cmd << " > #{outfile}"
  end

  #  puts "command: #{cmd}"

  h["command"] = cmd

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  #  puts "exit_code: #{exit_code}"
  h["exit_code"] = exit_code

  stdout_stringarray = get_io_as_array(stdout)
  #  puts "stdout_stringarray: #{stdout_stringarray}"
  h["stdout"] = stdout_stringarray

  stderr_stringarray = get_io_as_array(stderr)
  #  puts "stderr_stringarray: #{stderr_stringarray}"
  h["stderr"] = stderr_stringarray

  stdout.close
  stderr.close

  #h.to_json
  jj h

end


def gpg_import_private_key(keyfile, password)
  puts "calling gpg_import_private_key..."

  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  #  puts "command: #{gpg}"

  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"
  cmd = "#{gpg_sec} --import #{keyfile}"
  #  puts "command: #{cmd}"

  h["command"] = cmd

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_stringarray = get_io_as_array(stdout)
  h["stdout"] = stdout_stringarray

  stderr_stringarray = get_io_as_array(stderr)
  h["status"] = stderr_stringarray

  stdout.close
  stderr.close

  h
end


def gpg_import_public_key(keyfile)
  puts "calling gpg_import_public_key..."

  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  p gpg

  cmd = "#{gpg} --import #{keyfile}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_stringarray = get_io_as_array(stdout)
  h["stdout"] = stdout_stringarray

  stderr_stringarray = get_io_as_array(stderr)
  h["status"] = stderr_stringarray

  stdout.close
  stderr.close

  h
end


def gpg_export_public_key(keyid)
  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  cmd = "#{gpg} --armor --export #{keyid}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_stringarray = get_io_as_array(stdout)
  h["stdout"] = stdout_stringarray

  stderr_stringarray = get_io_as_array(stderr)
  h["status"] = stderr_stringarray

  stdout.close
  stderr.close

  h
end


def gpg_export_private_key(keyid, password)
  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"
  cmd = "#{gpg_sec} --armor --export-secret-keys #{keyid}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus
  h["exit_code"] = exit_code

  stdout_stringarray = get_io_as_array(stdout)
  h["stdout"] = stdout_stringarray

  stderr_stringarray = get_io_as_array(stderr)
  h["stderr"] = stderr_stringarray

  stdout.close
  stderr.close

  h
end


#" --recipient "
def array_to_string(prefix, keyid)
  recipients = ""
  keyid.each {|x| recipients << "#{prefix}#{x}" }
end


## encrypt unsigned, with default output name
def gpg_encrypt(keyid, in_file, format)

  p keyid
  keyidArray = keyid.split
  recipient = " --recipient "
  recipients = recipient + keyidArray.join(recipient)
  p recipients

  p in_file
  p format

  if (format == "asc")
    isarmor = "-a"
    output_filename = "#{in_file}.asc"
  else
    isarmor = ""
    output_filename = "#{in_file}.pgp"
  end

  puts "\n"
  puts "isarmor: "+isarmor
  puts "output_filename: "+output_filename

  #File.delete output_filename if File.exists? output_filename

  cmd = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/ #{recipients} #{isarmor} --no-tty --always-trust -o #{output_filename} --encrypt #{in_file}"

  p cmd

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  puts exit_status
  puts exit_code

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_encrypt",
    recipients: keyid,
    input_filename: in_file,
    output_filename: output_filename,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
  
end


def gpg_sign_detached(keyid, password, in_file)
  cmd = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/ --pinentry-mode loopback --batch --yes --passphrase-fd 0 --local-user #{keyid} --detach-sig #{in_file}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    status: stderr_stringarray
  }
end


def gpg_verify(keyfile)

  filepaths = array_to_string(" ", keyfile)

  cmd = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/  --verify #{filepaths}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    status: stderr_stringarray
  }
end

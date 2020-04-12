require 'open3'
require 'json'


def gpg_list_public_keys()
  cmd = "/data/data/com.termux/files/usr/bin/gpg -k --keyid-format long -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stdout_stringarray_selected = stdout_stringarray.select { |line| line =~ /^pub/ }

  keys = []
  stdout_stringarray_selected.each do |line|
    /\/\S+/.match( line) do |matchdata|
      keys << matchdata.to_s[1..-1]
    end
  end

  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_list_public_keys",
    keys: keys,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_list_private_keys()
  cmd = "/data/data/com.termux/files/usr/bin/gpg --list-secret-keys --keyid-format long -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stdout_stringarray_selected = stdout_stringarray.select { |line| line =~ /^sec/ }

  keys = []
  stdout_stringarray_selected.each do |line|
    /\/\S+/.match(line) do |matchdata|
      keys << matchdata.to_s[1..-1]
    end
  end

  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_list_private_keys",
    keys: keys,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_list_packets_hash(keyfile)
  dirname = File.dirname keyfile
  basename = File.basename keyfile
  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  cmd = "#{gpg} --no-tty --batch --list-packets #{keyfile}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)
  
  selected = stderr_stringarray.select { |line| line =~ /^gpg: public key is/ }
  keys = []
  selected.each do |line|
    keys << line[18..-1].strip
  end

  stdout.close
  stderr.close

  {
    type: "gpg_list_packets_hash",
    keyfile: keyfile,
    dirname: dirname,
    filename: basename,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_decrypt(password, keyfile, outfile)
  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"

  cmd = "#{gpg_sec} --decrypt #{keyfile}"

  if outfile.to_s.strip.size > 0
    cmd = cmd << " > #{outfile}"
  end

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  if password.to_s.strip.size > 0
    stdin.puts password
  end

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_decrypt",
    keyfile: keyfile,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_import_private_key(keyfile, password)
  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"
  cmd = "#{gpg_sec} --import #{keyfile}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_import_private_key",
    keyfile: keyfile,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_import_public_key(keyfile)
  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  cmd = "#{gpg} --import #{keyfile}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)

  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_import_public_key",
    keyfile: keyfile,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_export_public_key(keyid)

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  cmd = "#{gpg} --armor --export #{keyid}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)

  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_export_public_key",
    recipients: keyid,
    input_filename: in_file,
    output_filename: output_filename,
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_export_private_key(keyid, password)
  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"
  cmd = "#{gpg_sec} --armor --export-secret-keys #{keyid}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)
  stdin.puts password

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)

  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_export_private_key",
    command: cmd,
    keyid: keyid,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


## encrypt unsigned, with default output name
def gpg_encrypt(keyid, in_file, fmt)

  keyidArray = keyid.split
  recipient = " --recipient "
  recipients = recipient + keyidArray.join(recipient)

  if (fmt == "asc")
    isarmor = "-a"
    output_filename = "#{in_file}.asc"
  else
    isarmor = ""
    output_filename = "#{in_file}.pgp"
  end

  File.delete output_filename if File.exists? output_filename

  cmd = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/ #{recipients} #{isarmor} --no-tty --always-trust -o #{output_filename} --encrypt #{in_file}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_encrypt",
    recipients: keyid,
    input_filename: in_file,
    fomat: fmt,
    command: cmd,
    output_filename: output_filename,
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
    type: "gpg_sign_detached",
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end


def gpg_verify(sig_file, original_file)

  cmd = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/  --verify #{sig_file} #{original_file}"

  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

  exit_status = wait_thread.value
  exit_code = exit_status.exitstatus

  stdout_stringarray = get_io_as_array(stdout)
  stderr_stringarray = get_io_as_array(stderr)

  stdout.close
  stderr.close

  {
    type: "gpg_verify",
    command: cmd,
    exit_code: exit_code,
    stdout: stdout_stringarray,
    stderr: stderr_stringarray
  }
end

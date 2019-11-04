require 'open3'
require 'cgi'
require 'json'


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


def get_io_as_array(io)
  data = []
  io.each_line do |line|
    data << line
  end
  return data
end


def response_header_text_plain_iso8859
  "Content-type: text/plain; charset=iso-8859-1\n\n"
end


def print_response_header
  print response_header_text_plain_iso8859
end


def sys_output_frame_format(h, frame, format)
  if frame == nil || frame.empty?
    if format == "txt"
      puts h
    elsif format == "json"
      #puts h.to_json
      jj h
    else #ruby
      p h
    end
    
  else
    if format == "txt"
      puts h["#{frame}"]
    elsif format == "json"
      #puts h["#{frame}"].to_json
      jj h["#{frame}"]
    else #ruby
      p h["#{frame}"]
    end

  end
end


def directory_hash()
  files = Dir.entries "."
  pwd = Dir.pwd
  subdir = []
  files.each {|x| subdir << x if File.directory? x }
  files = files - subdir
  h = Hash.new("null")
  h["type"] = "directory"
  h["directory"] = pwd
  h["files"] = files.sort!
  h["subdir"] = subdir.sort!
  h
end


def eigen_directory_listview(dirpath)
  Dir.chdir dirpath
  h = directory_hash()

  # declare frames

  padding = Hash.new("null")
  margin = Hash.new("null")
  infoLeftIcon = Hash.new("null")
  headerTextView = Hash.new("null")

#  parentButton = Hash.new("null")
#  parentButtonScript = Hash.new("null")

  subdirListViewEigenFrame = Hash.new("null")
  subdirListViewOnClickEigenScreen = Hash.new("null")
  subdirListViewOnClickJavaScript = Hash.new("null")
  filesListViewEigenFrame = Hash.new("null")
  filesListViewOnClickJavaScript = Hash.new("null")
  eigenScreenLayout = Hash.new("null")
  horzLine = Hash.new("null")
  filesListView = Hash.new("null")
  subdirListView = Hash.new("null")

  # define frames

  padding["left"] = 40
  padding["top"] = 40
  padding["right"] = 40
  padding["bottom"] = 40

  margin["left"] = 10
  margin["top"] = 10
  margin["right"] = 10
  margin["bottom"] = 10


  infoLeftIcon["name"] = "info.jpg"
  infoLeftIcon["location"] = "left"

  headerTextView["type"] = "TextView"
  headerTextView["layout-width"] = "wrap_content"
  headerTextView["layout-height"] = "wrap_content"
  headerTextView["text-size"] = "30"
  headerTextView["text-color"] = "#ffffff"
  headerTextView["text"] = "Directory: #{h['directory']}"
  headerTextView["padding"] = padding
  headerTextView["margin"] = margin

=begin
  parentButton["type"] = "Button"
  parentButton["layout-width"] = "wrap_content"
  parentButton["layout-height"] = "wrap_content"
  parentButton["text"] = "Directory: #{h['directory']}"
  parentButton["text-size"] = "30"
  parentButton["text-color"] = "#ffffff"
  parentButton["background-color"] = "#000000"
  parentButton["gravity"] = "CENTER_HORIZONTAL, CENTER_VERTICAL"
  parentButton["on-click"] = parentButtonScript

  parent_path = File.expand_path("..", Dir.pwd)

  parentButtonScript["type"] = "EigenScreen"
  parentButtonScript["layout-width"] = "match_parent"
  parentButtonScript["layout-height"] = "wrap_content"
  parentButtonScript["text"] = "EigenScreen"
  parentButtonScript["text-size"] = "30"
  parentButtonScript["text-color"] = "#ffffff"
  parentButtonScript["background-color"] = "#111111"
  parentButtonScript["icon"] = infoLeftIcon
  parentButtonScript["url-script-list"] =
  [
    "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{parent_path}"
  ],

=end

  horzLine["type"] = "HorizontalLine"
  horzLine["size"] = 2
  horzLine["color"] = "#00ff00"

  filesListView["type"] = "ListView"
  filesListView["id"] = 700
  filesListView["layout-width"] = "match_parent"
  filesListView["layout-height"] = "wrap_content"
  filesListView["background-color"] = "#123456"
  filesListView["key-list"] = h["files"]
  filesListView["on-click"] = filesListViewOnClickJavaScript
  filesListView["eigen-frame"] = filesListViewEigenFrame

  filesListViewOnClickJavaScript["type"] = "JavaScript"
  filesListViewOnClickJavaScript["script-list"] =
    [
      "var pos = eigenFragment.getMapValueInteger(eigenMap, 'position', 0)",
      "var opt = eigenMap.get('option')",
      "eigenActivity.showToast('ListView file selected: '+ pos + ' - ' + opt)"
    ]

  filesListViewEigenFrame["type"] = "TextView"
  filesListViewEigenFrame["text-script-list"] =
    [
      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ' -> ' + eigenMap.get('metadata')"
    ]
  filesListViewEigenFrame["text-size"] = "30"
  filesListViewEigenFrame["text-color"] = "#ffffff"
  filesListViewEigenFrame["layout-width"] = "wrap_content"
  filesListViewEigenFrame["layout-height"] = "wrap_content"
  filesListViewEigenFrame["padding"] = padding
  filesListViewEigenFrame["margin"] = margin


  subdirListView["type"] = "ListView"
  subdirListView["id"] = 1700
  subdirListView["layout-width"] = "match_parent"
  subdirListView["layout-height"] = "wrap_content"
  subdirListView["background-color"] = "#000000"
  subdirListView["key-list"] = h["subdir"]

  subdirListViewOnClickJavaScript["type"] = "JavaScript"
  subdirListViewOnClickJavaScript["script-list"] =
    [
      "var pos = eigenFragment.getMapValueInteger(eigenMap, 'position', 0)",
      "var opt = eigenMap.get('option')",
      "eigenActivity.showToast('ListView subdir selected: '+ pos + ' - ' + opt)"
    ]
  #subdirListView["on-click"] = subdirListViewOnClickJavaScript


  subdirListViewOnClickEigenScreen["type"] = "EigenScreen"
  subdirListViewOnClickEigenScreen["layout-width"] = "match_parent"
  subdirListViewOnClickEigenScreen["layout-height"] = "wrap_content"
  subdirListViewOnClickEigenScreen["text"] = "subdirListViewOnClickEigenScreen"
  subdirListViewOnClickEigenScreen["text-size"] = "30"
  subdirListViewOnClickEigenScreen["text-color"] = "#ffffff"
  subdirListViewOnClickEigenScreen["background-color"] = "#111111"
  subdirListViewOnClickEigenScreen["url-script-list"] =
    [
      "'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"
    ]
  subdirListViewOnClickEigenScreen["icon"] = infoLeftIcon
  subdirListView["on-click"] = subdirListViewOnClickEigenScreen


  subdirListViewEigenFrame["type"] = "TextView"
  subdirListViewEigenFrame["text-script-list"] =
    [
      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ' - ' + eigenMap.get('metadata')"
    ]
  subdirListViewEigenFrame["text-size"] = "30"
  subdirListViewEigenFrame["text-color"] = "#ffffff"
  subdirListViewEigenFrame["layout-width"] = "wrap_content"
  subdirListViewEigenFrame["layout-height"] = "wrap_content"
  subdirListView["eigen-frame"] = subdirListViewEigenFrame
  subdirListViewEigenFrame["background-color"] = "#654321"


  eigenScreenLayout["type"] = "LinearLayout"
  eigenScreenLayout["orientation"] = "vertical"
  eigenScreenLayout["layout-width"] = "match_parent"
  eigenScreenLayout["layout-height"] = "match_parent"
  eigenScreenLayout["component-list"] = [headerTextView,horzLine,subdirListView,horzLine,filesListView]
   
  jj eigenScreenLayout
end


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


# encrypt unsigned, with default output name
def gpg_encrypt(keyid, in_file, format)
  h = Hash.new("null")
  h["type"] = "gpg-encrypt"
  h["recipients"] = keyid
  h["input-filename"] = in_file

  if (format == "asc")
    isarmor = "-a"
    output_filename = "#{in_file}.asc"
  else
    isarmor = ""
    output_filename = "#{in_file}.pgp"
  end
  
  h["output-filename"] = output_filename
  File.delete output_filename if File.exists? output_filename 

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  recipients = ""
  keyid.each {|x| recipients << " --recipient #{x}" }

  cmd = "#{gpg} #{recipients} #{isarmor} --no-tty --always-trust -o #{output_filename} --encrypt #{in_file}"
  h["command"] = cmd

  puts cmd
  
  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

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


def gpg_sign_detached(keyid, password, in_file)
  puts "keyid:"
  p keyid

  puts "password:"
  p password

  puts "in_file:"
  p in_file

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"
  gpg_sec = "#{gpg} --pinentry-mode loopback --batch --yes --passphrase-fd 0"

  cmd = "#{gpg_sec} --local-user #{keyid} --detach-sig #{in_file}"
  
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

  #h.to_json
  jj h
end

def gpg_verify(keyfile)
  h = Hash.new("null")

  gpg = "/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/"

  filepaths = ""
  keyfile.each {|x| filepaths << " #{x}" }

  cmd = "#{gpg} --verify #{filepaths}"
  
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


def sysops(type, cmd)
  h = Hash.new("null")
  h["type"] = type

  h["command"] = cmd
  
  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

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


def zip_contents(zipfile)  

  h = sysops("sysops-unzip-list", "unzip -l #{zipfile}")

  stdout = h["stdout"]
  selected = stdout.select { |line| line =~ /[0-9]/ }

  keys = []
  selected.each do |line|
    fields = line.split
    keys << fields[-1].strip if fields.size == 4
  end

  h["filenames"] = keys

  stat = File.stat(zipfile)
  h["file-size"] = stat.size
  h["file-created"] = stat.ctime

  h["time-now"] = Time.now
  
  h

end


def create_symlink(target, symlink)
  if !File.exists? symlink
    puts "create symlink: #{symlink}"
    puts File.symlink(target, symlink)
  else
    puts "link exists: #{symlink}"
  end
end


def openssl_genrsa(bitcount)

  #  puts "app-lib/sysops"
  
  h = Hash.new("null")
  h["type"] = "openssl-genrsa"

  #  cmd = ""

  #// generate a new RSA private key bits:2048, 4096, 8192
  #  cmd = "openssl genrsa -out privateKey.key 512"
  #  cmd = "openssl genrsa -out privateKey.key 2048"
  #  cmd = "openssl genrsa -aes256 -out privateKey-with-passphase.key 2048"
  #  cmd = "openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out privateKey.pem"
  #  cmd = "openssl genpkey -aes256 -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out privateKey.pem"

  
  #// produce an encrypted private key with a passphase from an existing key without passphase
  #  cmd = "openssl rsa -des3 -in privateKey.key -out privateKeyWithPass.pem"
  
  #// produce public key for a given private key
  #  cmd = "openssl pkey -pubout -in privateKey.pem -out publicKey.pem"

  #// show RSA information
  #  cmd = "openssl rsa -text -in privateKey.key"

  #// show private key information
  #  cmd = "openssl pkey -text -in privateKey.pem"

  #// show public key information
  #  cmd = "openssl pkey -pubin -text -in privateKey.pem"

  #// show list of algorithms
  #  cmd = "openssl list -cipher-algorithms"

  #// generate a new private key and CSR
  #  cmd = "openssl req -out CSR.csr -new -newkey rsa:2048 -nodes keyout privateKey.key"

  #// generate self-signed certificate
  #  cmd = "openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt"

  #// generate a certificate signing request (CSR) for an existing private key
  #  cmd = "openssl req -out CSR.csr -key privateKey.key -new"
  #  cmd = "openssl req -new -key privateKey.key -out CSR.csr"

  #// generate a certificate signing request (CSR) based on an existing certificate 
  #  cmd = "openssl x509 -x509toreqreq -in certificate.crt -out CSR.csr -signkey privateKey.key"

  #// generate a certificate signing request (CSR) and a private key 
  #  cmd = "openssl req -new -newkey rsa:2048 -nodes -keyout privateKey.key -out CSR.csr subj \"/C=US/ST=Kentucky/L=Louisville/O=organization/OU=org-unit/CN=fully-qualified-domain-name.com\" "

  #// remove a passphase from a private key
  #  cmd = "openssl rsa -in privateKey.pem -out newPrivateKey.pem"

  #// check a Certificate Signing Request (CSR)
  #  cmd = "openssl req -text -noout -verify -in CSR.csr"

  #// check a privateKey
  #  cmd = "openssl rsa -in privateKey.key -check"

  #// check a certificate
  #  cmd = "openssl x509 -in certificate.crt -text -noout"

  #// check a PKCS12 (.pxf or .p12)
  #  cmd = "openssl pkcs12 -info -in keyStore.p12"

  #// convert a DER to PEM
  #  cmd = "openssl x509 -inform der -in certicate.cer -out cerificate.pem"

  #// convert a PEM to DER
  #  cmd = "openssl x509 -outform der -in certificate.pem -out certificate.der"

  #// convert a PKCS12 file containing a private key and certs to PEM
  #  cmd = "openssl pkcs12 -in keyStore.pfx -out keyStore.pem -nodes"

  #// convert a PEM cert file and private key to PKCS12(.pfx.p12)
  #  cmd = "openssl pkcs12 -export -out keyStore.pfx -inkey -privateKey.key -in certificate.crt -certfile CACert.crt"

  #// convert a PEM to P7B
  #  cmd = "openssl crl2pkcs7 -nocrl -certfile certificate.cer -out certificate.p7b -certfile CACert.crt"

  #// generate prime
  #  cmd = "openssl prime -generate -bits 24"

  #// show version
  #  cmd = "openssl version -a"

  #// show base64 encoding of text
  #  cmd = "openssl base64 -e <<< 'sample text' "

  #// show text of base64 encoding
  #  cmd = "openssl base64 -d <<< 'V2VsY29tZSB0byBvcGVuc3NsIHdpa2kK' "

  #// show md5 digest/hash 
  #  cmd = "openssl dgst -md5 data.dat"

  #// show sha1 digest/hash 
  #  cmd = "openssl dgst -sha1 data.dat"

  #// show sha384 digest/hash 
  #  cmd = "openssl dgst -sha384 data.dat"

  #// show list digest/hash options 
  #  cmd = "openssl list -digest-commands"

  #// show list ciphers
  #  cmd = "openssl enc -cipher"

  #// show list ciphers algorithms
  #  cmd = "openssl list -cipher-algorithms"


  h["command"] = cmd
  
  stdin, stdout, stderr, wait_thread = Open3.popen3(cmd)

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



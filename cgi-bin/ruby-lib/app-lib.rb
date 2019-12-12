require 'open3'
require 'cgi'
require 'json'


##==================================================================================================
def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")
  return get_io_as_string(f)
end


##==================================================================================================
def get_io_as_string(io)
  data = ''
  io.each_line do |line|
    data += line
  end
  return data
end


##==================================================================================================
def get_io_as_array(io)
  data = []
  io.each_line do |line|
    data << line
  end
  return data
end


##==================================================================================================
def response_header_text_plain_iso8859
  "Content-type: text/plain; charset=iso-8859-1\n\n"
end


##==================================================================================================
def print_response_header
  print response_header_text_plain_iso8859
end


##==================================================================================================
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


## get directory_hash for specified dirpath
def set_directory_hash(dirpath)
  Dir.chdir dirpath
  directory_hash()
end


## get directory_hash for unspecified current directory
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


##==================================================================================================
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


##==================================================================================================
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
  h["file_size"] = stat.size
  h["file_created"] = stat.ctime

  h["time_now"] = Time.now
  
  h

end


##==================================================================================================
def create_symlink(target, symlink)
  if !File.exists? symlink
    puts "create symlink: #{symlink}"
    puts File.symlink(target, symlink)
  else
    puts "link exists: #{symlink}"
  end
end


##==================================================================================================
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



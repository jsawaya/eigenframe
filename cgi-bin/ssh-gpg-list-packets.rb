#!/usr/bin/ruby

require 'json'
require_relative 'ruby-lib/app-lib'
require_relative 'ruby-lib/gpg-lib'

exit 10 if ARGV.length == 0 

keyfile = ARGV[0]

puts gpg_list_packets_hash(keyfile)

#=======================================================================================================
#
#{"type":"gpg-list-packets",
#"command":"/data/data/com.termux/files/usr/bin/gpg -v -v --homedir /data/data/com.termux/files/home/.gnupg/ --batch --list-packets /data/data/com.termux/files/home/storage/downloads/termux-files/test2.txt.gpg",
#"exit_code":2,
#"stdout":[],
#"status":["# off=0 ctb=85 tag=1 hlen=3 plen=268\n",
#":pubkey enc packet: version 3, algo 1, keyid 4621F72F1A58024E\n",
#"\tdata: [2044 bits]\n",
# >>> "gpg: public key is 4621F72F1A58024E\n", <<<
#"gpg: using subkey 4621F72F1A58024E instead of primary key 2A4C67D1EE8DD2DD\n",
#"gpg: pinentry launched (17894 curses 1.1.0 - - -)\n",
#"# off=271 ctb=d2 tag=18 hlen=2 plen=0 partial new-ctb\n",
#":encrypted data packet:\n",
#"\tlength: unknown\n",
#"\tmdc_method: 2\n",
#"gpg: using subkey 4621F72F1A58024E instead of primary key 2A4C67D1EE8DD2DD\n",
#"gpg: encrypted with 2048-bit RSA key, ID 4621F72F1A58024E, created 2019-07-03\n",
#"      \"test this <none@none>\"\n",
#"gpg: public key decryption failed: Not a typewriter\n",
#"gpg: decryption failed: No secret key\n"]}


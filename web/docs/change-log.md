# Change Log
## Recent Changes

V1.3 EigenFrame is a truly extensible architecture for dynamic system integration with
Termux, ssh, sftp, javascript, apache http/cgi, ruby, prolog, and openpgp, using json specs.
 * Added JavaScript console (script_script [doc](JavaScript.md) ).
 * Added Camera Image Capture and Camera Image View - see [example](../frames/script-photo.json)
 * Added Drawing Screen see [example](../frames/script-drawing.json)
 * Added Drawing Javascript and Json Format see [doc](Draw.md)
 * Added support for URL post-method (which enables simple integration with GnuPG, Prolog, ...) see [doc](UrlRequest.md)
 * Added support for OpenPGP (ruby interface to GnuPG, many post-method examples) see [example](../frames/http-cgi-ruby-pgp.json)
 * Added new 'condition' attribute to all components, layouts and actions. 
 	- provides an easy way to assert the required conditions (context dependencies) for any EigenFrame element.
 	- example: {... "condition_script": "eigenFragment.getBooleanVariable('IsShowWorkingDirectory',0,false)" }
 * Playstore update now refreshes 'app.json', but does not change any existing 'home-url.txt' - so your eigenframe apps remain active.
 * EigenFrame GitHub now has 4 branches: master, test, beta, and 1.3
    - 'master' is the current EigenFrame release - documentation, cgi-bin/scripts, apps/frames and resources.
    - 'test' is for merging minor changes from actual Android test devices
    - 'beta' is for developers, and pre-release testing
    - '1.3' is for pre-launch testing; after release it serves as the static v1.3 reference implementation
 * Remote Ruby File Edit/Execution. 
 * Prolog Examples. 
 * Extended OpenPGP support using ssh/Ruby interface with GnuPG. 
 * View id can be JS, see "id_script".  
 * New JS eigenFragment copyFile, renameFile and deleteFile.

## Releases:
 * 4/2020 - Version 1.3 - Camera Image Capture/View, Drawing Screen (and Draw Format), OpenPGP Support (ssh), Prolog, etc.
 * 3/2020 - Version 1.2 - JavaScript meta-programming (script_script), Beta Branch
 * 3/2020 - Version 1.1 - OpenPGP Support: URL(post), Ruby, GnuPG, conditional components
 * 2/2020 - Version 1.0 - Initial Release: JavaScript, SSH, SFTP, URL(get), Apache2/CGI
 * 12/2019 - Version 0.3 - incremental design, testing
 * 10/12/2019 Version 0.2 - Add Layouts, Buttons, ...
 * 9/18/2019 Version 0.1 - Create EigenFrame prototype


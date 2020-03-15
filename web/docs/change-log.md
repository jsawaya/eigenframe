# Change Log
## Recent Changes

V1.2 EigenFrame is a truly extensible architecture for dynamic system integration with
Termux, ssh, sftp, javascript, apache http/cgi, ruby, and pgp, using json specs.
 * Added JavaScript console (script_script example).
 * Added support for URL post-method (which enables simple integration with GnuPG, Prolog, ...)
 * Added support for OpenPGP (ruby interface to GnuPG, many post-method examples).
 * Added new 'condition' attribute to all components, layouts and actions.
 		- this provides an easy way to assert the required conditions (context dependencies) for each EigenFrame element.
 		- example: {... "condition_script": "eigenFragment.getBooleanVariable('IsShowWorkingDirectory',0,false)" }
 * Playstore update now refreshes 'app.json', but does not change any existing 'home-url.txt' - so your eigenframe apps remain active.
 * EigenFrame GitHub now has 3 branches: master, test, and beta
    - 'master' is the current EigenFrame release - documentation, cgi-bin/scripts, apps/frames and resources.
    - 'test' is for merging minor changes from actual Android test devices
    - 'beta' is only for developers, pre-release

## Releases:
 * 3/2020 - Version 1.2 - JavaScript meta-programming (script_script), Beta Branch
 * 3/2020 - Version 1.1 - OpenPGP Support: URL(post), Ruby, GnuPG, conditional components
 * 2/2020 - Version 1.0 - Initial Release: JavaScript, SSH, SFTP, URL(get), Apache2/CGI
 * 12/2019 - Version 0.3 - incremental design, testing
 * 10/12/2019 Version 0.2 - Add Layouts, Buttons, ...
 * 9/18/2019 Version 0.1 - Create EigenFrame prototype


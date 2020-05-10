# Getting Started


## Install EigenFrame Services

1. Termux Setup Instructions (below)
2. SecureShell Settings
   - enables remote control of Termux App
3. GIT - interface to EigenFrame GitHub repository
4. Ruby - systems integration / transforms
5. SWI-Prolog - inference engine
6. OpenPGP - cryptography and security
7. Apache2 - http/cgi support


## Initial Setup of Termux Host - install openssh

1. Install Termux from Google PlayStore
2. Open Termux app terminal console
3. At $ prompt, type the following -- this ensures you have the latest software:
>  $ pkg upgrade
4. Enable Termux to access shared storage -- enables Termux to access EigenFrame Shared Files:
>  $ termux-setup-storage
5. Install openssh (open secure-shell):
>  $ pkg install openssh
6. Create a new ssh password (you will re-enter this password later in [SecureShell Settings]):
>  $ passwd
7. Start the secure-shell background process:
>  $ sshd
8. Verify you can login to secure-ftp:
>  $ sftp -P 8022 localhost

>    Connected to localhost.

>    sftp> quit
9. Open EigenFrame, click [SecureShell Settings], enter your new ssh password, and test your ssh connection

At this point you have a working Secure-Shell connection to Termux.  
This is enough to for you to use EigenFrame buttons to perform the remaining setup tasks.


## Initial Setup for EigenFrame - install git

1. Click [Git Installation] button
    * Click [Install git package] button
    * Click [Make git-repos directory] button 
        - this prepares a working directory in Termux home/git-repos for you to develop EigenFrame apps.
    * Click [Clone EigenFrame From GitHub and checkout test branch] button 
        - this downloads the EigenFrame GitHub project distribution files. 
    * At this point you have a git working storage copy of EigenFrame that you can use as reference examples.  

2. You may want to create a new GitHub repository for your own EigenFrame projects. 
    * In this case, you may clone the EigenFrame repository as an example

3. Decide your EigenFrame devops workflow - choose a method to edit your source files
    * You might use a [Simple Text Editor] from the Google Playstore, there are many.
    * You might use an editor in Termux (emacs, vim, etc.)
        - With this option, you'll want to use a bluetooth keyboard, or software interface like "Vysor".
    * Better yet, use your PC and favorite IDE (Visual Studio Code) to edit your source files 
        - With support for JSON format checks, git/github integration, and much more. 

4. Your source files will need to be accessible in some way to your Android device:
    * You can easily push code to your own github repository, and let EigenFrame url requests get it from there -- this is how the default app works!
    * You might have a web-service or ssh running on your pc (vm or cloud), 
        - EigenFrame url/ssh/sftp interfaces can access static (or dynamic) components directly.
    * Or you could copy files through usb interface to the EigenFrame Shared Directory -- not recommended.


## Advanced Setup for EigenFrame - editing the default app

* Edit /storage/emulated/0/Android/data/com.sawaya.eigenframe/files/home-url.txt to install a custom app url

example:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/yourapp.json

* Restart EigenFrame - see the new tab(s)

* Read [EigenFrame](EigenFrame.md) to understand the top-level application specification. 

* Read [EigenFragment](EigenFragment.md) to understand the EigenFragment tabs.

* On your Android device you can view/edit files in the EigenFrame Shared Directory
> /storage/emulated/0/Android/data/com.sawaya.eigenframe/files/

* App specification (yourapp.json) calls (newfile.json) and creates a new tab: Hello World
    


# Getting Started

## Initial Setup of Termux Host - install openssh

1. Install Termux from Google PlayStore
2. Open Termux app terminal console
3. At $ prompt, type the following:
>  $ pkg upgrade
4. Enable Termux to share storage:
>  $ termux-setup-storage
5. Install openssh (open secure-shell):
>  $ pkg install openssh
6. Create a new ssh password (you will re-enter this password in [SecureShell Settings]):
>  $ passwd
7. Start the secure-shell process:
>  $ sshd
8. Verify you can login to secure-ftp:
>  $ sftp -P 8022 localhost
>    Connected to localhost.
>    sftp> quit
9. Open EigenFrame, click [SecureShell Settings], enter your new ssh password, and test your ssh connection

At this point you have a Secure-Shell connection to Termux.  
This is enough to for you to use EigenFrame to perform the remaining setup tasks.

## Initial Setup for EigenFrame - edit default app

* Edit home-url.txt to call a new customized app

from:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/app.json

to:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/yourapp.json

* Restart EigenFrame - see the new tab     

* Read [EigenFrame](EigenFrame.md) to understand the top-level application specification. 

* Read [EigenFragment](EigenFragment.md) to understand the EigenFragment tabs.

* On your Android device edit yourapp.json and newfile.json 
* yourapp.json creates a new tab that points to newfile.json:
    
```json
{
  "type": "EigenFragment",
  "name": "MyProject",
  "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/<your-frame>.json"
}
```

## Initial Setup for EigenFrame - install git

1. Click [Git Installation] Button
    * Click [Install git package] Button
    * Click [Make git-repos directory] Button 
        - this prepares a working directory in Termux home/git-repos for you to develop EigenFrame apps.
    * Click [Clone EigenFrame From GitHub and checkout test branch] Button 
        - this downloads the EigenFrame GitHub project distribution files. 
    * At this point you have a git working storage copy of EigenFrame that you can use as reference examples.  

2. You may want to create a new GitHub repository for your own EigenFrame projects. 
    * You may clone the EigenFrame repository as an example

3. Decide your EigenFrame devops workflow - choose a method to edit your source files

4. You might get a [Simple Text Editor] from the Google Playstore, there are many.
5. You might use an editor in Termux (emacs, vim, etc.)
  * With this option, you'll want to get a bluetooth keyboard, or software interface like "Vysor".
6. Better yet, use your PC and favorite IDE to edit source files 
  * This method probably supports JSON format checks, git/github integration, and much more. 
  * But these files will need to be accessible in some way to your Android device
    - You could copy files through usb
    - Or you could push to your github repository and let Android EigenFrame get url requests from there.
    - Or you might happen to have a web-service running on your pc (or vm). 
    - Better yet, you might run sshd on your pc (or vm) and use the builtin EigenFrame ssh/sftp interface to access static (and dynamic) components directly.  So many choices.


# SecureShell
## schema pattern

* type = "SecureShell"
* id : saves ssh response to cache SecureShell:{id}
* ssh | ssh_list
* is_eigen_response : true | false (default)
* is_toast = true | false (default)
* on_complete : action script begins when ssh response is available 

Related:
[PopupTextView](PopupTextView.md) 
[PopupScreen](PopupScreen.md) 
[JavaScript](JavaScript.md) 
[UrlRequest](UrlRequest.md) 
[SecureFtp](SecureFtp.md) 
[ActionList](ActionList.md) 


Example:
```json
  {
    "type": "SecureShell",
    "is_eigen_response": true,
    "ssh_list": [
      "cd /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin",
      "ruby ssh-directory-listview.rb /data/data/com.termux/files/home"
    ]
  }
```

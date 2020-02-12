# UrlRequest
## schema pattern

* type = "UrlRequest"
* url
** is_eigen_response : true | false (default)
* on_complete : action script begins when url response is available 

Related:
[PopupTextView](PopupTextView.md)  
[PopupScreen](PopupScreen.md)  
[JavaScript](JavaScript.md)  
[UrlRequest](UrlRequest.md)  
[SecureShell](SecureShell.md)  
[SecureFtp](SecureFtp.md) 
[ActionList](ActionList.md)  


Example:
```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
}
```






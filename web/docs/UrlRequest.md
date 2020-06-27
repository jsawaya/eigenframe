# UrlRequest
## schema pattern

* type = UrlRequest
* url : url-string 
    - http: | https: - get method request - with or without url query parameters
    - http: | https: - put method request - requires parameter_list
    - file: - local filesystem request 
        - syntax:  file://{absolute-file-path}
        - example:  
        >  "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/image/eigenframe.png"

* parameter_list (optional) : list of name/value pairs, enables http(s) put method requests
  - simple example:  

```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "http://localhost:8080/cgi-bin/cgi-directory-listview.rb",
    "parameter_list": 
    [
      {
      "name": "dirpath",
      "value": "."
      }
    ]
}
```


* is_eigen_response (optional) : response is a JSON formatted layout, component or action { true | false (default)}

* id (optional) : saves the response to cache UrlRequest:{id}
   - the cache can then be referenced just like any other url 
        > "url": "file:///data/user/0/com.sawaya.eigenframe/files/UrlRequest:5002"
   - or the cache can then be referenced like a string via javascript 
        > eigenFragment.getCacheString('UrlRequest:5002')

* on_complete (optional) : action script that begins when url response is complete 

Related:
[PopupTextView](PopupTextView.md) 
[PopupScreen](PopupScreen.md) 
[JavaScript](JavaScript.md) 
[SecureShell](SecureShell.md) 
[SecureFtp](SecureFtp.md) 
[ActionList](ActionList.md) 


Example:
```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/{BRANCH}/web/frames/playlist.json"
}
```






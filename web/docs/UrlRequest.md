# UrlRequest
## schema pattern

* type = "UrlRequest"
* url
** is_eigen_response : true | false (default)
* on_complete : action script begins when url response is available 

Example:
```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
}
```






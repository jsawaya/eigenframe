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

* parameter_list : list of name/value pairs, enables http(s) put method requests
    - each name/value pair 
        - simple example:  

```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb",
    "parameter_list": 
    [
      {
      "name": "dirpath",
      "value": "."
      }
    ]
}
```

        - example that show how to create url parameters dynamically with javascript:  
```json
{
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb",
    "parameter_list": 
    [
      {
      "name": "dirpath",
      "value_script": "''+eigenFragment.concatPaths(eigenFragment.getCacheString('TextView:991000'), eigenFragment.getCacheString('EditText:991001'))"
      }
    ]
}
```
    
* is_eigen_response : response is a JSON formatted layout, component or action { true | false (default)}
* on_complete : action script begins when url response is available 

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
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
}
```

Example:
```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "component_list": [
    {
      "type": "TextView",
      "text": "Test UrlRequest",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text_size": "14",
      "text_color": "#ffffff"
    },
    {
      "type": "Clone",
      "name": "HorizontalLine"
    },

    {
      "type": "Button",
      "text": "UrlRequest:5001 (directory listing) is_eigen_response: false",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "UrlRequest",
        "id": 5001,
        "is_eigen_response": false,
        "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=.",
        "on_complete": {
          "type": "Clone",
          "name": "PopupScreenDefault",
          "attributes": {
            "title": "UrlRequest:5001 directory listing",
            "component_list": [
              {
                "type": "Clone",
                "name": "LayoutVerticalScrollable",
                "attributes": {
                  "component_list": [
                    {
                      "type": "Clone",
                      "name": "TextViewDetail",
                      "attributes": {
                        "url": "file:///data/user/0/com.sawaya.eigenframe/files/UrlRequest:5001"
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    },

    {
      "type": "Button",
      "text": "UrlRequest (directory-listview) is_eigen_response: true",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "Clone",
        "name": "PopupScreenDefault",
        "attributes": {
          "title": "UrlRequest directory listing",
          "component_list": [
            {
              "type": "UrlRequest",
              "is_eigen_response": true,
              "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=."
            }
          ]
        }
      }
    },

    {
      "type": "Button",
      "text": "UrlRequest:5002 (directory listing) is_eigen_response: false",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "UrlRequest",
        "id": 5002,
        "is_eigen_response": false,
        "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb",
        "parameter_list": [
          {
            "name": "dirpath",
            "value": "."
          }
        ],
        "on_complete": {
          "type": "Clone",
          "name": "PopupScreenDefault",
          "attributes": {
            "title": "UrlRequest:5002 directory listing",
            "component_list": [
              {
                "type": "Clone",
                "name": "LayoutVerticalScrollable",
                "attributes": {
                  "component_list": [
                    {
                      "type": "Clone",
                      "name": "TextViewDetail",
                      "attributes": {
                        "url": "file:///data/user/0/com.sawaya.eigenframe/files/UrlRequest:5002"
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    },

    {
      "type": "Button",
      "text": "UrlRequest:5002 (directory listing) is_eigen_response: false",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "UrlRequest",
        "id": 5003,
        "is_eigen_response": false,
        "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb",
        "parameter_list": [
          {
            "name": "dirpath",
            "value_script": "''+eigenFragment.concatPaths(eigenFragment.getCacheString('TextView:991000'), eigenFragment.getCacheString('EditText:991001'))"
          }
        ],
        "on_complete": {
          "type": "Clone",
          "name": "PopupScreenDefault",
          "attributes": {
            "title": "UrlRequest:5003 directory listing",
            "component_list": [
              {
                "type": "Clone",
                "name": "LayoutVerticalScrollable",
                "attributes": {
                  "component_list": [
                    {
                      "type": "Clone",
                      "name": "TextViewDetail",
                      "attributes": {
                        "url": "file:///data/user/0/com.sawaya.eigenframe/files/UrlRequest:5003"
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    },

    {
      "type": "Button",
      "text": "UrlRequest PostMethod is_eigen_response: true",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "Clone",
        "name": "PopupScreenDefault",
        "attributes": {
          "title": "UrlRequest directory listing",
          "component_list": [
            {
              "type": "UrlRequest",
              "is_eigen_response": true,
              "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb",
              "parameter_list": [
                {
                  "name": "dirpath",
                  "value_script": "''+eigenFragment.concatPaths(eigenFragment.getCacheString('TextView:991000'), eigenFragment.getCacheString('EditText:991001'))"
                }
              ]
            }
          ]
        }
      }
    }

  ]
}
```





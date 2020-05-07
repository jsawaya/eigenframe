# PopupHtmlView
## schema pattern

* type = "PopupHtmlView"
* html | html_list | url | url_script
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin

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
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "PopupHtmlView with html_list",
      "text_color": "#ffffff",
      "background_color": "#11ff0000",
      "icon": {
        "name": "info.",
        "location": "left"
      },
      "on_click": {
        "type": "PopupHtmlView",
        "title": "PopupHtmlView/html_list",
        "html_list": [
          "9/27/2019 Version 0.1<hr/>",
          "- Popup dynamic html with access to application-embedded icons [<img src='info.jpg'>]"
        ]
      }
    }
```

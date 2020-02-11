# PopupTextView
## schema pattern

* type = "PopupTextView"
* title = heading on title bar
* text | text_script
* url
* ssh / is_toast = true | false
* sftp

* text_color
* text_size
* font: [font attribute](./web/docs/font.md)
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin

Example:
```json
    {
      "type": "Clone",
      "name": "ButtonDefault",
      "attributes": {
        "text": "Stop Apache2 HTTP/CGI Services",
        "icon": {
          "name": "close.",
          "location": "top"
        },
        "on_click": {
          "type": "PopupTextView",
          "title": "Stop Apache2 HTTP/CGI Services",
          "font": "font/droid-sans-mono/DroidSansMono.ttf",
          "ssh_list": [
            "killall httpd",
            "echo Stopped Apache2 services"
          ]
        }
      }
    }
```


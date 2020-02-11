# Button
## schema pattern

* type = "Button"
* text | text_script
* id = define unique view id
* text_color
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin
* on_click action script


Example:
```json
{
  "type": "Button",
  "layout_width": "match_parent",
  "text": "getViewState RadioButton:500",
  "text_color": "#ffffff",
  "background_color": "#ff00ff",
  "on_click": {
    "type": "JavaScript",
    "script_list": [
      "eigenActivity.showToast('getViewState: '+eigenFragment.getViewState(500))"
    ]
  }
}
```

Example:
```json
{
  "type": "Button",
  "layout_width": "wrap_content",
  "layout_height": "wrap_content",
  "text": "Start ruby webrick service",
  "text_color": "#ffffff",
  "background_color": "#123456",
  "margin": {
    "left": 10,
    "top": 10,
    "right": 10,
    "bottom": 10
  },
  "on_click": {
    "type": "PopupTextView",
    "title": "Start ruby webrick",
    "font": "font/droid-sans-mono/DroidSansMono.ttf",
    "abort": 2000,
    "ssh": "ruby /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin/sys-webrick.rb > ruby-webrick.out 2> ruby-webrick.log &"
  }
}
```


Example:
```json
{
  "type": "Button",
  "text": "PopupHtmlView with url",
  "text_color": "#ffffff",
  "on_click": {
    "type": "PopupHtmlView",
    "title": "localhost webpage:",
    "url": "http://localhost:8080/"
  }
}
```

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

Example:
```json
{
  "type": "Button",
  "text": "Explore Current GIT Path",
  "layout_width": "wrap_content",
  "layout_height": "wrap_content",
  "text_color": "#ffffff",
  "background_color": "#654321",
  "icon": {
    "name": "listview.",
    "location": "top"
  },
  "margin": {
    "left": 10,
    "top": 10,
    "right": 10,
    "bottom": 10
  },
  "on_click":
  {
    "type": "SecureFtp",
    "id": 991004,
    "sftp_script": "'directory ' + eigenFragment.concatPaths(991000, 991001, 991002)",
    "on_complete":
    {
      "type": "PopupScreen",
      "title_script": "''+ eigenFragment.concatPaths(991000, 991001, 991002)",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/ssh-git-admin-listview.json",
      "layout_width": "match_parent",
      "text_size": "14",
      "text_color": "#ffffff",
      "background_color": "#111111"
    }
  }
}
```

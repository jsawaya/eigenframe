
AlertDialog specification:
* "type": "AlertDialog"
* "title": text string appears at top of popup dialog
* "icon": {"name", "location"} 
icon appears adjacent to title (on left, by default)
* "positive": {"option", "on_click"}
* "negative": {"option", "on_click"}
* "neutral": {"option", "on_click"}

Example AlertDialog as Button on_click action
```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "component_list": [
    {
      "type": "TextView",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text": "Test AlertDialog",
      "text_size": "14",
      "gravity": "center",
      "text_color": "#ffffff",
      "icon": {
        "name": "ic_launcher_round.",
        "location": "top"
      }
    },
    {
      "type": "HorizontalLine",
      "size": 1,
      "color": "#00ff00"
    },
    {
      "type": "Button",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text": "Test AlertDialog",
      "text_color": "#ffffff",
      "background_color": "#22ff0000",
      "on_click": {
        "type": "AlertDialog",
        "title": "My AlertDialog",
        "icon": {
          "name": "info."
        },
        "positive": {
          "option": "YES",
          "on_click": {
            "type": "JavaScript",
            "script": "eigenActivity.showToast('AlertDialog says YES')"
          }
        },
        "negative": {
          "option": "NO",
          "on_click": {
            "type": "JavaScript",
            "script": "eigenActivity.showToast('AlertDialog says NO')"
          }
        },
        "neutral": {
          "option": "UNKNOWN",
          "on_click": {
            "type": "JavaScript",
            "script": "eigenActivity.showToast('AlertDialog says UNKNOWN')"
          }
        }
      }
    }
  ]
}
```


# AlertDialog
## schema pattern

* type: "AlertDialog"
* title: text string appears at top of popup dialog
* icon: {"name", "location"} 
icon appears adjacent to title (on left, by default)
* positive: {"option", "on_click"}
* negative: {"option", "on_click"}
* neutral: {"option", "on_click"}

Related:
[AlertDialog](AlertDialog.md)  
[SelectDialog](SelectDialog.md)  
[RadioButton](RadioButton.md)  
[Spinner](Spinner.md)  
[ListView](ListView.md)  
[PopupScreen](PopupScreen.md)  

Example:
```json
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
```


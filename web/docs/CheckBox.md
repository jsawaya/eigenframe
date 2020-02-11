# CheckBox
## schema pattern

* type = "CheckBox"
* text | text_script
* checked = true | false (default)
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
  "type": "CheckBox",
  "id": 200,
  "layout_width": "wrap_content",
  "layout_height": "wrap_content",
  "text": "This is CheckBox:200",
  "checked": true,
  "text_color": "#ffffff",
  "background_color": "#ff00ff",
  "padding": {
    "left": 20,
    "top": 20,
    "right": 20,
    "bottom": 20
  },
  "margin": {
    "left": 40,
    "top": 40,
    "right": 40,
    "bottom": 40
  },
  "on_click": {
    "type": "JavaScript",
    "script_list": [
      "eigenActivity.showToast('eigenFragment.getViewState(200): '+eigenFragment.getViewState(200))"
    ]
  }
}
```


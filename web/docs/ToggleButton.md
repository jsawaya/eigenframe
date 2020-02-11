# ToggleButton
## schema pattern

* type = "ToggleButton"
* text_on
* text_off
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
      "type": "ToggleButton",
      "text_on": "Clear Path",
      "text_off": "Reset Path",
      "checked": false,
      "text_color": "#ffffff",
      "background_color": "#654321",
      "gravity": "center",
      "icon": {
        "name": "cancel.",
        "location": "top"
      },
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "if (eigenFragment.getViewState() == '1') eigenFragment.setViewState(991001,'git-repos/eigenframe')",
          "else eigenFragment.setViewState(991001,'')",
          "eigenFragment.setViewState(991002,'')",
          "eigenFragment.setViewState(991003,'')"
        ]
      }
    }
```


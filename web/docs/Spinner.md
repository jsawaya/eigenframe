# Spinner
## schema pattern

* type = "Spinner"
* option_list
* checked_option = 0 ... n 
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
      "type": "Spinner",
      "id": 600,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "background_color": "#ff00ff",
      "checked_option": 2,
      "option_list": [
        "option 0",
        "option 1",
        "option 2"
      ],
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.showToast('Spinner getViewState: '+eigenFragment.getViewState(600))"
        ]
      }
    },
```


# RadioButton
## schema pattern

* type = "RadioButton"
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
      "type": "RadioButton",
      "id": 500,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "orientation": "vertical",
      "background_color": "#654321",
      "checked_option": 1,
      "option_list": [
        "option 0",
        "option 1",
        "option 2"
      ],
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.showToast('RadioButton getViewState: '+eigenFragment.getViewState(500))"
        ]
      }
    }
```


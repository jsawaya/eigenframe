# Spinner
## schema pattern

* type = "Spinner"
* option_list
* checked_option, checked_option_script = 0 ... n 
* id = define unique id to store the view-state
* text_color
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin
* on_click action script

Related:
[Button](Button.md) 
[TextView](TextView.md) 
[ImageView](ImageView.md) 
[EditText](EditText.md) 
[CheckBox](CheckBox.md) 
[Switch](Switch.md) 
[ToggleButton](ToggleButton.md) 
[RadioButton](RadioButton.md) 
[AlertDialog](AlertDialog.md) 
[SelectDialog](SelectDialog.md) 
[ListView](ListView.md) 

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
          "eigenActivity.showToast('Spinner getViewState: '+eigenFragment.getViewState(600));"
        ]
      }
    },
```


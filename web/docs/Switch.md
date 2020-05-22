# Switch
## schema pattern

* type = "Switch"
* text | text_script
* checked = true | false (default)
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
[ToggleButton](ToggleButton.md) 
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 


Example:
```json
    {
      "type": "Switch",
      "id": 300,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text": "This is Switch:300",
      "checked": true,
      "text_color": "#ffffff",
      "background_color": "#ff00ff",
      "padding": {
        "left": 40,
        "top": 40,
        "right": 40,
        "bottom": 40
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.showToast('Switch getViewState: '+eigenFragment.getViewState(300));"
        ]
      }
    }
```

# LinearLayout
## schema pattern

* type = "LinearLayout"
* scrollable = true | false (default)
* layout_width = MATCH_PARENT | WRAP_CONTENT (default) | integer pixels
* layout_height = MATCH_PARENT | WRAP_CONTENT (default) | integer pixels
* orientation = horizontal | vertical (default)
* gravity = top | bottom | left | right | center_horizontal | center_vertical
* component_list is a sequence of components, actions or nested layouts

Related:
[PopupScreen](PopupScreen.md) 
[Button](Button.md) 
[TextView](TextView.md) 
[HtmlView](HtmlView.md) 
[WebView](WebView.md)
[ImageView](ImageView.md)
[EditText](EditText.md) 
[CheckBox](CheckBox.md) 
[Spinner](Spinner.md)
[Switch](Switch.md) 
[ToggleButton](ToggleButton.md) 
[RadioButton](RadioButton.md) 
[HorizontalLine](HorizontalLine.md) 
[VerticalLine](VerticalLine.md) 
[ListView](ListView.md) 
[HorizontalLine](HorizontalLine.md) 
[VerticalLine](VerticalLine.md) 


Example:
```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "component_list": [

    {
      "type": "Clone",
      "name": "HorizontalLine"
    },

    {
      "type": "Clone",
      "name": "TextViewLabel",
      "attributes": {
        "text": "Termux Home (sftp home):"
      }
    },

    {
      "type": "TextView",
      "id": 991000,
      "sftp": "pwd",
      "layout_width": "match_parent",
      "text_color": "#ffffff",
      "text_size": "20",
      "gravity": "left",
      "background_color": "#000000",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      }
    }
  ]
}
```

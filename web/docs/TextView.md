# TextView
## schema pattern

* type = "TextView"
* text | text_script
* url
* ssh / is_toast = true | false
* sftp
* id = define unique view id, 
  puts contents into cache TextView:{id} 

* text_color
* text_size
* font: [font attribute](./font.md)
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin

Related:
[Button](Button.md)  
[TextView](TextView.md)  
[ImageView](ImageView.md) 
[EditText](EditText.md)  
[CheckBox](CheckBox.md) 
[Switch](Switch.md)  
[ToggleButton](ToggleButton.md)  
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 


Example:
```json
  {
    "type": "TextView",
    "text": "Sub-directories",
    "text_size": "14",
    "text_color": "#ffffff",
    "layout_width": "match_parent",
    "layout_weight": "1",
    "background_color": "#123456",
    "gravity": "center_horizontal",
    "font": "font/open-sans/OpenSans-SemiboldItalic.ttf"
  }
```

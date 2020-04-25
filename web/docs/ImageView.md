# ImageView
## schema pattern

* type = "ImageView"
* url
* id = define unique view id, 
  puts contents into cache ImageView:{id} 

* layout_width
* layout_height
* gravity
* background_color
* padding 
* margin

Related:
[Button](Button.md) 
[TextView](TextView.md) 
[EditText](EditText.md) 
[CheckBox](CheckBox.md) 
[Switch](Switch.md) 
[ToggleButton](ToggleButton.md) 
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 


Example:
```json
{
  "type": "ImageView",
  "url_script": "'file://'+ eigenFragment.getCacheFilePath('ImageView.png')",
  "layout_width": "match_parent",
  "layout_height": "match_parent",
  "background_color": "#123456",
  "on_click": {
     "type": "JavaScript",
     "script": "eigenActivity.showToast('image click eigenframe')"
  }
}
```

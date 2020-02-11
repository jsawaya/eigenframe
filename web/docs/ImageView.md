# ImageView
## schema pattern

* type = "ImageView"
* url
* id = define unique view id, 
  puts contents into cache TextView:{id} 

* layout_width
* layout_height
* gravity
* background_color
* padding 
* margin

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

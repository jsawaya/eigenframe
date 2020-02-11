# EditText
## schema pattern

Example:
```json
    {
      "type": "EditText",
      "id": 991001,
      "text": "git-repos/eigenframe",
      "max_length": 200,
      "is_single_line": true,
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
```

      "type": "EditText",
      "id": 991001,
      "text": "git-repos/eigenframe",
      "max_length": 200,
      "is_single_line": true,
      "layout_width": "match_parent",
      "text_color": "#ffffff",
      "text_size": "20",
      "gravity": "left",
      "background_color": "#000000",
      "margin": {

* type = "EditText"
* is_password = true | false (default)
* is_single_line = true | false (default)
* filter: [filter attribute](./web/docs/EditText-filter.md)
* text | text_script
* url
* ssh / is_toast = true | false
* sftp
* id = define unique view id, 
  puts contents into cache TextView:{id} 

* text_color
* text_size
* font: [font attribute](./web/docs/font.md)
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin



# EditText
## schema pattern

* type = "EditText"
* is_password = true | false (default)
* is_single_line = true | false (default)
* max_length, max_length_script
* filter: [filter attribute](EditText-filter.md)
* input source:
  - text | text_script
  - url
  - ssh 
  - sftp
* id = define unique view id, puts contents into cache EditText:{id} 

* text_color
* text_size, text_size_script
* font: [font attribute](font.md)
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin

Related:
[TextView](TextView.md) 

UserID Example:
```json
    {
      "type": "EditText",
      "id": 88800,
      "max_length": 40,
      "filter": "no-whitespace",
      "is_single_line": true,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#000000"
    }
```

Password Example:
```json
    {
      "type": "EditText",
      "id": 88801,
      "is_password": true,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text_color": "#ffffff",
      "background_color": "#000000",
      "text": "password"
    }
```


Host/IP Example:
```json
    {
      "type": "EditText",
      "id": 88802,
      "max_length": 40,
      "filter": "no-whitespace",
      "is_single_line": true,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text": "localhost",
      "text_color": "#ffffff",
      "background_color": "#000000"
    }
```


SSH Port Example:
```json
    {
      "type": "EditText",
      "id": 88803,
      "max_length": 6,
      "filter": "digits",
      "is_single_line": true,
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text": "8022",
      "text_color": "#ffffff",
      "background_color": "#000000"
    }
```


Example:
```json
```


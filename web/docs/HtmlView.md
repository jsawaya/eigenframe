# HtmlView
## schema pattern

* type = "HtmlView"
* html
* url
* id = define unique view id, puts contents into cache HtmlView:{id} 
* text_size, text_size_script
* text_color
* layout_width
* layout_height
* gravity
* background_color
* icon
* padding 
* margin

Related:
[TextView](TextView.md) 
[ImageView](ImageView.md) 
[WebView](WebView.md) 


Example:
```json
    {
      "type": "HtmlView",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "text_size": "14",
      "gravity": "CENTER_HORIZONTAL, CENTER_VERTICAL",
      "text_color": "#ffffff",
      "icon": {
        "name": "info.jpg",
        "location": "left"
      },
      "html": "example-links: <hr/> google.com<p/> https://en.wikipedia.org/wiki/Pretty_Good_Privacy#OpenPGP <p/>internal-icon: <img src='play.'>"
    }
```

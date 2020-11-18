# WebView
## schema pattern

* type = "WebView"
* layout_width
* layout_height
* source:
  - html
  - url
** is_javascript_enabled : true | false (default)

Related:
[TextView](TextView.md) 
[HtmlView](HtmlView.md) 
[ImageView](ImageView.md) 


Example:
```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "layout_height": "match_parent",
  "component_list": [
    {
      "type": "WebView",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "html": "<html><body><h1>PhotoPGP.com</h1></body></html>"
    },
    {
      "type": "WebView",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "url": "http://photopgp.com/site",
      "is_javascript_enabled": true
    }
  ]
}
```







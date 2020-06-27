# Define
## schema pattern

* type: "Define"
* name: name becomes filename in private file cache
  - note: name does not support javascript sourcing (name_script)

* component

Related:
[Clone](Clone.md) 

Example:
```json
{
  "type": "ActionList",
  "component_list": [
    {
      "type": "Define",
      "name": "HorizontalLine",
      "component": {
        "type": "HorizontalLine",
        "size": 3,
        "color": "#666666"
      }
    },
    {
      "type": "Define",
      "name": "VerticalLine",
      "component": {
        "type": "VerticalLine",
        "size": 3,
        "color": "#666666"
      }
    },
    {
      "type": "Define",
      "name": "TextViewLabel",
      "component": {
        "type": "TextView",
        "layout_width": "match_parent",
        "gravity": "left",
        "text_color": "#8aec81",
        "text_size": "22"
      }
    },
    {
      "type": "Define",
      "name": "TextViewDetail",
      "component": {
        "type": "TextView",
        "layout_width": "match_parent",
        "gravity": "left",
        "font": "font/droid-sans-mono/DroidSansMono.ttf",
        "text_color": "#ffffff",
        "text_size": "14"
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenDefault",
      "component": {
        "type": "PopupScreen",
        "layout_width": "match_parent",
        "text_size": "14",
        "text_color": "#ffffff",
        "background_color": "#222222"
      }
    },
    {
      "type": "Define",
      "name": "ButtonDefault",
      "component": {
        "type": "Button",
        "text": "Button Text",
        "text_color": "#ffffff",
        "background_color": "#654321",
        "gravity": "center",
        "layout_width": "match_parent",
        "margin": {
          "left": 10,
          "top": 10,
          "right": 10,
          "bottom": 10
        }
      }
    },
    {
      "type": "Define",
      "name": "LayoutVerticalScrollable",
      "component": {
        "type": "LinearLayout",
        "scrollable": true,
        "orientation": "vertical",
        "gravity": "center_horizontal",
        "layout_width": "match_parent"
      }
    }
  ],
  "on_complete": {
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/1.4/web/frames/playlist.json"
  }
}
```



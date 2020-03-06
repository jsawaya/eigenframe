# ListView
## schema pattern

* type = "ListView"
* id = define unique id to store the view-state
* layout_width
* layout_height
* gravity
* background_color
* item_layout - define the layout for each list item
* on_click action script

ListView support for dynamic lists:
* checked_option
* option_list

ListView support for file lists:
* cached_filename : "SecureFtp:{id}"
* dir_type: subdir | files | links
 
Related:
[SelectDialog](SelectDialog.md) 
[Spinner](Spinner.md) 


Example:
```json
    {
      "type": "ListView",
      "id": 700,
      "layout_width": "match_parent",
      "layout_height": "match_parent",
      "background_color": "#123456",
      "checked_option": 1,
      "option_list": [
        "test1.txt.asc",
        "test1.json",
        "test1.zip",
        "test1.pdf",
        "test2.txt.asc",
        "test2.json",
        "test3.zip",
        "test4.pdf",
        "test4.txt.asc",
        "test5.json",
        "test5.zip",
        "test5.pdf"
      ],
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "var pos = eigenFragment.getOptionPosition()",
          "var opt = eigenFragment.getOptionLabel()",
          "eigenActivity.showToast('ListView row selected: '+ pos + ': ' + opt)"
        ]
      },
      "item_layout": {
        "type": "LinearLayout",
        "orientation": "horizontal",
        "gravity": "center_vertical",
        "layout_width": "wrap_content",
        "layout_height": "wrap_content",
        "component_list": [
          {
            "type": "Button",
            "layout_width": "wrap_content",
            "layout_height": "wrap_content",
            "text_script_list": [
              "eigenFragment.getOptionPosition() + ': ' + eigenFragment.getOptionLabel()"
            ],
            "text_color": "#ffffff",
            "background_color": "#123456",
            "padding": {
              "left": 20,
              "top": 20,
              "right": 20,
              "bottom": 20
            },
            "margin": {
              "left": 40,
              "top": 40,
              "right": 40,
              "bottom": 40
            },
            "on_click": {
              "type": "JavaScript",
              "script_list": [
                "var pos = eigenFragment.getOptionPosition()",
                "var opt = eigenFragment.getOptionLabel()",
                "eigenActivity.showToast('Button selected: '+ pos + ': ' + opt)"
              ]
            }
          }
        ]
      }
    }
```




# ListView
## schema pattern

* type = "ListView"
* id = define unique view id
* layout_width
* layout_height
* gravity
* background_color
* on_click action script
* item_layout - define the layout for each list item
* option_list | cached_filename

** cached_filename 

* on_complete

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

Example:
```json
        {
          "type": "ListView",
          "layout_width": "match_parent",
          "layout_height": "match_parent",
          "layout_weight": "1",
          "background_color": "#123456",
          "cached_filename": "SecureFtp:991004",
          "dir_type": "subdir",
          "on_click": {
            "type": "ActionList",
            "component_list":
            [
              {
                "type": "JavaScript",
                "script_list": [
                  "var pos = eigenFragment.getOptionPosition()",
                  "var opt = eigenFragment.getOptionLabel()",
                  "eigenActivity.showToast('ListView row selected: '+ pos + ' - ' + opt)",
                  "eigenFragment.appendPath(991002, opt)",
                  "eigenFragment.closePopupWindow()"
                ]
              },
              {
                "type": "SecureFtp",
                "comment": "call sftp this way when you don't need immediate results for a TextView",
                "id": 991004,
                "sftp_script": "'directory ' + eigenFragment.concatPaths(991000, 991001, 991002)",
                "on_complete": {
                  "type": "PopupScreen",
                  "layout_width": "match_parent",
                  "layout_height": "wrap_content",
                  "text_size": "14",
                  "text_color": "#ffffff",
                  "background_color": "#111111",
                  "title_script": "''+ eigenFragment.concatPaths(991000, 991001, 991002)",
                  "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/ssh-git-admin-listview.json"
                }
              }
            ]
          },
          "item_layout": {
            "type": "LinearLayout",
            "orientation": "horizontal",
            "layout_width": "wrap_content",
            "layout_height": "wrap_content",
            "gravity": "center_vertical",
            "component_list": [
              {
                "type": "TextView",
                "text_script": "eigenFragment.getOptionPosition() + ': ' + eigenFragment.getOptionLabel()",
                "text_color": "#ffffff",
                "background_color": "#123456",
                "margin": {
                  "left": 40,
                  "top": 40,
                  "right": 40,
                  "bottom": 40
                }
              }
            ]
          }
        }
```



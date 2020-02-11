# Define
## schema pattern

* type: "Define"
* name 
* component

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
    },
    {
      "type": "Define",
      "name": "EditTextRemoteFilePath",
      "component": {
        "type": "EditText",
        "id": 999001,
        "max_length": 200,
        "is_single_line": true,
        "layout_width": "match_parent",
        "text": "",
        "text_color": "#ffffff",
        "background_color": "#000000",
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
      "name": "EditTextLocalFileCache",
      "component": {
        "type": "EditText",
        "url_script": "'file://' + eigenFragment.getCacheFilePath('EditText:999000') ",
        "id": 999000,
        "gravity": "left",
        "layout_width": "match_parent",
        "text_color": "#ffffff",
        "background_color": "#000000"
      }
    },
    {
      "type": "Define",
      "name": "ButtonSaveEditsToRemoteFile",
      "component": {
        "type": "Clone",
        "name": "ButtonDefault",
        "attributes": {
          "text": "Save Edits to Remote File",
          "icon": {
            "name": "save.",
            "location": "top"
          },
          "on_click": {
            "type": "ActionList",
            "component_list": [
              {
                "type": "SecureFtp",
                "sftp_script": "'put EditText:999000 ' + eigenFragment.getViewState(999001)",
                "on_complete": {
                  "type": "JavaScript",
                  "script_list": [
                    "var x1 = eigenFragment.clearCacheFile('EditText:999000')",
                    "eigenActivity.showToast('Local File Cache Status: ' + x1 )",
                    "eigenFragment.closePopupScreen(999099)"
                  ]
                }
              },
              {
                "type": "x-JavaScript",
                "comment": "closePopupWindow needs to be here, rather than inside SecureFtp(on-complete)/JavaScript, because it seeks parent views to find PopupScreen",
                "script_list": [
                  "eigenFragment.closePopupWindow()"
                ]
              }
            ]
          }
        }
      }
    },
    {
      "type": "Define",
      "name": "ButtonCancelLocalEdits",
      "component": {
        "type": "Clone",
        "name": "ButtonDefault",
        "attributes": {
          "text": "Cancel Local Edits",
          "icon": {
            "name": "cancel.",
            "location": "top"
          },
          "on_click": {
            "type": "JavaScript",
            "script_list": [
              "var x1 = eigenFragment.clearCacheFile('EditText:999000')",
              "eigenActivity.showToast('Edit Cache: ' + x1 )",
              "eigenFragment.closePopupScreen(999099)"
            ]
          }
        }
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenEdit",
      "component": {
        "type": "Clone",
        "name": "PopupScreenDefault",
        "attributes": {
          "id": 999099,
          "title_script": "'Remote file: '+eigenFragment.getViewState(999001)",
          "component_list": [
            {
              "type": "Clone",
              "name": "LayoutVerticalScrollable",
              "attributes": {
                "component_list": [
                  {
                    "type": "Clone",
                    "name": "ButtonSaveEditsToRemoteFile"
                  },
                  {
                    "type": "Clone",
                    "name": "ButtonCancelLocalEdits"
                  },
                  {
                    "type": "Clone",
                    "name": "EditTextLocalFileCache"
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenShowRemoteFile",
      "component": {
        "type": "Clone",
        "name": "PopupScreenDefault",
        "attributes": {
          "title_script": "'Remote file: '+eigenFragment.getViewState(999001)",
          "component_list": [
            {
              "type": "Clone",
              "name": "LayoutVerticalScrollable",
              "attributes": {
                "component_list": [
                  {
                    "type": "Clone",
                    "name": "TextViewDetail",
                    "attributes": {
                      "ssh_script": "'cat ' + eigenFragment.getViewState(999001)"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenEditRemoteFile",
      "component": {
        "type": "SecureFtp",
        "sftp_script": "'get ' + eigenFragment.getViewState(999001) + ' EditText:999000'",
        "on_complete": {
          "type": "Clone",
          "name": "PopupScreenEdit"
        }
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenImage",
      "component": {
        "type": "Clone",
        "name": "PopupScreenDefault",
        "attributes": {
          "title_script": "'Remote file: '+eigenFragment.getViewState(999001)",
          "component_list": [
            {
              "type": "Clone",
              "name": "LayoutVerticalScrollable",
              "attributes": {
                "component_list": [
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
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "Define",
      "name": "PopupScreenImageRemoteFile",
      "component": {
        "type": "SecureFtp",
        "sftp_script": "'get ' + eigenFragment.getViewState(999001) + ' ImageView.png'",
        "on_complete": {
          "type": "Clone",
          "name": "PopupScreenImage"
        }
      }
    },
    {
      "type": "Define",
      "name": "SetIsSourceButton",
      "component": {
        "type": "Switch",
        "id": 999300,
        "text": "Enable Source Button",
        "checked_script": "eigenFragment.getBooleanVariable('IsSourceButton', 0, true)",
        "text_color": "#ffffff",
        "background_color": "#654321",
        "icon": {
          "name": "pageview.",
          "location": "top"
        },
        "margin": {
          "left": 10,
          "top": 10,
          "right": 10,
          "bottom": 10
        },
        "padding": {
          "left": 30,
          "top": 30,
          "right": 30,
          "bottom": 30
        },
        "on_click": {
          "type": "JavaScript",
          "script_list": [
            "var b1 = eigenFragment.getViewState(999300) == 1",
            "eigenFragment.setBooleanVariable('IsSourceButton', 0, b1)",
            "eigenActivity.showToast('IsSourceButton: ' + b1)"
          ]
        }
      }
    }
  ],
  "on_complete": {
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
  }
}
```


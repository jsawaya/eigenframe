# eigenframe

* Open frames via url request 
* Open frames via ssh request

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "component_list": [
    {
      "type": "HtmlView",
      \...
    }
  ]
}
```

```javascript
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "component_list": [
    {
      "type": "HtmlView",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "x_gravity": "center_horizontal",
      "gravity": "center",
      "x_text_size": "14",
      "text_color": "#ffffff",
      "html_list": [
        "<img src='ic_launcher.png'>",
        "<h1><font color=\"#8aec81\">EigenFrame: a platform to launch dynamic apps</font></h1>",
        "<h4><i>Visit https://github.com/jsawaya/eigenframe repository for more info </i></h4>"
      ]
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Set Screen Orientation:",
      "gravity": "left"
    },
    {
      "type": "Switch",
      "id": 321,
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Automatic Orientation",
      "gravity": "center",
      "checked": false,
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.enableOrientationEventListener(eigenFragment.getViewIdState(321) != 0)"
        ]
      }
    },
    {
      "type": "LinearLayout",
      "orientation": "horizontal",
      "gravity": "center_horizontal",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "component_list": [
        {
          "type": "Button",
          "layout_width": "wrap_content",
          "layout_height": "wrap_content",
          "text": "landscape",
          "text_color": "#ffffff",
          "background_color": "#123456",
          "margin": {
            "left": 10,
            "top": 10,
            "right": 10,
            "bottom": 10
          },
          "on_click": {
            "type": "JavaScript",
            "script_list": [
              "eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE)"
            ]
          }
        },
        {
          "type": "Button",
          "layout_width": "wrap_content",
          "layout_height": "wrap_content",
          "text": "portrait",
          "text_color": "#ffffff",
          "background_color": "#123456",
          "margin": {
            "left": 10,
            "top": 10,
            "right": 10,
            "bottom": 10
          },
          "on_click": {
            "type": "JavaScript",
            "script_list": [
              "eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)"
            ]
          }
        }
      ]
    },
    {
      "type": "LinearLayout",
      "orientation": "horizontal",
      "gravity": "center_horizontal",
      "layout_width": "match_parent",
      "layout_height": "wrap_content",
      "component_list": [
        {
          "type": "Button",
          "layout_width": "wrap_content",
          "layout_height": "wrap_content",
          "text": "landscape-reverse",
          "text_color": "#ffffff",
          "background_color": "#123456",
          "margin": {
            "left": 10,
            "top": 10,
            "right": 10,
            "bottom": 10
          },
          "on_click": {
            "type": "JavaScript",
            "script_list": [
              "eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE)"
            ]
          }
        },
        {
          "type": "Button",
          "layout_width": "wrap_content",
          "layout_height": "wrap_content",
          "text": "portrait-reverse",
          "text_color": "#ffffff",
          "background_color": "#123456",
          "margin": {
            "left": 10,
            "top": 10,
            "right": 10,
            "bottom": 10
          },
          "on_click": {
            "type": "JavaScript",
            "script_list": [
              "eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT)"
            ]
          }
        }
      ]
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Launch apps directly from the local Android filesystem"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "launch this initial application (again),\nthen press back-button to exit",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.launch('file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/app.json')"
        ]
      }
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Launch apps from an internet/cloud server\n(like Github, for example):"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Gallery of examples",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.launch('https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/apps/app1.json')"
        ]
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Photo application demo",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.launch('https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/apps/app0.json')"
        ]
      }
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Launch apps from Apache2 HTTP service (CGI):"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Gallery of examples",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "JavaScript",
        "script_list": [
          "eigenActivity.launch('http://localhost:8080/apps/app1_localhost.json')"
        ]
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "show apache2 error log",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "http://localhost:8080/cgi-bin/sys-list-error-log.sh",
        "url": "http://localhost:8080/cgi-bin/sys-list-error-log.sh"
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "test httpd service response",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=/data/data/com.termux/files/home",
        "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=/data/data/com.termux/files/home"
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "File System Explorer\n(Dynamic Application Demo)",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupScreen",
        "layout_width": "match_parent",
        "layout_height": "wrap_content",
        "text_size": "20",
        "text_color": "#ffffff",
        "background_color": "#111111",
        "text": "EigenFrame",
        "url": "http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=/data/data/com.termux/files/home"
      }
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Launch apps from a Ruby HTTP service:"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "test ruby webrick service response",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "http://localhost:1234/listdir?dirpath=/data/data/com.termux/files/home",
        "url": "http://localhost:1234/listdir?dirpath=/data/data/com.termux/files/home"
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "File System Explorer\n(Dynamic Application Demo)",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupScreen",
        "layout_width": "match_parent",
        "layout_height": "wrap_content",
        "text_size": "20",
        "text_color": "#ffffff",
        "background_color": "#111111",
        "text": "Ruby http server (webrick):",
        "url": "http://localhost:1234/listdir?dirpath=/data/data/com.termux/files/home"
      }
    },
    {
      "type": "HorizontalLine",
      "size": 3,
      "color": "#666666"
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Launch apps from SecureShell:"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "File System Explorer\n(Dynamic Application Demo)",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupScreen",
        "layout_width": "match_parent",
        "layout_height": "wrap_content",
        "text_size": "20",
        "text_color": "#ffffff",
        "background_color": "#111111",
        "text": "File system explorer",
        "icon": {
          "name": "info.jpg",
          "location": "left"
        },
        "component_list": [
          {
            "type": "TextView",
            "layout_width": "match_parent",
            "layout_height": "wrap_content",
            "text": "SecureShell calls ruby to generate the following components:",
            "text_size": "20",
            "gravity": "CENTER_HORIZONTAL, CENTER_VERTICAL",
            "text_color": "#ffffff"
          },
          {
            "type": "SecureShell",
            "is_eigen_response": true,
            "ssh_list": [
              "cd /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin",
              "ruby test-dir-list.rb /data/data/com.termux/files/home"
            ]
          }
        ]
      }
    },
    {
      "type": "TextView",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text_color": "#8aec81",
      "text_size": "22",
      "text": "Install and configure services using SecureShell"
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Access Termux app services",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "Use ssh to access Termux services and filesystem",
        "font": "font/droid-sans-mono/DroidSansMono.ttf",
        "ssh_list": [
          "echo List of processes:",
          "ps -e",
          "echo ",
          "echo List of files in Termux home directory:",
          "ls -la"
        ]
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Termux Package Update",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "Termux Package Update",
        "font": "font/droid-sans-mono/DroidSansMono.ttf",
        "ssh_list": [
          "echo Package update:",
          "echo y | pkg update"
        ]
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Pull github updates",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "git checkout master, pull, checkout test, merge, status",
        "font": "font/droid-sans-mono/DroidSansMono.ttf",
        "ssh_list": [
          "cd /data/data/com.termux/files/home/git-repos/eigenframe",
          "echo current working directory:",
          "pwd",
          "echo ",
          "echo git status:",
          "git status",
          "echo ",
          "echo git checkout master:",
          "git checkout master",
          "echo ",
          "echo git pull:",
          "git pull",
          "echo ",
          "echo git checkout test:",
          "git checkout test",
          "echo ",
          "echo git merge master:",
          "git merge master",
          "echo ",
          "echo git status:",
          "git status"
        ]
      }
    },
    {
      "type": "Button",
      "layout_width": "wrap_content",
      "layout_height": "wrap_content",
      "text": "Check if ruby webrick process is currently running",
      "text_color": "#ffffff",
      "background_color": "#123456",
      "margin": {
        "left": 10,
        "top": 10,
        "right": 10,
        "bottom": 10
      },
      "on_click": {
        "type": "PopupTextView",
        "title": "Use ssh to access Termux services",
        "font": "font/droid-sans-mono/DroidSansMono.ttf",
        "ssh_list": [
          "echo Webrick?",
          "ps -eo cmd | grep -n 'ruby' | grep -v 'grep'"
        ]
      }
    }
  ]
}

```

# EigenFrame
## Platform for dynamic systems on Android

EigenFrame is similar to a web-browser in that it starts with a url request.  

Instead of getting a simple web page, EigenFrame gets the specifications to dynamically build a custom application
including Android user-interface components and provides access to available camera hardware and device sensors.  

EigenFrame is openly programmable. 

More than just a web-browser, EigenFrame enables programmable scripting interfaces including
an embedded javascript interpreter with access to internal Android classes, methods and properties.  

In contrast, web-browsers have very limited scripting access to the host mobile device, from inside a browser window.  

EigenFrame includes a secure-shell client capability to interface with a local Termux app (with openssh)
to run your application scripts (bash, git, ruby, perl, python, prolog, gpg ...) to implement dynamic systems.

With EigenFrame you can also use cloud-based micro-services through asynchronous url/ssh requests to generate
dynamic EigenFrame screen components with secure system integration for a truly extensible architecture.

## Initial app-url request

EigenFrame starts with a url request to retrieve the application-level security specifications, 
permissions and tab-fragments.

There are 3 ways to perform the initial app-url request:
* launch the EigenFrame app with a default home-url
* use an EigenFrame short-cut (which contains the app-url)
* use one EigenFrame app to launch another EigenFrame app (and another). 

The home-url is defined in this eigenframe shared directory file:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/home-url.txt

This home-url file contains the following default app-url:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/app.json

As a simple example, app.json contains the following:
```json
{
  "is_secure_window": "true",
  "request_permissions": [
    "android.permission.CAMERA",
    "android.permission.WRITE_EXTERNAL_STORAGE",
    "android.permission.INTERNET"
  ],
  "tab_list": [
    {
      "icon_name": "ic_launcher.png",
      "type": "EigenFragment",
      "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/playlist.json"
    }
  ]
}
```


For example an app-spec might start with a vertical scrollable LinearLayout 
```json
{
  "type": "LinearLayout",
  "scrollable": true,
  "orientation": "vertical",
  "gravity": "center_horizontal",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "component_list": [
```
Next are the components of this LinearLayout 
```json

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

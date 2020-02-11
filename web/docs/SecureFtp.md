# SecureFtp
## schema pattern

Example:
```json
      {
        "type": "SecureFtp",
        "id": 991004,
        "sftp_script": "'directory ' + eigenFragment.concatPaths(991000, 991001, 991002)",
        "on_complete":
        {
          "type": "PopupScreen",
          "title_script": "''+ eigenFragment.concatPaths(991000, 991001, 991002)",
          "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/ssh-git-admin-listview.json",
          "layout_width": "match_parent",
          "text_size": "14",
          "text_color": "#ffffff",
          "background_color": "#111111"
        }
      }
```


* type = "SecureFtp"
* id
* sftp
** is_eigen_response : true | false (default)
* on_complete : action script begins when url response is available 






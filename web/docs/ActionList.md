# ActionList
## schema pattern

* type: "ActionList"
* component_list = list of actions

Related:
[Define](Define.md)  
[Variable](Variable.md)  
[Cache](Cache.md)  
[JavaScript](JavaScript.md)  
[UrlRequest](UrlRequest.md)  
[SecureShell](SecureShell.md)  
[SecureFtp](SecureFtp.md) 


Example:
```json
{
  "type": "ActionList",
  "component_list": [
    {
      "type": "JavaScript",
      "script_list": [
        "eigenFragment.parentPath(991002)",
        "eigenFragment.closePopupWindow()"
      ]
    },
    {
      "type": "SecureFtp",
      "comment": "call sftp this way when you don't need immediate results for a TextView",
      "id": 991004,
      "sftp_script": "'directory ' + eigenFragment.concatPaths(991000, 991001, 991002)",
      "on_complete":
      {
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
}
```



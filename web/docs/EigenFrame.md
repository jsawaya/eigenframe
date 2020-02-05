* type: "EigenFrame", a top-level application specification 
* is_secure_window: [true | false], true disables screen snapshots and android task-manager screen view
* request_permissions: list of required permission strings 
* tab_list: sequence of EigenFragment components

Example:
```json  
{
  "type": "EigenFrame",
  "is_secure_window": true,
  "request_permissions": [
    "android.permission.CAMERA"
  ],
  "tab_list": [
    {
      "icon_name": "ic_launcher.png",
      "type": "EigenFragment",
      "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/playlist.json"
    },
    {
      "name": "PlayList\nfrom github",
      "type": "EigenFragment",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
    }
  ]
```
}
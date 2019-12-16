type: "EigenFrame", a top-level application specification 
is_secure_window: true, disables screen snapshots, and android task-manager screen view
request_permissions: list of required permission strings 
tab_list: sequence of EigenFragment components

Example:
```json  
{
  "type": "EigenFrame",
  "is_secure_window": true | false,
  "request_permissions": [
    "android.permission.CAMERA",
    "android.permission.WRITE_EXTERNAL_STORAGE",
    "android.permission.INTERNET"
  ],
  "tab_list": [
    ...
  ]
```
}
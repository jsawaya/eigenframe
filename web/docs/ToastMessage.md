# ToastMessage
## schema pattern

* type = "ToastMessage"
* message | message_script 

Related:
[ActionList](ActionList.md) 
[SecureShell](SecureShell.md) 
[JavaScript](JavaScript.md) 


Example:
```json
{
  "type": "ToastMessage",
  "message_script": "'status: ' + status"
}
```

Equivalent:
```json
{
  "type": "JavaScript",
  "script": "eigenActivity.showToast('status: ' + status)"
}
```



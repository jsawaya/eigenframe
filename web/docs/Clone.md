# Clone
## schema pattern

* type: "Clone"
* name: reference to a cached Define name
* attributes

Related:
[Define](Define.md) 

Example:
```json
{
  "type": "Clone",
  "name": "HorizontalLine"
}
```

Example:
```json
{
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
```

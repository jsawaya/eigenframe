# Clone
## schema pattern

* type: "Clone"
* name: reference to a cached Define name
* attributes

Example:
```json
{
  "type": "Clone",
  "name": "HorizontalLine"
}
```

```json
{
  "type": "Clone",
  "name": "TextViewDetail",
  "attributes": {
    "ssh_script": "'cat ' + eigenFragment.getViewState(999001)"
  }
}
```

Example:
```json
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

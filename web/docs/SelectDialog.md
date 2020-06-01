# SelectDialog
## schema pattern

* "type": "SelectDialog"
* id : view id used get viewState
* "title": text string appears at top of popup dialog
* "icon": {"name"} icon appears adjacent to title (on left, by default)
* checked_option
* option_list
* on_click : action script event listener

Related:
[AlertDialog](AlertDialog.md) 
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 
[ListView](ListView.md) 
[PopupScreen](PopupScreen.md) 

Example:
```json
{
  "type": "SelectDialog",
  "title": "Test SelectDialog",
  "id": 111,
  "icon": {
    "name": "info."
  },
  "checked_option": 1,
  "option_list": [
    "option 0",
    "option 1",
    "option 2"
  ],
  "on_click": {
    "type": "JavaScript",
    "script_list": [
      "eigenActivity.showToast('SelectDialog: option: '+eigenFragment.getOptionLabel() + ', position: '+eigenFragment.getOptionPosition() );"
    ]
  }
}
```


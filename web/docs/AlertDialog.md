# AlertDialog
## schema pattern

AlertDialog defines a popup dialog with (1, 2 or 3) on_click actions to perform, or the user may click outside of the dialog to cancel, or press the back-button to cancel.

Use cases:
1) The alert dialog is created dynamically, so it is an action that may be called from anywhere.
2) At least one option must be defined (positive, negative, or neutral)
3) By using just one option (positive) the dialog may be used to CONFIRM the execution of some optional action.
4) By using two options (positive, negative) the dialog may be used to CHOOSE one of (2) possible choices.
4) By using three options (positive, negative, neutral) the dialog may be used to SELECT one of (3) possible choices.

Attributes:
* type: "AlertDialog"
* title: text string that appears at top of popup dialog
* icon: 
    - name: internal icon name
    - location
    - icon appears adjacent to title (on left, by default)
* positive: 
    - option: the positive label text 
    - on_click: action to perform 
* negative (optional): 
    - option: the negative label text 
    - on_click: action to perform 
* neutral (optional): 
    - option: the neutral label text 
    - on_click: action to perform 

Related:
[SelectDialog](SelectDialog.md) 
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 
[ListView](ListView.md) 
[PopupScreen](PopupScreen.md) 

Example:
```json
{
  "type": "Button",
  "layout_width": "match_parent",
  "layout_height": "wrap_content",
  "text": "Test AlertDialog",
  "text_color": "#ffffff",
  "background_color": "#22ff0000",
  "on_click": {
    "type": "AlertDialog",
    "title": "My AlertDialog",
    "icon": {
      "name": "info."
    },
    "positive": {
      "option": "YES",
      "on_click": {
        "type": "JavaScript",
        "script": "eigenActivity.showToast('AlertDialog says YES')"
      }
    },
    "negative": {
      "option": "NO",
      "on_click": {
        "type": "JavaScript",
        "script": "eigenActivity.showToast('AlertDialog says NO')"
      }
    },
    "neutral": {
      "option": "UNKNOWN",
      "on_click": {
        "type": "JavaScript",
        "script": "eigenActivity.showToast('AlertDialog says UNKNOWN')"
      }
    }
  }
}
```


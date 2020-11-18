# PopupScreen
## schema pattern

PopupScreen is a dynamic fullscreen layout so it can be declared as an action event listener (e.g. on_click | on_complete).
The contents of the screen are sourced synchronously from the component_list, or asynchronously from the url.

* type = "PopupScreen"
* id is an integer that uniquely identifies this screen from other popup screens 
   - the purpose of the id is to allow another component or action to close this popup screen programmatically.
   - screen id only needs to be unique with respect to other popup-screens, it does not need to unique with respect to all other view ids
* background_color
* title | title_script
* text_size, text_size_script
* text_color
* gravity
* icon 
* padding
* margin
* component_list | url | url_script

Related:
[LinearLayout](LinearLayout.md) 
[AlertDialog](AlertDialog.md)
[SelectDialog](SelectDialog.md) 
[PopupTextView](PopupTextView.md) 
[PopupHtmlView](PopupHtmlView.md) 
[JavaScript](JavaScript.md) 
[UrlRequest](UrlRequest.md) 
[SecureShell](SecureShell.md) 
[SecureFtp](SecureFtp.md)
[ActionList](ActionList.md)



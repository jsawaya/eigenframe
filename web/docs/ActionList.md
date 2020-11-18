# ActionList
## schema pattern

ActionList defines a sequence of actions to perform, followed by an optional on_complete listener to create a layout, component or action.

Use cases:
1) The action list may contain any number of different action types (JavaScript, SecureFtp, ...) called as single action.
2) The action list may contain any number of prerequisite actions (e.g. Define) that may be required before calling a particular in-line layout or component.  See [Define-Clones](../frames/define-clones.json)


Attributes:
* type: "ActionList"
* component_list: sequence of actions to perform
* on_complete (optional): event listener to call layout, component, or action that may produce an eigen-response
  - Here is an example at the end of define-clones.json where "on_complete" loads a UrlRequest.
```json
  "on_complete": {
    "type": "UrlRequest",
    "is_eigen_response": true,
    "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/playlist.json"
  }
```

Notes: Any asynchronous actions that may be called (url, ssh, ftp) are not necessarily finished when the ActionList on_complete is called - for this use case, you would instead need to use the on_complete attribute associated with each of your asynchronous actions.  This is easy; in each on_complete action, just set a variable to flag the completion and call the final action (which would check if all the preconditions have been met).  

Related:
[Define](Define.md) 
[JavaScript](JavaScript.md) 
[UrlRequest](UrlRequest.md) 
[SecureShell](SecureShell.md) 
[SecureFtp](SecureFtp.md)





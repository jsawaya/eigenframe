## Tabs / EigenFragment

An Android activity is typically composed of several fragments that can be dynamically loaded and unloaded to manage system resources.

As a simple way to define muliple fragments, tabs also provide a way to select which fragments are currently active, although your app design may choose to hide this particular feature by using PopupScreen components.

The tab_list may define any number of fragments that load and activate as you select them.

Fragments associated with adjacent tabs are also activated.

Tabs can either be selected with the user interface, or selected programmatically.

Tabs can have a "name" attribute and/or an "icon_name" attribute to define the tab label.

* type: "EigenFragment", represents a tab/fragment specification 
* name: tab title
* icon_name: [Internal Icons](./icon.md)
* url: attribute to dynamically load layouts, components and actions.

Related:
[EigenFrame](EigenFrame.md)

Example:
```json
{
  "type": "EigenFrame",
  "is_secure_window": "true",
  "tab_list": [
    {
      "type": "EigenFragment",
      "name": "Startup",
      "icon_name": "ic_launcher_round.",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/define-clones.json"
    },
    {
      "type": "EigenFragment",
      "name": "Readme",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/eigenframe-readme.json"
    },
    {
      "type": "EigenFragment",
      "name": "About",
      "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/about.json"
    }
  ]
}
```

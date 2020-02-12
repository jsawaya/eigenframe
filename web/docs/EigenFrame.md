## EigenFrame App Url

EigenFrame starts with an app url request to enable window security feature, 
and tab-fragment specifications.  

There are 3 ways to perform an EigenFrame app url request:
* launch the default EigenFrame app (which uses the default home-url)
* launch an EigenFrame short-cut (which contains an EigenFrame app url) - see Startup tab for example.
* or an EigenFrame app can be designed to launch the url of another EigenFrame app.

The home-url is located in the eigenframe shared directory file: 
> /storage/emulated/0/Android/data/com.sawaya.eigenframe/files/home-url.txt

This home-url file contains the following default app url:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/app.json

As an sample, the home-url may return the following EigenFrame app specification:

* type: "EigenFrame", the top-level application specification 
* is_secure_window: [true | false], true disables screen snapshots and android task-manager screen view
* tab_list: sequence of EigenFragment components

Related:
[EigenFragment](EigenFragment.md)  

Example:
```json
{
  "type": "EigenFrame",
  "is_secure_window": "true",
  "tab_list": [
    {
      "icon_name": "ic_launcher_round.",
      "name": "Startup",
      "type": "EigenFragment",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/define-clones.json"
    },
    {
      "name": "Readme",
      "type": "EigenFragment",
      "url": "https://raw.githubusercontent.com/jsawaya/eigenframe/master/web/frames/eigenframe-readme.json"
    },
    {
      "name": "About",
      "type": "EigenFragment",
      "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/about.json"
    }
  ]
}
```

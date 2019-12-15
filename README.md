# EigenFrame
## Platform for dynamic systems on Android

EigenFrame is similar to a web-browser in that it starts with a url request.  

Instead of getting a simple web page, EigenFrame gets the specifications to dynamically build a custom application
including Android user-interface components and provides access to available camera hardware and device sensors.  

EigenFrame is openly programmable. 

More than just a web-browser, EigenFrame enables programmable scripting interfaces including
an embedded javascript interpreter with access to internal Android classes, methods and properties.  

In contrast, web-browsers have very limited scripting access to the host mobile device, from inside a browser window.  

EigenFrame includes a secure-shell client capability to interface with a local Termux app (with openssh)
to run your own application scripts (bash, git, ruby, perl, python, prolog, gpg ...).

You can also use cloud-based micro-services through asynchronous url/ssh requests to generate
dynamic EigenFrame screen components for secure system integration and a truly extensible architecture.

EigenFrame specifications are represented in JSON format.

## Initial app-url request

EigenFrame starts with a url request to retrieve the application-level security specifications, 
permissions and tab-fragments.  

There are 3 ways to perform the initial app-url request:
* launch the EigenFrame app with a default home-url
* use an EigenFrame short-cut (which contains the app-url)
* use one EigenFrame app to launch another EigenFrame app (and then another)

The home-url is defined in this eigenframe shared directory file:
> /storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/home-url.txt

This home-url file contains the following default app-url:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/app.json

As a simple example, this app-url returns the following specifications:
```json
{
  "is_secure_window": "true",
  "request_permissions": [
    "android.permission.CAMERA",
    "android.permission.WRITE_EXTERNAL_STORAGE",
    "android.permission.INTERNET"
  ],
  "tab_list": [
    {
      "icon_name": "ic_launcher.png",
      "type": "EigenFragment",
      "url": "file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/playlist.json"
    }
  ]
}
```
Android activities are typically composed of several fragments that can be dynamically loaded and unloaded to manage system resources.

Tabs are an easy way to select which fragments are currently active, although your app designs may 
choose to hide this particular feature by using EigenScreen specifications.

The tab_list can define any number of fragments that load as you select them.  

Tabs can either be selected with the user interface, or programmatically selected.

Tabs can have a "name" attribute and/or an "icon_name" attribute to define the tab label.  

Tabs of "type": "EigenFragment" have the "url" attribute to load components dynamically. 

## EigenFrame components

A fragment can layout scrollable components below the tab selection area, 
or create any number of new screen components.

Here are the types of component specifications:

Component type | Description | Examples
-------------- | ----------- | --------  
EigenFragment  | Found only in app-level tab_list specifications | [Examples](./web/apps)

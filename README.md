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
choose to hide this particular feature by using PopupScreen components.

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
EigenFrame  | component that represents a top-level application specification | [examples](./web/apps)
EigenFragment  | component that represents each tab/fragment in an application | [examples](./web/apps)
PopupScreen | component that represents a collection of components as a fullscreen window | 
[LinearLayout](./web/docs/LinearLayout.md)  | sequence of components arranged vertically or horizontally | [examples](./web/frames)
RelativeLayout | not implemented yet |
ConstraintLayout | not implemented yet |
TextView  | component shows plain text | [examples](./web/frames), 
HtmlView  | component shows simple html, internal-icons, and simple web-links | [examples](./web/frames), 
ImageView  | component shows images and external-icons | [examples](./web/frames), 
WebView  | component shows elaborate html, and url web-page  - javascript capable  | [examples](./web/frames), 
HorizontalLine | component that shows a horizontal line <hr/> to separate components in vertical LinearLayout |  
VerticalLine | component that shows a vertical line to separate components in horizontal LinearLayout |  
EditText | component that represents a string value, shows an editable text area |
Button  | component that shows plain text and has an "on_click" callback attribute  | [examples](./web/frames), 
ToggleButton | component that represents a integer value [0, 1], shows as bi-modal button label |  
CheckBox | component that represents a small box with or without a check mark, with integer value [0, 1] |  
Switch | component that represents a  small switch [off, on] with integer value [0, 1] |  
RadioButton | component that represents a multiple-choice option-list, and a selected index | 
Spinner | component that represents a popup multiple-choice option-list, and a selection index |   
ListView | component that represents a multiple-choice option-list, with a row layout and a selected index |
SelectDialog | component that represents a popup multiple-choice option-list selection index| 
AlertDialog | component represents a popup multiple-choice option-list | [examples](./web/frames), 

PopupHtmlView | component that shows a small transient popup html window | 
PopupTextView | component that shows a small transient popup text window | 
JavaScript | component calls embedded javascript  | [examples](./web/frames), 
SecureShell | component represents ssh commands |
UrlRequest | component represents url request - not fully tested |
Variable | component, not implemented yet |
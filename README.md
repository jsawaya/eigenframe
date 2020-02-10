# ![Alt](web/res/icon/mipmap-mdpi/ic_launcher_round.png "eigenframe") EigenFrame
## Framework to Generate Android Apps

EigenFrame starts with a url request, but instead of getting a simple web page, 
EigenFrame parses specifications (represented in JSON format) to dynamically build an openly programmable application that 
includes Android user-interface components, and provides access to certain device sensors and hardware.  

More than just a web-browser, EigenFrame has an embedded javascript interpreter with access to internal Android classes,
methods and properties, and a secure-shell client capability to interface with a local Termux app (with openssh)
to integrate *your own* application scripts, in whatever language/tool you choose (bash, git, ruby, perl, python, prolog, gpg ...).
In contrast, web-browsers only have limited scripting access to the host mobile device, from inside a browser window.  

EigenFrame provides asynchronous url/ssh/sftp requests, so you can use cloud-based services, or local Termux services 
(like: Apache2/CGI, or Ruby Webrick) to generate dynamic EigenFrame components - the github jsawaya/eigenframe repository includes examples. 
 
EigenFrame - a truly extensible architecture for dynamic system integration.

## EigenFrame app url

EigenFrame starts with an app url request to enable window security feature, 
and tab-fragment specifications.  

There are 3 ways to perform an EigenFrame app url request:
* launch the default EigenFrame app (which uses the default home-url)
* launch an EigenFrame short-cut (which contains an EigenFrame app url) - see Startup tab for example.
* or an EigenFrame app can be designed to launch the url of another EigenFrame app.

The home-url is defined in this eigenframe shared directory file - this 
> /storage/emulated/0/Android/data/com.sawaya.eigenframe/files/home-url.txt

This home-url file contains the following default app-url:
> file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/app.json

As an sample, the home-url may return the following EigenFrame app specification:
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

## EigenFrame Activity and Tabs/Fragments

An Android activity is typically composed of several fragments that can be dynamically loaded and unloaded to manage system resources.

As a simple way to define muliple fragments, tabs also provide a way to select which fragments are currently active, 
although your app design may choose to hide this particular feature by using PopupScreen components.

The tab_list may define any number of fragments that load and activate as you select them.  

Fragments associated with adjacent tabs are also activated.

Tabs can either be selected with the user interface, or selected programmatically.

Tabs can have a "name" attribute and/or an "icon_name" attribute to define the tab label.  

Tabs of "type": "EigenFragment" have the "url" attribute to dynamically load layouts, components and actions. 

### App-level specifications:

App spec | Description 
-------------- | ----------- 
[EigenFrame](./web/docs/EigenFrame.md)  | represents the top-level application specification 
[EigenFragment](./web/docs/EigenFragment.md)  | a tab/fragment can layout components within the tab selection area. 


### EigenFrame Layouts:

Layout type | Description 
----------- | ----------- 
[PopupScreen](./web/docs/PopupScreen.md) | layout a sequence of components in a new fullscreen window, and hides tabs (also an Action type) 
[LinearLayout](./web/docs/LinearLayout.md)  | sequence of components arranged vertically or horizontally, possibly scrollable 
RelativeLayout | not implemented yet 
ConstraintLayout | not implemented yet 

### EigenFrame Components

Component type | Description 
-------------- | ----------- 
[Button](./web/docs/Button.md)  | stateless component shows plaintext, with optional icon and has an "on_click" callback attribute  
[TextView](./web/docs/TextView.md)  | shows plain text, with built-in fonts 
[HtmlView](./web/docs/HtmlView.md)  | shows simple html, internal-icons, and simple web-links 
[WebView](./web/docs/WebView.md)  | shows elaborate html, and url web-page  - javascript capable 
[ImageView](./web/docs/ImageView.md)  | shows images and external-icons 
[EditText](./web/docs/EditText.md) | a string value, with an editable text area for state value 
[CheckBox](./web/docs/CheckBox.md) | a small box with or without a check mark, with integer value [0, 1] 
[Spinner](./web/docs/Spinner.md) | a popup multiple-choice option-list, and a selection index 
[Switch](./web/docs/Switch.md) | a small switch [off, on] with an integer state value [0, 1] 
[ToggleButton](./web/docs/ToggleButton.md) | bi-modal button label with an integer state value [0, 1] 
[RadioButton](./web/docs/RadioButton.md) | a multiple-choice option-list, and a selected index 
[HorizontalLine](./web/docs/HorizontalLine.md) | a horizontal line <hr/> to separate components in vertical LinearLayout 
[VerticalLine](./web/docs/VerticalLine.md) | a vertical line to separate components in horizontal LinearLayout 
[LinearLayout](./web/docs/LinearLayout.md)  | layout may also be nested component, within another layout 
[ListView](./web/docs/ListView.md) | a complex/dynamic multiple-choice option-list, with a row layout and a selected index 

### EigenFrame Actions:

Action type | Description
----------- | ----------- 
[ToastMessage](./web/docs/ToastMessage.md) | send a transient non-blocking "toast" message to the user's screen - good for a quick status update 
[AlertDialog](./web/docs/AlertDialog.md) | popup dialog with "positive", "negative", and "neutral" options defined - Are you sure: "YES", "NO", "CANCEL" 
[SelectDialog](./web/docs/SelectDialog.md) | popup multiple-choice option-list selected index
[PopupTextView](./web/docs/PopupTextView.md) | popup transient plaintext window
[PopupHtmlView](./web/docs/PopupHtmlView.md) | popup transient HTML window 
[PopupScreen](./web/docs/PopupScreen.md) | popup collection of components in a new fullscreen window (also a Layout type)
[JavaScript](./web/docs/JavaScript.md) | embedded javascript  
[UrlRequest](./web/docs/UrlRequest.md) | url request 
[SecureShell](./web/docs/SecureShell.md) | ssh commands 
[SecureFtp](./web/docs/SecureShell.md) | sftp commands 
[Variable](./web/docs/Variable.md) | dynamic variable values 
[Cache](./web/docs/Cache.md) | dynamic cache files
[ActionList](./web/docs/ActionList.md) | calls a sequence of actions 
[Define](./web/docs/Define.md) | define a reusable cached component 
[Clone](./web/docs/Clone.md) | clone creates a new instance of a defined reusable component 


![Alt](web/res/eigenframe.png "eigenframe")


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

## EigenFrame app url-request

EigenFrame starts with an app url-request to retrieve the application-level security specifications, 
and tab-fragments.  

There are 3 ways to perform an initial EigenFrame url-request:
* launch the EigenFrame app (which uses the default home-url)
* launch an EigenFrame short-cut (which contains an EigenFrame app url)
* or an EigenFrame app can be designed launch the url of another EigenFrame app.

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

## EigenFrame Activity and Fragments

An Android activity is typically composed of several fragments that can be dynamically loaded and unloaded to manage system resources.

Tabs are an common way to select which fragments are currently active, although your app designs may 
choose to hide this particular feature by using PopupScreen components.

The tab_list may define any number of fragments that load and activate as you select them.  
Generally, the fragments associated with adjacent tabs are also kept active.
For example, using the sample app specification, the About tab fragment would not be loaded until the user selects Readme or About tabs.
Also, If the user selects the About tab, then the Startup tab would become deactivated.
This behaviour can be demonstrated with the [Enable Source Button]

Tabs can either be selected with the user interface, or programmatically selected.

Tabs can have a "name" attribute and/or an "icon_name" attribute to define the tab label.  

Tabs of "type": "EigenFragment" have the "url" attribute to load components dynamically. 

## EigenFrame components

A fragment can layout scrollable components below the tab selection area, 
or create any number of new screen components.

### App-level specifications:

App spec | Description | Examples
-------------- | ----------- | --------  
[EigenFrame](./web/docs/EigenFrame.md)  | represents the top-level application specification | [examples](./web/apps/app1.json)
[EigenFragment](./web/docs/EigenFragment.md)  | represents each tab/fragment within an application | [examples](./web/apps/app1.json)


### Layout types:

Layout type | Description | Examples
----------- | ----------- | --------  
[PopupScreen](./web/docs/PopupScreen.md) | collection of components in a new fullscreen window (also an Action type) | [example](./web/frames/test-PopupScreen.json) 
[LinearLayout](./web/docs/LinearLayout.md)  | sequence of components arranged vertically or horizontally, possibly scrollable | [example](./web/frames/playlist.json) 
RelativeLayout | not implemented yet |
ConstraintLayout | not implemented yet |

### Component types:

Component type | Description | Examples
-------------- | ----------- | --------  
[Button](./web/docs/Button.md)  | stateless component shows plaintext, with optional icon and has an "on_click" callback attribute  | [example](./web/frames/test-Button.json) 
[TextView](./web/docs/TextView.md)  | shows plain text, with built-in fonts | [example](./web/frames/test-TextView.json) 
[HtmlView](./web/docs/HtmlView.md)  | shows simple html, internal-icons, and simple web-links | [example](./web/frames/test-HtmlView.json) 
[WebView](./web/docs/WebView.md)  | shows elaborate html, and url web-page  - javascript capable  | [example](./web/frames/test-WebView.json) 
[ImageView](./web/docs/ImageView.md)  | shows images and external-icons | [example](./web/frames/test-ImageView.json) 
[EditText](./web/docs/EditText.md) | a string value, with an editable text area for state value | [example](./web/frames/test-EditText.json) 
[CheckBox](./web/docs/CheckBox.md) | a small box with or without a check mark, with integer value [0, 1] |  [example](./web/frames/test-CheckBox.json) 
[Spinner](./web/docs/Spinner.md) | a popup multiple-choice option-list, and a selection index |   [example](./web/frames/test-Spinner.json) 
[Switch](./web/docs/Switch.md) | a small switch [off, on] with an integer state value [0, 1] |  [example](./web/frames/test-Switch.json) 
[ToggleButton](./web/docs/ToggleButton.md) | bi-modal button label with an integer state value [0, 1] |  [example](./web/frames/test-ToggleButton.json) 
[RadioButton](./web/docs/RadioButton.md) | a multiple-choice option-list, and a selected index | [example](./web/frames/test-RadioButton.json) 
[HorizontalLine](./web/docs/HorizontalLine.md) | a horizontal line <hr/> to separate components in vertical LinearLayout | [example](./web/frames/playlist.json) 
[VerticalLine](./web/docs/VerticalLine.md) | a vertical line to separate components in horizontal LinearLayout |  
[LinearLayout](./web/docs/LinearLayout.md)  | layout may also be nested component, within another layout | [example](./web/frames/playlist.json) 

### Action types:

Action type | Description | Examples
----------- | ----------- | --------  
[ToastMessage](./web/docs/ToastMessage.md) | send a transient non-blocking "toast" message to the user's screen - good for a quick status update |
[AlertDialog](./web/docs/AlertDialog.md) | popup dialog with "positive", "negative", and "neutral" options defined - Are you sure: "YES", "NO", "CANCEL"  | [example](./web/frames/test-AlertDialog.json) 
[SelectDialog](./web/docs/SelectDialog.md) | popup multiple-choice option-list selected index| [example](./web/frames/test-SelectDialog.json) 
[ListView](./web/docs/ListView.md) | popup a complex/dynamic multiple-choice option-list, with a row layout and a selected index | [example](./web/frames/test-ListView.json) 
[PopupTextView](./web/docs/PopupTextView.md) | popup transient plaintext window | [example](./web/frames/test-PopupTextView.json) 
[PopupHtmlView](./web/docs/PopupHtmlView.md) | popup transient HTML window | [example](./web/frames/test-PopupHtmlView.json) 
[PopupScreen](./web/docs/PopupScreen.md) | popup collection of components in a new fullscreen window (also a Layout type) | [example](./web/frames/test-PopupScreen.json) 
[JavaScript](./web/docs/JavaScript.md) | embedded javascript  | [example](./web/frames/test-Javascript.json) 
[UrlRequest](./web/docs/UrlRequest.md) | url request |
[SecureShell](./web/docs/SecureShell.md) | ssh commands |  
[SecureFtp](./web/docs/SecureShell.md) | sftp commands | 
[SetVariable](./web/docs/SetVariable.md) | sets a particular variable value |
[ActionList](./web/docs/ActionList.md) | calls a sequence of actions |
[Define](./web/docs/Define.md) | define a reusable cached component |
[Clone](./web/docs/Clone.md) | clone creates a new instance of a defined reusable component |


![Alt](web/res/eigenframe.png "eigenframe")


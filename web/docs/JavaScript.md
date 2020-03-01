# JavaScript
## schema pattern

* type = "JavaScript"

* script 
* script_list 

### eigenFragment methods:
void eigenFragment.closePopupScreen(int screenId)
void eigenFragment.closePopupWindow()

boolean eigenFragment.setViewState(int viewId, String value)
String eigenFragment.getViewState()
String eigenFragment.getViewState(int viewId)

void eigenFragment.setOptionList(int listViewId, int secureFtpViewId)

String eigenFragment.getCacheFilePath(String filename)
String eigenFragment.getCacheString(String type, int id, String initValue)
String eigenFragment.getCacheString(String filename)
byte[] eigenFragment.getCacheByteArray(String filename)

void eigenFragment.setCacheString(String type, int id, String initialValue)
void eigenFragment.setCacheString(String filename, String initialValue)

String eigenFragment.clearCacheFile(String filename)
String eigenFragment.concatPaths(String rootPath, String relativePath)
String eigenFragment.concatPaths(int viewId1, int viewId2)
String eigenFragment.concatPaths(int viewId1, int viewId2, int viewId3)
String eigenFragment.concatCachePaths(String rootPathCache, String relativePathCache)
boolean eigenFragment.appendPath(int viewId1, String optionLabel)
- setViewState(viewId1, concatPaths(getViewState(viewId1), optionLabel))

boolean eigenFragment.parentPath(int viewId1)
String eigenFragment.getOptionLabel()
int eigenFragment.getOptionPosition()
String eigenFragment.getOptionString(String optionName, String init)
int eigenFragment.getOptionInteger(String optionName, int init)
long eigenFragment.getOptionLong(String optionName, long init)
boolean eigenFragment.getOptionBoolean(String optionName, boolean init)
Object eigenFragment.getOption(String optionName)

String eigenFragment.getVariableName(String type, int id)
String eigenFragment.getStringVariable(String type, int id, String initialValue)
int eigenFragment.getIntegerVariable(String type, int id, int initialValue)
long eigenFragment.getLongVariable(String type, int id, long initialValue)
boolean eigenFragment.getBooleanVariable(String type, int id, boolean initialValue)
void eigenFragment.setStringVariable(String type, int id, String initialValue)
void eigenFragment.setIntegerVariable(String type, int id, int initialValue)
void eigenFragment.setLongVariable(String type, int id, long initialValue)
void eigenFragment.setBooleanVariable(String type, int id, boolean initialValue)

### eigenActivity methods:
void eigenActivity.showToast(String message)
void eigenActivity.launch(String url_string)
void eigenActivity.addShortcut(String shortcut, String url_string)
void eigenActivity.finish()
String eigenActivity.getString(com.sawaya.R.string.change_log)
void eigenActivity.enableOrientationEventListener(boolean isEnabled)
void eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)

        
Related:
[PopupTextView](PopupTextView.md) 
[PopupScreen](PopupScreen.md) 
[UrlRequest](UrlRequest.md) 
[SecureShell](SecureShell.md) 
[SecureFtp](SecureFtp.md) 
[ActionList](ActionList.md) 


## Examples:        
Example:
```json
{
  "type": "JavaScript",
  "script_list": [
    "var selected_path = 'Hello World')",
    "eigenActivity.showToast('SelectedPath: '+ selected_path)",
    "java.lang.System.out.println('SelectedPath: '+selected_path)"
  ]
}
```

Example:
```json
{
  "type": "JavaScript",
  "script_list": [
    "var x1 = eigenFragment.clearCacheFile('EditText:999000')",
    "eigenActivity.showToast('Local File Cache Status: ' + x1 )",
    "eigenFragment.closePopupScreen(999099)"
  ]
}
```

Example:
```json
{
  "type": "Clone",
  "name": "ButtonDefault",
  "attributes": {
    "text": "launch this initial application (again),\nthen press back-button to exit",
    "icon": {
      "name": "open_browser.",
      "location": "top"
    },
    "on_click": {
      "type": "JavaScript",
      "script": "eigenActivity.launch('file:///storage/emulated/0/Android/data/com.sawaya.eigenframe/files/app.json')"
    }
  }
}
```


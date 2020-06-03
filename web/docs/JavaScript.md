# JavaScript
## schema pattern

 * type = "JavaScript"
 * id = ID reference to capture the result (see script_script example)

One of the following:
 * script - a javascript string to evaluate.
 * script_list - a list of javascript script strings to evaluate.
		- delimiter - after each line of a script_list (or <tag>_script_list) append ";"
 * script_script - a script that produces the script to evaluate (see example).
 * (script_script_list is not supported)

## Methods in eigenActivity:

 * String eigenActivity.getString(com.sawaya.R.string.eula)
 * void eigenActivity.addShortcut(String shortcut, String url_string)
 * void eigenActivity.enableOrientationEventListener(boolean isEnabled)
 * void eigenActivity.finish()
 * void eigenActivity.launch(String url_string)
 * void eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)
 * void eigenActivity.showToast(String message)

### Methods in eigenFragment:

 * boolean eigenFragment.appendPath(int viewId1, String optionLabel)
 * boolean eigenFragment.getOptionBoolean(String optionName, boolean init)
 * boolean eigenFragment.parentPath(int viewId1)
 * boolean eigenFragment.setViewState(int viewId, String value)
 * int eigenFragment.getOptionInteger(String optionName, int init)
 * int eigenFragment.getOptionPosition()
 * long eigenFragment.getOptionLong(String optionName, long init)
 * Object eigenFragment.getOption(String optionName)
 * String eigenFragment.concatPaths(int viewId1, int viewId2, int viewId3)
 * String eigenFragment.concatPaths(int viewId1, int viewId2)
 * String eigenFragment.getOptionLabel()
 * String eigenFragment.getOptionString(String optionName, String init)
 * String eigenFragment.getViewState()
 * String eigenFragment.getViewState(int viewId)
 * void eigenFragment.closePopupScreen(int screenId)
 * void eigenFragment.closePopupWindow()
 * void eigenFragment.setOptionList(int listViewId, int secureFtpViewId)

### Methods in both eigenActivity and eigenFragment:

 * boolean eigenActivity.getBooleanVariable(String type, int id, boolean initialValue)
 * boolean eigenFragment.getBooleanVariable(String type, int id, boolean initialValue)
 * byte[] eigenActivity.getCacheByteArray(String filename)
 * byte[] eigenFragment.getCacheByteArray(String filename)
 * int eigenActivity.getIntegerVariable(String type, int id, int initialValue)
 * int eigenFragment.getIntegerVariable(String type, int id, int initialValue)
 * long eigenActivity.getLongVariable(String type, int id, long initialValue)
 * long eigenFragment.getLongVariable(String type, int id, long initialValue)
 * public void eigenActivity.copyFile(String filename1, String filename2)
 * public void eigenActivity.deleteFile(String filename1)
 * public void eigenActivity.renameFile(String filename1, String filename2)
 * public void eigenFragment.copyFile(String filename1, String filename2)
 * public void eigenFragment.deleteFile(String filename1)
 * public void eigenFragment.renameFile(String filename1, String filename2)
 * String eigenActivity.clearCacheFile(String filename)
 * String eigenActivity.concatCachePaths(String rootPathCache, String relativePathCache)
 * String eigenActivity.concatPaths(String homePath, String workPath, String relativePath)
 * String eigenActivity.concatPaths(String rootPath, String relativePath)
 * String eigenActivity.getCacheFilePath(String filename)
 * String eigenActivity.getCacheString(String filename)
 * String eigenActivity.getCacheString(String type, int id, String initValue)
 * String eigenActivity.getStringVariable(String type, int id, String initialValue)
 * String eigenActivity.getVariableName(String type, int id)
 * String eigenFragment.clearCacheFile(String filename)
 * String eigenFragment.concatCachePaths(String rootPathCache, String relativePathCache)
 * String eigenFragment.concatPaths(String homePath, String workPath, String relativePath)
 * String eigenFragment.concatPaths(String rootPath, String relativePath)
 * String eigenFragment.getCacheFilePath(String filename)
 * String eigenFragment.getCacheString(String filename)
 * String eigenFragment.getCacheString(String type, int id, String initValue)
 * String eigenFragment.getStringVariable(String type, int id, String initialValue)
 * String eigenFragment.getVariableName(String type, int id)
 * void eigenActivity.setBooleanVariable(String type, int id, boolean initialValue)
 * void eigenActivity.setCacheString(String filename, String initialValue)
 * void eigenActivity.setCacheString(String type, int id, String initialValue)
 * void eigenActivity.setIntegerVariable(String type, int id, int initialValue)
 * void eigenActivity.setLongVariable(String type, int id, long initialValue)
 * void eigenActivity.setStringVariable(String type, int id, String initialValue)
 * void eigenFragment.setBooleanVariable(String type, int id, boolean initialValue)
 * void eigenFragment.setCacheString(String filename, String initialValue)
 * void eigenFragment.setCacheString(String type, int id, String initialValue)
 * void eigenFragment.setIntegerVariable(String type, int id, int initialValue)
 * void eigenFragment.setLongVariable(String type, int id, long initialValue)
 * void eigenFragment.setStringVariable(String type, int id, String initialValue)
       
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
    "var selected_path = 'Hello World');",
    "eigenActivity.showToast('SelectedPath: '+ selected_path);",
    "java.lang.System.out.println('SelectedPath: '+selected_path);"
  ]
}
```

Example:
```json
{
  "type": "JavaScript",
  "script_list": [
    "var x1 = eigenFragment.clearCacheFile('EditText:999000');",
    "eigenActivity.showToast('Local File Cache Status: ' + x1 );",
    "eigenFragment.closePopupScreen(999099);"
  ]
}
```

Example:
```json
{
  "type": "Clone",
  "name": "ButtonDefault",
  "attributes": {
    "text": "launch an application",
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

This one is more advanced, the attribute "script_script": evaluates a script that is itself the script to be evaluated.
In other words, this script produces a script to be evaluated.  Simply meta-programming.
```json
		{
			"type": "Clone",
			"name": "ButtonDefault",
			"attributes": {
				"text": "Execute JavaScript Command",
				"icon": {
					"name": "play.",
					"location": "top"
				},
				"on_click": {
					"type": "Clone",
					"name": "PopupScreenDefault",
					"attributes": {
						"title": "JavaScript Command Output",
						"component_list": [
							{
								"type": "JavaScript",
								"id": 7501,
								"script_script": "''+eigenFragment.getViewState(7500)"
							},
							{
								"type": "Clone",
								"name": "LayoutVerticalScrollable",
								"attributes": {
									"component_list": [
										{
											"type": "Clone",
											"name": "TextViewDetail",
											"attributes": {
												"text_size": "10",
												"text_script": "''+eigenFragment.getViewState(7500)"
											}
										},
										{
											"type": "Clone",
											"name": "TextViewDetail",
											"attributes": {
												"text_size": "10",
												"url": "file:///data/user/0/com.sawaya.eigenframe/files/JavaScript:7501"
											}
										}
									]
								}
							}
						]
					}
				}
			}
		}
```



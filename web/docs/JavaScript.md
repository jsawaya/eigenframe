# JavaScript
## schema pattern

 * type = "JavaScript"
 * id = ID reference to capture the result (see script_script example)

One of the following:
 * script - a javascript string to evaluate.
 * script_list - a list of javascript script strings to evaluate.
		- delimiter - after each line of a script_list (or <tag>_script_list) append ";"
 * script_script - is a meta-script that produces a script to evaluate (see example).
 * (note: script_script_list is not supported)

## Methods in eigenActivity:

 * String eigenActivity.getGithubBranchString() // e.g. returns "1.4"
 * String eigenActivity.getString(com.sawaya.R.string.eula)
 * void eigenActivity.addShortcut(String shortcut, String url_string)
 * void eigenActivity.enableOrientationEventListener(boolean isEnabled)
 * void eigenActivity.finish()
 * void eigenActivity.launch(String url_string)
 * void eigenActivity.setRequestedOrientation(android.content.pm.ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)
 * void eigenActivity.showToast(String message)
 * String eigenActivity.editDrawing(String drawingFilePath) // returns drawingFilePath
 * String eigenActivity.captureCameraImage() // returns jpg_filename

### Methods in both eigenActivity and eigenFragment:

 * boolean eigenActivity.getBooleanVariable(String type, int id, boolean initialValue)
 * byte[] eigenActivity.getCacheByteArray(String filename)
 * int eigenActivity.getIntegerVariable(String type, int id, int initialValue)
 * long eigenActivity.getLongVariable(String type, int id, long initialValue)
 * public void eigenActivity.copyFile(String filename1, String filename2)
 * public void eigenActivity.deleteFile(String filename1)
 * public void eigenActivity.renameFile(String filename1, String filename2)
 * String eigenActivity.clearCacheFile(String filename)
 * String eigenActivity.concatCachePaths(String rootPathCache, String relativePathCache)
 * String eigenActivity.concatPaths(String homePath, String workPath, String relativePath)
 * String eigenActivity.concatPaths(String rootPath, String relativePath)
 * String eigenActivity.getCacheFilePath(String filename)
 * String eigenActivity.getCacheString(String filename)
 * String eigenActivity.getCacheString(String type, int id, String initValue)
 * String eigenActivity.getStringVariable(String type, int id, String initialValue)
 * String eigenActivity.getVariableName(String type, int id)
 * void eigenActivity.setBooleanVariable(String type, int id, boolean initialValue)
 * void eigenActivity.setCacheString(String filename, String initialValue)
 * void eigenActivity.setCacheString(String type, int id, String initialValue)
 * void eigenActivity.setIntegerVariable(String type, int id, int initialValue)
 * void eigenActivity.setLongVariable(String type, int id, long initialValue)
 * void eigenActivity.setStringVariable(String type, int id, String initialValue)
       
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

Example - set script_list delimiter:
```json
{
	"type": "JavaScript",
	"delimiter": ";",
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



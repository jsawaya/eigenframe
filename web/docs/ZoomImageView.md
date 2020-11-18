# ZoomImageView
## schema pattern

* type = "ZoomImageView"
* url, url_script or url_script_list
* rotation, rotation_script [-270, -180, -90, 0, 90, 180, 270]
* id = define unique view id, puts contents into cache ZoomImageView:{id} 
* layout_width
* layout_height
* gravity
* background_color
* padding 
* margin

Related:
[Button](Button.md) 
[TextView](TextView.md) 
[EditText](EditText.md) 
[CheckBox](CheckBox.md) 
[Switch](Switch.md) 
[ToggleButton](ToggleButton.md) 
[RadioButton](RadioButton.md) 
[Spinner](Spinner.md) 
[ImageView](ImageView.md) 


Example:  This example starts from an on_click event (e.g. button), executes SFTP to get a remote image to 'ImageView.png', on_complete shows PopupScreen component ZoomImageView. 
```json
	"on_click": {
		"on_complete": {
			"attributes": {
				"component_list": [
					{
						"attributes": {
							"component_list": [
								{
									"background_color": "#123456",
									"layout_height": "match_parent",
									"layout_width": "match_parent",
									"on_click": {
										"script": "eigenActivity.showToast('image click eigenframe')",
										"type": "JavaScript"
									},
									"type": "ZoomImageView",
									"url_script": "'file://'+ eigenFragment.getCacheFilePath('ImageView.png')"
								}
							]
						},
						"name": "LayoutVerticalScrollable",
						"type": "Clone"
					}
				],
				"title_script_list": [
					"var targetVid = eigenFragment.getIntegerVariable('TargetViewId');",
					"var filename = eigenFragment.getViewState(targetVid);",
					"'Remote Image: '+filename;"
				]
			},
			"name": "PopupScreenDefault",
			"type": "Clone"
		},
		"sftp_script_list": [
			"var targetVid = eigenFragment.getIntegerVariable('TargetViewId');",
			"var filename = eigenFragment.getViewState(targetVid);",
			"'get ' + filename + ' ImageView.png';"
		],
		"type": "SecureFtp"
	},
	"text": "Show Remote Image File (via sftp) with Zoom Image View"
}
```

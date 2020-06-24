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
* is_wake_lock: [true | false], true keeps screen on - e.g. SimulationView
* tab_list: sequence of EigenFragment components
* script, script_list: initialization script in eigenActivity context (eigenFragment context is not applicable).


Related:
[EigenFragment](EigenFragment.md) 

Example:
```json
{
	"type": "EigenFrame",
	"script_list": [
		"var github_branch = eigenActivity.getGithubBranchString();",
		"eigenActivity.showToast('Github Branch: '+github_branch);",
		"eigenActivity.setCacheString('GithubBranch', github_branch);",
		"var root_url = 'https://raw.githubusercontent.com/jsawaya/eigenframe/'+github_branch+'/web/';",
		"eigenActivity.setCacheString('RootUrl', root_url);"
	],
	"is_secure_window": "false",
	"tab_list": [
		{
			"type": "EigenFragment",
			"name_script": "'v'+eigenActivity.getGithubBranchString()",
			"url_script": "eigenActivity.getCacheString('RootUrl')+'frames/define-clones.json'",
			"icon_name": "ic_launcher_round."
		},
		{
			"type": "EigenFragment",
			"name": "About",
			"url_script": "eigenActivity.getCacheString('RootUrl')+'frames/about.json'",
			"icon_name": "info."
		}
	]
}
```

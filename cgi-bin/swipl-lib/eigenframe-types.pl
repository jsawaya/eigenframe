%-----------------------------------------------

eigenframe_types(Types) :-
Types = 
[
	'EigenFrame',
	'EigenFragment',
	'ActionList',
	'AlertDialog',
	'Button',
	'CheckBox',
	'Clone',
	'Define',
	'EditText',
	'HorizontalLine',
	'HtmlView',
	'ImageView',
	'JavaScript',
	'LinearLayout',
	'ListView',
	'PopupHtmlView',
	'PopupScreen',
	'PopupTextView',
	'RadioButton',
	'SecureFtp',
	'SecureShell',
	'SelectDialog',
	'Spinner',
	'Switch',
	'TextView',
	'ToastMessage',
	'ToggleButton',
	'UrlRequest',
	'VerticalLine',
	'WebView'
].

%-----------------------------------------------

%eigen_type(?Type, ?IsAction, ?IsLayout).
% 1) Type is one of the implemented EigenFrame types.
% 2) Layout:
% 		layout_null :- parent layout is not applicable
% 		layout_req :- parent layout is required
% 		layout_opt :- parent layout is optional, and may use parent layout
% 3) Input_sources: [url, sftp(directory), ssh, text, option_list, component, component_list, defined_name]

eigen_type('EigenFrame', 			layout_null, [tab_list, script]). 	% creates new app, with new set of fragments
eigen_type('EigenFragment',		layout_null, [url_script]).	  % runs fragment/tab with implicit parent linearlayout
eigen_type('PopupScreen', 		layout_null, [component_list, url_script]).		% begin a new screen with implicit parent linearlayout
eigen_type('AlertDialog', 		layout_null, [positive_option, neutral_option, negative_option]).		% popup alert with upto 3 options
eigen_type('PopupHtmlView', 	layout_null, [url_script, ssh_script]).		% popup html view
eigen_type('PopupTextView', 	layout_null, [url_script, sftp_script, ssh]).		% popup text view
eigen_type('SelectDialog', 		layout_null, [option_list]).		% popup alert with option_list
eigen_type('ToastMessage', 		layout_null, [message_script]).		% popup message(text)
eigen_type('Define', 					layout_null, [component]).		% define a cached eigenframe template
eigen_type('JavaScript', 			layout_null, [script]).		% execute javascript

eigen_type('SecureFtp', 			layout_opt, [sftp_script]).		% execute sftp async-request, is_eigen_response 
eigen_type('SecureShell', 		layout_opt, [ssh_script]).		% execute ssh async-request, is_eigen_response
eigen_type('UrlRequest', 			layout_opt, [url_script]).		% execute url async-request, is_eigen_response
eigen_type('ActionList', 			layout_opt, [component_list]).		% execute list of actions
eigen_type('Clone', 					layout_opt, [defined_name]). % produce component/action from defined name

eigen_type('LinearLayout', 		layout_req, [component_list]). 		% begin a new vertical or horizontal layout
eigen_type('TextView', 				layout_req, [text_script, url_script, sftp_script, ssh_script]).		% UI component - async-request
eigen_type('HtmlView', 				layout_req, [url_script, ssh_script]).		% UI component - async-request
eigen_type('ImageView', 			layout_req, [url_script]).		% UI component - async-request
eigen_type('EditText', 				layout_req, [text_script, url_script, sftp_script, ssh_script]).		% UI component - async-request
eigen_type('WebView', 				layout_req, [url_script]).		% UI component - async-request
eigen_type('Button', 					layout_req, [text_script]). 		% UI component, with on_click action
eigen_type('CheckBox', 				layout_req, [text_script]).		% UI component, with on_click action
eigen_type('Switch', 					layout_req, [text_script]).		% UI component, with on_click action
eigen_type('ToggleButton', 		layout_req, [text_script]).		% UI component, with on_click action
eigen_type('ListView', 				layout_req, [option_list, sftp_script]). 		% UI component, may include an item-layout
eigen_type('RadioButton', 		layout_req, [option_list]).		% UI component, with on_click action
eigen_type('Spinner', 				layout_req, [option_list]).		% UI component, with on_click action
eigen_type('HorizontalLine',	layout_req, []).		% UI component
eigen_type('VerticalLine', 		layout_req, []).		% UI component


%-----------------------------------------------

nominal_EigenFragment(Data, Tab_name, Icon_name, Url) :-
	Data = _{
  	type: 'EigenFragment',
  	name: Tab_name,
		icon_name: Icon_name,
  	url: Url
	}.

nominal_EigenFrame(Data, Is_secure_window, Tab_list) :-
	Data = _{
		type:'EigenFrame',
		is_secure_window: Is_secure_window,
		tab_list: Tab_list	
	}.

create_app_test(Data_frame) :-
	nominal_EigenFragment(Data1, 'prolog', 'info.', 'http://localhost:8000/frame?file=playlist.json'),
	nominal_EigenFragment(Data2, 'textview', 'info.', 'http://localhost:8000/frame?file=test-TextView.json'),
	nominal_EigenFrame(Data_frame, false, [Data1, Data2]),
	show_json(Data_frame).

%	directory_eigenframe_web_apps(Dir),
%	format(" = app dir: ~w~n", [Dir]),
%	directory_file_path(Dir, 'app1.json', FPath),
%	save_json_file(FPath, Data_frame).

%-----------------------------------------------

nominal_Define(Data, Define_name, Component) :-
	Data = _{
  	type: 'Define',
  	name: Define_name,
  	component: Component
	}.

%-----------------------------------------------

nominal_Clone(Data, Define_name, []) :-
	Data = _{
  	type: 'Clone',
  	name: Define_name
	}.

nominal_Clone(Data, Define_name, Attributes) :-
	Data = _{
  	type: 'Clone',
  	name: Define_name,
  	attributes: Attributes
	}.

% - this clause requires attributes, which may not be true 
% - and it can not create a new instance, only parse	
% nominal_Clone(Data, Define_name, Attributes) :-
%		'Clone' == Data.get(type),
%		Define_name = Data.get(name),
%		Attributes = Data.get(attributes),

%-----------------------------------------------

add_eigenfragment_to_list(Data, Tab_list) :- 
	'EigenFragment' == Data.get(type),
	member(Data, Tab_list),
	format(" = added eigenfragment~n", []).

%-----------------------------------------------

nominal_LinearLayout(Data, Orientation, Scrollable, Component_list) :-
	Data = _{
  	type: 'LinearLayout',
  	orientation: Orientation,
		scrollable: Scrollable,
  	component_list: Component_list
	}.

nominal_TextView(Data, Text, Text_size) :-
	Data = _{
  	type: 'TextView',
  	text: Text,
  	text_size: Text_size,
		text_color: '#ffffff'
	}.

nominal_ActionList(Data, Component_list, On_complete) :-
	Data = _{
  	type: 'ActionList',
  	component_list: Component_list,
  	on_complete: On_complete
	}.

nominal_AlertDialog(Data, Title) :-
	Data = _{
  	type: 'AlertDialog',
  	title: Title
	}.

nominal_Button(Data, Text,On_click) :-
	Data = _{
  	type: 'Button',
  	text: Text,
  	on_click: On_click
	}.

nominal_CheckBox(Data, Text, On_click) :-
	Data = _{
  	type: 'CheckBox',
  	text: Text,
  	on_click: On_click
	}.

nominal_EditText(Data, Text, Text_size) :-
	Data = _{
  	type: 'EditText',
  	text: Text,
  	text_size: Text_size,
		text_color: '#ffffff'
	}.

nominal_HorizontalLine(Data, Size, Color) :-
	Data = _{
  	type: 'HorizontalLine',
  	size: Size,
  	color: Color
	}.

nominal_HtmlView(Data, Html) :-
	Data = _{
  	type: 'HtmlView',
  	html: Html
	}.

nominal_ImageView(Data, Image_url, Rotation, On_click) :-
	Data = _{
  	type: 'ImageView',
  	image_url: Image_url,
  	rotation: Rotation,
  	on_click: On_click
	}.

nominal_JavaScript(Data, Script) :-
	Data = _{
  	type: 'JavaScript',
  	script: Script
	}.

nominal_ListView(Data, Option_list, On_click) :-
	Data = _{
  	type: 'ListView',
  	option_list: Option_list,
  	on_click: On_click
	}.

nominal_PopupHtmlView(Data, Title, Html) :-
	Data = _{
  	type: 'PopupHtmlView',
  	title: Title,
  	html: Html
	}.

nominal_PopupScreen(Data, Title, Url) :-
	Data = _{
  	type: 'PopupScreen',
  	title: Title,
  	url: Url,
		layout_width: 'match_parent',
		layout_height: 'match_parent'
	}.

nominal_PopupTextView(Data, Text, Text_size) :-
	Data = _{
  	type: 'PopupTextView',
  	text: Text,
  	text_size: Text_size,
		text_color: '#ffffff'
	}.

nominal_RadioButton(Data, Option_list, On_click) :-
	Data = _{
  	type: 'RadioButton',
  	option_list: Option_list,
  	on_click: On_click
	}.

nominal_SecureFtp(Data, Sftp, Is_eigen_response, On_complete) :-
	Data = _{
  	type: 'SecureFtp',
  	sftp: Sftp,
  	is_eigen_response: Is_eigen_response,
  	on_complete: On_complete
	}.

nominal_SecureShell(Data, Ssh, Is_eigen_response, On_complete) :-
	Data = _{
  	type: 'SecureShell',
  	ssh: Ssh,
  	is_eigen_response: Is_eigen_response,
  	on_complete: On_complete
	}.

nominal_SelectDialog(Data, Option_list, On_click) :-
	Data = _{
  	type: 'SelectDialog',
  	option_list: Option_list,
  	on_click: On_click
	}.

nominal_Spinner(Data, Option_list, On_click) :-
	Data = _{
  	type: 'Spinner',
  	option_list: Option_list,
  	on_click: On_click
	}.

nominal_Switch(Data, Text, On_click) :-
	Data = _{
  	type: 'Switch',
  	text: Text,
  	on_click: On_click
	}.

nominal_ToastMessage(Data, Message) :-
	Data = _{
  	type: 'ToastMessage',
  	message: Message
	}.

nominal_ToggleButton(Data, Text, On_click) :-
	Data = _{
  	type: 'ToggleButton',
  	text: Text,
  	on_click: On_click
	}.

nominal_UrlRequest(Data, Url, Is_eigen_response, On_complete) :-
	Data = _{
  	type: 'UrlRequest',
  	url: Url,
  	is_eigen_response: Is_eigen_response,
  	on_complete: On_complete
	}.

nominal_VerticalLine(Data, Size, Color) :-
	Data = _{
  	type: 'VerticalLine',
  	size: Size,
  	color: Color
	}.

nominal_WebView(Data, Title, Url) :-
	Data = _{
  	type: 'WebView',
  	title: Title,
  	url: Url,
		layout_width: 'match_parent',
		layout_height: 'match_parent'
	}.







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
	'Variable',
	'VerticalLine',
	'WebView'
].

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
	nominal_EigenFragment(Data1, 'button', 'info.', 'http://localhost:8000/frame?file=test-Button.json'),
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






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

nominal_EigenFrame(Data, Is_secure_window, Tab_list) :-
	Data = _{
		type:'EigenFrame',
		is_secure_window: Is_secure_window,
		tab_list: Tab_list	
	}.

nominal_EigenFragment(Data, Tab_name, Icon_name, Url) :-
	Data = _{
  	type: 'EigenFragment',
  	name: Tab_name,
		icon_name: Icon_name,
  	url: Url
	}.

nominal_Define(Define, Define_name, Component) :-
	Define = _{
  	type: 'Define',
  	name: Define_name,
  	component: Component
	}.

nominal_Clone(Clone, Define_name, []) :-
	Clone = _{
  	type: 'Clone',
  	name: Define_name
	}.

nominal_Clone(Clone, Define_name, Attributes) :-
	Clone = _{
  	type: 'Clone',
  	name: Define_name,
  	attributes: Attributes
	}.







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

nominal_Define(Data, Define_name, Component) :-
	Data = _{
  	type: 'Define',
  	name: Define_name,
  	component: Component
	}.

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

%nominal_Clone(Data, Define_name, Attributes) :-
% this version requires attributes, which may not be true 		
%		'Clone' == Data.get(type),
%		Define_name = Data.get(name),
%		Attributes = Data.get(attributes),




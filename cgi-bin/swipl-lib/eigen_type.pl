%eigen_type(?Type, ?IsAction, ?IsLayout).
% Type is one of the implemented EigenFrame types.
% IsAction is true if eigenframe component can operate without a layout.
% IsLayout is true if eigenframe component can produce a layout.

eigen_type('EigenFrame', 			_, _).  				% creates new app, with new set of fragments
eigen_type('EigenFragment',		_, _). 					% runs fragment with implicit linearlayout

eigen_type('LinearLayout', 		false, true). 	% begin a new vertical or horizontal layout
eigen_type('ListView', 				false, true). 	% UI component, may include an item-layout
eigen_type('Button', 					false, false). 	% UI component, with on_click action
eigen_type('CheckBox', 				false, false).	% UI component, with on_click action
eigen_type('RadioButton', 		false, false).	% UI component, with on_click action
eigen_type('Spinner', 				false, false).	% UI component, with on_click action
eigen_type('Switch', 					false, false).	% UI component, with on_click action
eigen_type('ToggleButton', 		false, false).	% UI component, with on_click action
eigen_type('HorizontalLine',	false, false).	% UI component
eigen_type('VerticalLine', 		false, false).	% UI component
eigen_type('TextView', 				false, false).	% UI component - async-request
eigen_type('HtmlView', 				false, false).	% UI component - async-request
eigen_type('ImageView', 			false, false).	% UI component - async-request
eigen_type('EditText', 				false, false).	% UI component - async-request
eigen_type('WebView', 				false, false).	% UI component - async-request

eigen_type('PopupScreen', 		true, true).		% begin a new screen with implicit linearlayout
eigen_type('AlertDialog', 		true, false).		% popup alert with upto 3 options
eigen_type('PopupHtmlView', 	true, false).		% popup html view
eigen_type('PopupTextView', 	true, false).		% popup text view
eigen_type('SelectDialog', 		true, false).		% popup alert with option_list
eigen_type('ToastMessage', 		true, false).		% popup message text
eigen_type('Variable', 				true, false).		% set a variable
eigen_type('Define', 					true, false).		% define a cached eigenframe template
eigen_type('JavaScript', 			true, false).		% execute javascript
eigen_type('SecureFtp', 			true, true.			% execute sftp async-request, is_eigen_response 
eigen_type('SecureShell', 		true, true).		% execute ssh async-request, is_eigen_response
eigen_type('UrlRequest', 			true, true).		% execute url async-request, is_eigen_response
eigen_type('ActionList', 			true, true).		% execute list of actions

eigen_type('Clone', 					_, _).					% produce component/action from defined template

eigen_type('Draw', 						_, _).					% drawing file

%eigen_type('ConstraintLayout', false, true).
%eigen_type('RelativeLayout', false, true).
%eigen_type('Cache',					true, false). 
%eigen_type('RubyScript', 		true, true).

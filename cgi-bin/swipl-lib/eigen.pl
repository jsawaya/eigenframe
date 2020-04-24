has_type('EigenFrame').
has_type('EigenFragment').
has_type('Draw').

has_type('LinearLayout').
has_type('Button'). 
has_type('CheckBox').
has_type('Define').
has_type('EditText').
has_type('HorizontalLine').
has_type('HtmlView').
has_type('ImageView').
has_type('ListView').
has_type('PopupHtmlView').
has_type('PopupTextView').
has_type('RadioButton').
has_type('Spinner').
has_type('Switch').
has_type('TextView').
has_type('ToastMessage').
has_type('ToggleButton').
has_type('Variable').
has_type('VerticalLine').
has_type('WebView').
%has_type('Cache'). 
%has_type('ConstraintLayout').
%has_type('RelativeLayout').
%has_type('RubyScript').
has_type('ActionList').
has_type('AlertDialog').
has_type('Clone').
has_type('JavaScript').
has_type('PopupScreen').
has_type('SecureFtp').
has_type('SecureShell').
has_type('SelectDialog').
has_type('UrlRequest').


action('ActionList').
action('AlertDialog').
action('Define').
action('JavaScript').
action('PopupHtmlView').
action('PopupScreen').
action('PopupTextView').
action('SecureFtp').
action('SecureShell').
action('SelectDialog').
action('ToastMessage').
action('UrlRequest').
action('Variable').
%action('Cache'). 
%action('RubyScript').

%action(X) :- has_type('Clone'),has_ssh(X).

layout_container('LinearLayout').
layout_container('ListView').
layout_container('PopupScreen').
layout_container('SecureFtp').
layout_container('SecureShell').
layout_container('UrlRequest').
%layout_container('ConstraintLayout').
%layout_container('RelativeLayout').
%layout_container('ActionList').
%layout_container('Clone').
%layout_container('Define').

has_component_list('ActionList')

layout_component('Button'). 
layout_component('CheckBox').
layout_component('Define').
layout_component('EditText').
layout_component('HorizontalLine').
layout_component('HtmlView').
layout_component('ImageView').
layout_component('JavaScript').
layout_component('LinearLayout').
layout_component('ListView').
layout_component('PopupHtmlView').
layout_component('PopupScreen').
layout_component('PopupTextView').
layout_component('RadioButton').
layout_component('SecureFtp').
layout_component('SecureShell').
layout_component('SelectDialog').
layout_component('Spinner').
layout_component('Switch').
layout_component('TextView').
layout_component('ToastMessage').
layout_component('ToggleButton').
layout_component('UrlRequest').
layout_component('Variable').
layout_component('VerticalLine').
layout_component('WebView').
%layout_component('Cache'). 
%layout_component('ConstraintLayout').
%layout_component('RelativeLayout').
%layout_component('RubyScript').
layout_component('ActionList'). /*maybe visible_component*/
layout_component('AlertDialog').
layout_component('Clone').

visible_component('Button'). 
visible_component('CheckBox').
visible_component('EditText').
visible_component('HorizontalLine').
visible_component('HtmlView').
visible_component('ImageView').
visible_component('LinearLayout').
visible_component('ListView').
visible_component('RadioButton').
visible_component('SecureFtp').
visible_component('SecureShell').
visible_component('Spinner').
visible_component('Switch').
visible_component('TextView').
visible_component('ToggleButton').
visible_component('UrlRequest').
visible_component('VerticalLine').
visible_component('WebView').
%visible_component('ConstraintLayout').
%visible_component('RelativeLayout').
%visible_component('RubyScript').
visible_component('ActionList').
visible_component('Clone').

on_complete('ActionList').
on_complete('ListView').
on_complete('SecureFtp').
on_complete('SecureShell').
on_complete('UrlRequest').
on_complete('RubyScript').

has_title('AlertDialog').
has_title('PopupScreen').
has_title('PopupHtmlView').
has_title('PopupTextView').
has_title('SelectDialog').

may_have_icon('EigenFragment').
may_have_icon('AlertDialog').
may_have_icon('PopupScreen').
may_have_icon('SelectDialog').
may_have_icon('SelectDialog').
may_have_icon('CheckBox').
may_have_icon('Switch').
may_have_icon('Button').
may_have_icon('SelectDialog').
may_have_icon('ToggleButton').

may_have_url('EigenFragment').
may_have_url('PopupScreen').
may_have_url('WebView').
may_have_url('HtmlView').
may_have_url('EditText').
may_have_url('ImageView').
may_have_url('UrlRequest').
may_have_url('TextView').
may_have_url('ListView').

may_have_ssh('SecureShell').
%may_have_ssh('HtmlView').
may_have_ssh('TextView').
may_have_ssh('EditText').
may_have_ssh('PopupHtmlView').
may_have_ssh('PopupTextView').

may_have_sftp('EditText').
may_have_sftp('TextView').
may_have_sftp('SecureFtp').
may_have_sftp('ListView').


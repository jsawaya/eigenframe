
%eigen_type('Cache'). 
%eigen_type('ConstraintLayout').
%eigen_type('RelativeLayout').
%eigen_type('RubyScript').
eigen_type('ActionList').
eigen_type('AlertDialog').
eigen_type('Button'). 
eigen_type('CheckBox').
eigen_type('Clone').
eigen_type('Define').
eigen_type('Draw').
eigen_type('EditText').
eigen_type('EigenFragment').
eigen_type('EigenFrame').
eigen_type('HorizontalLine').
eigen_type('HtmlView').
eigen_type('ImageView').
eigen_type('JavaScript').
eigen_type('LinearLayout').
eigen_type('ListView').
eigen_type('PopupHtmlView').
eigen_type('PopupScreen').
eigen_type('PopupTextView').
eigen_type('RadioButton').
eigen_type('SecureFtp').
eigen_type('SecureShell').
eigen_type('SelectDialog').
eigen_type('Spinner').
eigen_type('Switch').
eigen_type('TextView').
eigen_type('ToastMessage').
eigen_type('ToggleButton').
eigen_type('UrlRequest').
eigen_type('Variable').
eigen_type('VerticalLine').
eigen_type('WebView').

%action('Cache'). 
%action('RubyScript').
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


%eigen_attribute('ConstraintLayout', 'component_list').
%eigen_attribute('HtmlView', 'ssh'). /* not supported */
%eigen_attribute('RelativeLayout', 'component_list').
%eigen_attribute('RubyShell', 'id').
%eigen_attribute('RubyShell', 'is_eigen_response').
eigen_attribute('ActionList', 'component_list').
eigen_attribute('ActionList', 'component_list').
eigen_attribute('ActionList', 'on_complete').
eigen_attribute('AlertDialog', 'icon').
eigen_attribute('AlertDialog', 'negative_on_click').
eigen_attribute('AlertDialog', 'negative_option_text').
eigen_attribute('AlertDialog', 'neutral_on_click').
eigen_attribute('AlertDialog', 'neutral_option_text').
eigen_attribute('AlertDialog', 'positive_on_click').
eigen_attribute('AlertDialog', 'positive_option_text').
eigen_attribute('AlertDialog', 'title').
eigen_attribute('Button', 'icon').
eigen_attribute('Button', 'id').
eigen_attribute('Button', 'text').
eigen_attribute('Cache', 'id').
eigen_attribute('CheckBox', 'icon').
eigen_attribute('CheckBox', 'id').
eigen_attribute('CheckBox', 'text').
eigen_attribute('Clone', 'name').
eigen_attribute('Define', 'component').
eigen_attribute('Define', 'name').
eigen_attribute('EditText', 'id').
eigen_attribute('EditText', 'sftp').
eigen_attribute('EditText', 'ssh').
eigen_attribute('EditText', 'text').
eigen_attribute('EditText', 'url').
eigen_attribute('EigenFragment', 'icon_name').
eigen_attribute('EigenFragment', 'icon').
eigen_attribute('EigenFragment', 'name').
eigen_attribute('EigenFragment', 'url').
eigen_attribute('EigenFrame', 'url').
eigen_attribute('HtmlView', 'html').
eigen_attribute('HtmlView', 'url').
eigen_attribute('icon', 'name').
eigen_attribute('ImageView', 'url').
eigen_attribute('JavaScript', 'id').
eigen_attribute('LinearLayout', 'component_list').
eigen_attribute('ListView', 'id').
eigen_attribute('ListView', 'item_layout').
eigen_attribute('ListView', 'on_complete').
eigen_attribute('ListView', 'sftp').
eigen_attribute('PopupHtmlView', 'html').
eigen_attribute('PopupHtmlView', 'ssh').
eigen_attribute('PopupHtmlView', 'title').
eigen_attribute('PopupHtmlView', 'url').
eigen_attribute('PopupScreen', 'component_list').
eigen_attribute('PopupScreen', 'icon').
eigen_attribute('PopupScreen', 'id').
eigen_attribute('PopupScreen', 'title').
eigen_attribute('PopupScreen', 'url').
eigen_attribute('PopupTextView', 'sftp').
eigen_attribute('PopupTextView', 'ssh').
eigen_attribute('PopupTextView', 'text').
eigen_attribute('PopupTextView', 'title').
eigen_attribute('PopupTextView', 'url').
eigen_attribute('RadioButton', 'id').
eigen_attribute('RubyScript', 'on_complete').
eigen_attribute('SecureFtp', 'id').
eigen_attribute('SecureFtp', 'is_eigen_response').
eigen_attribute('SecureFtp', 'on_complete').
eigen_attribute('SecureFtp', 'sftp').
eigen_attribute('SecureShell', 'id').
eigen_attribute('SecureShell', 'is_eigen_response').
eigen_attribute('SecureShell', 'on_complete').
eigen_attribute('SecureShell', 'ssh').
eigen_attribute('SelectDialog', 'icon').
eigen_attribute('SelectDialog', 'icon').
eigen_attribute('SelectDialog', 'id').
eigen_attribute('SelectDialog', 'title').
eigen_attribute('SelectDialog', 'icon').
eigen_attribute('Spinner', 'id').
eigen_attribute('Switch', 'icon').
eigen_attribute('Switch', 'id').
eigen_attribute('Switch', 'text').
eigen_attribute('TextView', 'id').
eigen_attribute('TextView', 'sftp').
eigen_attribute('TextView', 'ssh').
eigen_attribute('TextView', 'text').
eigen_attribute('TextView', 'url').
eigen_attribute('ToggleButton', 'icon').
eigen_attribute('ToggleButton', 'id').
eigen_attribute('ToggleButton', 'text').
eigen_attribute('UrlRequest', 'id').
eigen_attribute('UrlRequest', 'is_eigen_response').
eigen_attribute('UrlRequest', 'on_complete').
eigen_attribute('UrlRequest', 'url').
eigen_attribute('Variable', 'id').
eigen_attribute('WebView', 'html').
eigen_attribute('WebView', 'url').

%layout_container('ConstraintLayout').
%layout_container('RelativeLayout').
layout_container('ActionList').
layout_container('Clone').
layout_container('Define').
layout_container('LinearLayout').
layout_container('PopupScreen').
layout_container('SecureFtp'). 
layout_container('SecureShell').
layout_container('UrlRequest').

%component('Cache'). 
%component('ConstraintLayout').
%component('RelativeLayout').
%component('RubyScript').
component('ActionList'). /*maybe visible_component*/
component('AlertDialog').
component('Button'). 
component('CheckBox').
component('Clone').
component('Define').
component('EditText').
component('HorizontalLine').
component('HtmlView').
component('ImageView').
component('JavaScript').
component('LinearLayout').
component('ListView').
component('PopupHtmlView').
component('PopupScreen').
component('PopupTextView').
component('RadioButton').
component('SecureFtp').
component('SecureShell').
component('SelectDialog').
component('Spinner').
component('Switch').
component('TextView').
component('ToastMessage').
component('ToggleButton').
component('UrlRequest').
component('Variable').
component('VerticalLine').
component('WebView').

%visible_component('ConstraintLayout').
%visible_component('RelativeLayout').
%visible_component('RubyScript').
visible_component('ActionList').
visible_component('Button'). 
visible_component('CheckBox').
visible_component('Clone').
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
visible_component('VerticalLine').
visible_component('WebView').


frame('TextView',[text(_)]).
frame('TextView',[text_list([_])]).
frame('TextView',[text_script(_)] ).
frame('TextView',[text_script_list([_])] ).

frame('ActionList',[
	component_list([_]), 
	on_complete(_)
	]).

frame('AlertDialog',[
	title(_),
	icon(_,_),
	positive(option(_), on_click(_)), 
	negative(option(_), on_click(_)), 
	neutral(option(_), on_click(_))
	]).

frame('Button',[
	text(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	on_click(_),
	icon(_,_),
	padding(_),
	margin(_)
	]).

frame('Button',[
	text_script(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	on_click(_),
	icon(_,_),
	padding(_),
	margin(_)
	]).

frame('CheckBox',[
	text(_),
	checked(_),
	id(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	on_click(_),
	icon(_,_),
	padding(_),
	margin(_),
	on_click(_)
	]).

frame('Clone',[
	name(_),
	attributes(_)
	]).

frame('Define',[
	name(_),
	component(_)
	]).


frame('HorizontalLine',[
	size(_),
	color(_)
	]).

frame('HtmlView',[
	html(_),
	id(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_,_),
	padding(_),
	margin(_)
	]).

frame('HtmlView',[
	url(_),
	id(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_,_),
	padding(_),
	margin(_)
	]).

frame('ImageView',[
	url(_),
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	padding(_),
	margin(_)
	]).

frame('JavaScript',[
	script(_)
	]).

frame('JavaScript',[
	script_list([_])
	]).

frame('JavaScript',[
	script_script(_),
	id(_)
	]).

frame('LinearLayout',[
	scrollable(_),
	layout_width(_),
	layout_height(_),
	orientation(_),
	gravity(_),
	component_list([_])
	]).

frame('ListView',[
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	item_layout(_),
	on_click(_),
	option_list([_]),
	checked_option(_)
	]).

frame('ListView',[
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	item_layout(_),
	on_click(_),
	cached_filename(_),  /* "SecureFtp:{id}" */
	dir_type(_) /* subdir | files | links */
	]).

frame('PopupHtmlView',[
	html(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupHtmlView',[
	html_list([_]),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupHtmlView',[
	url(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).


frame('PopupScreen',[
	id(_),
	url(_),
	gravity(_),
	title(_),
	text_size(_),
	text_color(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupScreen',[
	id(_),
	url_script(_),
	gravity(_),
	title(_),
	text_size(_),
	text_color(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupScreen',[
	id(_),
	component_list([_]),
	gravity(_),
	title(_),
	text_size(_),
	text_color(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupTextView',[
	title(_),
	text(_),
	text_size(_),
	text_color(_),
	background_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	font(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupTextView',[
	title(_),
	text_script(_),
	text_size(_),
	text_color(_),
	background_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	font(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupTextView',[
	title(_),
	url(_),
	text_size(_),
	text_color(_),
	background_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	font(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupTextView',[
	title(_),
	ssh(_),
	is_toast(_),
	text_size(_),
	text_color(_),
	background_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	font(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('PopupTextView',[
	title(_),
	sftp(_),
	text_size(_),
	text_color(_),
	background_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	font(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame('RadioButton',[
	option_list([_]),
	checked_option(_),
	id(_),
	layout_width(_),
	layout_height(_),
	background_color(_),
	on_click(_)
	]).

frame('SecureFtp',[
	id(_),
	sftp(_),
	is_eigen_response(_),
	on_complete(_)
	]).

frame('SecureShell',[
	id(_),
	ssh(_),
	is_eigen_response(_),
	is_toast(_),
	on_complete(_)
	]).

frame('SecureShell',[
	id(_),
	ssh_list([_]),
	is_eigen_response(_),
	is_toast(_),
	on_complete(_)
	]).

frame('SelectDialog',[
	id(_),
	title(_),
  icon(_),
	checked_option(_),
	option_list([_]),
	on_click(_)
	]).

frame('Spinner',[
	id(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_),
	checked_option(_),
	option_list([_]),
	on_click(_)
	]).

frame('Switch',[
	id(_),
	text(_),
	checked(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_),
	on_click(_)
	]).

frame('TextView',[
	id(_),
	text(_) ; text_script(_),
	text_color(_),
	text_size(_),
	font(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_)
	]).

frame('TextView',[
	id(_),
	url(_) ; url_script(_),
	text_color(_),
	text_size(_),
	font(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_)
	]).

frame('TextView',[
	id(_),
	ssh(_) ; ssh_script(_),
	is_toast(_),
	text_color(_),
	text_size(_),
	font(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_)
	]).

frame('TextView',[
	id(_),
	sftp(_) ; sftp_script(_),
	text_color(_),
	text_size(_),
	font(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_)
	]).

frame('ToastMessage',[
	message(_) ; message_script(_)
	]).

frame('ToggleButton',[
	id(_),
	text_on(_),
	text_off(_),
	checked(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
  icon(_),
	padding(_),
	margin(_),
	on_click(_)
	]).



frame('UrlRequest',[
	id(_),
	url(_) ; url_script(_),
	is_eigen_response(_),
	on_complete(_)
	]).

frame('UrlRequest',[
	id(_),
	url(_) ; url_script(_),
	parameter_list([_]),  /* enables post-method request */
	is_eigen_response(_),
	on_complete(_)
	]).

frame('Variable',[
	name(_),
	id(_),
	method(_), 
	class(_),
	on_complete(_)
	]).

frame('VerticalLine',[
	size(_),
	color(_)
	]).

frame('WebView',[
	layout_width(_),
	layout_height(_),
	html(_), 
	is_javascript_enabled(_)
	]).

frame('WebView',[
	layout_width(_),
	layout_height(_),
	url(_), 
	is_javascript_enabled(_)
	]).


%frame(X,Y),member(text(Z),Y).

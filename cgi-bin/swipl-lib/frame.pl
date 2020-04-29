/*
?- frame(Y), member(source_text(Q),Y).
Y = [type('Button'), source_text(Q), text_color(_2084), layout_width(_2094), layout_height(_2104), gravity(_2114), background_color(_2124), icon(_2134), padding(...)|...] ;
Y = [type('CheckBox'), source_text(Q), source_checked(_2084), id(_2094), text_color(_2104), layout_width(_2114), layout_height(_2124), gravity(_2134), background_color(...)|...] ;
Y = [type('EditText'), source_text(Q), source_url(_2084), source_ssh(_2094), source_sftp(_2104), is_password(_2114), is_single_line(_2124), filter(_2134), id(...)|...] ;
Y = [type('PopupTextView'), source_text(Q), source_url(_2084), source_ssh(_2094), source_sftp(_2104), title(_2114), text_size(_2124), text_color(_2134), background_color(...)|...] ;
Y = [type('Switch'), id(_2074), source_text(Q), source_checked(_2094), text_color(_2104), layout_width(_2114), layout_height(_2124), gravity(_2134), background_color(...)|...] ;
Y = [type('TextView'), source_text(Q), source_url(_2084), source_ssh(_2094), source_sftp(_2104), id(_2114), text_color(_2124), text_size(_2134), font(...)|...] ;

?- frame(Y), member(type('CheckBox'),Y).
Y = [type('CheckBox'), source_text(_3836), source_checked(_3846), id(_3856), text_color(_3866), layout_width(_3876), layout_height(_3886), gravity(_3896), background_color(...)|...] ;

?- frame(Y), member(icon(Z),Y).
Y = [type('AlertDialog'), title(_2898), icon(Z), positive(option(_2924), on_click(_2928)), negative(option(_2944), on_click(_2948)), neutral(option(_2964), on_click(_2968))] ;
Y = [type('Button'), source_text(_2898), text_color(_2908), layout_width(_2918), layout_height(_2928), gravity(_2938), background_color(_2948), icon(Z), padding(...)|...] ;
Y = [type('CheckBox'), source_text(_2898), source_checked(_2908), id(_2918), text_color(_2928), layout_width(_2938), layout_height(_2948), gravity(_2958), background_color(...)|...] ;
Y = [type('EditText'), source_text(_2898), source_url(_2908), source_ssh(_2918), source_sftp(_2928), is_password(_2938), is_single_line(_2948), filter(_2958), id(...)|...] ;
Y = [type('HtmlView'), source_html(_2898), source_url(_2908), id(_2918), text_color(_2928), layout_width(_2938), layout_height(_2948), gravity(_2958), background_color(...)|...] ;
Y = [type('PopupHtmlView'), source_html(_2898), source_url(_2908), layout_width(_2918), layout_height(_2928), gravity(_2938), background_color(_2948), icon(Z), padding(...)|...] ;
Y = [type('PopupScreen'), source_url(_2898), id(_2908), gravity(_2918), title(_2928), text_size(_2938), text_color(_2948), background_color(_2958), icon(...)|...] ;
Y = [type('PopupScreen'), component_list([_2902]), id(_2914), gravity(_2924), title(_2934), text_size(_2944), text_color(_2954), background_color(_2964), icon(...)|...] ;
Y = [type('PopupTextView'), source_text(_2898), source_url(_2908), source_ssh(_2918), source_sftp(_2928), title(_2938), text_size(_2948), text_color(_2958), background_color(...)|...] ;
Y = [type('SelectDialog'), id(_2898), title(_2908), icon(Z), checked_option(_2928), option_list([_2942]), on_click(_2954)] ;
Y = [type('Spinner'), id(_2898), text_color(_2908), layout_width(_2918), layout_height(_2928), gravity(_2938), background_color(_2948), icon(Z), padding(...)|...] ;
Y = [type('Switch'), id(_2898), source_text(_2908), source_checked(_2918), text_color(_2928), layout_width(_2938), layout_height(_2948), gravity(_2958), background_color(...)|...] ;
Y = [type('TextView'), source_text(_2898), source_url(_2908), source_ssh(_2918), source_sftp(_2928), id(_2938), text_color(_2948), text_size(_2958), font(...)|...] ;
Y = [type('ToggleButton'), id(_2898), text_on(_2908), text_off(_2918), source_checked(_2928), text_color(_2938), layout_width(_2948), layout_height(_2958), gravity(...)|...] ;

?- source_text(Z), frame(Y), member(source_text(Z),Y).
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('Button'), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])]), text_color(_2226), layout_width(_2236), layout_height(_2246), gravity(_2256), background_color(_2266), icon(_2276), padding(...)|...] ;
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('CheckBox'), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])]), source_checked(_2226), id(_2236), text_color(_2246), layout_width(_2256), layout_height(_2266), gravity(_2276), background_color(...)|...] ;
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('EditText'), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])]), source_url(_2226), source_ssh(_2236), source_sftp(_2246), is_password(_2256), is_single_line(_2266), filter(_2276), id(...)|...] ;
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('PopupTextView'), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])]), source_url(_2226), source_ssh(_2236), source_sftp(_2246), title(_2256), text_size(_2266), text_color(_2276), background_color(...)|...] ;
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('Switch'), id(_2216), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([...])]), source_checked(_2236), text_color(_2246), layout_width(_2256), layout_height(_2266), gravity(_2276), background_color(...)|...] ;
Z = [text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])],
Y = [type('TextView'), source_text([text(_2154), text_list([_2168]), text_script(_2180), text_script_list([_2194])]), source_url(_2226), source_ssh(_2236), source_sftp(_2246), id(_2256), text_color(_2266), text_size(_2276), font(...)|...] ;

?- frame(Y), member(source_url(Z),Y), source_url(Z).
Y = [type('EditText'), source_text(_3624), source_url([url(_3804), url_script(_3814), url_script_list(_3824)]), source_ssh(_3644), source_sftp(_3654), is_password(_3664), is_single_line(_3674), filter(_3684), id(...)|...],
Z = [url(_3804), url_script(_3814), url_script_list(_3824)] ;
Y = [type('HtmlView'), source_html(_3624), source_url([url(_3734), url_script(_3744), url_script_list(_3754)]), id(_3644), text_color(_3654), layout_width(_3664), layout_height(_3674), gravity(_3684), background_color(...)|...],
Z = [url(_3734), url_script(_3744), url_script_list(_3754)] ;
Y = [type('ImageView'), source_url([url(_3714), url_script(_3724), url_script_list(_3734)]), rotation(_3634), id(_3644), layout_width(_3654), layout_height(_3664), gravity(_3674), background_color(_3684), padding(...)|...],
Z = [url(_3714), url_script(_3724), url_script_list(_3734)] ;
Y = [type('PopupHtmlView'), source_html(_3624), source_url([url(_3714), url_script(_3724), url_script_list(_3734)]), layout_width(_3644), layout_height(_3654), gravity(_3664), background_color(_3674), icon(_3684), padding(...)|...],
Z = [url(_3714), url_script(_3724), url_script_list(_3734)] ;
Y = [type('PopupScreen'), source_url([url(_3724), url_script(_3734), url_script_list(_3744)]), id(_3634), gravity(_3644), title(_3654), text_size(_3664), text_color(_3674), background_color(_3684), icon(...)|...],
Z = [url(_3724), url_script(_3734), url_script_list(_3744)] ;
Y = [type('PopupTextView'), source_text(_3624), source_url([url(_3774), url_script(_3784), url_script_list(_3794)]), source_ssh(_3644), source_sftp(_3654), title(_3664), text_size(_3674), text_color(_3684), background_color(...)|...],
Z = [url(_3774), url_script(_3784), url_script_list(_3794)] ;
Y = [type('TextView'), source_text(_3624), source_url([url(_3774), url_script(_3784), url_script_list(_3794)]), source_ssh(_3644), source_sftp(_3654), id(_3664), text_color(_3674), text_size(_3684), font(...)|...],
Z = [url(_3774), url_script(_3784), url_script_list(_3794)] ;
Y = [type('UrlRequest'), source_url([url(_3680), url_script(_3690), url_script_list(_3700)]), id(_3634), parameter_list([_3648]), is_eigen_response(_3660), on_complete(_3670)],
Z = [url(_3680), url_script(_3690), url_script_list(_3700)] ;
Y = [type('WebView'), source_url([url(_3664), url_script(_3674), url_script_list(_3684)]), layout_width(_3634), layout_height(_3644), is_javascript_enabled(_3654)],
Z = [url(_3664), url_script(_3674), url_script_list(_3684)] ;

has_type('Clone', Y).
Y = [type('Clone'), name(_2630), attributes(_2640)] ;

has_attr(source_url(url('http:')), Y).
Y = [type('EditText'), source_text(_2902), source_url(url('http:')), source_ssh(_2922), source_sftp(_2932), is_password(_2942), is_single_line(_2952), filter(_2962), id(...)|...] ;
Y = [type('HtmlView'), source_html(_2902), source_url(url('http:')), id(_2922), text_color(_2932), layout_width(_2942), layout_height(_2952), gravity(_2962), background_color(...)|...] ;
Y = [type('ImageView'), source_url(url('http:')), rotation(_2912), id(_2922), layout_width(_2932), layout_height(_2942), gravity(_2952), background_color(_2962), padding(...)|...] ;
Y = [type('PopupHtmlView'), source_html(_2902), source_url(url('http:')), layout_width(_2922), layout_height(_2932), gravity(_2942), background_color(_2952), icon(_2962), padding(...)|...] ;
Y = [type('PopupScreen'), source_url(url('http:')), id(_2912), gravity(_2922), title(_2932), text_size(_2942), text_color(_2952), background_color(_2962), icon(...)|...] ;
Y = [type('PopupTextView'), source_text(_2902), source_url(url('http:')), source_ssh(_2922), source_sftp(_2932), title(_2942), text_size(_2952), text_color(_2962), background_color(...)|...] ;
Y = [type('TextView'), source_text(_2902), source_url(url('http:')), source_ssh(_2922), source_sftp(_2932), id(_2942), text_color(_2952), text_size(_2962), font(...)|...] ;
Y = [type('UrlRequest'), source_url(url('http:')), id(_2912), parameter_list([_2926]), is_eigen_response(_2938), on_complete(_2948)] ;
Y = [type('WebView'), source_html(_2902), source_url(url('http:')), layout_width(_2922), layout_height(_2932), is_javascript_enabled(_2942)] ;

*/


%ensure_loaded('projects/eigenframe-repository/cgi-bin/swipl-lib/frame.pl')

%member2(A, B, Y) :- 
%	member(A,Y),
%	member(B,Y).

%adjacent(A, B, L) :- append(_, [A,B|_], L).
%adjacent(A, B, L) :- append(_, [B,A|_], L).

has_attr(Attr, Y) :- 
	frame(Y), member( Attr, Y).

has_type(Type,Y) :- frame(Y), member(type(Type),Y).
is_checkbox(Y) :- frame(Y), member(type('CheckBox'),Y).
is_clone(Y) :- frame(Y), member(type('Clone'),Y).
is_define(Y) :- frame(Y), member(type('Define'),Y).

source_name(
	name(_);
	name_script(_);
	name_script_list([_])
).

source_text(
	text(_); 
	text_list([_]); 
	text_script(_); 
	text_script_list([_])
).

has_source_text(Y) :- frame(Y), member(source_text(_),Y).

source_title(
	title(_); 
	title_list([_]); 
	title_script(_); 
	title_script_list([_])
).

has_title(Title, Y) :- 
	frame(Y), member( title(Title), Y).

source_html(
	html(_); 
	html_list([_])
).

source_url(
	url(_); 
	url_script(_); 
	url_script_list([_]) 
	).

has_source_url(Y) :- frame(Y), member(source_url(_),Y).
has_source_url(SourceUrl, Y) :- 
	frame(Y), member( source_url(SourceUrl), Y).


source_ssh(
	is_toast(_),
	ssh(_); 
	ssh_list([_]); 
	ssh_script(_); 
	ssh_script_list([_])
).

source_sftp(
	sftp(_); 
	sftp_script(_); 
	sftp_script_list([_])
).

source_script(
	script_script(_); 
	script(_); 
	script_list([_])
).

checked(
	_; 
	script(_); 
	script_list([_]) 
	).
has_checked(Y) :- frame(Y), member(checked(_),Y).
has_checked(B, Y) :- frame(Y), member( checked(B), Y).
has_checked_script(B, Y) :- frame(Y), member( checked(script(B)), Y).

icon(
	name(_), 
	location(_) 
	).
has_icon(Y) :- frame(Y), member(icon(_),Y).
has_icon(Name, Location, Y) :- 
	frame(Y), member( icon([name(Name), location(Location) ]), Y).

has_on_complete(Y) :- frame(Y), member(on_complete(_),Y).
has_on_complete(OnComplete, Y) :- 
	frame(Y), member( on_complete(OnComplete), Y).

has_on_click(Y) :- frame(Y), member(on_click(_),Y).
has_on_click(OnClick, Y) :- 
	frame(Y), member( on_click(OnClick), Y).

is_action(Y) :- frame(Y), member(type('ActionList'),Y).
is_action(Y) :- frame(Y), member(type('AlertDialog'),Y).
is_action(Y) :- frame(Y), member(type('Define'),Y).
is_action(Y) :- frame(Y), member(type('JavaScript'),Y).
is_action(Y) :- frame(Y), member(type('PopupHtmlView'),Y).
is_action(Y) :- frame(Y), member(type('PopupScreen'),Y).
is_action(Y) :- frame(Y), member(type('PopupTtextView'),Y).
is_action(Y) :- frame(Y), member(type('SecureFtp'),Y).
is_action(Y) :- frame(Y), member(type('SecureShell'),Y).
is_action(Y) :- frame(Y), member(type('SelectDialog'),Y).
is_action(Y) :- frame(Y), member(type('ToastMessage'),Y).
is_action(Y) :- frame(Y), member(type('UrlRequest'),Y).
is_action(Y) :- frame(Y), member(type('Variable'),Y).

is_component(Y) :- frame(Y), member(type('Button'),Y).
is_component(Y) :- frame(Y), member(type('TextView'),Y).
is_component(Y) :- frame(Y), member(type('HtmlView'),Y).
is_component(Y) :- frame(Y), member(type('WebView'),Y).
is_component(Y) :- frame(Y), member(type('ImageView'),Y).
is_component(Y) :- frame(Y), member(type('EditText'),Y).
is_component(Y) :- frame(Y), member(type('CheckBox'),Y).
is_component(Y) :- frame(Y), member(type('Spinner'),Y).
is_component(Y) :- frame(Y), member(type('Switch'),Y).
is_component(Y) :- frame(Y), member(type('ToggleButton'),Y).
is_component(Y) :- frame(Y), member(type('RadioButton'),Y).
is_component(Y) :- frame(Y), member(type('HorizontalLine'),Y).
is_component(Y) :- frame(Y), member(type('VerticalLine'),Y).
is_component(Y) :- frame(Y), member(type('LinearLayout'),Y).
is_component(Y) :- frame(Y), member(type('ListView'),Y).
is_component(Y) :- has_eigen_response(true, Y).

has_eigen_response(Y) :- frame(Y), member(is_eigen_response(true),Y).
has_eigen_response(B, Y) :- frame(Y), member(is_eigen_response(B),Y).

frame([
	type('EigenFrame'),
	script(_),
	script_list([_]),
	is_secure_window(_),
	tab_list([_])  				/* list of fragments */
]).

frame([
	type('EigenFragment'),
  name(_),
  icon_name(_),
  source_url(_)
]).

frame([
	type('ActionList'),
	component_list([_]), 
	on_complete(_)
	]).

frame([
	type('AlertDialog'),
	title(_),
	icon(_),
	positive(option(_), on_click(_)), 
	negative(option(_), on_click(_)), 
	neutral(option(_), on_click(_))
	]).

frame([
	type('Button'),
	source_text(_),
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

frame([
	type('CheckBox'),
	source_text(_),
	checked(_),
	id(_),
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

frame([
	type('Clone'),
	name(_),
	attributes(_)
	]).

frame([
	type('Define'),
	name(_),
	component(_)
	]).

frame([
	type('EditText'),
	source_text(_),
	source_url(_),
	source_ssh(_),
	source_sftp(_),
	is_password(_),
	is_single_line(_),
	filter(_),
	id(_),
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

frame([
	type('HorizontalLine'),
	size(_),
	color(_)
	]).

frame([
	type('HtmlView'),
	source_html(_),
	source_url(_),
	id(_),
	text_color(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame([
	type('ImageView'),
	source_url(_),
	rotation(_),
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	padding(_),
	margin(_),
	on_click(_)
	]).

frame([
	type('JavaScript'),
	source_script(_),
	id(_)
	]).

frame([
	type('LinearLayout'),
	scrollable(_),
	layout_width(_),
	layout_height(_),
	orientation(_),
	gravity(_),
	component_list([_])
	]).

frame([
	type('ListView'),
	option_list([_]),
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	item_layout(_),
	checked_option(_),
	on_click(_)
	]).

frame([
	type('ListView'),
	cached_filename(_),		/* "SecureFtp:{id}" */
	dir_type(_),  				/* "subdir" | "files" | "links" */
	id(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	item_layout(_),
	on_click(_)
	]).

frame([
	type('PopupHtmlView'),
	source_html(_),
	source_url(_),
	layout_width(_),
	layout_height(_),
	gravity(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame([
	type('PopupScreen'),
	source_url(_),
	id(_),
	gravity(_),
	title(_),
	text_size(_),
	text_color(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame([
	type('PopupScreen'),
	component_list([_]),
	id(_),
	gravity(_),
	title(_),
	text_size(_),
	text_color(_),
	background_color(_),
	icon(_),
	padding(_),
	margin(_)
	]).

frame([
	type('PopupTextView'),
	source_text(_),
	source_url(_),
	source_ssh(_),
	source_sftp(_),
	title(_),
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

frame([
	type('RadioButton'),
	option_list([_]),
	checked_option(_),
	id(_),
	layout_width(_),
	layout_height(_),
	background_color(_),
	on_click(_)
	]).

frame([
	type('SecureFtp'),
	source_sftp(_),
	id(_),
	is_eigen_response(_),
	on_complete(_)
	]).

frame([
	type('SecureShell'),
	source_ssh(_),
	id(_),
	is_eigen_response(_),
	on_complete(_)
	]).

frame([
	type('SelectDialog'),
	id(_),
	title(_),
  icon(_),
	checked_option(_),
	option_list([_]),
	on_click(_)
	]).

frame([
	type('Spinner'),
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

frame([
	type('Switch'),
	id(_),
	source_text(_),
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


frame([
	type('TextView'),
	source_text(_),
	source_url(_),
	source_ssh(_),
	source_sftp(_),
	id(_),
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

frame([
	type('ToastMessage'),
	message(_) ; message_script(_)
	]).

frame([
	type('ToggleButton'),
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

frame([
	type('UrlRequest'),
	source_url(_),
	id(_),
	parameter_list([_]),  /* enables post-method request */
	is_eigen_response(_),
	on_complete(_)
	]).

frame([
	type('Variable'),
	name(_),
	id(_),
	method(_), 
	class(_)
	]).

frame([
	type('VerticalLine'),
	size(_),
	color(_)
	]).

frame([
	type('WebView'),
	source_html(_), 
	source_url(_), 
	layout_width(_),
	layout_height(_),
	is_javascript_enabled(_)
	]).


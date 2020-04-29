:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_open)).

%ensure_loaded('projects/eigenframe-repository/cgi-bin/swipl-lib/frame.pl')

%open_this_url("http://api.open-notify.org/iss-now.json").
%open_this_url("https://jsonplaceholder.typicode.com/users/").
%open_this_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
open_this_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").

%open_this_url(URL), get_json_data(URL, Data), parse_eigenframe(Data).

get_json_data(URL, Data) :-
	setup_call_cleanup(
		http_open(URL, In, [request_header('Accept'='application/json')]),
		json_read_dict(In, Data, [tag(json), value_string_as(atom)]),
		close(In)
	).

parse_eigenframe(Data) :- 
	Type = Data.get(type),
	Type == 'EigenFrame',
  format(" ~w~n", [Type]),
	X = Data.get(tab_list),
	parse_eigenframe_list(X).

parse_eigenframe(Data) :- 
	Type = Data.get(type),
	Type == 'EigenFragment',
  format(" ~w~n", [Type]),
	URL = Data.get(url),
	get_json_data(URL, FragmentData),
	parse_eigenframe(FragmentData).

parse_eigenframe(Data) :- 
	Type = Data.get(type),
	Type == 'SecureFtp',
  format(" ~w~n", [Type]),
	X = Data.get(on_complete),
	parse_eigenframe(X).

parse_eigenframe(Data) :- 
	Type = Data.get(type),
	Type == 'LinearLayout',
  format(" ~w~n", [Type]),
	X = Data.get(component_list),
	parse_eigenframe_list(X).

parse_eigenframe(Data) :- 
	Type = Data.get(type),
  format(" Undefined: ~w~n", [Type]).

parse_eigenframe_list([]).
parse_eigenframe_list([H|T]) :-
	parse_eigenframe(H),
  parse_eigenframe_list(T).


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

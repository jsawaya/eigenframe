:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_open)).
:- use_module(library(filesex)).

%ensure_loaded('projects/eigenframe-repository/cgi-bin/swipl-lib/frame.pl')

select_frame_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
select_app_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").

% select_app_url(URL), show_json_url(URL).
% select_app_url(URL), read_eigenframe_url(URL).

show_json_url(URL) :-
	read_json_url(URL, Data), 
	show_json(Data).

read_eigenframe_url(URL) :-
	read_json_url(URL, Data), 
	parse_eigenframe(Data).

read_json_url(URL, Data) :-
	setup_call_cleanup(
		http_open(URL, In, [request_header('Accept'='application/json')]),
		json_read_dict(In, Data, [tag(json), value_string_as(atom)]),
		close(In)
	).

%-----------------------------------------------

select_file_checkbox('/home/john/projects/eigenframe-repository/web/frames/test-CheckBox.json').
select_file_frame('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').
select_dir_frames('/home/john/projects/eigenframe-repository/web/frames').

% select_dir_frames(Dir), show_directory(Dir,Entries), show_filenames(Dir, Entries).
% select_dir_frames(Dir), directory_files(Dir, Entries), organize_eigenframe_files(Dir, Entries).

% select_file_frame(FPath), read_eigenframe_file(FPath).
% select_file_frame(FPath), organize_eigenframe_file(FPath).
% select_file_frame(FPath), show_json_file(FPath).

% show_json_file('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').

show_directory(Dir, Entries) :- 
  working_directory(CWD, CWD),
  write(" Current: "), 	writeln(CWD),
  write(" Directory: "), 	writeln(Dir),
	directory_files(Dir, Entries),
  write(" Entries: "), 	writeln(Entries).

read_eigenframe_file(FPath) :-
	read_json_file(FPath, Data), parse_eigenframe(Data).

read_json_file(FPath, Data) :-
	open(FPath, read, Stream), 
	json_read_dict(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream).

save_json_file(FPath, Data) :-
	open(FPath, write, Stream), 
	json_write(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream).

show_json(Data) :-
	json_write(current_output, Data, [tag(json), value_string_as(atom)]).

show_json_file(FPath) :-
	read_json_file(FPath, Data), 
	show_json(Data).

organize_eigenframe_file(FPath) :-
	exists_file(FPath),
  write(" Path: "), 	writeln(FPath),
	read_json_file(FPath, Data), 
	save_json_file(FPath, Data).

show_filenames(_, []).
show_filenames(Dir, [File|T]) :-
	directory_file_path(Dir, File, Path),
	(
		exists_file(Path),
	  write(" Path: "), 	writeln(Path)
		;true
	),
	show_filenames(Dir, T).

organize_eigenframe_files(_, []).
organize_eigenframe_files(Dir, [File|T]) :-
	directory_file_path(Dir, File, Path),
	(organize_eigenframe_file(Path);true),
	organize_eigenframe_files(Dir, T).



%-----------------------------------------------
parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EigenFrame'),
	(parse_eigenframe_is_secure_window(Data,_);true),
	(parse_eigenframe_script_sources(Data);true),
	X = Data.get(tab_list),
	parse_eigenframe_list(X).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EigenFragment'),
	(parse_eigenframe_name(Data,_);true), 
	(parse_eigenframe_icon_name(Data,_);true), 
	parse_eigenframe_url(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ActionList'),
	(parse_eigenframe_component_list(Data);true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'AlertDialog').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Button'),
	(parse_eigenframe_text_sources(Data); true),
	parse_eigenframe_on_click(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'CheckBox'),
	(parse_eigenframe_text_sources(Data); true),
	(parse_eigenframe_checked(Data,_); true),
	(parse_eigenframe_id(Data,_); true),
	(parse_eigenframe_layout_width(Data,_); true),
	(parse_eigenframe_layout_height(Data,_); true),
	(parse_eigenframe_gravity(Data,_); true),
	(parse_eigenframe_background_color(Data,_); true),
	(parse_eigenframe_icon(Data,_); true),
	(parse_eigenframe_padding(Data,_); true),
	(parse_eigenframe_margin(Data,_); true),
	(parse_eigenframe_on_click(Data,_); true).


parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Clone'),
	parse_eigenframe_name(Data,_),
	(parse_eigenframe_attributes(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Define'),
	parse_eigenframe_name(Data,_),
	parse_eigenframe_component(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EditText'),
	parse_eigenframe_text_sources(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'HorizontalLine').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'HtmlView').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ImageView').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'JavaScript').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'LinearLayout'),
	parse_eigenframe_component_list(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ListView').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupHtmlView').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupScreen'),
	parse_eigenframe_component_list(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupTextView'),
	(parse_eigenframe_text_sources(Data); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'RadioButton'),
	parse_eigenframe_on_click(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SecureFtp'),
	(parse_eigenframe_sftp_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SecureShell'),
	(parse_eigenframe_ssh_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SelectDialog'),
	parse_eigenframe_on_click(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Spinner'),
	parse_eigenframe_on_click(Data,_).
	
parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Switch'),
	(parse_eigenframe_text_sources(Data); true),
	parse_eigenframe_on_click(Data,_).
	
parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'TextView'),
	(parse_eigenframe_text_sources(Data); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ToastMessage').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ToggleButton'),
	parse_eigenframe_on_click(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'UrlRequest'),
	(parse_eigenframe_url_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Variable').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'VerticalLine').

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'WebView').

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
  format(" Undefined: ~w~n", [Type]),
	writeln(Data).

%-----------------------------------------------

parse_eigenframe_component(Data) :- 
	X = Data.get(component),
  writeln("  component:"), 
	parse_eigenframe(X).

parse_eigenframe_attributes(Data) :- 
	X = Data.get(attributes),
  write("  attributes: "), 
  writeln(X).

parse_eigenframe_component_list(Data) :- 
	X = Data.get(component_list),
  writeln("  component_list..."), 
	parse_eigenframe_list(X).

parse_eigenframe_list([]).
parse_eigenframe_list([H|T]) :-
	parse_eigenframe(H),
  parse_eigenframe_list(T).

%parse_eigenframe_type(+Data, -Type)
%	should always succeed for any valid EigenFrame
parse_eigenframe_type(Data, Type) :- 
	Type = Data.get(type),
  write("  type: "), 
	writeln(Type).

%select_eigenframe_type(+Data, +Type)
select_eigenframe_type(Data, Type) :- 
	Type == Data.get(type),
  write("= Select type: "), 
	writeln(Type).

%-----------------------------------------------

parse_eigenframe_url(Data) :- 
	URL = Data.get(url),
  write("  url: "), 
	writeln(URL),
	read_json_url(URL, FrameData),
	parse_eigenframe(FrameData).

parse_eigenframe_url_script(Data) :- 
	X = Data.get(url_script),
  write("  url_script: "), 
	writeln(X).

parse_eigenframe_url_script_list(Data) :- 
	X = Data.get(url_script_list),
  write("  url_script_list: "), 
	writeln(X).

% will succeed - if frame has url source
parse_eigenframe_url_sources(Data) :- 
	(
		parse_eigenframe_url(Data);
		parse_eigenframe_url_script(Data);
		parse_eigenframe_url_script_list(Data)
	).

%-----------------------------------------------

parse_eigenframe_ssh(Data) :- 
	X = Data.get(ssh),
  write("  ssh: "), 
	writeln(X).

parse_eigenframe_ssh_script(Data) :- 
	X = Data.get(ssh_script),
  write("  ssh_script: "), 
	writeln(X).

parse_eigenframe_ssh_script_list(Data) :- 
	X = Data.get(ssh_script_list),
  write("  ssh_script_list: "), 
	writeln(X).

parse_eigenframe_ssh_sources(Data) :- 
	(
		parse_eigenframe_ssh(Data);
		parse_eigenframe_ssh_script(Data);
		parse_eigenframe_ssh_script_list(Data)
	).

%-----------------------------------------------

parse_eigenframe_sftp(Data) :- 
	X = Data.get(sftp),
  write("  sftp: "), 
	writeln(X).

parse_eigenframe_sftp_script(Data) :- 
	X = Data.get(sftp_script),
  write("  sftp_script: "), 
	writeln(X).

parse_eigenframe_sftp_script_list(Data) :- 
	X = Data.get(sftp_script_list),
  write("  sftp_script_list: "), 
	writeln(X).

parse_eigenframe_sftp_sources(Data) :- 
	(
		parse_eigenframe_sftp(Data);
		parse_eigenframe_sftp_script(Data);
		parse_eigenframe_sftp_script_list(Data)
	).

%-----------------------------------------------

parse_eigenframe_script(Data) :- 
	X = Data.get(script),
  write("  script: "), 
	writeln(X).

parse_eigenframe_script_list(Data) :- 
	X = Data.get(script_list),
  write("  script_list: "), 
	writeln(X).

parse_eigenframe_script_sources(Data) :- 
	(
		parse_eigenframe_script(Data);
		parse_eigenframe_script_list(Data)
	).

%-----------------------------------------------

parse_eigenframe_text(Data) :- 
	X = Data.get(text),
  write("  text: "), 
	writeln(X).

parse_eigenframe_text_list(Data) :- 
	X = Data.get(text_list),
  write("  text_list: "), 
	writeln(X).

parse_eigenframe_text_script(Data) :- 
	X = Data.get(text_script),
  write("  text_script: "), 
	writeln(X).

parse_eigenframe_text_script_list(Data) :- 
	X = Data.get(text_script_list),
  write("  text_script_list: "), 
	writeln(X).

parse_eigenframe_text_sources(Data) :- 
	(
		parse_eigenframe_text(Data);
		parse_eigenframe_text_list(Data);
		parse_eigenframe_text_script(Data);
		parse_eigenframe_text_script_list(Data)
	).

%-----------------------------------------------

%parse_eigenframe_id(+Data, -X) 
parse_eigenframe_id(Data, X) :- 
	X = Data.get(id),
	write("  id: "), 
	writeln(X).

%parse_eigenframe_id_script(+Data, -X) 
parse_eigenframe_id_script(Data, X) :- 
	X = Data.get(id_script),
	write("  id_script: "), 
	writeln(X).

%parse_eigenframe_id_script_list(+Data, -X) 
parse_eigenframe_id_script_list(Data, X) :- 
	X = Data.get(id_script_list),
	write("  id_script_list: "), 
	writeln(X).

parse_eigenframe_id_sources(Data) :- 
	(
		parse_eigenframe_id(Data, _);
		parse_eigenframe_id_script(Data, _);
		parse_eigenframe_id_script_list(Data, _)
	).

%-----------------------------------------------

parse_eigenframe_on_click(Data, Frame) :- 
	Frame = Data.get(on_click),
  writeln("  on_click..."), 
	parse_eigenframe(Frame).

parse_eigenframe_on_complete(Data) :- 
	Frame = Data.get(on_complete),
  write("  on_complete..."), 
	parse_eigenframe(Frame).

parse_eigenframe_is_secure_window(Data, X) :- 
	X = Data.get(is_secure_window),
 	write("  is_secure_window: "), 
	writeln(X).

%parse_eigenframe_name(+Data, -X) 
parse_eigenframe_name(Data,X) :- 
	X = Data.get(name),
	write("  name: "), 
	writeln(X).

%parse_eigenframe_icon_name(+Data, -X) 
parse_eigenframe_icon_name(Data,X) :- 
	X = Data.get(icon_name),
	write("  icon_name: "), 
	writeln(X).

%parse_eigenframe_checked(+Data, -X) 
parse_eigenframe_checked(Data, X) :- 
	X = Data.get(checked),
	write("  checked: "), 
	writeln(X).

%parse_eigenframe_text_color(+Data, -X) 
parse_eigenframe_text_color(Data, X) :- 
	X = Data.get(text_color),
	write("  text_color: "), 
	writeln(X).

%parse_eigenframe_layout_width(+Data, -X) 
parse_eigenframe_layout_width(Data, X) :- 
	X = Data.get(layout_width),
	write("  layout_width: "), 
	writeln(X).

%parse_eigenframe_layout_height(+Data, -X) 
parse_eigenframe_layout_height(Data, X) :- 
	X = Data.get(layout_height),
	write("  layout_height: "), 
	writeln(X).

%parse_eigenframe_gravity(+Data, -X) 
parse_eigenframe_gravity(Data, X) :- 
	X = Data.get(gravity),
	write("  gravity: "), 
	writeln(X).

%parse_eigenframe_background_color(+Data, -X) 
parse_eigenframe_background_color(Data, X) :- 
	X = Data.get(background_color),
	write("  background_color: "), 
	writeln(X).

%parse_eigenframe_icon(+Data, -X) 
parse_eigenframe_icon(Data, X) :- 
	X = Data.get(icon),
	write("  icon: "), 
	writeln(X).

%parse_eigenframe_padding(+Data, -X) 
parse_eigenframe_padding(Data, X) :- 
	X = Data.get(padding),
	write("  padding: "), 
	writeln(X).

%parse_eigenframe_margin(+Data, -X) 
parse_eigenframe_margin(Data, X) :- 
	X = Data.get(margin),
	write("  margin: "), 
	writeln(X).

%-----------------------------------------------



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

frame([
	type('AlertDialog'),
	title(_),
	icon(_),
	positive(option(_), on_click(_)), 
	negative(option(_), on_click(_)), 
	neutral(option(_), on_click(_))
	]).


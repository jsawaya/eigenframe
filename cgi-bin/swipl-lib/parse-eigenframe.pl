:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_open)).
:- use_module(library(filesex)).

%ensure_loaded('projects/eigenframe-repository/cgi-bin/swipl-lib/frame.pl')

select_frame_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
select_app_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").

% select_app_url(URL), read_eigenframe_url(URL).

read_eigenframe_url(URL) :-
	read_json_url(URL, Data), parse_eigenframe(Data).

read_json_url(URL, Data) :-
	setup_call_cleanup(
		http_open(URL, In, [request_header('Accept'='application/json')]),
		json_read_dict(In, Data, [tag(json), value_string_as(atom)]),
		close(In)
	).

% select_app_url(URL), show_eigenframe_url(URL).

show_eigenframe_url(URL) :-
	read_json_url(URL, Data), show_json(Data).

%-----------------------------------------------

select_file_frame('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').
select_dir_frames('/home/john/projects/eigenframe-repository/web/frames').

show_directory(Dir, Entries) :- 
  working_directory(CWD, CWD),
  write(" Current: "), 	writeln(CWD),
  write(" Directory: "), 	writeln(Dir),
	directory_files(Dir, Entries),
  write(" Entries: "), 	writeln(Entries).


% select_dir_frames(Dir), show_directory(Dir,Entries), show_filenames(Dir, Entries).
% select_dir_frames(Dir), directory_files(Dir, Entries), organize_eigenframe_files(Dir, Entries).

% select_file_frame(FPath), read_eigenframe_file(FPath).
% select_file_frame(FPath), organize_eigenframe_file(FPath).
% select_file_frame(FPath), show_eigenframe_file(FPath).


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

show_eigenframe_file(FPath) :-
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
	parse_eigenframe_type(Data, Type),
	Type == 'EigenFrame',
  format(" ~w~n", [Type]),
	(parse_eigenframe_is_secure_window(Data);true),
	(parse_eigenframe_script_sources(Data);true),
	X = Data.get(tab_list),
	parse_eigenframe_list(X).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'EigenFragment',
  format(" ~w~n", [Type]),
	(parse_eigenframe_name(Data);true), 
	(parse_eigenframe_icon_name(Data);true), 
	parse_eigenframe_url(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'ActionList',
  format(" ~w~n", [Type]),
	(parse_eigenframe_component_list(Data);true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'AlertDialog',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Button',
  format(" ~w~n", [Type]),
	(parse_eigenframe_text_sources(Data); true),
	parse_eigenframe_on_click(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'CheckBox',
  format(" ~w~n", [Type]),
	(parse_eigenframe_text_sources(Data); true),
	parse_eigenframe_on_click(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Clone',
  format(" ~w~n", [Type]),
	parse_eigenframe_name(Data),
	(parse_eigenframe_attributes(Data);true).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Define',
  format(" ~w~n", [Type]),
	parse_eigenframe_name(Data),
	parse_eigenframe_component(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'EditText',
  format(" ~w~n", [Type]),
	parse_eigenframe_text_sources(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'HorizontalLine',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'HtmlView',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'ImageView',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'JavaScript',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'LinearLayout',
  format(" ~w~n", [Type]),
	parse_eigenframe_component_list(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'ListView',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'PopupHtmlView',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'PopupScreen',
  format(" ~w~n", [Type]),
	parse_eigenframe_component_list(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'PopupTextView',
  format(" ~w~n", [Type]),
	(parse_eigenframe_text_sources(Data); true).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'RadioButton',
  format(" ~w~n", [Type]),
	parse_eigenframe_on_click(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'SecureFtp',
  format(" ~w~n", [Type]),
	(parse_eigenframe_sftp_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'SecureShell',
  format(" ~w~n", [Type]),
	(parse_eigenframe_ssh_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'SelectDialog',
  format(" ~w~n", [Type]),
	parse_eigenframe_on_click(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Spinner',
  format(" ~w~n", [Type]),
	parse_eigenframe_on_click(Data).
	
parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Switch',
  format(" ~w~n", [Type]),
	(parse_eigenframe_text_sources(Data); true),
	parse_eigenframe_on_click(Data).
	
parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'TextView',
  format(" ~w~n", [Type]),
	(parse_eigenframe_text_sources(Data); true).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'ToastMessage',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'ToggleButton',
  format(" ~w~n", [Type]),
	parse_eigenframe_on_click(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'UrlRequest',
  format(" ~w~n", [Type]),
	(parse_eigenframe_url_sources(Data); true),
	parse_eigenframe_on_complete(Data).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'Variable',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'VerticalLine',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
	Type == 'WebView',
  format(" ~w~n", [Type]).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
  format(" Undefined: ~w~n", [Type]),
	writeln(Data).

parse_eigenframe_component_list(Data) :- 
	X = Data.get(component_list),
  writeln(" Found component_list..."), 
	parse_eigenframe_list(X).

parse_eigenframe_component(Data) :- 
	X = Data.get(component),
  writeln(" Found component"), 
	parse_eigenframe(X).

parse_eigenframe_attributes(Data) :- 
	X = Data.get(attributes),
  write(" Found attributes: "), 
  writeln(X).

parse_eigenframe_list([]).
parse_eigenframe_list([H|T]) :-
	parse_eigenframe(H),
  parse_eigenframe_list(T).

%-----------------------------------------------
% should always succeed for any valid EigenFrame

parse_eigenframe_type(Data, Type) :- 
	Type = Data.get(type).

%-----------------------------------------------
% will succeed - if frame has url source

parse_eigenframe_url_sources(Data) :- 
	(
		parse_eigenframe_url(Data);
		parse_eigenframe_url_script(Data);
		parse_eigenframe_url_script_list(Data)
	).

parse_eigenframe_url(Data) :- 
	URL = Data.get(url),
  write(" Found url: "), 
	writeln(URL),
	read_json_url(URL, FrameData),
	parse_eigenframe(FrameData).

parse_eigenframe_url_script(Data) :- 
	X = Data.get(url_script),
  write(" Found url_script: "), 
	writeln(X).

parse_eigenframe_url_script_list(Data) :- 
	X = Data.get(url_script_list),
  write(" Found url_script_list: "), 
	writeln(X).

%-----------------------------------------------

parse_eigenframe_ssh_sources(Data) :- 
	(
		parse_eigenframe_ssh(Data);
		parse_eigenframe_ssh_script(Data);
		parse_eigenframe_ssh_script_list(Data)
	).

parse_eigenframe_ssh(Data) :- 
	X = Data.get(ssh),
  write(" Found ssh: "), 
	writeln(X).

parse_eigenframe_ssh_script(Data) :- 
	X = Data.get(ssh_script),
  write(" Found ssh_script: "), 
	writeln(X).

parse_eigenframe_ssh_script_list(Data) :- 
	X = Data.get(ssh_script_list),
  write(" Found ssh_script_list: "), 
	writeln(X).

%-----------------------------------------------

parse_eigenframe_sftp_sources(Data) :- 
	(
		parse_eigenframe_sftp(Data);
		parse_eigenframe_sftp_script(Data);
		parse_eigenframe_sftp_script_list(Data)
	).

parse_eigenframe_sftp(Data) :- 
	X = Data.get(sftp),
  write(" Found sftp: "), 
	writeln(X).

parse_eigenframe_sftp_script(Data) :- 
	X = Data.get(sftp_script),
  write(" Found sftp_script: "), 
	writeln(X).

parse_eigenframe_sftp_script_list(Data) :- 
	X = Data.get(sftp_script_list),
  write(" Found sftp_script_list: "), 
	writeln(X).

%-----------------------------------------------

parse_eigenframe_script_sources(Data) :- 
	(
		parse_eigenframe_script(Data);
		parse_eigenframe_script_list(Data)
	).

parse_eigenframe_script(Data) :- 
	X = Data.get(script),
  write(" Found script: "), 
	writeln(X).

parse_eigenframe_script_list(Data) :- 
	X = Data.get(script_list),
  write(" Found script_list: "), 
	writeln(X).

%-----------------------------------------------

parse_eigenframe_text_sources(Data) :- 
	(
		parse_eigenframe_text(Data);
		parse_eigenframe_text_list(Data);
		parse_eigenframe_text_script(Data);
		parse_eigenframe_text_script_list(Data)
	).

parse_eigenframe_text(Data) :- 
	X = Data.get(text),
  write(" Found text: "), 
	writeln(X).

parse_eigenframe_text_list(Data) :- 
	X = Data.get(text_list),
  write(" Found text_list: "), 
	writeln(X).

parse_eigenframe_text_script(Data) :- 
	X = Data.get(text_script),
  write(" Found text_script: "), 
	writeln(X).

parse_eigenframe_text_script_list(Data) :- 
	X = Data.get(text_script_list),
  write(" Found text_script_list: "), 
	writeln(X).

%-----------------------------------------------

parse_eigenframe_on_click(Data) :- 
	Frame = Data.get(on_click),
  write(" Found on_click: "), 
%	writeln(Frame),
	parse_eigenframe(Frame).

parse_eigenframe_on_complete(Data) :- 
	Frame = Data.get(on_complete),
  write(" Found on_complete: "), 
%	writeln(Frame),
	parse_eigenframe(Frame).


parse_eigenframe_is_secure_window(Data) :- 
	X = Data.get(is_secure_window),
 	write(" Found is_secure_window: "), 
	writeln(X).

parse_eigenframe_name(Data) :- 
	X = Data.get(name),
	write(" Found name: "), 
	writeln(X).

parse_eigenframe_icon_name(Data) :- 
	X = Data.get(icon_name),
	write(" Found icon_name: "), 
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


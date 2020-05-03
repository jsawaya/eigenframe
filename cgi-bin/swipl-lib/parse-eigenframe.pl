:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_open)).
:- use_module(library(filesex)).

%ensure_loaded('projects/eigenframe-repository/cgi-bin/swipl-lib/frame.pl')

select_frame_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
select_app_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").

show_json_url_test :-
	select_app_url(URL), 
	show_json_url(URL).

read_eigenframe_url_test :-
	select_app_url(URL), 
	read_eigenframe_url(URL).

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
select_dir_frames('/home/john/projects/eigenframe-repository/web/frames').

list_filenames_test :-
	select_dir_frames(Dir), 
	directory_files(Dir, E), 
	sort(E,Entries), 
	list_filenames(Dir, Entries).

list_filenames(_, []).
list_filenames(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
	  write(" Path: "), 	writeln(FPath)
		;true
	),
	list_filenames(Dir, T).

%-----------------------------------------------
select_file_test('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').

show_json_file_test :-
	select_file_test(X),
	show_json_file(X).

show_json_file(FPath) :-
	read_json_file(FPath, Data), 
	show_json(Data).

show_json(Data) :-
	json_write(current_output, Data, [tag(json), value_string_as(atom)]).

assert_json_file_test :-
	select_file_test(X),
	read_json_file(X, Data), 
	assert(json_file_data(X, Data)).

%json_file_data(X,Data), parse_eigenframe(Data).


%-----------------------------------------------

read_eigenframe_file_test :-
	read_eigenframe_file('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').

read_eigenframe_files_test :- 
	select_dir_frames(Dir), 
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_eigenframe_files(Dir, Entries).

read_eigenframe_files(_, []).
read_eigenframe_files(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		read_eigenframe_file(FPath),
	  write(" ------------------------- Path: "), 	writeln(FPath)
		;true
	),
	read_eigenframe_files(Dir, T).

read_eigenframe_file(FPath) :-
	read_json_file(FPath, Data), 
	parse_eigenframe(Data).

:- dynamic
        json_file_data/2.

% check dynamic assertion first
read_json_file(FPath, Data) :-
	json_file_data(FPath, Data).

% create dynamic assertion
read_json_file(FPath, Data) :-
  write(" Read from filepath: "), 	writeln(FPath),
	open(FPath, read, Stream), 
	json_read_dict(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream),
	assert(json_file_data(FPath, Data)).

%-----------------------------------------------

organize_eigenframe_file_test :-
	organize_eigenframe_file('/home/john/projects/eigenframe-repository/web/frames/script-cmd.json').

organize_eigenframe_file(FPath) :-
	exists_file(FPath),
  write(" Path: "), 	writeln(FPath),
	read_json_file(FPath, Data), 
	save_json_file(FPath, Data).

% select_dir_frames(Dir), directory_files(Dir, Entries), organize_eigenframe_files(Dir, Entries).

organize_eigenframe_files(_, []).
organize_eigenframe_files(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		organize_eigenframe_file(FPath),
	  write(" ------------------------- Path: "), 	writeln(FPath)
		;true
	),
	organize_eigenframe_files(Dir, T).

save_json_file(FPath, Data) :-
	open(FPath, write, Stream), 
	json_write(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream).

%-----------------------------------------------

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EigenFrame'),
	parse_eigenframe_list(Data.get(tab_list)),
	(parse_eigenframe_is_secure_window(Data,_);true),
	(parse_eigenframe_script_sources(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EigenFragment'),
	parse_eigenframe_url_expand(Data),
	(parse_eigenframe_name_sources(Data);true), 
	(parse_eigenframe_icon_name(Data,_);true). 

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ActionList'),
	(parse_eigenframe_comment(Data,_); true),
	(parse_eigenframe_component_list(Data);true),
	(parse_eigenframe_on_complete(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'AlertDialog'),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_icon(Data,_); true),
	(parse_eigenframe_alert_dialog_positive(Data,_); true),
	(parse_eigenframe_alert_dialog_negative(Data,_); true),
	(parse_eigenframe_alert_dialog_neutral(Data,_); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Button'),
	(parse_eigenframe_text_sources(Data); true),
	(parse_eigenframe_on_click(Data,_); true).

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
	parse_eigenframe_name(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Clone'),
	parse_eigenframe_name(Data,_),
	(parse_eigenframe_attributes(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Define'),
	parse_eigenframe_name_sources(Data),
	parse_eigenframe_component(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'EditText'),
	(parse_eigenframe_text_sources(Data);true),
	(parse_eigenframe_url_sources(Data);true),
	(parse_eigenframe_ssh_sources(Data);true),
	(parse_eigenframe_sftp_sources(Data);true),
	(parse_eigenframe_is_password(Data,_);true),
	(parse_eigenframe_is_single_line(Data,_);true),
	(parse_eigenframe_filter(Data,_);true),
	(parse_eigenframe_id(Data,_);true),
	(parse_eigenframe_text_color(Data,_);true),
	(parse_eigenframe_text_size(Data,_);true),
	(parse_eigenframe_font(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'HorizontalLine'),
	(parse_eigenframe_size(Data,_);true),
	(parse_eigenframe_color(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'HtmlView'),
	parse_eigenframe_html_sources(Data),
	(parse_eigenframe_id(Data,_);true),
	(parse_eigenframe_text_color(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'HtmlView'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_id(Data,_);true),
	(parse_eigenframe_text_color(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ImageView'),
	(parse_eigenframe_image_url_sources(Data);true),
	(parse_eigenframe_rotation(Data,_);true),
	(parse_eigenframe_id(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'JavaScript'),
	(parse_eigenframe_comment(Data,_); true),
	(parse_eigenframe_id_sources(Data); true),
	(parse_eigenframe_script_sources(Data); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'LinearLayout'),
	(parse_eigenframe_scrollable(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_orientation(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	parse_eigenframe_component_list(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ListView'),
	parse_eigenframe_cached_filename(Data,_),
	parse_eigenframe_dir_type(Data,_),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_item_layout(Data,_);true),
	(parse_eigenframe_checked_option(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ListView'),
	parse_eigenframe_option_list(Data,_),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_item_layout(Data,_);true),
	(parse_eigenframe_checked_option(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupHtmlView'),
	parse_eigenframe_html_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupHtmlView'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupScreen'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupScreen'),
	parse_eigenframe_component_list(Data),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupTextView'),
	parse_eigenframe_text_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupTextView'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupTextView'),
	parse_eigenframe_ssh_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'PopupTextView'),
	parse_eigenframe_sftp_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_text_size(Data,_); true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'RadioButton'),
	parse_eigenframe_option_list(Data,_),
	(parse_eigenframe_checked_option(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_orientation(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SecureFtp'),
	parse_eigenframe_sftp_sources(Data),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_is_eigen_response(Data,_);true),
	(parse_eigenframe_on_complete(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SecureShell'),
	parse_eigenframe_ssh_sources(Data),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_is_eigen_response(Data,_);true),
	(parse_eigenframe_on_complete(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'SelectDialog'),
	parse_eigenframe_option_list(Data,_),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_title_sources(Data);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_checked_option(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Spinner'),
	parse_eigenframe_option_list(Data,_),
	(parse_eigenframe_checked_option(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_text_color(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Switch'),
	(parse_eigenframe_text_sources(Data); true),
	(parse_eigenframe_checked(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_text_color(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'TextView'),
	parse_eigenframe_text_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data); true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_text_size(Data,_); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'TextView'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data); true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_text_size(Data,_); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'TextView'),
	parse_eigenframe_ssh_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data); true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_text_size(Data,_); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'TextView'),
	parse_eigenframe_sftp_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_font(Data,_); true),
	(parse_eigenframe_gravity(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data); true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_); true),
	(parse_eigenframe_text_size(Data,_); true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ToastMessage'),
	parse_eigenframe_message_script(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ToggleButton'),
	parse_eigenframe_text_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_checked(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'ToggleButton'),
	parse_eigenframe_text_on_sources(Data),
	parse_eigenframe_text_off_sources(Data),
	(parse_eigenframe_background_color(Data,_);true),
	(parse_eigenframe_checked(Data,_);true),
	(parse_eigenframe_icon(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_margin(Data,_);true),
	(parse_eigenframe_on_click(Data,_);true),
	(parse_eigenframe_padding(Data,_);true),
	(parse_eigenframe_text_color(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'UrlRequest'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_parameter_list(Data,_);true),
	(parse_eigenframe_id_sources(Data);true),
	(parse_eigenframe_is_eigen_response(Data,_);true),
	(parse_eigenframe_on_complete(Data);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Variable'),
	parse_eigenframe_name_sources(Data),
	parse_eigenframe_id_sources(Data),
	parse_eigenframe_method(Data,_),
	parse_eigenframe_class(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'VerticalLine'),
	(parse_eigenframe_size(Data,_);true),
	(parse_eigenframe_color(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'WebView'),
	parse_eigenframe_html_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_is_javascript_enabled(Data,_);true).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'WebView'),
	parse_eigenframe_url_sources(Data),
	(parse_eigenframe_title_sources(Data); true),
	(parse_eigenframe_layout_width(Data,_);true),
	(parse_eigenframe_layout_height(Data,_);true),
	(parse_eigenframe_is_javascript_enabled(Data,_);true).

parse_eigenframe(Data) :- 
	parse_eigenframe_type(Data, Type),
  format(" Undefined: ~w~n", [Type]),
	writeln(Data).

%-----------------------------------------------

parse_eigenframe_component(Data) :- 
	X = Data.get(component),
%  writeln("  component:"), 
	parse_eigenframe(X).

parse_eigenframe_attributes(Data) :- 
	X = Data.get(attributes),
	write("  attributes: "), 
  writeln(X).

parse_eigenframe_component_list(Data) :- 
	X = Data.get(component_list),
%  writeln("  component_list..."), 
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


parse_eigenframe_url_expand(Data) :- 
	URL = Data.get(url),
  write("  url: "), 
	writeln(URL),
	read_json_url(URL, FrameData),
	parse_eigenframe(FrameData).

%-----------------------------------------------

parse_eigenframe_url(Data) :- 
	URL = Data.get(url),
  write("  url: "), 
	writeln(URL).

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

parse_eigenframe_image_url(Data) :- 
	URL = Data.get(url),
  write("  image_url: "), 
	writeln(URL).

parse_eigenframe_image_url_script(Data) :- 
	X = Data.get(url_script),
  write("  image_url_script: "), 
	writeln(X).

parse_eigenframe_image_url_script_list(Data) :- 
	X = Data.get(url_script_list),
  write("  image_url_script_list: "), 
	writeln(X).

% will succeed - if frame has url source
parse_eigenframe_image_url_sources(Data) :- 
	(
		parse_eigenframe_image_url(Data);
		parse_eigenframe_image_url_script(Data);
		parse_eigenframe_image_url_script_list(Data)
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

parse_eigenframe_html(Data) :- 
	X = Data.get(html),
  write("  html: "), 
	writeln(X).

parse_eigenframe_html_list(Data) :- 
	X = Data.get(html_list),
  write("  html_list: "), 
	writeln(X).

parse_eigenframe_html_script(Data) :- 
	X = Data.get(html_script),
  write("  html_script: "), 
	writeln(X).

parse_eigenframe_html_script_list(Data) :- 
	X = Data.get(html_script_list),
  write("  html_script_list: "), 
	writeln(X).

parse_eigenframe_html_sources(Data) :- 
	(
		parse_eigenframe_html(Data);
		parse_eigenframe_html_list(Data);
		parse_eigenframe_html_script(Data);
		parse_eigenframe_html_script_list(Data)
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

%parse_eigenframe_title(+Data, -X) 
parse_eigenframe_title(Data, X) :- 
	X = Data.get(title),
	write("  title: "), 
	writeln(X).

%parse_eigenframe_title_script(+Data, -X) 
parse_eigenframe_title_script(Data, X) :- 
	X = Data.get(title_script),
	write("  title_script: "), 
	writeln(X).

%parse_eigenframe_title_script_list(+Data, -X) 
parse_eigenframe_title_script_list(Data, X) :- 
	X = Data.get(title_script_list),
	write("  title_script_list: "), 
	writeln(X).

parse_eigenframe_title_sources(Data) :- 
	(
		parse_eigenframe_title(Data, _);
		parse_eigenframe_title_script(Data, _);
		parse_eigenframe_title_script_list(Data, _)
	).

%-----------------------------------------------

%parse_eigenframe_name(+Data, -X) 
parse_eigenframe_name(Data, X) :- 
	X = Data.get(name),
	write("  name: "), 
	writeln(X).

%parse_eigenframe_name_script(+Data, -X) 
parse_eigenframe_name_script(Data, X) :- 
	X = Data.get(name_script),
	write("  name_script: "), 
	writeln(X).

%parse_eigenframe_name_script_list(+Data, -X) 
parse_eigenframe_name_script_list(Data, X) :- 
	X = Data.get(name_script_list),
	write("  name_script_list: "), 
	writeln(X).

parse_eigenframe_name_sources(Data) :- 
	(
		parse_eigenframe_name(Data, _);
		parse_eigenframe_name_script(Data, _);
		parse_eigenframe_name_script_list(Data, _)
	).

%-----------------------------------------------

%parse_eigenframe_condition(+Data, -X) 
parse_eigenframe_condition(Data, X) :- 
	X = Data.get(condition),
	write("  condition: "), 
	writeln(X).

%parse_eigenframe_condition_script(+Data, -X) 
parse_eigenframe_condition_script(Data, X) :- 
	X = Data.get(condition_script),
	write("  condition_script: "), 
	writeln(X).

%parse_eigenframe_condition_script_list(+Data, -X) 
parse_eigenframe_condition_script_list(Data, X) :- 
	X = Data.get(condition_script_list),
	write("  condition_script_list: "), 
	writeln(X).

parse_eigenframe_condition_sources(Data) :- 
	(
		parse_eigenframe_condition(Data, _);
		parse_eigenframe_condition_script(Data, _);
		parse_eigenframe_condition_script_list(Data, _)
	).

%-----------------------------------------------
%parse_eigenframe_text_on(+Data, -X) 
parse_eigenframe_text_on(Data, X) :- 
	X = Data.get(text_on),
	write("  text_on: "), 
	writeln(X).

%parse_eigenframe_text_on_script(+Data, -X) 
parse_eigenframe_text_on_script(Data, X) :- 
	X = Data.get(text_on_script),
	write("  text_on_script: "), 
	writeln(X).

%parse_eigenframe_text_on_script_list(+Data, -X) 
parse_eigenframe_text_on_script_list(Data, X) :- 
	X = Data.get(text_on_script_list),
	write("  text_on_script_list: "), 
	writeln(X).

parse_eigenframe_text_on_sources(Data) :- 
	(
		parse_eigenframe_text_on(Data, _);
		parse_eigenframe_text_on_script(Data, _);
		parse_eigenframe_text_on_script_list(Data, _)
	).

%-----------------------------------------------
%parse_eigenframe_text_off(+Data, -X) 
parse_eigenframe_text_off(Data, X) :- 
	X = Data.get(text_off),
	write("  text_off: "), 
	writeln(X).

%parse_eigenframe_text_off_script(+Data, -X) 
parse_eigenframe_text_off_script(Data, X) :- 
	X = Data.get(text_off_script),
	write("  text_off_script: "), 
	writeln(X).

%parse_eigenframe_text_off_script_list(+Data, -X) 
parse_eigenframe_text_off_script_list(Data, X) :- 
	X = Data.get(text_off_script_list),
	write("  text_off_script_list: "), 
	writeln(X).

parse_eigenframe_text_off_sources(Data) :- 
	(
		parse_eigenframe_text_off(Data, _);
		parse_eigenframe_text_off_script(Data, _);
		parse_eigenframe_text_off_script_list(Data, _)
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

%parse_eigenframe_text_size(+Data, -X) 
parse_eigenframe_text_size(Data, X) :- 
	X = Data.get(text_size),
	write("  text_size: "), 
	writeln(X).

%parse_eigenframe_font(+Data, -X) 
parse_eigenframe_font(Data, X) :- 
	X = Data.get(font),
	write("  font: "), 
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

%parse_eigenframe_is_password(+Data, -X) 
parse_eigenframe_is_password(Data, X) :- 
	X = Data.get(is_password),
	write("  is_password: "), 
	writeln(X).

%parse_eigenframe_is_single_line(+Data, -X) 
parse_eigenframe_is_single_line(Data, X) :- 
	X = Data.get(is_single_line),
	write("  is_single_line: "), 
	writeln(X).

%parse_eigenframe_filter(+Data, -X) 
parse_eigenframe_filter(Data, X) :- 
	X = Data.get(filter),
	write("  filter: "), 
	writeln(X).

%parse_eigenframe_size(+Data, -X) 
parse_eigenframe_size(Data, X) :- 
	X = Data.get(size),
	write("  size: "), 
	writeln(X).

%parse_eigenframe_color(+Data, -X) 
parse_eigenframe_color(Data, X) :- 
	X = Data.get(color),
	write("  color: "), 
	writeln(X).

%parse_eigenframe_rotation(+Data, -X) 
parse_eigenframe_rotation(Data, X) :- 
	X = Data.get(rotation),
	write("  rotation: "), 
	writeln(X).

%parse_eigenframe_scrollable(+Data, -X) 
parse_eigenframe_scrollable(Data, X) :- 
	X = Data.get(scrollable),
	write("  scrollable: "), 
	writeln(X).

%parse_eigenframe_orientation(+Data, -X) 
parse_eigenframe_orientation(Data, X) :- 
	X = Data.get(orientation),
	write("  orientation: "), 
	writeln(X).

%parse_eigenframe_option_list(+Data, -X) 
parse_eigenframe_option_list(Data, X) :- 
	X = Data.get(option_list),
	write("  option_list: "), 
	writeln(X).

%parse_eigenframe_item_layout(+Data, -X) 
parse_eigenframe_item_layout(Data, X) :- 
	X = Data.get(item_layout),
	write("  item_layout: "), 
	writeln(X).

%parse_eigenframe_checked_option(+Data, -X) 
parse_eigenframe_checked_option(Data, X) :- 
	X = Data.get(checked_option),
	write("  checked_option: "), 
	writeln(X).

%parse_eigenframe_cached_filename(+Data, -X) 
parse_eigenframe_cached_filename(Data, X) :- 
	X = Data.get(cached_filename),
	write("  cached_filename: "), 
	writeln(X).

%parse_eigenframe_dir_type(+Data, -X) 
parse_eigenframe_dir_type(Data, X) :- 
	X = Data.get(dir_type),
	write("  dir_type: "), 
	writeln(X).

%parse_eigenframe_comment(+Data, -X) 
parse_eigenframe_comment(Data, X) :- 
	X = Data.get(comment),
	write("  comment: "), 
	writeln(X).

%parse_eigenframe_is_eigen_response(+Data, -X) 
parse_eigenframe_is_eigen_response(Data, X) :- 
	X = Data.get(is_eigen_response),
	write("  is_eigen_response: "), 
	writeln(X).

%parse_eigenframe_message_script(+Data, -X) 
parse_eigenframe_message_script(Data, X) :- 
	X = Data.get(message_script),
	write("  message_script: "), 
	writeln(X).

%parse_eigenframe_parameter_list(+Data, -X) 
parse_eigenframe_parameter_list(Data, X) :- 
	X = Data.get(parameter_list),
	write("  parameter_list: "), 
	writeln(X).

%parse_eigenframe_method(+Data, -X) 
parse_eigenframe_method(Data, X) :- 
	X = Data.get(method),
	write("  method: "), 
	writeln(X).

%parse_eigenframe_class(+Data, -X) 
parse_eigenframe_class(Data, X) :- 
	X = Data.get(class),
	write("  class: "), 
	writeln(X).

%parse_eigenframe_is_javascript_enabled(+Data, -X) 
parse_eigenframe_is_javascript_enabled(Data, X) :- 
	X = Data.get(is_javascript_enabled),
	write("  is_javascript_enabled: "), 
	writeln(X).

%parse_eigenframe_alert_dialog_positive(+Data, -X) 
parse_eigenframe_alert_dialog_positive(Data, X) :- 
	X = Data.get(positive),
	write("  positive: "), 	writeln(X),
	write("  option: "), writeln(X.get(option)),
	(parse_eigenframe_on_click(X,_); true).

%parse_eigenframe_alert_dialog_negative(+Data, -X) 
parse_eigenframe_alert_dialog_negative(Data, X) :- 
	X = Data.get(negative),
	write("  negative: "), writeln(X),
	write("  option: "), writeln(X.get(option)),
	(parse_eigenframe_on_click(X,_); true).

%parse_eigenframe_alert_dialog_neutral(+Data, -X) 
parse_eigenframe_alert_dialog_neutral(Data, X) :- 
	X = Data.get(neutral),
	write("  neutral: "), writeln(X),
	write("  option: "), writeln(X.get(option)),
	(parse_eigenframe_on_click(X,_); true).

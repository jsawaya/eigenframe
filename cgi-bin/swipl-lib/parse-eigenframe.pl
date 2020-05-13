% swipl projects/eigenframe-repository/cgi-bin/swipl-lib/parse-eigenframe.pl --http=8000
% swipl projects/eigenframe-repository/cgi-bin/swipl-lib/parse-eigenframe.pl

:- use_module(library(apply)).
:- use_module(library(lists)).
:- use_module(library(filesex)).

:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
%:- use_module(library(http/thread_httpd)).	% for testing only
:- use_module(library(http/http_unix_daemon)). %% enable for default http service

%:- use_module(library(http/http_session)).  % not needed

%:- set_setting(http:logfile, 'my_log_file.log').

:- http_handler('/hi', say_hi, []).
:- http_handler('/time', handle_time_request, []).
:- http_handler('/parms', handle_parms, []).
:- http_handler('/frame', handle_frame, []).
:- http_handler('/files', handle_files, []).
:- http_handler('/search', handle_search, []).
:- http_handler('/collect', handle_collect, []).
:- http_handler('/parse', handle_parse, []).
:- http_handler('/api', handle_api, []).
:- http_handler('/halt', handle_halt, []).

:- multifile http_json/1.

% :- initialization(start_svc). % for testing only

:- initialization(load_all_files).

load_all_files :- 
	load_frames,
	load_apps.

load_frames :-
	directory_eigenframe_web_frames(Dir),
	write("Read Directory: "), writeln(Dir),
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_filenames(Dir, Entries).

load_apps :-
	directory_eigenframe_web_apps(Dir),
	write("Read Directory: "), writeln(Dir),
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_filenames(Dir, Entries).

% ----------------------------------------------------
start_svc :- 
	server(8000).

stop_svc :- 
	http_stop_server(8000, []).

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

http_json:json_type('application/x-javascript').
http_json:json_type('text/javascript').
http_json:json_type('text/x-javascript').
http_json:json_type('text/x-json').

%curl 'http://localhost:8000/halt'
%curl --header 'Content-Type: application/json' --request POST --data '{"a": 1, "b": 2 }' 'http://localhost:8000/api'
%curl --header 'Content-Type: application/json' 'http://localhost:8000/search?type=EditText'
%curl 'http://localhost:8000/parse?file=test-Button.json'
%curl 'http://localhost:8000/files'
%curl 'http://localhost:8000/parms?data=test("this").'

% ----------------------------------------------------
handle_halt(_Request) :-
	reply_html_page(
		[title('Halting SWI-Prolog HTTP Service...')],
		[h1('SWI-Prolog HTTP Service Halted')]
	),
	halt.

% ----------------------------------------------------
solve(_{a:X, b:Y}, _{answer:N}) :-
	number(X),
	number(Y),
	N is X + Y.

handle_api(Request) :-
	http_read_json_dict(Request, Query),
	solve(Query, Solution),
	reply_json_dict(Solution).

% ----------------------------------------------------
% http://localhost:8000/collect?file=test-TextView.json
handle_collect(Request) :-
	http_parameters(Request,
  	[	file(File, [ optional(true) ]) 
		]),
	format('Content-type: text/plain~n~n', []),
	directory_eigenframe_web_frames(Dir),
	writeln("Directory: "), writeln(Dir),
	directory_file_path(Dir, File, FPath),
	exists_file(FPath),
  write(" FilePath: "), writeln(FPath),
	dyn_json_file_data(FPath, Data),
	collect_data(Data, List),
	each_write(List).

% ----------------------------------------------------
% http://localhost:8000/search?type=PopupHtmlView
% http://localhost:8000/search?type=EditText
handle_search(Request) :-
	http_parameters(Request,
  	[	type(Type, [ optional(true) ]) 
		]),
	format('Content-type: application/json; charset=UTF-8~n~n', []),
	write('{"type": "'), write(Type), write('", "found": [ {}'), 
	search_eigenframe_type_test(Type),false;
	write("]}"),
	true.

% ----------------------------------------------------
% http://localhost:8000/parse
handle_parse(Request) :-
	http_parameters(Request,
  	[	file(File, [ optional(false) ]) 
		]),
	format('Content-type: text/plain~n~n', []),
	directory_eigenframe_web_frames(Dir),
	writeln("Directory: "), writeln(Dir),
	directory_file_path(Dir, File, FPath),
	exists_file(FPath),
  write(" FilePath: "), writeln(FPath),
	read_eigenframe_file(FPath).

% ----------------------------------------------------
% http://localhost:8000/files
handle_files(_Request) :-
	format('Content-type: text/plain~n~n', []),
	directory_eigenframe_web_frames(Dir),
	writeln("Directory: "), writeln(Dir),
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_filenames(Dir, Entries).

% ----------------------------------------------------
% http://localhost:8000/frame?file=test-TextView.json
% show json frame given file
handle_frame(Request) :-
	http_parameters(Request,
  	[	file(FName, [ optional(true) ]) 
		]),
%	format('Content-type: application/json; charset=UTF-8~n~n', []),
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data), 
	reply_json_dict(Data).

/*
handle(Request) :-
	http_parameters(Request,
  	[	title(Title, [ optional(true) ]),
			name(Name,   [ length >= 2 ]),
			age(Age,     [ between(0, 150) ])
		]),
*/
% ----------------------------------------------------
handle_parms(Request) :-
	format('Content-type: text/html~n~n', []),
	format('<html>~n', []),
	format('<table border=1>~n'),
	print_request(Request),
	format('~n</table>~n'),
	format('</html>~n', []).

print_request([]).
print_request([H|T]) :-
	H =.. [Name, Value],
	format('<tr><td>~w<td>~w~n', [Name, Value]),
	print_request(T).

% ----------------------------------------------------
handle_time_request(_Request) :-
	get_time(X),  % X = seconds elapsed since the epoch.
	reply_html_page(
		[title('Time')],
		[h1('Time: '), p(X)]
	).

% ----------------------------------------------------
say_hi(_Request) :-
	format('Content-type: text/plain~n~n'),
	format('Hello World!~n'),
	directory_eigenframe(Root),
	format('root: ~w~n', [Root]),
	directory_eigenframe_cgibin(Cgi),
	format('cgi-bin: ~w~n', [Cgi]),
	directory_eigenframe_web_frames(Frames),
	format('frames: ~w~n', [Frames]).

% ----------------------------------------------------
% directory in eigenframe repository

eigenframe.

select_file_test(FPath) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, 'script-cmd.json', FPath).

directory_eigenframe_cgibin_swipllib(CWD) :-
	source_file(eigenframe, FPath),
	directory_file_path(Dir, _, FPath),
	working_directory(_,Dir),
	working_directory(CWD,CWD).

directory_eigenframe_cgibin(CWD) :-
	directory_eigenframe_cgibin_swipllib(Dir),
	working_directory(Dir,'..'),
	working_directory(CWD,CWD).

directory_eigenframe(CWD) :-
	directory_eigenframe_cgibin(Dir),
	working_directory(Dir,'..'),
	working_directory(CWD,CWD).

directory_eigenframe_web(CWD) :-
	directory_eigenframe(Dir),
	working_directory(Dir,'web'),
	working_directory(CWD,CWD).

directory_eigenframe_web_apps(CWD) :-
	directory_eigenframe_web(Dir),
	working_directory(Dir,'apps'),
	working_directory(CWD,CWD).

directory_eigenframe_web_frames(CWD) :-
	directory_eigenframe_web(Dir),
	working_directory(Dir,'frames'),
	working_directory(CWD,CWD).

% ----------------------------------------------------

read_filenames_test :-
	directory_eigenframe_web_frames(Dir), 
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_filenames(Dir, Entries).

read_filenames(_, []).
read_filenames(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
%	  write(" Read FilePath: "), 	writeln(FPath),
		read_json_file(FPath, _); 
		true
	),
	read_filenames(Dir, T).

% ----------------------------------------------------
% select directory, get directory entries, sort, list filenames

list_filenames_test :-
	directory_eigenframe_web_frames(Dir), 
	directory_files(Dir, E), 
	sort(E,Entries), 
	list_filenames(Dir, Entries).

list_filenames(_, []).
list_filenames(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
	  write(" List FilePath: "), 	writeln(FPath)
		;true
	),
	list_filenames(Dir, T).

% ----------------------------------------------------
% Read json into prolog dict structure (sorts attributes), and write to current_output (screen)

show_json_file_test :-
	select_file_test(X),
	show_json_file(X).

show_json_file(FPath) :-
	read_json_file(FPath, Data), 
	show_json(Data).

show_json(Data) :-
	json_write(current_output, Data, [tag(json), value_string_as(atom)]).

% ----------------------------------------------------
% Read json into prolog dict structure (sorts attributes), and parse_eigenframe. 
read_eigenframe_file_test :-
	select_file_test(FPath),
	read_eigenframe_file(FPath).

read_eigenframe_files_test :- 
	directory_eigenframe_web_frames(Dir), 
	directory_files(Dir, E), 
	sort(E,Entries), 
	read_eigenframe_files(Dir, Entries).

read_eigenframe_files(_, []).
read_eigenframe_files(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		read_eigenframe_file(FPath),
	  write(" Read EigenFrame FilePath: "), writeln(FPath)
		;true
	),
	read_eigenframe_files(Dir, T).

read_eigenframe_file(FPath) :-
	read_json_file(FPath, Data), 
	parse_eigenframe(Data).

% ----------------------------------------------------
:- dynamic dyn_json_file_data/2.

% check dynamic assertion first
read_json_file(FPath, Data) :-
	dyn_json_file_data(FPath, Data).

% create dynamic assertion
read_json_file(FPath, Data) :-
%  write(" Read from filepath: "), 	writeln(FPath),
	open(FPath, read, Stream), 
	json_read_dict(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream),
	assertz(dyn_json_file_data(FPath, Data)).

% ----------------------------------------------------

% Read json into prolog dict structure (sorts attributes), then write back into same file. 
organize_eigenframe_file_test :-
	select_file_test(FPath),
	organize_eigenframe_file(FPath).

organize_eigenframe_file(FPath) :-
	exists_file(FPath),
  write(" Organize FilePath: "), 	writeln(FPath),
	read_json_file(FPath, Data), 
	save_json_file(FPath, Data).

% directory_eigenframe_web_frames(Dir), directory_files(Dir, Entries), organize_eigenframe_files(Dir, Entries).

organize_eigenframe_files(_, []).
organize_eigenframe_files(Dir, [File|T]) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		organize_eigenframe_file(FPath),
	  write(" Organize FilePath: "), 	writeln(FPath)
		;true
	),
	organize_eigenframe_files(Dir, T).

% ----------------------------------------------------

save_json_file(FPath, Data) :-
	open(FPath, write, Stream), 
	json_write(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream).


% ----------------------------------------------------

collect_component(Data, List) :-
	X = Data.get(component),
	member(X, List). 

collect_on_click(Data, List) :- 
	X = Data.get(on_click),
	member(X, List).

collect_on_complete(Data, List) :- 
	X = Data.get(on_complete),
	member(X, List).

collect_item_layout(Data, List) :- 
	X = Data.get(item_layout),
	member(X, List).

collect_positive_on_complete(Data, List) :- 
	Y = Data.get(positive),
	X = Y.get(on_complete),
	member(X, List).

collect_negative_on_complete(Data, List) :- 
	Y = Data.get(negative),
	X = Y.get(on_complete),
	member(X, List).

collect_neutral_on_complete(Data, List) :- 
	Y = Data.get(neutral),
	X = Y.get(on_complete),
	member(X, List).

collect_component_list(Data, List) :-
	X = Data.get(component_list),
	each_member(X, List).

collect_tab_list(Data, List) :- 
	X = Data.get(tab_list),
	each_member(X, List).

each_member([], _List).
each_member([H|T], List) :- 
	collect_data(H, List); 
	each_member(T, List).

each_show([]).
each_show([H|T]) :- 
	show_json(H),
	each_show(T).

each_write([]).
each_write([H|T]) :- 
  write('\n\n = '),	write(H),	write('\n\n'), 	
	each_write(T).

is_member(E, L) :- 
	nonvar(L), 
	memberchk(E, L).

collect_data(Data, List) :-
	is_member(Data, List).

collect_data(Data, List) :-
	'Define' \= Data.get(type),
	member(Data, List),
	(collect_component(Data, List);true), % define has component
	(collect_on_click(Data, List);true),
	(collect_on_complete(Data, List);true),
	(collect_item_layout(Data, List);true),
	(collect_positive_on_complete(Data, List);true),
	(collect_negative_on_complete(Data, List);true),
	(collect_neutral_on_complete(Data, List);true),
	(collect_component_list(Data, List);true),
	(collect_tab_list(Data, List);true).

% set FPath
collect_filepath_test(FPath) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, 'define-clones.json', FPath),
  write('\nTest Path: '), writeln(FPath).

test_collect(List) :-
	collect_filepath_test(FPath), 
	dyn_json_file_data(FPath, Data),
	collect_data(Data, List),
	each_write(List).

% ----------------------------------------------------

% Here are examples to search for a given EigenFrame type
%search_eigenframe_type_test('WebView'),false.
%search_eigenframe_type_test('PopupTextView'),false.
search_eigenframe_type_test(Type) :-
	dyn_json_file_data(FPath, Data), 
	search_eigenframe_type(FPath, Data, Type).

%select_file_test(FPath), search_eigenframe_type_test(FPath,'JavaScript'),false.
search_eigenframe_type_test(FPath, Type) :-
	dyn_json_file_data(FPath, Data), 
	search_eigenframe_type(FPath, Data, Type).

% ----------------------------------------------------

%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(component),
	search_eigenframe_type(FPath, X, Type).

%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(on_click),
	search_eigenframe_type(FPath, X, Type).

%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(on_complete),
	search_eigenframe_type(FPath, X, Type).

% 'ListView' == Type
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(item_layout), 
	search_eigenframe_type(FPath, X, Type).

% 'AlertDialog' == Type, positive
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Y = Data.get(positive),
	X = Y.get(on_complete),
	search_eigenframe_type(FPath, X, Type).

% 'AlertDialog' == Type, negative
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Y = Data.get(negative),
	X = Y.get(on_complete),
	search_eigenframe_type(FPath, X, Type).

% 'AlertDialog' == Type, neutral
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Y = Data.get(neutral),
	X = Y.get(on_complete),
	search_eigenframe_type(FPath, X, Type).

%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(component_list),
	search_eigenframe_list(FPath, X, Type).

% 'EigenFrame' == Type
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	X = Data.get(tab_list), 
	search_eigenframe_list(FPath, X, Type).

% all the frame types come here 
% if the type is the one we are looking for -- write data
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Type == Data.get(type),
  write(',\n{ "filepath": "'), 	write(FPath),	write('", "data": '), 	
	show_json(Data),
  writeln("}").

% ----------------------------------------------------

% +FPath is passed into recursion - constant 
% +H|T is the recursion list of components 
% +Type is the type of component we are searching for
search_eigenframe_list(_, [], _).
search_eigenframe_list(FPath, [H|T], Type) :-
	search_eigenframe_type(FPath, H, Type);true,
  search_eigenframe_list(FPath, T, Type).

% ----------------------------------------------------
select_frame_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
select_app_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").
select_app2_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_gallery.json").

show_frame_url_test :-
	select_frame_url(URL), 
	show_json_url(URL).

read_frame_url_test :-
	select_frame_url(URL), 
	read_eigenframe_url(URL).

show_app_url_test :-
	select_app_url(URL), 
	show_json_url(URL).

show_app2_url_test :-
	select_app2_url(URL), 
	show_json_url(URL).

read_app_url_test :-
	select_app_url(URL), 
	read_eigenframe_url(URL).

read_app2_url_test :-
	select_app2_url(URL), 
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
	parse_eigenframe_name(Data,_),
	parse_eigenframe_attributes(Data).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Clone'),
	parse_eigenframe_name(Data,_).

parse_eigenframe(Data) :- 
	select_eigenframe_type(Data, 'Define'),
	parse_eigenframe_name(Data,_),
	X = Data.get(component),
  write("  component:"), writeln(X).
% Note: a define component may not be complete, do not parse_eigenframe_component(Data). 

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
  write("= Select eigenframe type: "), 
	writeln(Type).

% -------------------------------------

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

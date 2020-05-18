% swipl projects/eigenframe-repository/cgi-bin/swipl-lib/eigenframe.pl

:- use_module(library(clpfd)).
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

:- initialization(start_eigenframe).

start_eigenframe :- 
	open_eigenframe_types,
	open_eigenframe_parse,
	load_frames,
	load_apps.

open_eigenframe_types :-
	directory_eigenframe_cgibin_swipllib(Dir),
	directory_file_path(Dir, 'eigenframe-types.pl', FPath),
	format(" ensure_loaded: ~w~n", [FPath]),
	ensure_loaded(FPath).

open_eigenframe_parse :-
	directory_eigenframe_cgibin_swipllib(Dir),
	directory_file_path(Dir, 'eigenframe-parse.pl', FPath),
	format(" ensure_loaded: ~w~n", [FPath]),
	ensure_loaded(FPath).

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
eigenframe_atom.

directory_eigenframe_cgibin_swipllib(CWD) :-
	source_file(eigenframe_atom, FPath),
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
		read_json_file(FPath, _)
		;true
	),
	read_filenames(Dir, T).

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
% Read json into prolog dict structure (sorts attributes), and write to current_output (screen)

show_json_file(FPath) :-
	read_json_file(FPath, Data), 
	show_json(Data).

show_json(Data) :-
	json_write(current_output, Data, [tag(json), value_string_as(atom)]).

each_show_json([]).
each_show_json([H|T]) :- 
	show_json(H),
	each_show_json(T).

each_write([]).
each_write([H|T]) :- 
	format('~n = ~w~n', [H]),
	each_write(T).

write_type(Data) :- 
	Type = Data.get(type), 
	format('write_type: ~w~n', [Type]).


% ----------------------------------------------------

each_write_type([]).
each_write_type([H|T]) :- 
	write_type(H),
	each_write_type(T).

% ----------------------------------------------------
% is_member(+Element, +List) -- element is member of list?

is_member(Element, List) :- 
	nonvar(List), 
	memberchk(Element, List).

% ----------------------------------------------------

save_json_file(FPath, Data) :-
	open(FPath, write, Stream), 
	json_write(Stream, Data, [tag(json), value_string_as(atom)]),
	close(Stream).

% ----------------------------------------------------

app_data(FName, Data) :-
	directory_eigenframe_web_apps(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data).

frame_data(FName, Data) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data).

% Read json into prolog dict structure (sorts attributes), and parse_eigenframe. 
read_eigenframe_file_test(Spec, FName) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]).

read_frame_url_test(Spec) :-
	select_frame_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]).

read_app_url_test(Spec) :-
	select_app_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]).

read_app2_url_test(Spec) :-
	select_app2_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]).


% ----------------------------------------------------

read_eigenframe_files(_, _, [], _List).
read_eigenframe_files(Spec, Dir, [File|T], List) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		read_json_file(FPath, Data), 
		parse_eigenframe(Spec, Data, List),
	  format(" Read EigenFrame FilePath: ~w~n", [FPath])
		;true
	),
	read_eigenframe_files(Spec, Dir, T, List).

% ----------------------------------------------------
:- dynamic dyn_define_component/2.

% check dynamic assertion first
define_component(Define_name, Component) :-
	dyn_define_component(Define_name, Component).

% create dynamic assertion
define_component(Define_name, Component) :-
	format(' assert define_component(~w, ~w)~n', [Define_name, Component]),
	asserta(dyn_define_component(Define_name, Component)).

each_clone_parse(_Spec, [], _List2).
each_clone_parse(Spec, [Data|T], List2) :- 
	write_type(Data),
	(
%		'Clone' == Data.get(type),
%		Attributes == Data.get(attributes),
		nominal_Clone(Data, Define_name, Attributes), 
		define_component(Define_name, Component),
		format(' Write Define-name: ~w~n', [Define_name]),
%		format(' Write Component: ~w~n', [Component]),
%		format(' Write Attributes: ~w~n', [Attributes]),
		Clone = Component.put(Attributes),
%		format(' Write Clone: ~w~n', [Clone]),
		member(Clone, List2),
		parse_eigenframe(Spec, Clone, List2)
		;true
	),
	each_clone_parse(Spec, T, List2).

each_member([], _List2).
each_member([Data|T], List2) :- 
	member(Data, List2),
	each_member(T, List2).

recurse_each_clone_parse(_Spec, [], _List2, _List_all).
recurse_each_clone_parse(Spec, List, List2, List_all) :-
	length(List, N),
  format(" Length: ~w~n", [N]),
	each_clone_parse(Spec, List, List2),
	each_member(List2, List_all),
	recurse_each_clone_parse(Spec, List2, _, List_all).

read_eigenframe_files_test(Spec) :- 
	directory_eigenframe_web_frames(Dir), 
	directory_files(Dir, E), 
	read_eigenframe_files(Spec, Dir, E, List),
	each_member(List, List_all),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" Length2: ~w~n", [N_all]).

/*
	each_clone_parse(Spec, List, List2),
	each_clone_parse(Spec, List2, List3),
	each_clone_parse(Spec, List3, List4),
	each_clone_parse(Spec, List4, List5),
	each_clone_parse(Spec, List5, List6),
	each_clone_parse(Spec, List6, List7),
	each_clone_parse(Spec, List7, List8),
	each_clone_parse(Spec, List8, List9),
	each_clone_parse(Spec, List9, List10),
	each_clone_parse(Spec, List10, List11),
  format(" List of nested cloned objects:~n", []),
	each_write_type(List11),
	length(List, N),
  format(" Length: ~w~n", [N]),
	length(List2, N2),
  format(" Length2: ~w~n", [N2]),
	length(List3, N3),
  format(" Length3: ~w~n", [N3]),
	length(List4, N4),
  format(" Length4: ~w~n", [N4]),
	length(List5, N5),
  format(" Length5: ~w~n", [N5]),
	length(List6, N6),
  format(" Length6: ~w~n", [N6]),
	length(List7, N7),
  format(" Length7: ~w~n", [N7]),
	length(List8, N8),
  format(" Length8: ~w~n", [N8]),
	length(List9, N9),
  format(" Length9: ~w~n", [N9]),
	length(List10, N10),
  format(" Length10: ~w~n", [N10]),
	length(List11, N11),
  format(" Length11: ~w~n", [N11]).
*/
/*
write_type: TextView
write_type: TextView
write_type: LinearLayout
write_type: Clone
 Write Define-name: TextViewDetail
 Write Clone: _136484{font:font/droid-sans-mono/DroidSansMono.ttf,gravity:left,layout_width:match_parent,ssh_script_list:[var targetVid = eigenFragment.getIntegerVariable('TargetViewId'),var dir = '/data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin' ,swipl_path = eigenFragment.getViewState(targetVid),swipl_goal = eigenFragment.getViewState(976000) ,'cd '+dir+'; ruby ssh_swipl.rb "'+swipl_path+'" "'+swipl_goal+'"  '],text_color: #ffffff,text_size:10,type:TextView}
write_type: TextView
 List of nested cloned objects:
 Length: 818
 Length2: 519
 Length3: 221
 Length4: 176
 Length5: 95
 Length6: 28
 Length7: 17
 Length8: 10
 Length9: 3
 Length10: 1
 Length11: 0
*/

% ----------------------------------------------------

select_frame_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/ssh-apache.json").
select_app_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json").
select_app2_url("https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_gallery.json").

read_json_url(URL, Data) :-
	setup_call_cleanup(
		http_open(URL, In, [request_header('Accept'='application/json')]),
		json_read_dict(In, Data, [tag(json), value_string_as(atom)]),
		close(In)
	).

show_json_url(URL) :-
	read_json_url(URL, Data), 
	show_json(Data).

show_frame_url_test :-
	select_frame_url(URL), 
	show_json_url(URL).

show_app_url_test :-
	select_app_url(URL), 
	show_json_url(URL).

show_app2_url_test :-
	select_app2_url(URL), 
	show_json_url(URL).


% ----------------------------------------------------
/*
% Read json into prolog dict structure (sorts attributes), then write back into same file. 
organize_eigenframe_file_test :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath).
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
*/
% ----------------------------------------------------

% Here are examples to search for a given EigenFrame type
%search_eigenframe_type_test('WebView'),false.
%search_eigenframe_type_test('PopupTextView'),false.
search_eigenframe_type_test(Type) :-
	dyn_json_file_data(FPath, Data), 
	search_eigenframe_type(FPath, Data, Type).

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
	X = Y.get(on_click),
	search_eigenframe_type(FPath, X, Type).

% 'AlertDialog' == Type, negative
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Y = Data.get(negative),
	X = Y.get(on_click),
	search_eigenframe_type(FPath, X, Type).

% 'AlertDialog' == Type, neutral
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Y = Data.get(neutral),
	X = Y.get(on_click),
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


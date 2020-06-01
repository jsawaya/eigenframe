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
	directory_eigenframe_cgibin_swipllib(Dir),
	eigenframe_ensure_loaded(Dir, 'eigenframe-types.pl'),
	eigenframe_ensure_loaded(Dir, 'eigenframe-parse.pl'),
	eigenframe_ensure_loaded(Dir, 'eigenframe-search.pl'),
	load_frames,
	load_apps.

eigenframe_ensure_loaded(Dir, FName) :-
	directory_file_path(Dir, FName, FPath),
	format(" ensure_loaded: ~w~n", [FPath]),
	ensure_loaded(FPath).

load_frames :-
	directory_eigenframe_web_frames(Dir),
	write("Read Directory: "), writeln(Dir),
	directory_files(Dir, E), 
%	sort(E,Entries), 
%	read_filenames(Dir, Entries),
	eigen_types(Spec), 
	read_eigenframe_files(Spec, Dir, E, List),
	each_member(List, List_all),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" List Length: ~w~n", [N_all]),
	!.

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
	;	true
	),
	read_filenames(Dir, T).

% ----------------------------------------------------
:- dynamic dyn_json_file_data/2.

% check dynamic assertion first
read_json_file(FPath, Data) :-
	dyn_json_file_data(FPath, Data).

% create dynamic assertion
read_json_file(FPath, Data) :-
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

% ----------------------------------------------------

each_write([]).
each_write([H|T]) :- 
	format(' ~w~n', [H]),
	each_write(T).

% ----------------------------------------------------

write_data_type(Data) :- 
	( 
		FPath = Data.get(fpath), 
		format('fpath: ~w~n', [FPath])
	; true
	),
	Type = Data.get(type), 
	format('write_data_type: ~w~n', [Type]).

each_write_data_type([]).
each_write_data_type([H|T]) :- 
	write_data_type(H),
	each_write_data_type(T).

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

read_eigenframe_files(_, _, [], _List).
read_eigenframe_files(Spec, Dir, [File|T], List) :-
	directory_file_path(Dir, File, FPath),
	(
		exists_file(FPath),
		read_json_file(FPath, Data0), 
		Data = Data0.put('fpath', FPath),
		parse_eigenframe(Spec, Data, List),
	  format(" Read FilePath: ~w~n", [FPath])
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
	write_data_type(Data),
	(
		eigen_clone(Data, Define_name, Attributes), 
		define_component(Define_name, Component),
		format(' clone_define_name: ~w~n', [Define_name]),
		format(' clone_attributes: ~w~n', [Attributes]),
%		format(' define_component: ~w~n', [Component]),
		Clone = Component.put(Attributes),
%		format(' clone_define_instantiation: ~w~n', [Clone]),
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

eigenframe_files_component_list(Spec, List_all) :- 
	directory_eigenframe_web_frames(Dir), 
	directory_files(Dir, E), 
	read_eigenframe_files(Spec, Dir, E, List),
	each_member(List, List_all),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" List Length: ~w~n", [N_all]),
	!.

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

app_url_parse(Spec) :-
	select_app_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
%	each_write_data_type(List),
%	length(List, N),
% format(" Length: ~w~n", [N]).
	each_member(List, List_all),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" Length2: ~w~n", [N_all]).



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

app_data(FName, Data) :-
	directory_eigenframe_web_apps(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data).

frame_data(FName, Data) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data).

% Read json into prolog dict structure (sorts attributes), and parse_eigenframe. 
eigenframe_file_component_list(Spec, FName) :-
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data), 
	parse_eigenframe(Spec, Data, List),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" List Length: ~w~n", [N_all]),
	!.

eigenframe_url_component_list(Spec) :-
	select_frame_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" List Length: ~w~n", [N_all]),
	!.
%	each_write_data_type(List),
%	length(List, N),
%  format(" Length: ~w~n", [N]),
%	!.

read_app_url_test(Spec) :-
	select_app_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_data_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]),
	!.

read_app2_url_test(Spec) :-
	select_app2_url(URL), 
	read_json_url(URL, Data), 
	parse_eigenframe(Spec, Data, List),
	each_write_data_type(List),
	length(List, N),
  format(" Length: ~w~n", [N]),
	!.


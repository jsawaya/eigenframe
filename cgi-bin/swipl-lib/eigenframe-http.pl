% swipl projects/eigenframe-repository/cgi-bin/swipl-lib/eigenframe-http.pl --http=8000

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
%:- use_module(library(http/thread_httpd)).	% for testing only
:- use_module(library(http/http_unix_daemon)). %% enable for default http service

%:- use_module(library(http/http_session)).  % not needed

%:- set_setting(http:logfile, 'my_log_file.log').

:- http_handler('/halt', handle_halt, []).

:- http_handler('/proxy', handle_proxy, []).

:- http_handler('/file', handle_frame, []).
:- http_handler('/type_search', handle_type_search, []).

:- http_handler('/parse_file_shallow', handle_parse_file_shallow, []).
:- http_handler('/parse_file', handle_parse_file, []).
:- http_handler('/parse_url', handle_parse_url, []).

:- http_handler('/prolog', handle_prolog, []).

:- http_handler('/dyn_app', handle_dyn_app, []).
:- http_handler('/dyn_layout', handle_dyn_layout, []).

:- http_handler('/parms', handle_parms, []).
:- http_handler('/time', handle_time_request, []).
:- http_handler('/hi', say_hi, []).

%:- http_handler('/files', handle_files, []).
%:- http_handler('/api', handle_api, []).

:- multifile http_json/1.

% :- initialization(start_svc). % for testing only

eigenframe_http_atom.

eigenframe_http_directory_cgibin_swipllib(CWD) :-
	source_file(eigenframe_http_atom, FPath),
	directory_file_path(Dir, _, FPath),
	working_directory(_,Dir),
	working_directory(CWD,CWD).

get_eigenframe_pl(FPath) :-
	eigenframe_http_directory_cgibin_swipllib(Dir),
	directory_file_path(Dir, 'eigenframe.pl', FPath).

open_eigenframe :-
	get_eigenframe_pl(FPath),
	format(" ensure_loaded: ~w~n", [FPath]),
	ensure_loaded(FPath).

:- initialization(open_eigenframe). 

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
		[title('EigenFrame')],
		[h1('SWI-Prolog HTTP Service Halted')]
	),
	halt.

% ----------------------------------------------------
% json api example - not used
%solve(_{a:X, b:Y}, _{answer:N}) :-
%	number(X),
%	number(Y),
%	N is X + Y.

%handle_api(Request) :-
%	http_read_json_dict(Request, Query),
%	solve(Query, Solution),
%	reply_json_dict(Solution).

% ----------------------------------------------------
% http://localhost:8000/files
%handle_files(_Request) :-
%	format('Content-type: text/plain~n~n', []),
%	directory_eigenframe_web_frames(Dir),
%	writeln("Directory: "), writeln(Dir),
%	directory_files(Dir, E), 
%	sort(E,Entries), 
%	read_filenames(Dir, Entries).

% ----------------------------------------------------
% http://localhost:8000/proxy?url=https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/define-clones.json
% http://localhost:8000/proxy?url=https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/apps/app_github_master.json

% show json frame given url
handle_proxy(Request) :-
	http_parameters(Request,
  	[	url(Url, [ optional(false) ]) 
		]),
	read_json_url(Url, Data), 
	reply_json_dict(Data),
	!.

% ----------------------------------------------------
% http://localhost:8000/frame?file=test-TextView.json
% show json frame given file
handle_frame(Request) :-
	http_parameters(Request,
  	[	file(FName, [ optional(true) ]) 
		]),
	directory_eigenframe_web_frames(Dir),
	directory_file_path(Dir, FName, FPath),
	read_json_file(FPath, Data), 
	reply_json_dict(Data),
	!.

% ----------------------------------------------------
% search for instances of a given type
% search is limited to static references, and non-clones
% http://localhost:8000/search?type=PopupHtmlView
% http://localhost:8000/search?type=EditText
handle_type_search(Request) :-
	http_parameters(Request,
  	[	type(Type, [ optional(true) ]) 
		]),
	format('Content-type: application/json; charset=UTF-8~n~n', []),
	write('{"type": "'), write(Type), write('", "found": [ {}'), 
	search_eigenframe_type_test(Type),false;write("]}"),
	true.

% ----------------------------------------------------
% parse a given static file in web/frames/*
% http://localhost:8000/parse_frame?file=define-clones.json
% http://localhost:8000/parse_frame?file=playlist.json
handle_parse_file_shallow(Request) :-
	http_parameters(Request,
  	[	file(File, [ optional(false) ]) 
		]),
	format('Content-type: text/plain~n~n', []),
	directory_eigenframe_web_frames(Dir),
	writeln("Directory: "), writeln(Dir),
	directory_file_path(Dir, File, FPath),
	exists_file(FPath),
  write(" FilePath: "), writeln(FPath),
	read_json_file(FPath, Data), 
	eigen_types(Spec), 
	parse_eigenframe(['Verbose'|Spec], Data, List),
	each_write_data_type(List),
	length(List, N),
	format(" Length: ~w~n", [N]),
	!.

% ----------------------------------------------------
% http://localhost:8000/parse_file?file=define-clones.json
% http://localhost:8000/parse_file?file=playlist.json

handle_parse_file(Request) :-
	http_parameters(Request,
  	[	file(File, [ optional(false) ]) 
		]),
	format('Content-type: text/plain~n~n', []),
	directory_eigenframe_web_frames(Dir),
	writeln("Directory: "), writeln(Dir),
	directory_file_path(Dir, File, FPath),
	exists_file(FPath),
  write(" FilePath: "), writeln(FPath),
	read_json_file(FPath, Data), 
	eigen_types(Spec), 
	parse_eigenframe(Spec, Data, List),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" Length: ~w~n", [N_all]),
	!.

% ----------------------------------------------------
% http://localhost:8000/parse_url?url=https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/define-clones.json
% http://localhost:8000/parse_url?url=https://raw.githubusercontent.com/jsawaya/eigenframe/1.3/web/frames/playlist.json

handle_parse_url(Request) :-
	http_parameters(Request,
  	[	url(Url, [ optional(false) ]) 
		]),
	format('Content-type: text/plain~n~n', []),
	read_json_url(Url, Data), 
	eigen_types(Spec), 
	parse_eigenframe(Spec, Data, List),
	recurse_each_clone_parse(Spec, List, _, List_all),
	length(List_all, N_all),
  format(" Length: ~w~n", [N_all]),
	!.

% ----------------------------------------------------
% http://localhost:8000/prolog
% http://localhost:8000/prolog?g=eigen_textview(D,'tst',14),show_json(D)
% http://localhost:8000/prolog?dbug=true&g=eigen_textview(D,'tst',14),show_json(D)
% http://localhost:8000/prolog?mime=text&dbug=true&g=eigen_textview(D,'tst',14),show_json(D)
% http://localhost:8000/prolog?mime=text&g=eigen_textview(D,%27tst%27,14),show_json(D)
% http://localhost:8000/prolog?mime=json&g=eigen_textview(D,%27tst%27,14),show_json(D)

handle_prolog(Request) :-
	http_parameters(Request,
  	[	g(GoalText, []), 
			dbug(Dbug, [boolean,optional(true),default(false)]),
			mime(Mime, [optional(true),default(text)])
		]),
	(
		Mime == text,
		format('Content-type: text/plain~n~n', [])
		;true
	),
	(
		Mime == json,
		format('Content-type: application/json; charset=UTF-8~n~n', [])
		;true
	),
	atom_to_term(GoalText, Term, Bindings),
	(
		Dbug == true,
		Mime == 'text',
		format('Term: ~w~n', [Term]),
		format('Bindings: ~w~n', [Bindings])
		;true
	),
	callable(Term),
	ignore(Term).
%	call(Term).

% ----------------------------------------------------
% http://localhost:8000/dyn_app
% create simple dynamic app
handle_dyn_app(_Request) :-
	format('Content-type: application/json; charset=UTF-8~n~n', []),
	eigenfragment(Data3, 'Dynamic', 'ic_launcher_round.', 'http://localhost:8000/dyn_layout'),
	eigenframe_app(Data,false,[Data3]),
	show_json(Data).

% ----------------------------------------------------
% http://localhost:8000/layout
% create simple layout
handle_dyn_layout(_Request) :-
	format('Content-type: application/json; charset=UTF-8~n~n', []),
	eigen_textview(Data1, 'this is a test', 14),
	eigen_layout(Data, [Data1], 'vertical', true),
	show_json(Data).

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

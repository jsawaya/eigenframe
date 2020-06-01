
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
% if the type is one we are looking for -- write data
%search_eigenframe_type(FPath, +Data, +Type)
search_eigenframe_type(FPath, Data, Type) :- 
	Type == Data.get(type),
  write(',\n{ "filepath": "'), 	write(FPath),	write('", "data": '), 	
	show_json(Data),
  writeln("}").

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

% +FPath is passed into recursion - constant 
% +H|T is the recursion list of components 
% +Type is the type of component we are searching for
search_eigenframe_list(_, [], _).
search_eigenframe_list(FPath, [H|T], Type) :-
	search_eigenframe_type(FPath, H, Type);true,
  search_eigenframe_list(FPath, T, Type).

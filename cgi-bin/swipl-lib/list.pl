% working with lists
% append is builtin     
% --------------------------------

% a suffix of x is y if something appended to y is x   
suffix(Xs, Ys) :-
    append(_, Ys, Xs).

% a prefix of x is y if y appended to somthing is x  
prefix(Xs, Ys) :-
    append(Ys, _, Xs).

% a sublist of x is y if there is a z where:  
sublist(Xs, Ys) :-
    suffix(Xs, Zs),
    prefix(Zs, Ys),
    Xs \= [],
    Ys \= [].

% reverse list contents
nrev([], []).
nrev([H|T0], L) :-
	nrev(T0, T),
	append(T, [H], L).


% sublist([a, b, c, d, e], [c, d]) is true
% sublist([a, b, c, d, e], Ys).
% nrev([a, b, c, d, e], Ys).
% nrev([a,b,c,d,e], Y), write(Y)
% numlist(1, 1000, L), time(nrev(L, _)), nl
% sublist([a, b, c, d, e], Y),writeln(Y),false
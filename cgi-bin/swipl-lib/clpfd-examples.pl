:- use_module(library(clpfd)).

test_clpfd1(X,Y) :-
	4*X + 2*Y #= 24, 
	X + Y #= 9, 
	[X,Y] ins 0..sup.


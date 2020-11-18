
next(A, B, L) :- append(_, [A,B|_], L).
next(A, B, L) :- append(_, [B,A|_], L).

solve(Matrix) :-
	Matrix = [_,_,v(_,_,_,a22,_),_,_],
	Matrix = [v(a04,_,_,_,_),_,_,_,_],
	next(v(_,_,_,_,a15), v(_,_,_,_,a17), Matrix),
	next(v(_,a23,_,_,_), v(_,_,a24,_,_), Matrix),
	next(v(_,_,a20,_,_), v(_,a25,_,_,_), Matrix),
	next(v(a04,_,_,_,_), v(_,_,_,_,a08), Matrix),
	member(v(a01,_,_,_,a12), Matrix),  
	member(v(a02,a13,_,_,_), Matrix),  
	member(v(_,_,_,a14,a15), Matrix),  
	member(v(a03,_,_,a16,_), Matrix),  
	member(v(_,a18,a19,_,_), Matrix),  
	member(v(_,_,a20,_,a21), Matrix), 
	member(v(_,_,a11,a10,_), Matrix), 
	member(v(a05,_,a9,_,_),  Matrix), 
	member(v(_,_,_,a07,_),   Matrix),	
	member(v(_,a06,_,_,_),   Matrix).	

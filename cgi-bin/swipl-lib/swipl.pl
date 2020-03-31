entity(cynthia).
entity(monica). 
entity(melissa). 
entity(dillon).
entity(brock).

parent(cynthia, monica).
parent(cynthia, melissa).
parent(monica, dillon).
parent(monica, brock).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y,
    write('{\"'),write(X),write(' is sibling of '),write(Y),write(' with parent '),write(Z),write('\"}'),nl.

ancestor(A, B) :-
 		parent(A, B),
    write('{\"'),write(A),write(' is parent of '),write(B),write('\"}'),nl.

ancestor(A, B) :-
		parent(A, X), ancestor(X, B),
    write('{\"'),write(A),write(' is an ancestor of '),write(B),write('\"}'),nl.

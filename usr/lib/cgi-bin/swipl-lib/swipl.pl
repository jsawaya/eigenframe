entity(cynthia).
entity(monica). 
entity(melissa). 

parent(cynthia, monica).
parent(cynthia, melissa).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

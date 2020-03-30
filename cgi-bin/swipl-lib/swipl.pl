entity(cynthia).
entity(monica). 
entity(melissa). 

parent(cynthia, monica).
parent(cynthia, melissa).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y,
    write(X),write(' is sibling of '),write(Y),write(' with parent '),write(Z),nl.

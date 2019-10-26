mother_of(jane, paul).
mother_of(jane, mary).

male(paul).
male(joe).

female(mary).
female(jane).

father_of(joe, paul).
father_of(joe, mary).

woman(cynthia).
woman(monica). 
man(john). 
person(X):- man(X); woman(X).
loves(X,Y):- father(X,Y).
father(Y,Z):- man(Y), son(Z,Y). 
father(Y,Z):- man(Y), daughter(Z,Y).
    print_all(List) :- woman(List), write(List), nl, false.
    print_all(_).
    

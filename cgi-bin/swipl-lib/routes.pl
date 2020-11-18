adjacent(edgware_road,paddington,district,1).
adjacent(paddington,bayswater,district,1).
adjacent(bayswater,nottinghill_gate,district,1).
adjacent(paddington,warwick_avenue,bakerloo,1).
adjacent(warwick_avenue,maida_vale,bakerloo,1).


    next(X,Y,L):-adjacent(X,Y,L,_).

    next(X,Y,L):-adjacent(Y,X,L,_).

    direct_connect(X,Y,L,S,F):-
                next(X,Z,L),
                not(member(Z,S)),
                direct_connect(Z,Y,L,[Z|S],F).

    direct_connect(X,Y,L,S,[Y|S]):- next(X,Y,L).

    one_change(X,Y,L,F):- 
                direct_connect(X,Z,L,[X],F1),
                direct_connect(Z,Y,L2,[Z|F1],F),
                write('At:'),write(Z),write(', Change:'),write(L),write('->'),write(L2),nl,
                L\=L2.

    exist(X):-next(X,_,_).

    member(X,[X|_]).

    member(X,[_|T]):-member(X,T).

    route(X,Y,F):-exist(X),exist(Y), 
              direct_connect(X,Y,L,[X],F),
              write('Direct Connection:'),write(L),nl,
              revwrite(F).

    route(X,Y,F):-exist(X),exist(Y), 
              one_change(X,Y,_,F), 
%              write('One Change Required:'),write(L),nl,
%              write('X:'),write(X),nl,
%              write('Y:'),write(Y),nl,
%              write('F:'),write(F),nl,
              revwrite(F).

    revwrite([X]):-write(X),nl.

    revwrite([H|T]):-revwrite(T),write('->'),write(H),nl.

    %route(nottinghill_gate,maida_vale,F).

    %swipl -s routes.pl -g "route(nottinghill_gate,maida_vale,F)" -t halt

    

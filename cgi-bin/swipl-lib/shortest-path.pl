/* prolog tutorial 2.15 Graph structures and paths */

connected(X,Y,L) :- edge(X,Y,L) ; edge(Y,X,L).

travel(A,B,P,[B|P],L) :- 
       connected(A,B,L).
travel(A,B,Visited,Path,L) :-
       connected(A,C,D),           
       C \== B,
       \+member(C,Visited),
       travel(C,B,[C|Visited],Path,L1),
       L is D+L1.  

min([],M,M).
min([[P,L]|R],[_,M],Min) :- L < M, !, min(R,[P,L],Min). 
min([_|R],M,Min) :- min(R,M,Min).

minimal([F|R],M) :- min(R,F,M).

path(A,B,Path,Len) :-
       travel(A,B,[A],Q,Len), 
       reverse(Q,Path).

shortest(A,B,Path,Length) :-
   setof([P,L],path(A,B,P,L),Set),
   Set = [_|_], % fail if empty
   minimal(Set,[Path,Length]).

edge(1,2,1).
edge(1,4,3.5).
edge(1,3,2.5).
edge(2,3,1).
edge(2,5,2.5).
edge(3,4,1).
edge(3,5,2.2).
edge(4,5,1).

edge(a1,a2,2).
edge(a1,a3,5).
edge(a1,a4,1).
edge(a2,a5,10).
edge(a2,a6,12).
edge(a3,a5,5).
edge(a3,a6,10).
edge(a3,a7,7).
edge(a4,a6,15).
edge(a4,a7,13).
edge(a5,a8,7).
edge(a5,a9,5).
edge(a6,a8,3).
edge(a6,a9,4).
edge(a7,a8,7).
edge(a7,a9,1).
edge(a8,a10,1).
edge(a9,a10,4).



/* try goals like

  ?- shortest(1,5,Path,Length).

*/
:- use_module(library(simplex)).

solv1_constraints -->
	constraint([0.3*x1, 0.1*x2] =< 2.7),
	constraint([0.5*x1, 0.5*x2] = 6),
	constraint([0.6*x1, 0.4*x2] >= 6),
	constraint([x1] >= 0),
	constraint([x2] >= 0),
  minimize([0.4*x1, 0.5*x2]).

solv1(X1, X2) :- 
  gen_state(S0),
  solv1_constraints(S0, S),
	variable_value(S, x1, X1),
	variable_value(S, x2, X2).

%----------------------------------------------------

solv2_constraints -->
  constraint([6*x(1), 4*x(2)] =< 8),
  constraint([x(1)] =< 1),
  constraint([x(2)] =< 2),
  maximize([7*x(1), 4*x(2)]).

solv2(X1, X2) :- 
  gen_state(S0),
  solv2_constraints(S0, S),
	variable_value(S, x(1), X1),
	variable_value(S, x(2), X2).				

%----------------------------------------------------

solv3_constraints -->
	constraint([c(1), 5*c(5), 20*c(20)] = 111),
	constraint([c(1)] =< 3),
	constraint([c(5)] =< 20),
	constraint([c(20)] =< 10),
	constraint([c(1)] >= 0),
	constraint([c(5)] >= 0),
	constraint([c(20)] >= 0),
	constraint(integral(c(1))),
	constraint(integral(c(5))),
	constraint(integral(c(20))),
	minimize([c(1), c(5), c(20)]).

solv3(C1, C5, C20) :- 
  gen_state(S0),
  solv3_constraints(S0, S),
	variable_value(S, c(1), C1),             
	variable_value(S, c(5), C5),             
	variable_value(S, c(20), C20).

%----------------------------------------------------

solv4_constraints -->
	constraint([x(1), 2*x(2), x(3)] =< 430),
	constraint([3*x(1), 2*x(3)] =< 460),
	constraint([x(1), 4*x(2)] =< 420),
	constraint([x(1)] >= 0),
	constraint([x(2)] >= 0),
	constraint([x(3)] >= 0),
	maximize([x(1), x(2), x(3)]).

solv4(X1, X2, X3) :- 
  gen_state(S0),
  solv4_constraints(S0, S),
	variable_value(S, x(1), X1),             
	variable_value(S, x(2), X2),             
	variable_value(S, x(3), X3).

%----------------------------------------------------

solv5_constraints -->
	constraint([2*x(1), 7*x(2)] =< 21),
	constraint([7*x(1), 2*x(2)] =< 21),
	constraint([x(1)] >= 0),
	constraint([x(2)] >= 0),
	maximize([4*x(1), 14*x(2)]).

solv5(X1, X2) :- 
  gen_state(S0),
  solv5_constraints(S0, S),
	variable_value(S, x(1), X1),             
	variable_value(S, x(2), X2).

%----------------------------------------------------

solv6_constraints -->
	constraint([x(1), 9*x(2)] =< 60),
	constraint([2*x(1), 3*x(2)] =< 45),
	constraint([5*x(1), -2*x(2)] =< 20),
	constraint([x(2)] =< 30),
	constraint([x(1)] >= 0),
	constraint([x(2)] >= 0),
	maximize([5*x(1), 6*x(2)]).

solv6(X1, X2) :- 
  gen_state(S0),
  solv5_constraints(S0, S),
	variable_value(S, x(1), X1),             
	variable_value(S, x(2), X2).

%----------------------------------------------------

solv7_constraints -->
	constraint([2*x(1), x(2)] =< 430),
	constraint([2*x(2)] =< 460),
	constraint([x(1)] >= 0),
	constraint([x(2)] >= 0),
	maximize([2*x(1), 5*x(2)]).

solv7(X1, X2) :- 
  gen_state(S0),
  solv7_constraints(S0, S),
	variable_value(S, x(1), X1),             
	variable_value(S, x(2), X2).

%----------------------------------------------------

solv8_constraints -->
	constraint([c(1), 2*c(2), 2*c(3), 3*c(4), c(5)] =< 3),
	constraint([2*c(1), c(2), 2*c(3), c(4), 3*c(5)] =< 5),
	constraint(integral(c(1))),
	constraint(integral(c(2))),
	constraint(integral(c(3))),
	constraint(integral(c(4))),
	constraint(integral(c(5))),
	maximize([3*c(1), 4*c(2), 6*c(3), 8*c(4), 6*c(5)]).

solv8(C1, C2, C3, C4, C5) :- 
  gen_state(S0),
  solv8_constraints(S0, S),
	variable_value(S, c(1), C1),             
	variable_value(S, c(2), C2),             
	variable_value(S, c(3), C3),             
	variable_value(S, c(4), C4),             
	variable_value(S, c(5), C5).



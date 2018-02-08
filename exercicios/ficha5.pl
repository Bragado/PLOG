%ex1	Se B e C se verificarem, D e E tambem tem de se verificar. é um cut vermelho

%ex2 

p(1).
p(2) :- !.	%afeta apenas quem o chamou
p(3).

%a p(X) 	=> X = 1 ; X = 2
%b p(X), P(Y) 	=> X = 1, Y = 1 ; X = 1, Y = 2 ; X = 2, Y = 1; X = 2, Y = 2
%c P(X), !, P(Y)=> X = 1, Y = 1 ; X = 1, Y = 2 

%ex3

%a um dois tres ultima_clausula
%b um
%c um-um, um-dois, um-tres

%ex6

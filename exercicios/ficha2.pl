%ex1
r(a,b). 
r(a,c).
r(b,a). 
r(a,d).
s(b,c). 
s(b,d). 
s(c,c). 
s(d,e).

not(Goal) :- call(Goal), !, fail.
not(_).


%a
% X = a, Y = d ; Z = e
%b
%4


%ex2

a(a1,1).
a(A,2).
a(a3,N).
b(1,b1).
b(2,B).
b(N,b3).
c(X,Y) :- a(X,N), b(N,Y).
d(X,Y) :- a(X,N), b(Y,N).
d(X,Y) :- a(N,X), b(N,Y).

% yes
% X = 2
% X = _123 N = 2
% X = a1 Y = b1
% X = a1 Y = 2



%ex4

facturial(0, 1).
facturial(N, Valor) :- Num is N  - 1, facturial(Num, ValorAux), Valor is N * ValorAux.

facturialIter(N, Valor) :- facturialIter(N, 1, Valor).
facturialIter(0, Valor, Valor).
facturialIter(N, Acc, Valor) :- N1 is N - 1, Acc1 is Acc * N, facturialIter(N1, Acc1, Valor).


%fibonacci(N, Valor).
fibonacci(0 , 1).
fibonacci(1, 1).
fibonacci(X, Valor) :- N > 1, X1 is X - 1, X2 is X - 2, fibonacci(X1, Valor1), fibonacci(X2, Valor2), Valor is Valor1 + Valor2.

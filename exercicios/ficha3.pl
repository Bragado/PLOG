%ex1

% yes
% no
% H = apple T = [broccoli, refrigerator]
% H = a ; T = [b, c, d, e]
% H = apples ; T = [bananas]
% H = a ; T = [[b, c, d]]
% H = apples ; T = []
% no
% One = apple ; Two = sprouts ; T = [fridge, milk]
% no
% H = apple
% yes

%ex3
append([], Lista, Lista).
append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).




%ex4
inverter(Lista, InvLista) :- rev(Lista, [], InvLista).
rev([], InvLista, InvLista). 
rev([H|T], Acc, InvLista) :- rev(T, [H|Acc], InvLista).

%ex5 a)
member([], X) :- !, fail.
member([H|_], H).
member([_|T], X) :- member(T, X).

%ex5 b)
membro(X, L) :- append(_, [X|_], L).

%ex5 c)
last(X, L) :- append(_, [X], L).

%ex5 d) nesimo(Lista, N, Elem).
nesimo([], _, -1).
nesimo([H|_], 1, H).
nesimo([H|T], N, Elem) :- N > 1, N1 is N - 1, nesimo(T, N1, Elem).

%ex6 a)
delete_one(X, [X|T], T).
delete_one(X, [H|T], [H|T1]) :- delete_one(X, T, T1).

delete_one2(X, L1, L2) :- append(Lista, [X|T], L1), append(Lista, T, L2).


%ex6 b)
delete_all(X, [], []).
delete_all(X, [X|T], L2) :- delete_all(X, T, L2).
delete_all(X, [H|T], [H|T1]) :- delete_all(X, T, T1).

%ex6 c)

delete_all_list(LX, [], LX).
delete_all_list(LX, [H|T], L2) :- delete_all(H, LX, LX1), delete_all_list(LX1, T, L2).



%ex7
before(A, B, L) :- append(_, [A|T], L), append(_, [B|_], T).


%ex8 a)
conta(Lista, N) :- conta(Lista, 0, N).
conta([], Acc, Acc).
conta([_|T], Acc, N) :- Acc1 is Acc + 1, conta(T, Acc1, N).

%ex8 b)
conta_elem(X, Lista, N) :- conta_elem(X, Lista, 0, N).
conta_elem(_, [], Acc, Acc).
conta_elem(X, [X|T], Acc, N) :- Acc1 is Acc + 1, conta_elem(X, T, Acc1, N).
conta_elem(X, [_|T], Acc, N) :- conta_elem(X, T, Acc, N).





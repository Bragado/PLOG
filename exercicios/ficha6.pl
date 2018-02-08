%ex1

map([], _, []).
map([H|T], Pred, [H1|T1]) :- Goal =.. [Pred, H, H1], Goal, map(T, Pred, T1).

%ex2

idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18).

mais_proximos(Idade, [NL |ListaProximos]) :-	
	setof(Dif-Nome, prox(Idade, Dif, Nome), [D-NL | ListaProximos2]),
	calc(ListaProximos2, D, ListaProximos).

calc([], _, []).
calc([D-N|T], D1, [N|T2]) :- D =< D1, !, calc(T, D, T2).
calc([_|T], D, L) :- calc(T, D, L).

prox(Idade, Dif, Nome) :- idade(Nome, Idade1), diff(Idade, Idade1, Dif).



diff(Idade, Idade1, Dif) :- Idade > Idade1, !, Dif is Idade - Idade1.
diff(Idade, Idade1, Dif) :- Dif is Idade1 - Idade.




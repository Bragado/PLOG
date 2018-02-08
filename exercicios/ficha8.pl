% Fila de Carros

/*
	Azul - 1
	Verde - 2
	Amarelo - 3
	Preto - 4
*/


cars :- length(Cores, 4),
	length(Tam, 4),
	domain(Cars, 1, 4),
	domain(Tam, 1, 4),
	all_distinct(Cores), all_distinct(Tam),
	element(Index1, Cores, 1),	%carro Verde e Azul
	element(Index2, Cores, 2),	% Index1 = Azul, Index2 = Verde, Index3 = Amarelo, Index4 = Preto	
	Index2 #> Index1,
	element(Index3, Cores, 3),
	element(Index4, Cores, 4),
	Index3 #> Index4,
	
	Index1 #> 1,
	Index1 #< 4,
	
	Azul1 #= Index1 + 1,
	Azul2 #= Index1 - 1,
	element(Azul1, Tam, Tam1),
	element(Azul2, Tam, Tam2),
	Tam2 #< Tam1,
	element(Index3, Tam, 1),
	append(Cores, Tam, Vars),
	labeling([], Vars). 				% fazer uma vez só de uma só lista, neste caso, juntar as listas	
		




counter(_, [], 0).
counter(Val, [H|T], Count) :-
	counter(Val, T, Count2),
	Val #= H #<=> Var,
	Count #= Var + Count2.


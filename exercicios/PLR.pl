:-use_module(library(clpfd)).
:- use_module(library(lists)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex1	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


magic_cube3x3(Vars) :-
	Vars = [X1, X2, X3, X4, X5, X6, X7, X8, X9],
	domain(Vars, 1, 9),
	all_distinct(Vars),
	X1 + X2 + X3 #= Soma,
	X4 + X5 + X6 #= Soma,
	X7 + X8 + X9 #= Soma,
	X1 + X4 + X7 #= Soma,
	X2 + X5 + X8 #= Soma,
	X3 + X6 + X9 #= Soma,
	X1 + X5 + X9 #= Soma,
	X3 + X5 + X7 #= Soma,
	labeling([], Vars).

magic_cubeNxN(N, Vars) :-
	N2 is N * N,
	construct_domain(N, N, N2, Vars2),
	applyRestrictionsH(Vars2, Soma), 
	applyRestrictionsV(Vars2, N, Soma),
	applyRestrictionsD(Vars2, N, Soma),
	append(Vars2, Vars),
	all_distinct(Vars),
	labeling([], Vars).

construct_domain(0, N, _, []).
construct_domain(Acc, N, N2, [H|T]) :-
	length(H, N),
	domain(H, 1, N2),
	Acc1 is Acc -1,
	construct_domain(Acc1, N, N2, T).

applyRestrictionsH([], _).
applyRestrictionsH([H|T], Soma) :- 
	sum(H, #=, Soma), 
	applyRestrictionsH(T, Soma).


applyRestrictionsV(_, 0, _).
applyRestrictionsV(Vars, N, Soma) :-
	construct_lists(Vars, N, List),
	sum(List, #=, Soma),
	N1 is N - 1,
	applyRestrictionsV(Vars, N1, Soma).

applyRestrictionsD(Vars, N, Soma) :-
	construct_lists2(Vars, N, List),
	sum(List, #=, Soma),
	construct_lists3(Vars, 1, List2),
	sum(List2, #=, Soma).
	
 
construct_lists([], _, []).
construct_lists([H|T], N, [H1|T1]) :- nth1(N,H, H1), construct_lists(T, N, T1).


construct_lists2([], _, []).
construct_lists2([H|T], N, [H1|T1]) :- nth1(N, H, H1), N1 is N - 1, construct_lists2(T, N1, T1). 

%começa em 1
construct_lists3([], _, []).
construct_lists3([H|T], N, [H1|T1]) :- nth1(N, H, H1), N1 is N + 1, construct_lists3(T, N1, T1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex2	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


zebra(Zebra, Agua) :-
	Nac = [Ing, Esp, Nor, Uc, Pt],
	Beb = [SumoLaranja, Cha, Cafe, Leite, Agua],
	Cig = [Marlboro, Chesterfields, Winston, LukyStrike, SGLights],
	Animal = [Cao, Cavalo, Raposa, Iguana, Zebra],
	Cor = [Vermelho, Verde, Branco, Amarelo, Azul],
	Vars = [Ing, Esp, Nor, Uc, Pt, Vermelho, Verde, Branco, Amarelo, Azul, SumoLaranja, Cha, Cafe, Leite, Agua, Marlboro, Chesterfields, Winston, Zebra, LukyStrike, SGLights, Cao, Cavalo, Raposa, Iguana],	
	domain(Vars, 1, 5),
	all_different(Nac),
	all_different(Beb),
	all_different(Cig),
	all_different(Animal),
	all_different(Cor),	
	Ing #= Vermelho,
	Esp #= Cao,	
	Nor #= 1,
	Amarelo #= Marlboro,
	abs(Chesterfields-Raposa) #= 1, 
	abs(Nor - Azul) #= 1,
	Winston #= Iguana,
	LukyStrike #= SumoLaranja,
	Uc #= Cha,
	Pt #= SGLights,
	abs(Marlboro - Cavalo) #= 1,
	Verde #= Cafe,
	Verde  #= Branco + 1,
	Leite #= 3,
	labeling([], Vars). 	
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex6	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sol(A, B, C) :-
	A + B + C #= A * B * C,
	labeling([], [A, B, C]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex7	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
peru_cost(Each, Total) :-
	domain([M, C, D, U], 0, 9),
	C #= 6,
	D #= 7,
	M * 1000 + C * 100 + D * 10 + U #= Total,
	72 * Each #= Total,
	labeling([], [M, C, D, U]).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex8	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

price_of_products(List) :-
	List = [Arroz, Batatas, Esparguete, Atum],
	domain(List, 0, 711),
	Arroz/100 + Batatas/100 + Esparguete/100 + Atum/100 #= Total,
	Total #= (Arroz/100) * (Batatas/100) * (Esparguete/100 )* (Atum/100),
	Total*100 #= 711,
	Batatas #> Atum,
	Atum #> Arroz,
	Arroz #> Esparguete,	
	labeling([], [Arroz, Batatas, Esparguete, Atum]).
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex5	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

/*
	1- Azul
	2- Verde
	3- Preto
	4 - Amarelo	

*/

cor('Azul', 1).
cor('Verde', 2).
cor('Preto', 3).
cor('Amarelo', 4).



carros(Tam, Pos) :-
	length(Pos, 4),
	length(Tam, 4),
	domain(Pos, 1, 4),
	domain(Tam, 1, 4),
	 
	all_distinct(Pos),
	all_distinct(Tam),
	
	%o carro amarelo está depois do preto.
	element(IndexAmarelo, Pos, 4),
	element(IndexPreto, Pos, 3),
	IndexAmarelo #> IndexPreto,
	
	% o carro verde está depois do carro azul
	element(IndexVerde, Pos, 2),
	element(IndexAzul, Pos, 1),
	IndexVerde #> IndexAzul,
	
	IndexAzul #> 1,
	IndexAzul #< 4,
	
	%  o carro que está imediatamente antes do carro azul é menor do que 
	%  o que está imediatamente depois do carro azul
	IndexAntesAzul #= IndexAzul - 1,
	IndexDepoisAzul #= IndexAzul + 1,
	 
	element(IndexAntesAzul, Tam, Tam1),
	element(IndexDepoisAzul, Tam, Tam2),
	Tam1 #< Tam2,  
	% o carro verde é o menor de todos,
	element(IndexVerde, Tam, 1),
	
	append(Tam, Pos, Vars),
	labeling([], Vars).
	%element(1, Pos, P),
	%cor(P, Primeiro).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex2	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
	Joao #= 1,		1 - Terça
        Francisco #= 2,		2 - Quinta
	Antonio #= 3,		3 - Quinta
*/

musicos(Instrumentos) :-
	Instrumentos = [Harpa, Violino, Piano],
	length(Dias, 3),
	domain(Instrumentos, 1, 3),
	domain(Dias, 1, 3),
	all_distinct(Instrumentos),	
		
	% O antónio não é pianista
	Piano #\= 3,
		
	% o pianista ensaia sozinho à terça
	element(3, Dias, 1),
	
	% o joao ensaia à quinta
	element(2, Dias, 2),
	
	%o Joao ensaia à quinta
	element(Index, Instrumentos, 1),
	element(Index, Dias, 3),
	
	
	append(Instrumentos, Dias, Vars),
	labeling([], Vars).
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex3	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
/*
Quem comprou os livros:
	1 - Adams
	2 - Baker
	3 - Catt
	4 - Dodge
	5 - Ennis	
	6 - Fisk



*/

centro_comercial(Artigos, SaiuNoAndar) :-
	
	length(SaiuNoAndar, 6),
	Artigos = [Livro, Vestido, Bolsa, Gravata, Chapeu, Candeeiro],
	

	domain(Artigos, 1, 6),
	domain(SaiuNoAndar, 1, 6),
	all_distinct(Artigos),	

	% a senhora Adams "saiu" no andar 0
	element(SrAdams, Artigos, 1),	
	element(SrAdams, SaiuNoAndar, 1),
	
	% A senhora Catt e quem comprou a gravata saiu no andar 2
	element(SrCatt, Artigos, 3),
	element(SrCatt, SaiuNoAndar, 2),
	element(4, SaiuNoAndar, 2),
	Gravata #\= 3,	
	
	% No terceiro andar era a seccao dos vestidos
	element(2, SaiuNoAndar, 3),
	

	% Os dois homens sairam no quarto andar

	% A mulher que comprou o candeeiro saiu no quinto andar 
	element(6, SaiuNoAndar, 5),
					      	
	%  Fisk saltar sozinha no sexto andar.				
	element(SrFisk, Artigos, 6),
	element(SrFisk, SaiuNoAndar, 6),
	
	%  Bolsa está no segundo andar
	element(3, SaiuNoAndar, 2),
	
	% Baker recebeu uma bolsa das mulheres
	Bolsa #\= 2,	
	
	%  encontrou seu marido agradecendo a gravata que uma das outras mulheres lhe tinha dado.
	Gravata #\= 2,
	
	%os livros eram vendidos no andar térreo 
	element(1, SaiuNoAndar, 1),
	
	%  Sra. Ennis foi a sexta pessoa a sair do elevador
	element(SrEnnis, Artigos, 5),
	element(SrEnnis, SaiuNoAndar, 5), 


	append(Artigos, SaiuNoAndar, Vars),	
	labeling([], Vars).

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex7	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	
/*
	1 - Joao		 	
	2 - Miguel
	3 - Nadia
	4 - Silvia
	5 - Afonso
	6 - Cristina
	7 - Geraldo
	8 - Julio
	9 - Maria
	10 - Maximo
	11 - Manuel
	12 - Ivone

	Mesa :
	1 - Geraldo, Julio, Vodka, Cerveja
	2 - Maria, Maximo, Vermouth, Cha
	3 - Ivone, Manuel, Cafe, Laranjada

	Equipas Futebol:
	1 - Joao, Miguel
	2 - Cha, Cafe,
	3 - Julio, Geraldo
	4 - Guarana, Whisky
	5 - Nadia, Maria
	6 - Laranjada, Limonada

	Tenis:
	1 - Geraldo, Agua
	2 - Maximo, Whisky
	3 - Joao, Silvia
	4 - Cha, Vodka

	Atividades :
	1 - Julio, Champanhe, Agua
	2 - Miguel, Guarana, Vodka		??
	3 - Cafe, Silvia, Afonso		
	4 - Guarana, Maximo, Manuel		??

	
acampamentos(Bebida) :-
	Bebida = [Limonada, Guarana, Whisky, Vinho, Champanhe, Agua, Laranjada, Cafe, Cha, Vermouth, Cerveja, Vodka],
	length(Mesa, 12),
	domain(Bebida, 1, 12),
	domain(Mesa, 1, 12),
	
	all_distinct(Bebida),
	
	% Numa das mesas estão juntos Geraldo, Júlio e os que gostam de vodka e cerveja;
	element(Geraldo, Bebida, 7),
	element(Geraldo, Mesa, 1),
	element(Julio, Bebida, 8),
	element(Julio, Mesa. 1),	
	element(Vodka, Mesa, 1),
	element(Cerveja, Mesa, 1),
		
	%  na outra mesa os que bebem vermouth e chá enfrentam a Maria e Máximo
	element(Vermouth, Mesa, 2),
	element(Cha, Mesa, 2),
	element(Maria, Bebida, 9),
	element(Maria, Mesa, 2),
	element(Maximo, Bebida, 10),
	element(Maximo, Mesa, 2),
	
	%  Ivone e Manuel enfrentam os que bebem café e laranjada;
	element(Ivone, Bebida, 12),
	element(Ivone, Mesa, 3),
	element(Manuel, Bebida, 11),
	element(Manuel, Mesa, 3),
	element(Cafe, Mesa, 3),
	element(Laranjada, Mesa, 3).
*/		
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex8	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*
	1 - Peixe
	2 - Porco
	3 - Pato
	4 - Bife
	5 - Omeleta
	6 - Esparguete
	
	
	

*/
restaurante(People) :-
	People = [Bernard, Daniel, Francisco, Henrique, Jaqueline, Luis],
	domain(People, 1, 6),
	all_distinct(People),
	Bernard in 2..4,
	Francisco in 2..4,
	Henrique in 2..4,
	Daniel #\= 1,
	Jaqueline #\= 1,
	Francisco #\= 2,
	Francisco #\= 3,
	Bernard #\= 5,
	Bernard #\= 3,
	Daniel #\= 5,
	Daniel #\= 3,
	labeling([], People).
	
	

	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex10	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
		Reunião
	1 -
	2 -
	3 -

*/

renioes([A, C, D, Total]) :-
	domain([A, C, D, Unicos1, Unicos2, Unicos3, Total], 0, 200),
	
	/*
	A + X #= 130,
	B + Y #= 135,
	C + Z #= 65,
	X #= AB + AC,
	Y #= AB + BC,
	Z #= AC + BC,
	A + B + C + AB + AC + BC #= 200,
	 */
	
	A + 30 + D + Unicos1 #= 130,
	C + 30 + D + Unicos2 #= 65,
	A + 30 + C + Unicos3 #= 135,
	A + 30 + C + D + Unicos1 + Unicos2 + Unicos3 #= 200,
	
	%Total #< 171, 	
	Total #= 200 - A - D - C - 30.
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex11	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
Nomes:
	1 - Claudio
	2 - David
	3 - Domingos
	4 - Francisco
	5 - Marcelo
	6 - Paulo 

Desporto :
	1 - ping-pong
	2 - futebol
	3 - andebol
	4 - rugby
	5 - tenis
	6 - voleibol
Solteiro:
	1 - é solteiro
	2 - não é solteiro

*/

desportos(Jogos) :-
	Jogos = [PingPong, Futebol, Andebol, Rugby, Tenis, Voleibol],
	domain(Jogos, 1, 6),
	all_distinct(Jogos),	

	Tenis #\= 5,
	Voleibol #\= 4,
	Voleibol #\= 6,
	Rugby #\= 3,  	
	Rugby #\= 1,
	Rugby #\= 4,
	Futebol #\= 2,
	Futebol #= 5,
	Tenis #= 2,
	Andebol #\= 1,
	Andebol #\= 4,	

	labeling([], Jogos). 	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex13	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*

Nacionalidades :
	1 - Alemao
	2 - Ingles
	3 - Brasileiro
	4 - Espanhol
	5 - Italiano
	6 - Frances

Marcas :
	1 - La Vie Claire
	2 - Sistema-V
	3 - Fagor

*/

automoveis(Carros, Marcas) :-
	Carros = [N1, N2, N3, N4, N5, N6],
	length(Marcas, 6),
	length(Pos, 6),
	domain(Carros, 1, 6),
	domain(Marcas, 1, 3),
	all_distinct(Carros),
	 

	% O n°1 e o alemão são corredores da marca La Vie Claire 
	element(1, Marcas, 1),
	element(Alemao, Carros, 1),
	element(Alemao, Marcas, 1),

	% O n°5 e o brasileiro são corredores da marca Sistema -V
	element(5, Marcas, 2),
	element(Brasileiro, Carros, 3),
	element(Brasileiro, Marcas, 2),

	% O espanhol e o n°3 são corredores da marca Fagor 
	element(Espanhol, Carros, 4),
	element(Espanhol, Marcas, 3),
	element(3, Marcas, 3),

	% Espanhol ficou sem gasolina no inicio
	
	N2 #\= 4, N6 #\= 4, N3 #\= 4, N1 #\= 4,

	N3 #\= 5, N3 #\= 6,	
	
	N1 #\= 5, N1 #\= 1,
		
	N2 #\= 1, N2 #\= 5,
 			
	append(Carros, Marcas, Vars),		
	labeling([], Vars).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex15	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*

	Através do enunciado não se percebe bem os factos	

Nomes:
1 - Paula
2 - Artur
3 - Daniel
4 - Ema
5 - Mala
Sobrenomes:
1 - Postal
2 - Bola
3 - Famoso
4 - Primavera

Endereço:
1- Espanha
2- Hungria
3 - Sardenha
4 - Turquia

Encomenda:
1 - roupas de criança
2 - Livro
3 - Catalogo de Vendas
4 - Plantas

*/






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex16	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
	Está errado como sempre
*/


liquido_po([Total, L, N, P]) :-
	domain([Total, L, N, P], 0, 100000).
	Total #= 427*3 + L*3 + N*3,
	Total1 #= 7*427 + 7*P + 7*N,	
	Total #= Total1/2,
	Total #= 5*N,
	Total2 #= 5*427 + 5*L + 5*P,
	Total #= Total2/4,	
	Total #= L + P + 427 + N,
	427 #= Total - L - P - N,
	labeling([], [Total]). 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex1	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
	Não consegui gerar solução
	
*/


seq_magic(N, Seq) :-
	length(Seq, N),
	N1 is N - 1,
	domain(Seq, 0, N1),
	putRest(Seq, 0, Seq),
	labeling([], Seq).
	
putRest([H|T], I, Seq) :-
	count(I, Seq, #=, H),
	Acc1 is I + 1,
	putRest(T, Acc1, Seq).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex13	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 	
paulinho(Vars) :-
	Vars = [WakeUp, TakeBus1, StartWork, TakeBus2, TurnTvOn, FallASleep],
	domain(Vars, 1, 24),
	%minimum(WakeUp, Vars),
	
	WakeUp #>= 6,
	WakeUp  #=< TakeBus1 - 1,
	TakeBus1 #=< StartWork - 1,
	StartWork #=< TakeBus2 - 8,
	TakeBus2 #=< TurnTvOn - 1,
	TurnTvOn #=< FallASleep - 3,
	labeling([], Vars).  
		
 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex2	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

carteiro(Percurso, Time) :-
	length(Percurso, 10),
	domain(Percurso, 1, 10),
	all_distinct(Percurso),
	element(10, Percurso, 6),	
	tempo(Percurso, Time),
	labeling([maximize(Time)], Percurso).

tempo([_], 0).
tempo([A,B|T], Time) :-
	Time #= Time1 + abs(A-B),
	tempo([B|T], Time1).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex5	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   	ex11	      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*
	
	


*/
prob(X, Y) :-
	domain([X, Y], 0, 100),
	X #\= 100, X\= 1,
	Y #\= 100, Y\= 1,
	X*Y #= X + Y,
	labeling([], [X, Y]). 





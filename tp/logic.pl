:-use_module(library(lists)).
:-use_module(library(random)).

/*
	Globals and default values
*/

inicialize_possible_lines([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]).

:- assert(midle_line(f)).
:- assert(tab_height(5)).
:- assert(total_height(11)).
:- assert(dificulty(n)).

:- assert(
	tab([
	[cell(1-1, e), cell(1-2, e), cell(1-3, e), cell(1-4, e), cell(1-5, e)],
 	[cell(2-1, e), cell(2-2, e), cell(2-3, e), cell(2-4, e), cell(2-5, e), cell(2-6, e)],
	[cell(3-1, e), cell(3-2, e), cell(3-3, e), cell(3-4, e), cell(3-5, e), cell(3-6, e), cell(3-7, e)],
	[cell(4-1, e), cell(4-2, e), cell(4-3, e), cell(4-4, e), cell(4-5, e), cell(4-6, e), cell(4-7, e), cell(4-8, e)],
	[cell(5-1, e), cell(5-2, e), cell(5-3, e), cell(5-4, e), cell(5-5, e), cell(5-6, e), cell(5-7, e), cell(5-8, e), cell(5-9, e)],
	[cell(6-1, e), cell(6-2, e), cell(6-3, e), cell(6-4, e), cell(6-5, e), cell(6-6, e), cell(6-7, e), cell(6-8, e), cell(6-9, e), cell(6-10, e)],
	[cell(7-1, e), cell(7-2, e), cell(7-3, e), cell(7-4, e), cell(7-5, e), cell(7-6, e), cell(7-7, e), cell(7-8, e), cell(7-9, e)],
	[cell(8-1, e), cell(8-2, e), cell(8-3, e), cell(8-4, e), cell(8-5, e), cell(8-6, e), cell(8-7, e), cell(8-8, e)],
	[cell(9-1, e), cell(9-2, e), cell(9-3, e), cell(9-4, e), cell(9-5, e), cell(9-6, e), cell(9-7, e)],
	[cell(10-1, e), cell(10-2, e), cell(10-3, e), cell(10-4, e), cell(10-5, e), cell(10-6, e)],
	[cell(11-1, e), cell(11-2, e), cell(11-3, e), cell(11-4, e), cell(11-5, e)]
])).

:- assert(
	tab2([
	[cell(1-1, 'W'), cell(1-2, 'B'), cell(1-3, 'W'), cell(1-4, 'B'), cell(1-5, 'W')],
 	[cell(2-1, 'W'), cell(2-2, 'W'), cell(2-3, 'W'), cell(2-4, e), cell(2-5, e), cell(2-6, e)],
	[cell(3-1, 'B'), cell(3-2, 'B'), cell(3-3, 'B'), cell(3-4, e), cell(3-5, e), cell(3-6, e), cell(3-7, e)],
	[cell(4-1, 'W'), cell(4-2, 'W'), cell(4-3, e), cell(4-4, e), cell(4-5, e), cell(4-6, e), cell(4-7, e), cell(4-8, e)],
	[cell(5-1, 'B'), cell(5-2, 'W'), cell(5-3, 'W'), cell(5-4, e), cell(5-5, e), cell(5-6, e), cell(5-7, e), cell(5-8, e), cell(5-9, e)],
	[cell(6-1, e), cell(6-2, e), cell(6-3, e), cell(6-4, e), cell(6-5, e), cell(6-6, e), cell(6-7, e), cell(6-8, e), cell(6-9, e), cell(6-10, e)],
	[cell(7-1, e), cell(7-2, e), cell(7-3, 'W'), cell(7-4, e), cell(7-5, e), cell(7-6, e), cell(7-7, e), cell(7-8, e), cell(7-9, e)],
	[cell(8-1, e), cell(8-2, e), cell(8-3, e), cell(8-4, e), cell(8-5, e), cell(8-6, e), cell(8-7, e), cell(8-8, e)],
	[cell(9-1, e), cell(9-2, e), cell(9-3, e), cell(9-4, e), cell(9-5, e), cell(9-6, e), cell(9-7, e)],
	[cell(10-1, e), cell(10-2, e), cell(10-3, e), cell(10-4, e), cell(10-5, e), cell(10-6, e)],
	[cell(11-1, e), cell(11-2, e), cell(11-3, e), cell(11-4, e), cell(11-5, 'B')]
])).



construct_tab(Height, Tab) :-
		construct_first_half(0, Height, 6, Tab1),
		append([], Tab1, TabAux),
		Length is Height * 2, Length1 is Length + 1,
		N1 is Height + 1,
		Length2 is Length1 - 2,
		construct_middle(1, Length, N1, Middle),
		append(TabAux, [Middle], TabAux2),
		construct_second_half(N1, Length2, Tab2),
		append(TabAux2, Tab2, Tab).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%			Construção de um tabuleiro     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%construct_first_half(0, 5, 6, Tab).
construct_first_half(Height, Height, _, []).
construct_first_half(Height, Total_Height, Lenght, [H|T]) :-
		Heigth1 is Height + 1,
		construct_middle(1, Lenght, Heigth1, H),  Lenght1 is Lenght + 1,
		construct_first_half(Heigth1, Total_Height, Lenght1, T).


%construct_second_half(6, 10, Tab).
construct_second_half(_, 5, []).
construct_second_half(Height, Lenght, [H|T]) :-
		Heigth1 is Height + 1,
		construct_middle(1, Lenght, Heigth1, H),
		Lenght1 is Lenght - 1,
		construct_second_half(Heigth1,  Lenght1, T).

%construct_middle(1, 11, f, Line).
construct_middle(Length, Length, _,  []).
construct_middle(Length, TotalLength, Letter, [cell(Letter-Length, e)|T]) :-
		Length1 is Length + 1,
		construct_middle(Length1, TotalLength, Letter, T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%testes efetua_jogada('A', d-4), efetua_jogada('A', d-5), efetua_jogada('B', d-3), efetua_jogada('B', d-6), retira_bolas('B', d-3, List).



%testa_fim, testa se é o fim do jogo
testa_fim :- balls('B', 0).
testa_fim :- balls('W', 0).
%testa_fim :- ganhou(Player, Line-Col).   % para avaliar a vitória interessa-nos a ultima jogada


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%			Retorna as bolas a Retirar     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%todos os caminhos afetados pela ultima jogada, necessário para retira bolas e testar se o jogador ganhou
paths_affected(Tab, Player, Line-Col, List) :- possible_paths(Line-Col, Paths), searchCells(Tab, Paths, List).

%ganhou('A', [[cell(1-1, 'A'), ...], [...], [...]]).
ganhou(_, []) :- !, fail.
ganhou(Player,  [H|T]) :- ganhouAux(Player, H); ganhou(Player, T).
ganhouAux(_, []) :- !, fail.
ganhouAux(Player, [cell(_-_, Player), cell(_-_, Player), cell(_-_, Player), cell(_-_, Player), cell(_-_, Player)|T]).
ganhouAux(Player, [H|T]) :- ganhouAux(Player, T).


%para cada path
analisaRetiradaOuter(Player, Line-Col, Cells, List) :- analisaRetiradaOuter(Player, Line-Col, Cells, [], List).
analisaRetiradaOuter(_, _-_, [], List, List).
analisaRetiradaOuter(Player, Line-Col, [H|T], Lista, Result) :- analisaRetirada(Player, Line-Col, H, List), append(Lista, List, ListaAux), analisaRetiradaOuter(Player, Line-Col, T, ListaAux, Result).

%not tested
%analisa para um path se há bolas possiveis de retirar e retorna a lista das mesmas - WRONG
analisaRetirada(_, _-_, [], []).
analisaRetirada(Player, Line-Col, [cell(Line-Col, _), cell(Line1-Col1, State1), cell(Line2-Col2, State2), cell(_-_, State3)|T], [cell(Line1-Col1, State1), cell(Line2-Col2, State2)|T1]) :- analisaRetiradaAux(Player, [State1, State2, State3]), analisaRetirada(Player, Line-Col, T, T1).    %crescente
analisaRetirada(Player, Line-Col, [cell(_-_, State3), cell(Line1-Col1, State1), cell(Line2-Col2, State2), cell(Line-Col, _)|T], [cell(Line1-Col1, State1), cell(Line2-Col2, State2)|T1]) :- analisaRetiradaAux(Player, [State1, State2, State3]), analisaRetirada(Player, Line-Col, T, T1). %decrescente
analisaRetirada(Player, Line-Col, [H|T], List) :- analisaRetirada(Player, Line-Col, T, List).



%not tested: analisaRetiradaAux(B, [State1, State2, State3])
analisaRetiradaAux(Player, [P1, P1, Player]) :- player2(Player, P1).



%searchCells retorna as celulas de cada Path
%exemplo searchCells(-Tab, -[Path1, Path2, Path3], +Cells).
searchCells(Tab, [], []).
searchCells(Tab, [[Line-_, Line-_|_] | Tail], [H|T]) :- searchCellsLine(Tab, Line, H),     searchCells(Tab, Tail, T).
searchCells(Tab, [Head|Tail], [H|T]) :- searchCellsDiagnol(Tab, 1, Head, H), searchCells(Tab, Tail, T).

searchCellsLine([H|_], 1, H).
searchCellsLine([_|T], Line, Cells) :- Line1 is Line - 1, searchCellsLine(T, Line1, Cells).

searchCellsDiagnol(_, Acc, [], []).
searchCellsDiagnol([H|T], Acc, [Line-Col|T1], [H2|T2]) :- Acc == Line, searchCellsLine(H, Col, H2), Acc1 is Acc + 1, searchCellsDiagnol(T, Acc1, T1, T2).
searchCellsDiagnol([H|T], Acc, [Line-Col|T1], Cells) :- Acc1 is Acc + 1, searchCellsDiagnol(T, Acc1, [Line-Col|T1], Cells).







%player(Player, Player)
player2('W', 'B').
player2('B', 'W').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%	Testa e Efetua Jogada	 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%todos os paths possiveis relacionados com a ultima jogada
possible_paths(Line-Col, Paths) :- findall(Path, (possible_path(Path), member(Line-Col, Path)), Paths).




%Tested
%TODO: melhorar o getCellState, basta fazer um setCellState e verificar se não dá erro, adicionar erro quando a célula não está vazia
%testa se é possível efetuar uma jogada

testa_jogada(Tab, Player, Linha-Coluna) :- getCellState(Tab, Linha-Coluna, e).



%testa se há bolas disponiveis
bolas_disponiveis_ok(Player) :- balls(Player, Num), Num > 1.

%Tested
%efetua_jogada - regista uma jogada - WRONG
efetua_jogada(Tab, Player, Linha-Coluna, TabFinal) :- setCellState(Tab, Player, Linha-Coluna, TabFinal), retract(balls(Player, Num)), Numb is Num - 1, assert(balls(Player, Numb)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%	Get e Set de Peças do tabuleiro     %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Tested: Line must be a number
%setCellState(Tab, Player, Line-Coluna, NewTab)
setCellState([H|T], Player, 1-Coluna, [Line|T]) :- setCellStateAux(H, Player, Coluna,  Line).
setCellState([H|T], Player, Line-Coluna,  [H|T1]) :- Line1 is Line - 1, setCellState(T, Player, Line1-Coluna, T1).
setCellStateAux([H|T], Player, 1, [H1|T]) :- H=..[_, L-C,_], H1 =.. [cell, L-C, Player].
setCellStateAux([H|T], Player, Col, [H|T1]) :- Col1 is Col - 1, setCellStateAux(T, Player, Col1, T1).



%Tested: Line must be a number
%getCellState retorna o estado de uma determinada célula
getCellState([H|_], 1-Coluna, State) :- getCellStateAux(H, Coluna, State).
getCellState([H|T], Linha-Coluna, State) :- Linha1 is Linha - 1, getCellState(T, Linha1-Coluna, State).
getCellStateAux([H|_], 1, State) :- H =.. [_, _-_, State].
getCellStateAux([H|T], Col, State) :- Col1 is Col - 1, getCellStateAux(T, Col1, State).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-assert(possible_path([1-1, 2-1, 3-1, 4-1, 5-1, 6-1])).
:-assert(possible_path([1-2, 2-2, 3-2, 4-2, 5-2, 6-2, 7-1])).
:-assert(possible_path([1-3, 2-3, 3-3, 4-3, 5-3, 6-3, 7-2, 8-1])).
:-assert(possible_path([1-4, 2-4, 3-4, 4-4, 5-4, 6-4, 7-3, 8-2, 9-1])).
:-assert(possible_path([1-5, 2-5, 3-5, 4-5, 5-5, 6-5, 7-4, 8-3, 9-2, 10-1])).
:-assert(possible_path([2-6, 3-6, 4-6, 5-6, 6-6, 7-5, 8-4, 9-3, 10-2, 11-1])).
:-assert(possible_path([3-7, 4-7, 5-7, 6-7, 7-6, 8-5, 9-4, 10-3, 11-2])).
:-assert(possible_path([4-8, 5-8, 6-8, 7-7, 8-6, 9-5, 10-4, 11-3])).
:-assert(possible_path([5-9, 6-9, 7-8, 8-7, 9-6, 10-5, 11-4])).
:-assert(possible_path([6-10, 7-9, 8-8, 9-7, 10-6, 11-5])).


:-assert(possible_path([1-1, 1-2, 1-3, 1-4, 1-5])).
:-assert(possible_path([2-1, 2-2, 2-3, 2-4, 2-5, 2-6])).
:-assert(possible_path([3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7])).
:-assert(possible_path([4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8])).
:-assert(possible_path([5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9])).
:-assert(possible_path([6-1, 6-2, 6-3, 6-4, 6-5, 6-6, 6-7, 6-8, 6-9, 6-10])).
:-assert(possible_path([7-1, 7-2, 7-3, 7-4, 7-5, 7-6, 7-7, 7-8, 7-9])).
:-assert(possible_path([8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8])).
:-assert(possible_path([9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7])).
:-assert(possible_path([10-1, 10-2, 10-3, 10-4, 10-5, 10-6])).
:-assert(possible_path([11-1, 11-2, 11-3, 11-4, 11-5])).

:-assert(possible_path([1-5, 2-6, 3-7, 4-8, 5-9, 6-10])).
:-assert(possible_path([1-4, 2-5, 3-6, 4-7, 5-8, 6-9, 7-9])).
:-assert(possible_path([1-3, 2-4, 3-5, 4-6, 5-7, 6-8, 7-8, 8-8])).
:-assert(possible_path([1-2, 2-3, 3-4, 4-5, 5-6, 6-7, 7-7, 8-7, 9-7])).
:-assert(possible_path([1-1, 2-2, 3-3, 4-4, 5-5, 6-6, 7-6, 8-6, 9-6, 10-6])).
:-assert(possible_path([2-1, 3-2, 4-3, 5-4, 6-5, 7-5, 8-5, 9-5, 10-5, 11-5])).
:-assert(possible_path([3-1, 4-2, 5-3, 6-4, 7-4, 8-4, 9-4, 10-4, 11-4])).
:-assert(possible_path([4-1, 5-2, 6-3, 7-3, 8-3, 9-3, 10-3, 11-3])).
:-assert(possible_path([5-1, 6-2, 7-2, 8-2, 9-3, 10-2, 11-2])).
:-assert(possible_path([6-1, 7-1, 8-1, 9-1, 10-1, 11-1])).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- assert(balls('W', 36)).
:- assert(balls('B', 36)).

:-assert(letter(a, 1)).
:-assert(letter(b, 2)).
:-assert(letter(c, 3)).
:-assert(letter(d, 4)).
:-assert(letter(e, 5)).
:-assert(letter(f, 6)).
:-assert(letter(g, 7)).
:-assert(letter(h, 8)).
:-assert(letter(i, 9)).
:-assert(letter(j, 10)).
:-assert(letter(k, 11)).
:-assert(letter(l, 12)).
:-assert(letter(m, 13)).
:-assert(letter(n, 14)).
:-assert(letter(o, 15)).
:-assert(letter(p, 16)).
:-assert(letter(q, 17)).
:-assert(letter(r, 18)).
:-assert(letter(s, 19)).
:-assert(letter(t, 20)).
:-assert(letter(u, 21)).
:-assert(letter(v, 22)).
:-assert(letter(w, 23)).
:-assert(letter(x, 24)).
:-assert(letter(y, 25)).
:-assert(letter(z, 26)).
:-assert(letter(1, a)).
:-assert(letter(2, b)).
:-assert(letter(3, c)).
:-assert(letter(4, d)).
:-assert(letter(5, e)).
:-assert(letter(6, f)).
:-assert(letter(7, g)).
:-assert(letter(8, h)).
:-assert(letter(9, i)).
:-assert(letter(10, j)).
:-assert(letter(11, k)).
:-assert(letter(12, l)).
:-assert(letter(13, m)).
:-assert(letter(14, n)).
:-assert(letter(15, o)).
:-assert(letter(16, p)).
:-assert(letter(17, q)).
:-assert(letter(18, r)).
:-assert(letter(19, s)).
:-assert(letter(20, t)).
:-assert(letter(21, u)).
:-assert(letter(22, v)).
:-assert(letter(23, w)).
:-assert(letter(24, x)).
:-assert(letter(25, y)).
:-assert(letter(26, z)).

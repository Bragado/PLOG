:- use_module(library(lists)).

:- dynamic notPossibleMove/2.

jogada(Tab, Type, Player, NewTab, Cells) :-
	getMove(Type, Tab, Player, Line-Col),
	retract_move(Player),
	efetua_jogada(Tab, Player, Line-Col, Tab2),
	verifica_retirada(Tab2, Type, Player, Line-Col, NewTab, Cells), !.

getMove(pvp, Tab, Player, Line-Col)	:- pedeJogadaValida(Tab, Player, Line-Col).
getMove(ai, Tab, Player, Line-Col)	:- computeBestMove(Tab, Player, Line-Col).
getMove(pvai, Tab, 'W', Line-Col) :- pedeJogadaValida(Tab, Player, Line-Col).
getMove(pvai, Tab, 'B', Line-Col) :- computeBestMove(Tab, Player, Line-Col).

computeBestMove(Tab, Player, Line-Col) :- calc_bestMove(Tab, Player, pont(Line-Col, _)).


verifica_retirada(Tab, Type, Player, Line-Col, NewTab, Cells) :-
	paths_affected(Tab, Player, Line-Col, Cells),
	analisaRetiradaOuter(Player, Line-Col, Cells, List),
	conclude(Tab, Type, Player, NewTab, List).

conclude(Tab, _, _, Tab, []).
conclude(Tab, Type, Player, NewTab, List) :-
	askPiece(Type, Tab, Player, List, Line-Col),
	retira_bola(Tab, Player, Line-Col, NewTab),
	player2(Player, P1),
	assert(notPossibleMove(P1, Line-Col)).


retract_move(Player) :- retract(notPossibleMove(Player, _-_)).
retract_move(_).

askPiece(pvp, _, Player, List, Line-Col) :-
	nl, write('Choose one of your oponents pieces to remove'), nl,
	printList(List), nl, nl,
	repeat,
		getLineNCol(LineAux-ColAux),
		player2(Player, P2),
		member(cell(Line-Col, P2), List),
	Line = LineAux, Col = ColAux.

askPiece(ai, Tab, Player, List, Line-Col) :-
	computeRetirada(Tab, Player, List, Line-Col).	%TODO

askPiece(pvai, 'W', List, Line-Col) :- askPiece(pvp, 'W', List, Line-Col).
askPiece(pvai, 'B', List, Line-Col) :- askPiece(ai, 'B', List, Line-Col).

getLineNCol(Line-Col) :-
	write('Insert a valid Line [character]:   '), read(LineAux), not(integer(LineAux)), letter(LineAux, Line), nl,
	write('Insert a valid Col [integer]:    '), read(Col), integer(Col),  nl.

pedeJogadaValida(Tab, Player, Line-Col) :-
	nl, write('Player '), write(Player), write(' please insert the following:'), nl,
	repeat,
		getLineNCol(LineAux-ColAux),
		lineNColRespectBoundries(Tab, LineAux-ColAux),
		not( notPossibleMove(Player, LineAux-ColAux)),
		testa_jogada(Tab, Player, LineAux-ColAux),
	Line = LineAux, Col = ColAux.

not(Goal) :- call(Goal),!,fail.
not(Goal).

retira_bola(Tab, Player, Line-Col, NewTab) :-
	setCellState(Tab, e, Line-Col, NewTab),
	player2(Player, P1),
	retract(balls(P1, Num)), Numb is Num +1,
	assert(balls(P1, Numb)).

lineNColRespectBoundries(Tab, Line-Col) :-
	Line > 0, Col > 0,
	total_height(Heigth), Line =< Heigth,
	width(Tab, Line, Width), Col =< Width.

width([], _, -1).
width([H|_], 1, Width) :-
	length(H, Width).
width([_|T], Line, Width) :- Line1 is Line - 1, width(T, Line1, Width).


:- tab(Tab), assert(state(Tab, 'W')).

jogo(Type) :-
	repeat,
		retract(state(Tab, Player)),
		tab_height(H), nl, nl, printTab(Tab, H),
		jogada(Tab, Type, Player, NewTab, Cells),
		player2(Player, P1),
		assert(state(NewTab, P1)),
		testaFim(Player, Cells), !,
	print_final(NewTab, Player).

testaFim(Player,  Cells) :- testa_fim; ganhou(Player, Cells).
print_final(Tab, Player) :-
		tab_height(H), nl, nl, printTab(Tab, H), nl, nl, nl,
		write('  ____                                          _             _           _     _'), nl,
		write(' / ___|   ___    _ __     __ _   _ __    __ _  | |_   _   _  | |   __ _  | |_  (_)   ___    _ __    ___  '), nl,
		write('| |      / _ \\  |  _ \\   / _  | |  __|  / _  | | __| | | | | | |  / _  | | __| | |  / _ \\  |  _ \\  / __| '), nl,
		write('| |___  | (_) | | | | | | (_| | | |    | (_| | | |_  | |_| | | | | (_| | | |_  | | | (_) | | | | | \\__ \\ '), nl,
		write(' \\____|  \\___/  |_| |_|  \\__, | |_|     \\__,_|  \\__|  \\__,_| |_|  \\__,_|  \\__| |_|  \\___/  |_| |_| |___/ '), nl, nl,
		print_player(Player).


print_player('W') :-
		write('                       ____    _                                  __        __  '), nl,
		write('                      |  _ \\  | |   __ _   _   _    ___   _ __    \\ \\      / /  '), nl,
		write('                      | |_) | | |  / _` | | | | |  / _ \\ |  __|    \\ \\ /\\ / /   '), nl,
		write('                      |  __/  | | | (_| | | |_| | |  __/ | |        \\ V  V /    '), nl,
		write('                      |_|     |_|  \\__,_|  \\__, |  \\___| |_|         \\_/\\_/     '), nl, nl, nl.


print_player('B') :-
		write('                         ____    _                                   ____  '), nl,
		write('                        |  _ \\  | |   __ _   _   _    ___   _ __    | __ ) '), nl,
		write('                        | |_) | | |  / _` | | | | |  / _ \\ |  __|   |  _ \\  '), nl,
		write('                        |  __/  | | | (_| | | |_| | |  __/ | |      | |_) | '), nl,
		write('                        |_|     |_|  \\__,_|  \\__, |  \\___| |_|      |____/  '), nl,nl, nl.







printList(List) :-
	length(List, Cols),
	firstPrint(Cols), nl,
	printCols(Cols), nl, write('|'),
	printLineAux(List, 0), nl,
	printFinalCols(0, Cols).


firstPrint(Cols) :- Cols > 0,
		    Total is 6*Cols - 1,
		    write(' '),
		    firstPrintAux(Total).
firstPrintAux(0).
firstPrintAux(Total) :-
	write('_'),
	Total1 is Total -1,
	firstPrintAux(Total1).

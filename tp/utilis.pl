
:- dynamic possible_path/1.

traduz([], []).
traduz([H|T], [H1|T1]) :- traduz2(H, H1), traduz(T, T1).

traduz2([], []).
traduz2([cell(Line-Col, _)|T], [Line-Col|T1]) :- traduz2(T, T1).


assertPossiblePaths(Tab) :-
    traduz(Tab, NewTab),
    h_asserts(NewTab),
    d_asserts(NewTab, d1, 1),
    d_asserts(NewTab, d2, 1).


h_asserts([]).
h_asserts([H|T]) :- assert(possible_path(H)), h_asserts(T).

d_asserts([], Type, _).
d_asserts(_, Type, Acc) :- tab_height(N), Acc > N + 1.
d_asserts([H|T], Type, 1) :- d_asserts_first_Line(H, Type), d_asserts(T, Type, 2).
d_asserts([H|T], Type, Acc) :- Acc1 is Acc + 1, d_asserts_C(H, Type, List), assert(possible_path(List)), d_asserts(T, Type, Acc1).


d_asserts_first_Line([], _).
d_asserts_first_Line([H|T], Type) :-
      d_asserts_C([H], Type, List),
      assert(possible_path(List)),
      d_asserts_first_Line(T, Type).

d_asserts_C([H|_], d1, List) :- calculate_d1(H, List).
d_asserts_C(Line, d2, List) :- last(Line, Last), calculate_d2(Last, List).


calculate_d1(Line-Col, []) :- not(cellExists(Line-Col)).
calculate_d1(Line-Col, [Line-Col|T]) :-
      tab_height(N),
      Line > N,
      Line1 is Line + 1,
      calculate_d1(Line1-Col, T).
calculate_d1(Line-Col, [Line-Col|T]) :-
      Line1 is Line + 1, Col1 is Col + 1,
      calculate_d1(Line1-Col1, T).

calculate_d2(Line-Col, []) :- not(cellExists(Line-Col)).
calculate_d2(Line-Col, [Line-Col|T]) :-
      tab_height(N),
      Line > N,
      Line1 is Line + 1,
      Col1 is Col - 1,
      calculate_d2(Line1-Col1, T).
calculate_d2(Line-Col, [Line-Col|T]) :-
      Line1 is Line + 1,
      calculate_d2(Line1-Col, T).


cellExists(Line-Col) :- Line > 0, total_height(Max), Line < Max + 1, Col > 0, checkCols(Line-Col).

checkCols(Line-Col) :- tab_height(N), Line < N +1 , Col < Line + 5.
checkCols(Line-Col) :- tab_height(N), Line > N, total_height(MAX), Line1 is MAX - Line, Col < Line1 + 6.


%interesting_pieces(+Tab, +Tab, +[], -List)
interesting_pieces(Tab, [], List, List) :- !.
interesting_pieces(Tab, [H|T], L, Lista) :-
      interesting_pieces2(Tab, H, L2), !,
      append(L, L2, L3), !,
      interesting_pieces(Tab, T, L3, Lista).

interesting_pieces2(Tab, [], []).
interesting_pieces2(Tab, [H|T], Lista) :-
      not(interesting(Tab, H)),
      interesting_pieces2(Tab, T, Lista).
interesting_pieces2(Tab, [H|T], [H|T2]) :-
      interesting_pieces2(Tab, T, T2).

interesting(Tab, cell(Line-Col, e)) :-
      Line1 is Line + 1, Line2 is Line -1,
      Col1 is Col + 1, Col2 is Col-1,
      (
        (cellExists(Line1-Col),  not(getCellState(Tab, Line1-Col, e)));
        (cellExists(Line1-Col2),  not(getCellState(Tab, Line1-Col2, e)));
        (cellExists(Line-Col1),  not(getCellState(Tab, Line-Col1, e)));
        (cellExists(Line-Col2),  not(getCellState(Tab, Line-Col2, e)));
        (cellExists(Line2-Col),  not(getCellState(Tab, Line2-Col, e)));
        (cellExists(Line2-Col1),  not(getCellState(Tab, Line2-Col1, e)))
      ).

%TODO: TESTE
computeRetirada(Tab, Player, List, Line-Col) :- choose(List, cell(Line-Col)).
    


%calc_bestMove(Tab, Player, Move)
calc_bestMove(Tab, Player, Move) :-
      dificulty(N),
      interesting_pieces(Tab, Tab, [], Moves),
      calc_bestMove2(N, Tab, Player, Moves, Move).

calc_bestMove2(_, Tab, _, [], pont(6-5, 100)).
calc_bestMove2(e, _, _, Moves, pont(Line-Col, 100)) :- choose(Moves, cell(Line-Col, _)).
calc_bestMove2(n, Tab, Player, Moves, Move) :-
      calc_MovePontuation(Tab, Player, Moves, [Move|_]).

calc_MovePontuation(Tab, Player, Moves, MovePont) :- calc_MovePontuation2(Tab, Player, Moves, MovePont1), quick_sort2(MovePont1, MovePont).

calc_MovePontuation2(_, _, [], []).
calc_MovePontuation2(Tab, Player, [cell(Line-Col, _)|T], [pont(Line-Col, Pont)|T2]) :-
        calcPont(Tab, Player, Line-Col, Pont),
        calc_MovePontuation2(Tab, Player, T, T2).

calcPont(Tab, Player, Line-Col, 100) :- efetua_jogada(Tab, Player, Line-Col, Tab2), paths_affected(Tab2, Player, Line-Col, Cells), ganhou(Player, Cells).
calcPont(Tab, Player, Line-Col, 90) :- player2(Player, P1), efetua_jogada(Tab, P1, Line-Col, Tab2),  paths_affected(Tab2, P1, Line-Col, Cells),  ganhou(P1, Cells).
calcPont(Tab, Player, Line-Col, 80) :- efetua_jogada(Tab, Player, Line-Col, Tab2), paths_affected(Tab2, Player, Line-Col, Cells), analisaRetiradaOuter(Player, Line-Col, Cells, [_,_|T]).
calcPont(Tab, Player, Line-Col, 70) :- efetua_jogada(Tab, Player, Line-Col, Tab2),paths_affected(Tab2, P1, Line-Col, Cells), fourInArow(Line-Col, P1, Cells).
calcPont(Tab, Player, Line-Col, 60) :- efetua_jogada(Tab, Player, Line-Col, Tab2),paths_affected(Tab2, P1, Line-Col, Cells), threeInArow(Line-Col, P1, Cells).
calcPont(Tab, Player, Line-Col, 50) :- efetua_jogada(Tab, Player, Line-Col, Tab2),paths_affected(Tab2, P1, Line-Col, Cells), twoInArow(Line-Col, P1, Cells).
calcPont(Tab, Player, Line-Col, 40).



fourInArow(Line-Col, P, [H1, H2, H3]) :- fourInArow2(Line-Col, P, H1); fourInArow2(Line-Col, P, H2) ; fourInArow2(Line-Col, P, H3).
fourInArow2(_-_, _, [_, _, _]) :- !, fail.
fourInArow2(Line-Col, Player, [cell(Line-Col, Player), cell(_-_, Player), cell(_-_, Player), cell(_-_, Player) | _]).
fourInArow2(Line-Col, Player, [cell(_-_, Player), cell(Line-Col, Player), cell(_-_, Player), cell(_-_, Player) | _]).
fourInArow2(Line-Col, Player, [cell(_-_, Player), cell(_-_, Player), cell(Line-Col, Player), cell(_-_, Player) | _]).
fourInArow2(Line-Col, Player, [cell(_-_, Player), cell(_-_, Player), cell(_-_, Player), cell(Line-Col, Player) | _]).
fourInArow2(Line-Col, Player, [H|T]) :- fourInArow2(Line-Col, Player, T).


threeInArow(Line-Col, P, [H1, H2, H3]) :- threeInArow2(Line-Col, P, H1); threeInArow2(Line-Col, P, H2); threeInArow2(Line-Col, P, H3) .
threeInArow2(_-_, _, [_,_]) :- !, fail.
threeInArow2(Line-Col, Player, [cell(Line-Col, Player), cell(_-_, Player), cell(_-_, Player) | _]).
threeInArow2(Line-Col, Player, [cell(_-_, Player), cell(Line-Col, Player), cell(_-_, Player) | _]).
threeInArow2(Line-Col, Player, [cell(_-_, Player), cell(_-_, Player), cell(Line-Col, Player) | _]).
threeInArow2(Line-Col, Player, [H|T]) :- threeInArow2(Line-Col, Player, T).


twoInArow(Line-Col, P, [H1, H2, H3]) :- twoInArow2(Line-Col, P, H1); twoInArow2(Line-Col, P, H2); twoInArow2(Line-Col, P, H3).
twoInArow2(_-_, _, [_]) :- !, fail.
twoInArow2(Line-Col, Player, [cell(Line-Col, Player), cell(_-_, Player)| _]).
twoInArow2(Line-Col, Player, [cell(_-_, Player), cell(Line-Col, Player)| _]).
twoInArow2(Line-Col, Player, [H|T]) :- twoInArow2(Line-Col, Player, T).


pivoting(H,[],[],[]).
pivoting(pont(Line-Col, Pont),[pont(Line1-Col1, Pont1)|T],[pont(Line1-Col1, Pont1)|L],G):-Pont1=<Pont,pivoting(pont(Line-Col, Pont),T,L,G).
pivoting(pont(Line-Col, Pont),[pont(Line1-Col1, Pont1)|T],L,[pont(Line1-Col1, Pont1)|G]):-Pont1>Pont,pivoting(pont(Line-Col, Pont),T,L,G).


quick_sort2(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).


  choose([], []).
  choose(List, Elt) :-
          length(List, Length),
          random(0, Length, Index),
          nth0(Index, List, Elt).

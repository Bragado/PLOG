
print_game :- print_board([a, b, c, d, e, f, g, h, i, j, k ]).


%print_board(+Lines)

print_board(List) :- printLine0, print_boardAux(List).

print_boardAux([]):- nl.
print_boardAux([H|T]) :- nl,  printLine(H), print_boardAux(T).




abs(Original, Final) :- Original < 0, Final is 0 - Original.
abs(Original, Original).

printTab(Tab, Level) :-  Offset is Level*3 + 1, write_offset(Offset), write('_____________________________'), nl, printTabAux(Tab, Level, Level), !.

printTabAux([], _, _).
printTabAux([H|T], Level, LevelMax) :- Level1 is Level - 1, printCellLine(H, Level, LevelMax), printTabAux(T, Level1, LevelMax).

printCellLine(Line, Level, LevelMax) :- abs(Level, Level1), ColsAux is LevelMax - Level1, Cols is 5 + ColsAux, printInicial(Level, Cols), nl, printLine(Line, Level), nl, printFinal(Level, Cols), nl.




printInicial(0, Cols) :- printCols(Cols).
printInicial(Level, Cols) :-abs(Level, Level1), Offset is Level1*3, write_offset(Offset), printCols(Cols).
printLine(Line, Level) :- abs(Level, Level1),  Offset is Level1*3, write_offset(Offset), write('|'), printLineAux(Line).

printLineAux([]).
printLineAux([], _).
printLineAux([H|T]) :- H =.. [_, Line-Col, e], writeOffset(Col), letter(Line, Letter), write(Letter), write(Col), write(' |'), printLineAux(T).
printLineAux([H|T], _) :-  H =.. [_, Line-Col, _], writeOffset(Col), letter(Line, Letter), write(Letter), write(Col), write(' |'), printLineAux(T, _).
printLineAux([H|T]) :- H =.. [_, Line-Col, State], writeOffset(Col), write(State), write('  |'), printLineAux(T).

writeOffset(Col):- Col < 10, write('  ').
writeOffset(Col):- write(' ').

printCols(0) :- write('|').
printCols(Cols) :- write('|     '), Cols1 is Cols - 1, printCols(Cols1).
write_offset(3) :- write('   ').
write_offset(0).
write_offset(Offset) :- write(' '), Offset1 is Offset - 1, write_offset(Offset1).


printFinal(Level, Cols) :- Level > 0, abs(Level, Level1), Offset is Level1*3 - 2, Offset > 0, write_offset(Offset), printFinalCols(Level, Cols).
printFinal(Level, Cols) :- Level < 0, abs(Level, Level1), Offset is Level1*3, Offset > 0, write_offset(Offset), printFinalCols(Level, Cols).
printFinal(Level, Cols) :- printFinalCols(Level, Cols).


printFinalCols(Level, 0) :- Level > 0, write('__|__').
printFinalCols(Level, 0) :- Level < 1, write('|').
printFinalCols(Level, Cols) :- Level < 1, write('|_____'), Cols1 is Cols - 1, printFinalCols(Level, Cols1).
printFinalCols(Level, Cols) :- Level > 0, write('__|___'), Cols1 is Cols - 1, printFinalCols(Level, Cols1).






/*

                _____________________________
               |     |     |     |     |     |
               |  a1 |  a2 |  a3 |  a4 |  a5 |
             __|_____|_____|_____|_____|_____|__
            |     |     |     |     |     |     |
            |  b1 |  b2 |  b3 |  b4 |  b5 |  b6 |
          __|_____|_____|_____|_____|_____|_____|__
         |     |     |     |     |     |     |     |
         |  c1 |  c2 |  c3 |  c4 |  c5 |  c6 |  c7 |
       __|_____|_____|_____|_____|_____|_____|_____|__
      |     |     |     |     |     |     |     |     |
      |  d1 |  d2 |  d3 |  d4 |  d5 |  d6 |  d7 |  d8 |
    __|_____|_____|_____|_____|_____|_____|_____|_____|__
   |     |     |     |     |     |     |     |     |     |
   |  e1 |  e2 |  e3 |  e4 |  e5 |  e6 |  e7 |  e8 |  e9 |
 __|_____|_____|_____|_____|_____|_____|_____|_____|_____|__
|     |	    |     |     |     |     |     |     |     |     |
|  f1 |	 f2 |  f3 |  f4 |  f5 |  f6 |  f7 |  f8 |  f9 | f10 |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|
   |     |     |     |     |     |     |     |     |     |
   |  g1 |  g2 |  g3 |  g4 |  g5 |  g6 |  g7 |  g8 |  g9 |
   |_____|_____|_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |     |
      |  h1 |  h2 |  h3 |  h4 |  h5 |  h6 |  h7 |  h8 |
      |_____|_____|_____|_____|_____|_____|_____|_____|
         |     |     |     |     |     |     |     |
         |  i1 |  i2 |  i3 |  i4 |  i5 |  i6 |  i7 |
         |_____|_____|_____|_____|_____|_____|_____|
            |     |     |     |     |     |     |
            |  j1 |  j2 |  j3 |  j4 |  j5 |  j6 |
            |_____|_____|_____|_____|_____|_____|
               |     |     |     |     |     |
               |  k1 |  k2 |  k3 |  k4 |  k5 |
               |_____|_____|_____|_____|_____|
*/

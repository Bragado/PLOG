:-use_module(library(lists)).

%film(Title, Categories, Duration, AvgClassification).
film('Doctor Strange', [action, adventure, fantasy], 115, 7.6).
film('Hacksaw Ridge', [biography, drama, romance], 131, 8.7).
film('Inferno', [action, adventure, crime], 121, 6.4).
film('Arrival', [drama, mystery, scifi], 116, 8.5).
film('The Accountant', [action, crime, drama], 127, 7.6).
film('The Girl on the Train', [drama, mystery, thriller], 112, 6.7).

%user(Username, YearOfBirth, Country)
user(john, 1992, 'USA').
user(jack, 1989, 'UK').
user(peter, 1983, 'Portugal').
user(harry, 1993, 'USA').
user(richard, 1982, 'USA').

%vote(Username, List_of_Film-Rating)
vote(john, ['Inferno'-7, 'Doctor Strange'-9, 'The Accountant'-6]).
vote(jack, ['Inferno'-8, 'Doctor Strange'-8, 'The Accountant'-7]).
vote(peter, ['The Accountant'-4, 'Hacksaw Ridge'-7, 'The Girl on the Train'-3]).
vote(harry, ['Inferno'-7, 'The Accountant'-6]).
vote(richard, ['Inferno'-10, 'Hacksaw Ridge'-10, 'Arrival'-9]).


%ex1 : curto(+Movie)

curto(Movie) :- film(Movie, _, Duration, _), Duration < 125.

%ex2 : diff(+User1, +User2, -Difference, +Film)

diff(User1, User2, Difference, Film) :- getUserVote(User1, Film, Vote1), getUserVote(User2, Film, Vote2), calcDif(Vote1, Vote2, Difference), !.

getUserVote(User1, Film, Vote1):- vote(User1, List), member(Film-Vote1, List).
calcDif(Vote1, Vote2, Difference) :- Vote1 > Vote2, !, Difference is Vote1 - Vote2.
calcDif(Vote1, Vote2, Difference) :- Difference is Vote2 - Vote1.


%ex3 : niceGuy(+User) 

niceGuy(User) :- getUserVote(User, Film1, Vote1), getUserVote(User, Film2, Vote2), Film1 \= Film2, Vote1 > 7, Vote2 > 7, !.  


%ex4 : interseta(+List1, +List2, -Common) 

interseta([], _, []).
interseta([H|T], L, [H|T1]) :- member(H, L), interseta(T, L, T1), !.
interseta([_|T], L, T1) :- interseta(T, L, T1). 

%ex5 :  imprimeCategoria(+Categoria)

imprimeCategoria(Categoria) :- 
	film(Movie, Categories, Duration, AVG), 
	member(Categoria, Categories),
	write(Movie), write(' ('), write(Duration), write('min - '), write(AVG), write('/10)'), nl,
	fail.
imprimeCategoria(_).


%ex6 : similaridade(+Film1, -Similaridade, +Film2)

similaridade(Film1, Similaridade, Film2) :- percentCommonCat(Film1, Film2, Perc), durDiff(Film1, Film2, DurDiff), scoreDiff(Film1, Film2, ScoreDiff), Similaridade is Perc - 2*DurDiff - 10*ScoreDiff.

durDiff(Film1, Film2, DurDiff) :- film(Film1, _, Vote1, _), film(Film2, _, Vote2, _), calcDif(Vote1, Vote2, DurDiff).


scoreDiff(Film1, Film2, ScoreDiff) :- film(Film1, _, _, Vote1), film(Film2, _, _, Vote2), calcDif(Vote1, Vote2, ScoreDiff).


percentCommonCat(Film1, Film2, Perc) :- film(Film1, Movie1, _, _), film(Film2, Movie2, _, _), common(Movie1, Movie2, 0, Common), lengthDistinct(Movie1, Movie2, 0, Total), Distinct is Common/Total, Perc is Distinct*100.

common([], L2, N, N).
common([H|T], L2, Acc, N) :- Acc1 is Acc + 1, member(H, L2), !, common(T, L2, Acc1, N).
common([H|T], L2, Acc, N) :- common(T, L2, Acc, N).

lengthDistinct([], L2, Acc, N) :- length(L2, N1), N is Acc + N1.
lengthDistinct([H|T], L2, Acc, N) :- member(H, L2), !, lengthDistinct(T, L2, Acc, N).
lengthDistinct([_|T], L2, Acc, N) :- Acc1 is Acc + 1, lengthDistinct(T, L2, Acc1, N).

%ex7 : mostSimilar(+Film, -Films, -Similarity)











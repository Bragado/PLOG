:- use_module(library(clpfd)).
:- use_module(library(lists)).

%apply restrictions

applyRestrictions([]).
applyRestrictions([H|T]) :- applyRestriction(H), applyRestrictions(T).


%apply
applyRestriction(Group) :- 
	length(Group, Length),
	minimum(Min, Group),
	maximum(Max, Group),
	(Max - Min) #= Length - 1.



%groupDiff(+Original, +Generated, -Diff).
groupDiff([], [], 0).
groupDiff([H|T], [H1|T1], Diff) :- 
	groupDiff(T, T1, Diff2),
	Diff #= Diff2 + abs(H-H1).



%diff(+OriginalList, +GeneratedList, -Diff).  foreach group calculates de differences

diff([], [], []).
diff([H|T], [H1|T1], [H2|T2]) :- groupDiff(H, H1, H2), diff(T, T1, T2).


inicializeDomains(OriginalList, GeneratedList) :- 
	length(OriginalList, Length),
	length(GeneratedList, Length),
	totalSeats(Total),
	inicializeDomains(OriginalList, GeneratedList, Total). 	

inicializeDomains([], [], _). 
inicializeDomains([H|T], [H1|T1], Total) :-
	length(H, Length),
	length(H1, Length),
	domain(H1, 1, Total),
	
	inicializeDomains(T, T1, Total).


solver(OriginalList, GeneratedList) :-
	 
	inicializeDomains(OriginalList, GeneratedList),
		
	applyRestrictions(GeneratedList),
	 
	append(GeneratedList, Aux),
	 
	all_distinct(Aux),	
	diff(OriginalList, GeneratedList, Diff),
	sum(Diff, #= , TotalDiff),
	labeling([minimize(TotalDiff), time_out(5000, _)], Aux),
	print_plateia(GeneratedList),
	print_groups(1),
	nl, write('total dist: '), write(TotalDiff), nl.
	


print_plateia(GeneratedList,  GroupsList).
	


inicialize(TicketsSold, MaxNumSeatsPerRow) :-
	setof(Group, Name^group(Group, Name), Groups),
	inicialize_groups(Groups, TicketsSold),
	seatsPerRow(MaxNumSeatsPerRow).

inicialize_groups([], []).
inicialize_groups([H|T], [Tickets|T2]) :- findall(Ticket, (group(H, Name), bilhete(Ticket, Name)), Tickets), inicialize_groups(T, T2).



redistribut(TS, GL) :- inicialize(TS, _), solver(TS, GL).



print_groups(Acc) :-  findall(Name, group(Acc, Name), []).
print_groups(Acc) :- nl, findall(Name, group(Acc, Name), Names), print_groups(Acc, Names), Acc1 is Acc + 1, print_groups(Acc1).


print_groups(_, []).
print_groups(Acc, [H|T]):- write(Acc), write(' - '), write(H), nl, print_groups(Acc, T).

 




%print_plateia(Rows).

print_plateia(GL) :- nl, levels(MaxLevel),  places(GL, 0, MaxLevel, Places), print_plateia2(Places).
print_plateia2([]).
print_plateia2([H|T]) :- print_row(H), nl, print_plateia2(T).

print_row([]).
print_row([H|T]) :- X is H/10, X > 1, write(' '), write(H), write(' '), write('|'),  print_row(T), !.
print_row([H|T]) :- write(' '), write(H), write('  |'), print_row(T).


%places(GL, MinLevel, MaxLevel, Places).
places(_, MaxLevel, MaxLevel, []).
places(GL, MinLevel, MaxLevel, [H|T]) :- seatsPerRow(Rows), MinSeats is MinLevel * Rows + 1, MaxSeats is MinSeats + Rows, findGroupsRow(GL, MinSeats, MaxSeats, Lista), decide(MinLevel, Lista, H), Level is MinLevel + 1, places(GL, Level, MaxLevel, T).


decide(Level, Lista, Lista) :- 0 =:= mod(Level,2), !.
decide(_, Lista, Lista2) :- reverse(Lista, Lista2).   


%findGroupsRow(GL, MinSeats, MaxSeats + 1, Lista)
findGroupsRow(_, MaxSeats, MaxSeats, []) :- !.
findGroupsRow(GL, MinSeats, MaxSeats, [H|T]) :- findGroup(GL, MinSeats, 1, H), Min is MinSeats + 1, findGroupsRow(GL, Min, MaxSeats, T).   


%findGroup(GL, Seat, Acc, Group).
findGroup([], _, _, -1).
findGroup([H|T], Seat, Acc, Acc) :- member(Seat, H), !.
findGroup([_|T], Seat, Acc, Group) :- Acc1 is Acc + 1, findGroup(T, Seat, Acc1, Group).


%BD
/*
levels(3).
seatsPerRow(5).
totalSeats(15).
*/
group(1, johnny).
group(1, john).
group(1, mary).
group(1, marie).

group(2, antony).
group(2, ant).
group(2, mal).

group(3, lou).
group(3, loius).
group(3, pal).
group(3, mar).
group(3, ze).

group(4, tete).
group(4, tat).

group(5, palo).





bilhete(1, johnny).
bilhete(2, antony).
bilhete(3, ant).
bilhete(4, john).
bilhete(5, mary).
bilhete(6, tete).
bilhete(7, palo).
bilhete(8, marie).
bilhete(9, lou).
bilhete(10, loius).
bilhete(11, mal).
bilhete(12, pal).
bilhete(13, mar).
bilhete(14, ze).
bilhete(15, tat).



/*  plateia

    1   2   3   4  5
    6   7   8   9  10
    11  12  13  14 15


    1  - johnny
    2  - antony
    3  - ant
    4  - john
    5  - mary
    6  - tete
    7  - palo
    8  - marie
    9  - lou
    10 - loius
    11 - mal
    12 - pal
    13 - mar
    14 - ze
    15 - tat
*/
/*
teste2([[18, 27], [32, 47, 5], [6], [31, 36], [1, 23, 29, 30], [34, 41], [46, 15], [25, 43, 35], [14], [49, 28, 38], [13, 40], [48], [24, 12], [3, 8, 2], [10, 16, 19], [17], [4, 39], [42, 22], [26], [37, 21, 50], [11, 33], [45, 20], [9], [44, 7]]).

levels(5).
seatsPerRow(10).
totalSeats(50).
*/

teste3([[67, 3], [52, 20, 11], [34, 70, 55], [91, 28], [8], [68, 73, 51, 25], [77, 82, 43], [35, 64], [14, 80], [92, 93, 39], [66, 65, 41], [95, 26, 38], [49, 89], [4, 87], [100], [33], [76, 81, 86], [94, 48, 19], [85, 83], [56, 5, 6], [21, 16, 53, 13], [31, 60, 7, 30], [42, 2, 18], [54, 59, 10, 45], [36, 27, 96], [90, 24, 57], [12, 75], [97, 88], [63, 84, 58], [40, 32, 22], [72, 15, 9], [29, 1], [37, 23], [44, 79], [69], [78], [46, 71, 98], [61, 99], [47, 74], [50, 17, 62]]).

levels(10).
seatsPerRow(10).
totalSeats(100).




 

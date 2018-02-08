carteiro :- length(List, 10),
	domain(List, 1, 10), 
	all_distinct(list), 
	element(10, List, 6),
	tempo(List, Time),
	labeling([maximize(Time)], List).


tempo([], 0).
tempo([A,B|T], Time) :-
	tempo([B|T], NTime),
	Time #= NTime + abs(B - A).


tarefas :- 
	LTasks = [ 
		task(S1, 16, E1, 2, 1), ...
		task(S7, 4, E7, 11, 7)
	],
	comulative(LTasks, [limit(13)]),
	LEnds = [E1, E2, .., E6, E7],
	domain(LEnd, 1, 70	
	maximum(MaxEnd, LEnds),
	labeling([minimize(MaxEnd)], LEnds).


% Para o relatorio:
	fazer estatiscas de eficiencia com diferentes parametros no labeling

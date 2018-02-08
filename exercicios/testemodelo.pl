:-use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


not(G) :- call(G), !, fail.
not(_).



%pergunta1 : madeItThrough(+Participant)
madeItThrough(Participant) :- performance(Participant, Times), madeItThrough2(Times), !.
madeItThrough2([120|_]).
madeItThrough2([_|T]) :- madeItThrough2(T). 


%pergunta2 : juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes([], _, [],  0).
juriTimes([H|T], JuriMember, [Time|T2], Total) :- performance(H, Times),  nth1(JuriMember, Times, Time), juriTimes(T, JuriMember, T2, Total2), Total is Total2 + Time. 

%pergunta3 : patientJuri(+JuriMember)
patientJuri(JuriMember) :- performance(N1, Times1), performance(N2, Times2), N1 \= N2, nth1(JuriMember, Times1, 120), nth1(JuriMember, Times2, 120).


%pergunta4 : bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P) :- totalTime(P1, Total1), totalTime(P2, Total2), compare(P1, Total1, P2, Total2, P).

totalTime(P, Total) :- performance(P, Times), totalTime(Times, 0, Total).
totalTime([], Total, Total).
totalTime([H|T], Acc, Total) :- Acc1 is Acc + H, totalTime(T, Acc1, Total).

compare(P1, Total1, _, Total2, P1) :- Total1 > Total2, !.
compare(_, Total1, P2, Total2, P2) :- Total1 < Total2, !.
compare(_, _, _, _, _) :- !, fail.


%pergunta5 : allPerfs.

allPerfs :- printPerfs, fail.
allPerfs.

printPerfs :- 
	performance(Id, Times),
	participant(Id, _, Performance),
	write(Id), write(':'),
	write(Performance), write(':'),
	write(Times), nl. 

%pergunta6 : nSuccessfulParticipants(-T)
nSuccessfulParticipants(T) :- findall(P, success(P), Ps), length(Ps, T).


success(P) :- performance(P, Times), success2(Times).

success2([120]).
success2([120|T]) :- success2(T).


%pergunta7 : juriFans(juriFansList)
juriFans2(JuriFansList) :- findall(P-F, (performance(P, _), teste(P-F)), JuriFansList).
teste(P-F) :- findall(N, (performance(P, Lista), nth1(N, Lista, 120)), F). 

juriFans(JuriFansList) :- findall(P, performance(P,_), Ps), juriFans(Ps, JuriFansList).
juriFans([], []).
juriFans([H|T], [H-N|T1]) :- juris(H, N), juriFans(T, T1).

juris(P, N) :- performance(P, Times), juris2(Times, 1, N).
juris2([], _, []).
juris2([120|T], Counter, [Counter|T1]) :- Counter1 is Counter + 1, juris2(T, Counter1, T1).
juris2([_|T], Counter, T1) :- Counter1 is Counter + 1, juris2(T, Counter1, T1).

%pergunta8 : nextPhase(+N, -Participants)

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times), 
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

nextPhase(N, Participants) :- setof(TT-Id-Perf, eligibleOutcome(Id,Perf,TT), Every), reverse(Every, Every1), firstN(N, Every1, Participants).

firstN(0, _, []).
firstN(N, [], _) :- N > 0, !, fail.
firstN(N, [H|T], [H|T1]) :- N1 is N - 1, firstN(N1, T, T1).


%pergunta9 : predX/3
%este predicado recebe como primeiro argumento um numero (idade) e como segundo uma lista de participantes de seguida, retorna no terceiro argumento, uma lista com o nome do performance de todos os participantes de idade inferior ou igual ao primeiro argumento.
%trata-se de um cut verde pois a sua remoção não altera o significado do programa apenas poda a árvore de pesquisa do predicado


predX(Q,[R|Rs],[P|Ps]) :-
    participant(R,I,P), I=<Q,
    predX(Q,Rs,Ps).
predX(Q,[R|Rs],Ps) :-
    participant(R,I,_), I>Q,
    predX(Q,Rs,Ps).
predX(_,[],[]).


%pergunta10 : 
%este predicado retorna em L uma subsequencia S(X) ou seja, como primeiro elemento tem X, de seguida tem X espaços livres e novamente X (e resto da lista). Isto corresponde à regra S(X) = X, ..., X, ou seja, "começada e terminada com o número X e com X outros números de permeio". Para tal, atraves de length cria uma lista com X posições, de seguida, na primeira ocorrencia de append, é criado os elementos que estão depois de X e na segunda ocorrencia os elementos que estão entre X  

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

%pergunta11 : langford(+N,-L)

langford(N,L) :- N2 is N*2, langford(N, N2, L1, L).
langford(1, N2, L1, L) :- impoe(1, L1), firstN(N2, L1, L).
langford(N, N2, L1, L) :- impoe(N, L1), N1 is N - 1, langford(N1, N2, L1, L). 







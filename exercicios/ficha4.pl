ligado(a,b). 
ligado(f,i).
ligado(a,c). 
ligado(f,j).
ligado(b,d). 
ligado(f,k).
ligado(b,e). 
ligado(g,l).
ligado(b,f). 
ligado(g,m).
ligado(c,g). 
ligado(k,n).
ligado(d,h). 
ligado(l,o).
ligado(d,i). 
ligado(i,f).


membro(X, [X|_]):- !.
membro(X, [_|Y]):- membro(X,Y).
concatena([], L, L).
concatena([X|Y], L, [X|Lista]):- concatena(Y, L, Lista).
inverte([X], [X]).
inverte([X|Y], Lista):- inverte(Y, Lista1), concatena(Lista1, [X], Lista).

not(G) :- call(G), !, fail.
not(_).


resolva_prof(No_inicial, No_meta, Solucao) :- resolva_prof(No_inicial, No_meta, [], Solucao1), inverte(Solucao1, Solucao).

resolva_prof(No_meta, No_meta, Solucao, [No_meta|Solucao]).
resolva_prof(No_inical, No_meta, [No_inicial|T], Solucao) :- 
	ligado(No_inicial, No_intermedio), 
	not(membro(No_intermedio, T)),
	resolva_prof(No_intermedio, No_meta, [No_inicial|T], Solucao).

resolva_larg(No_incial, No_meta, Solucao) :- resolva_larg(No_incial, No_meta, [], Solucao), inverte(Solucao1, Solucao).
resolva_larg(No_meta, No_meta, Caminho, [No_meta|Caminho]).
resolva_larg(No_Inicial, No_meta, Caminho, Solucao) :-
	findall(No, ligado(No_Inicial, No), Nos),
	resolva_larg(Nos, Caminho).
resolva_larg2([], No_Meta, Caminho, Solucao).
resolva_larg2([H|T], No_Meta, Caminho, Solucao) :-
	not(membro(H, Caminho)),
	resolva_larg
	
		

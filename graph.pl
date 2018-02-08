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


% findall(X, ligado(Y, X), L). -> L = [a, b, c, d, e, f, ... ]

% bagof(X, ligado(Y, X), L).   -> Y = a, L = [b, c] ; Y = b, L =  [d, e] ... (o bagof instancia Y o findall não)

% bagof(X, Y^ligado(Y, X), L). -> o mesmo que findall
 
% setof (..) -> faz o mesmo que bagof mas os resultados estão ordenados e não há repetidos

 

%ex do trabalho

setof(Valor-PosX-PosY, (validMove(J, Tab, X, Y, NTab, NJ), value(Ntab, V)), L). -> todas as jogadas válidas possíveis ordenadas pela qualidade (Valor) que acrescenta ao tabuleiro

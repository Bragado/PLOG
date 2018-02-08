
%ex1

%parent(+Parent, +Son)

parent('Aldo', 'Lincoln').
parent('Christina', 'Lincoln').
parent('Lisa', 'LJ').
parent('Lincoln', 'LJ').
parent('Christina', 'Michael').
parent('Aldo', 'Michael').

parents(X, Parents) :- findall(Parent, parent(Parent, X), Parents).
sons(X, Sons) :- findall(Son, parent(X, Son), Sons).



%ex2

pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Breitling', 'Lamb').
team('RedBull', 'Besenyei').
team('RedBull', 'Chambliss').
team('MediterraneanRacingTeam', 'MacLean' ).
team('Matador', 'Jones').
team('Matador', 'Bonhomme').
team('Cobra', 'Mangold').

airPlane('Edge540', 'Bonhomme').
airPlane('Edge540', 'Besenyei').
airPlane('Edge540', 'Chambliss').
airPlane('Edge540', 'MacLean').
airPlane('Edge540', 'Mangold').
airPlane('Edge540', 'Jones').
airPlane('MX2', 'Lamb').

circuit('Porto').
circuit('Istanbul').
circuit('Budapest').

wonCircuit('Porto', 'Jones').
wonCircuit('Istanbul', 'Mangold').
wonCircuit('Budapest', 'Mangold').

gates('Porto', 5).
gates('Istanbul', 9).
gates('Budapest', 6).


wonPorto(Pilot) :- wonCircuit('Porto', Pilot).
wonTeamPorto(Team) :- wonCircuit('Porto', Pilot), team(Team, Pilot).
moreThenOne(Pilots) :- setof(Pilot, (wonCircuit(X, Pilot), wonCircuit(Y, Pilot), X \= Y), Pilots), !.
moreThen8(Circuits) :- findall(Circuit, (gates(Circuit, Num), Num > 8 ), Circuits). 
not540(Pilots) :- findall(Pilot, (airPlane(Airplane, Pilot), Airplane \= 'Edge540'), Pilots).


%ex7
traduza(1, integer_overflow).
traduza(2, divisao_por_zero).
traduza(3, id_desconhecido).

%ex8

cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).


%chefiado_por(tecnico, X), chefeido_por(X,Y).
% os proximos "dois" chefes do tecnico X = engenheiro, Y = supervisor
 
%chefiado_por(tecnico, X), cargo(X,ivone), cargo(Y,Z).
% Qual o cargo da ivone que chefeia os tecnicos    false

%cargo(J,P), (chefiado_por(J, supervisor_chefe); chefiado_por(J, supervisor)). 
% Quem é que é chefeiado por supervisores chefe ou por supervisores X = engenheiro, Y = daniel

%chefiado_por(P, director), not(cargo(P, carolina)).
% Quem é que é chefiado pelo diretor e não se chama carolina?   P = sonia

%ex9
aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).
frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).
professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).
funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

alunosDeProf(Prof, Aluno) :- professor(Prof, UC), aluno(Aluno, UC). 
pessoasUniv(Uni, Pessoa) :- funcionario(Pessoa, Uni) ; frequenta(Aluno, Uni).

colega(X, Y) :- funcionario(X, Uni), funcionario(Y, Uni), X \= Y.
colega(X, Y) :- aluno(X, UC), aluno(Y, UC), X \= Y.
colega(X, Y) :- frequenta(X, Uni), frequenta(Y, Uni), X \= Y.










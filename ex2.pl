%ex2

%pilot(+ Name).

pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').


%team(+Pilot, +TeamName)
team('Lamb', 'Breitling'). 
team('Besenyei', 'Red Bull').
team('Chambliss', 'Red Bull').
team('MacLean', 'Mediterraneam Racing Team').
team('Jones', 'Matador').
team('Bonhommme', 'Matador').
team('Mangold', 'Cobra').

%airplane( +Pilot, +Type).
airplane('Lamb', 'MX2').
airplane('Besenyei', 'Edge540').
airplane('Chambliss', 'Edge540').
airplane('MacLean', 'Edge540').
airplane('Mangold', 'Edge540').
airplane('Jones', 'Edge540').
airplane('Bonhomme', 'Edge540').

%circuit(+Name).
circuit('Istanbul').
circuit('Budapes').
circuit('Porto').

%won(+Pilot, +Circuit).
won('Jones', 'Porto').
won('Mangold', 'Budapest').
won('Mangold', 'Istanbul').

%gates(+Circuit, +Number).
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

%teamWon(+Circuit, -TeamName).
teamWon(Circuit, TeamName) :- won(X, 'Porto'), team(X, TeamName).


%moreThan1circuit(-PilotName)
moreThan1circuit(PilotName) :- won(PilotName, X), won(PilotName, Y), X \= Y.

%moreThan8gates(- CircuitName)
moreThan8gates(CircuitName) :- gates(CircuitName, N), N > 8.

%notEdge540(Pilot)
notEdge540(Pilot) :- \+ airplane(Pilot, 'Edge540').



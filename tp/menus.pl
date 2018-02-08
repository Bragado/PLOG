:- include('utilis.pl').
:- include('cli.pl').
:- include('logic.pl').
:- include('game.pl').



start :-
    nl,
    write('  Welcome to BOKU!'), nl,
    write('      1. Player Vs Player'), nl,
    write('      2. Player Vs Bot'), nl,
    write('      3. Bot Vs Bot'), nl,
    write('      4. Settings'), nl,
    write('      5. About'), nl,
    write('      6. Exit'), nl,
    getOption(Option, 1, 6),
    maqEstadoInicial(Option).

maqEstadoInicial(1) :-
    cleanAsserts,
    jogo(pvp).

maqEstadoInicial(2) :-
    cleanAsserts,
    jogo(pvai).

maqEstadoInicial(3) :-
    cleanAsserts,
    jogo(ai).

maqEstadoInicial(4) :-
    settings.
maqEstadoInicial(6).

cleanAsserts :- abolish(state/2), tab(Tab), assert(state(Tab, 'W')).


getOption(Option, Min, Max) :-
      repeat,
          write('Please choose one of the option above:    '), read(Opt),
          Opt >= Min, Opt =< Max,
          Option = Opt.

final :-
    nl, write('Do you wish to start again? [y/n]:   '),
    read(letra),
    maqEstadoFinal(letra).
maqEstadoFinal(n) :- abort.
maqEstadoFinal(_) :- start.



settings :-
      nl,
      write('1. Change tab size'), nl,
      write('2. Change dificulty'), nl,
      getOption(Option, 1, 2),
      maqEstadoSettings(Option).

maqEstadoSettings(1) :-
        repeat,
            nl, write('Insert a number between 5 and 10:    '),
            read(Number),
            Number > 4, Number < 11,
        retract(tab(_)),
        abolish(possible_path/1),
        retract(tab_height(_)),
        retract(total_height(_)),
        assert(tab_height(Number)),
        Number1 is Number*2+1,
        assert(total_height(Number1)),
        construct_tab(Number, Tab),
        assert(tab(Tab)),
        assertPossiblePaths(Tab),
        start.

maqEstadoSettings(2) :-
      repeat,
        nl,
        write('Choose between easy or normal mod [e/n]:    '),
        read(Mod),
      (Mod == e; Mod == n),
      retract(dificulty(_)),
      assert(dificulty(Mod)),
      start.

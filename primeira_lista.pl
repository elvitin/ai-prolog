% Exercicio(4)
/*
Netuno 2800
Urano 1790
Saturno 886
Júpiter 484
Marte 141
Terra 93
Vênus 67
Mercúrio 36
*/

distancia_do_sol(netuno, 2800).
distancia_do_sol(urano, 1790).
distancia_do_sol(saturno, 886).
distancia_do_sol(jupter, 484).
distancia_do_sol(marte, 141).
distancia_do_sol(terra, 93).
distancia_do_sol(venus, 67).
distancia_do_sol(mercurio, 36).

distancia_planeta_v2(P1, P2, D) :-
    distancia_do_sol(P1, DisP1),
    distancia_do_sol(P2, DisP2),
    D is abs(DisP1 - DisP2).

% distancia_planeta_v2(saturno, netuno, D).



%%% Exercicio (5)
casou(joao, maria, data(5, maio, 1980)).
casou(andre, fernanda, data(11, agosto, 1950)).
casou(adriano, claudia, data(15, outubro, 1973)).


% Qual a data do casamento de Maria?
casou_quando(Quem, Quando) :- casou(Quem, _, Quando); casou(_, Quem, Quando).
% ?- casou_quando(maria, Quando).

% Qual o mês do casamento de Andre?
mes_nascimento(Quem, Mes) :- casou_quando(Quem, data(_, Mes, _)).
% ?- mes_nascimento(andre, Mes).


% Quem casou antes de Adriano, considerando somente o ano de casamento?
ano_casamento(Quem, Ano) :- casou_quando(Quem, data(_, _, Ano)).
% ?- AnoCasamento(adriano, Ano).

% Quem casou antes de Adriano, considerando somente o ano de casamento?
casaram_antes(De, CasaramAntes) :-
    ano_casamento(De, AnoDe),
    findall([marido(Marido), mulher(Mulher)], (casou(Marido, Mulher, data(_, _, Ano)), Ano < AnoDe), CasaramAntes).
% ?- casaram_antes(adriano, CasaramAntes).

% Quem casou a menos de 20 anos (considerando apenas o ano)?
casaram_a_menos_de(Casaram, AnoAtual, Anos) :-
    findall([marido(Marido), mulher(Mulher)], (casou(Marido, Mulher, data(_, _, Ano)), Ano >= AnoAtual - Anos), Casaram).
% ?- casaram_a_menos_de(Casaram, 2000, 45).

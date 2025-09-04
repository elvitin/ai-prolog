piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).


equipe(lamb, breitling).
equipe(besenyei, redbull).
equipe(maclean, mediterranean_racing_team).
equipe(mangold, cobra).
equipe(jones, matador).
equipe(bonhomme, matador).


aviao(mx2, lamb).
aviao(edge540, besenyei).
aviao(edge540, chambliss).
aviao(edge540, maclean).
aviao(edge540, mangold).
aviao(edge540, jones).
aviao(edge540, bonhomme).

circuito(istanbul).
circuito(budapest).
circuito(porto).

venceu(jones, porto).
venceu(mangold, budapest).
venceu(mangold, istanbul).

gates(9, istanbul).
gates(6, budapest).
gates(5, porto).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a) Quem venceu a corrida no Porto?
% venceu(Quem, porto).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% b) Qual equipe ganhou no Porto?
equipe_venceu(Equipe, Circuito) :-
    venceu(Piloto, Circuito),
    equipe(Piloto, Equipe).
% equipe_venceu(Equipe, porto).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c) Quais pilotos venceram mais de um circuito?
venceu_mais_de_uma_circuito(Piloto, Lista) :-
    findall(Piloto, (venceu(Piloto, CircuitoX), venceu(Piloto, CircuitoY), CircuitoX \= CircuitoY), L),
	sort(L, Lista).
% venceu_mais_de_uma_circuito(Piloto, Lista).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d) Quais circuitos têm mais de 8 gates?
mais_de_oito_gates(Circuito) :-
    gates(Gates, Circuito),
    Gates > 8.
% mais_de_oito_gates(Circuito).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e) Quais pilotos não pilotam um Edge540?
nao_pilotam_edge(Piloto) :-
    aviao(Aviao, Piloto),
    Aviao \= edge540.

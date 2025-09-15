% posicao_livre (Linha, Coluna).
livre(pos(1,1)). livre(pos(1,2)). livre(pos(1,3)). livre(pos(1,5)).
livre(pos(2,1)). livre(pos(2,3)). livre(pos(2,4)). livre(pos(2,5)).
livre(pos(3,1)). livre(pos(3,2)). livre(pos(3,3)). livre(pos(3,5)).
livre(pos(4,1)). livre(pos(4,5)).
livre(pos(5,2)). livre(pos(5,3)). livre(pos(5,4)). livre(pos(5,5)).

% andar em N/S/L/O
% ?- encontra_caminho(pos(1,1), pos(5,5), CaminhoFinal).

inverter_lista_([], Acc, Acc).  % Lista vazia
inverter_lista_([H | T], Acc, Invertida) :- inverter_lista_(T, [H | Acc], Invertida).
inverter_lista(Lista, Invertida) :- inverter_lista_(Lista, [], Invertida).

pertence(X, [X | _]).
pertence(X, [_ | T]) :- pertence(X, T).

pode_ir(Pos, Caminho) :- livre(Pos), not(pertence(Pos, Caminho)).

encontra_caminho_(Pos, Pos, Caminho, Caminho).

encontra_caminho_(pos(L, C), PosFinal, Cam, CamFinal) :-
    (NL is L - 1, Pos = pos(NL, C), pode_ir(Pos, Cam), NCam = [Pos | Cam], encontra_caminho_(Pos, PosFinal, NCam, CamFinal)); % Norte (Linha - 1)
    (NL is L + 1, Pos = pos(NL, C), pode_ir(Pos, Cam), NCam = [Pos | Cam], encontra_caminho_(Pos, PosFinal, NCam, CamFinal)); % Sul (Linha + 1)
    (NC is C + 1, Pos = pos(L, NC), pode_ir(Pos, Cam), NCam = [Pos | Cam], encontra_caminho_(Pos, PosFinal, NCam, CamFinal)); % Leste (Coluna + 1)
    (NC is C - 1, Pos = pos(L, NC), pode_ir(Pos, Cam), NCam = [Pos | Cam], encontra_caminho_(Pos, PosFinal, NCam, CamFinal)). % Oeste (Coluna - 1)


encontra_caminho(PosInicio, PosFinal, CaminhoFinal) :-
    encontra_caminho_(PosInicio, PosFinal, [PosInicio], CaminhoFinal_), !, inverter_lista(CaminhoFinal_, CaminhoFinal).

% posicao_livre (Linha, Coluna).
livre(pos(1,1)). livre(pos(1,2)). livre(pos(1,3)). livre(pos(1,5)).
livre(pos(2,1)). livre(pos(2,3)). livre(pos(2,4)). livre(pos(2,5)).
livre(pos(3,1)). livre(pos(3,2)). livre(pos(3,3)). livre(pos(3,5)).
livre(pos(4,1)). livre(pos(4,5)).
livre(pos(5,2)). livre(pos(5,3)). livre(pos(5,4)). livre(pos(5,5)).

% ----- Utilitário: inverter lista -----
inverter_lista_([], Acc, Acc).
inverter_lista_([H | T], Acc, Inv) :- inverter_lista_(T, [H | Acc], Inv).
inverter_lista(Lista, Inv) :- inverter_lista_(Lista, [], Inv).

% ----- Movimentos válidos no grid -----
pode_ir(pos(L,C), pos(K,C)) :- L > 1, K is L - 1.
pode_ir(pos(L,C), pos(L,K)) :- C > 1, K is C - 1.
pode_ir(pos(L,C), pos(K,C)) :- L < 5, K is L + 1.
pode_ir(pos(L,C), pos(L,K)) :- C < 5, K is C + 1.

% ----- Busca em Largura (BFS) -----
% expande um nó gerando filhos (vizinhos livres ainda não visitados)
expande(Pos, CaminhoAtual, Visitados, Filhos, NovosVisitados) :-
    findall(N, (pode_ir(Pos, N), livre(N), \+ member(N, CaminhoAtual), \+ member(N, Visitados)), Nexts),
    cria_filhos(Nexts, CaminhoAtual, Filhos),
    append(Visitados, Nexts, NovosVisitados).

% transforma lista de nós em lista de caminhos (cada filho herda o caminho atual)
cria_filhos([], _, []).
cria_filhos([N | Ns], CaminhoAtual, [[N | CaminhoAtual] | Filhos]) :-
    cria_filhos(Ns, CaminhoAtual, Filhos).

% motor de Busca em Largura (BFS): fila de caminhos armazenados em ordem (cada caminho é mantido ao contrário para inserir O(1))
bfs([[Objetivo | Cam] | _], _, Objetivo, [Objetivo|Cam]).
bfs([[Pos | Cam] | RestoFila], Visitados, Objetivo, Solucao) :-
    expande(Pos, [Pos | Cam], Visitados, Filhos, Visitados1),
    append(RestoFila, Filhos, NovaFila),
    bfs(NovaFila, Visitados1, Objetivo, Solucao).

% ----- Predicado principal - Busca em Largura (BFS) -----
encontra_caminho_bfs(PosInicio, PosFinal, Caminho) :-
    (PosInicio = PosFinal -> Caminho = [PosInicio]; bfs([[PosInicio]], [PosInicio], PosFinal, CaminhoRev), inverter_lista(CaminhoRev, Caminho)).

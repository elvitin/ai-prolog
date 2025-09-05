% Exercício 1: Comprimento de uma Lista | ?- tamanho([a,b,c,d], Tam).
tamanho([], 0).  % A lista vazia tem comprimento 0
tamanho([_ | T], N) :-
    tamanho(T, N1),
    N is N1 + 1.

% Exercício 2: Soma dos Elementos de uma Lista | ?- soma_lista([3, 2, 1], Soma).
soma_lista([], 0).  % A soma de uma lista vazia é 0
soma_lista([H | T], Soma) :- soma_lista(T, SomaT), Soma is H + SomaT.

% Exercicio 3: Verificar se um Elemento Pertence a Lista | ?- pertence(a, [a, b, c]).
pertence(X, [X | _]).  % Se X é a cabeça da lista, ele pertence
pertence(X, [_ | T]) :- pertence(X, T).  % Verificar na cauda


% Exercicio 4: Inverter uma Lista | ?- inverter_lista([a, b, c], ListaInvertida).
inverter_lista_([], Acc, Acc).  % Lista vazia
inverter_lista_([H | T], Acc, Invertida) :- inverter_lista_(T, [H | Acc], Invertida).
inverter_lista(Lista, Invertida) :- inverter_lista_(Lista, [], Invertida).


% Exercício 5: Remover Duplicados de uma Lista | remove_duplicados([a,b,c,a,c,d],Lista).
% remove todas as ocorrencias de um elemento em uma lista.
% ?- remove_todos(a, [x, a, b, a, t, z, a], Lista).
remove_todos(_, [], []).
remove_todos(Elem, [Elem | T], LAux) :- remove_todos(Elem, T, LAux).
remove_todos(Elem, [H | T], L) :- remove_todos(Elem, T, LAux), L = [H | LAux].

% remove duplicados usando o remove todos
remove_duplicados([], []).
remove_duplicados([H | T], NL1) :-
    remove_todos(H, T, NL2),
    remove_duplicados(NL2, NL3),
    NL1 = [H | NL3].

% remove duplicados usando o pertence
% ?- remove_duplicados_com_pertence([a, b, c, a, c, d, b], Lista).
remove_duplicados_com_pertence([], []).
remove_duplicados_com_pertence([H | T], NL) :-
    remove_duplicados_com_pertence(T, NL_),
    (pertence(H, NL_) -> NL = NL_; NL = [H | NL_]).



% Exercício 6: Substituir um Elemento por Outro em uma Lista
% ?- substitui([a, b, c, a, c, d], a , x, Lista).
% Lista = [x, b, c, x, c, d]

substitui([], _, _, []).
substitui([H | T], Old, New, NL) :-
    substitui(T, Old, New, NL_),
    (H == Old -> NL = [New | NL_]; NL = [H | NL_]).


% Exercício 7: Contar Elementos dentro de uma Lista
% ?- contar_elementos([a,b,c,a,c,d],Lista).
% Lista = [[a,2],[b,1],[c,2],[d,1]]


contar([], _, 0).
contar([H | T], Elem, Qtde) :-
    contar(T, Elem, Qtde_),
    (H == Elem -> Qtde is Qtde_ + 1; Qtde is Qtde_ + 0).

contar_elementos_(_, [], []).
contar_elementos_(FullList, [H | T], NewList) :-
    contar_elementos_(FullList, T, NewList_),
    contar(FullList, H, Qtde),
    NewList = [[H, Qtde] | NewList_].

contar_elementos(FullList, NewList) :-
    remove_duplicados(FullList, NewList_),
    % por que isso aqui tráz mais resultados sem o corte !
    contar_elementos_(FullList, NewList_, NewList),!.


% Exercício 8: Separar Números Pares e Ímpares
% separar_elementos([10, 2, 3, 4, 1, 7], ListaPar, ListaImpar).
separar_elementos([], [], []).
separar_elementos([H | T], ListaPar, ListaImpar) :-
    separar_elementos(T, ListaPar_, ListaImpar_),
    X is H mod 2,
    (X == 0 -> (ListaPar = [H | ListaPar_], ListaImpar = ListaImpar_);
    (ListaPar = ListaPar_, ListaImpar = [H | ListaImpar_])).


% 9.1 Escreva regras genéricas em Prolog que possam responder as seguintes perguntas:
% filme(Título, Gênero, Diretor, Ano, Minutos).
encoding(utf8).
filme('Amnésia',   'Suspense', 'Nolan',     2000, 113).
filme('Babel',     'Drama',    'Inarritu',  2006, 142).
filme('Capote',    'Drama',    'Miller',    2005, 98).
filme('Casablanca','Romance',  'Curtiz',    1942, 102).
filme('Matrix',    'Ficção',   'Wachowski', 1999, 136).
filme('Rebecca',   'Suspense', 'Hitchcock', 1940, 130).
filme('Shrek',     'Aventura', 'Adamson',   2001, 90).
filme('Sinais',    'Ficção',   'Shyamalan', 2002, 106).
filme('Spartacus', 'Ação',     'Kubrik',    1960, 184).
filme('Superman',  'Aventura', 'Donner',    1978, 143).
filme('Titanic',   'Romance',  'Cameron',   1997, 194).
filme('Tubarão',   'Suspense', 'Spielberg', 1975, 124).
filme('Volver',    'Drama',    'Almodóvar', 2006, 121).


% a) Quem dirigiu o filme Titanic? | dirigiu(Quem, 'Titanic').
dirigiu(Quem, Filme) :-  filme(Filme, _, Quem, _, _).

% b) Quais são os filmes de suspense? | ?- filme_por_categoria('Suspense', Filme).
filme_por_genero(Categoria, Filme) :-  filme(Filme, Categoria, _, _, _).
filmes_por_genero(Categoria, Lista) :-
    findall(Filme, filme_por_genero(Categoria, Filme), Lista).

% c) Quais os filmes dirigidos por Donner? | ?- filmes_por_diretor('Donner', Filmes).
filme_por_diretor(Diretor, Filme) :- filme(Filme, _, Diretor, _, _).
filmes_por_diretor(Diretor, Filmes) :-
    findall(Filme, filme_por_diretor(Diretor, Filme), Filmes).

% d) Em que ano foi lançado o filme Sinais?
ano_filme(Filme, Ano) :- % ?- ano_filme('Sinais', Ano).
    filme(Filme, _, _, Ano, _).

% e) Quais os filmes com duração inferior a 100min?
duracao_filme(Filme, Duracao) :- % ?- duracao_filme('Volver', Duracao).
    filme(Filme, _, _, _, Duracao).

filme_duracao_inferior(Duracao, Filme) :- % ?- filme_duracao_inferior(100, Filme).
    duracao_filme(Filme, Duracao_),
    Duracao_ < Duracao.

filmes_duracao_inferior(Duracao, Filmes) :- % ?- filmes_duracao_inferior(100, Filmes).
    findall(Filme, filme_duracao_inferior(Duracao, Filme), Filmes).

% f) Quais os filmes lançados entre 2000 e 2005?
filme_entre(AnoInferior, AnoSuperior, Filme) :- % ?- filme_entre(2000, 2005, Filme).
    filme(Filme, _, _, Ano, _),
    AnoInferior =< Ano,
    Ano =< AnoSuperior.

filmes_entre(AnoInferior, AnoSuperior, Filmes) :- % ?- filmes_entre(2000, 2005, Filmes).
    findall(Filme, filme_entre(AnoInferior, AnoSuperior, Filme), Filmes).

% 9.2 Usando as regras criadas anteriormente construa o predicado
% "clássico", que retorna o título dos filmes lançados antes de 1980.
classico(Filme) :- % ?- classico(Filme).
    ano_filme(Filme, Ano),
    Ano < 1980.

classicos(Filmes) :- % ?- classicos(Filmes).
    findall(Filme, classico(Filme), Filmes).

% 9.3 Usando as regras criadas anteriormente construa o predicado
% "gênero", que retorna o título dos filmes de um gênero específico.

genero(Genero, Filme) :- % ?- genero('Drama', Filme).
    filme_por_genero(Genero, Filme).

genero_filmes(Genero, Filmes) :- % ?- genero_filmes('Drama', Filmes).
    findall(Filme, genero(Genero, Filme), Filmes).

% 9.4 Usando os predicados "clássico" e "gênero" faça uma consulta para
% recuperar os títulos de filmes clássicos de suspense.

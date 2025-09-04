mulher(ana).
mulher(maria).
mulher(luisa).
mulher(laura).
mulher(sueli).

homem(joao).
homem(joaquim).
homem(marcos).
homem(samuel).
homem(flavio).

progenitor(ana, joaquim).
progenitor(joao, joaquim).
progenitor(joao, luisa).
progenitor(maria, laura).
progenitor(joaquim, laura).
progenitor(luisa, samuel).
progenitor(luisa, sueli).
progenitor(marcos, samuel).
progenitor(marcos, sueli).
progenitor(laura, flavio).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sao_irmaos(X, Z) :-
    progenitor(Y, X),
    progenitor(Y, Z), X \= Z.

irmao(Irmao, Z) :- sao_irmaos(Irmao, Z), homem(Irmao).
% ?- irmao(Irmao, _).

irma(Irma, Z) :- sao_irmaos(Irma, Z), mulher(Irma).
% ?- irma(Irma, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
os_tios(Tio, Sobrinho) :-
    sao_irmaos(Tio, Pai),
    progenitor(Pai, Sobrinho).
/*
tios(Tio, Sobrinho).
------------------------------------------------
Sobrinho = samuel,
Tio = joaquim
Sobrinho = sueli,
Tio = joaquim
Sobrinho = laura,
Tio = luisa
false
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tio(Tio, Sobrinho) :-
    sao_irmaos(Tio, Pai),
    progenitor(Pai, Sobrinho),
    homem(Tio).
/*
tio(Tio, Sobrinho).
------------------------------------------------
Sobrinho = samuel,
Tio = joaquim
Sobrinho = sueli,
Tio = joaquim
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tia(Tia, Sobrinho) :-
    sao_irmaos(Tia, Pai),
    progenitor(Pai, Sobrinho),
    mulher(Tia).
/*
tia(Tia, Sobrinho).
------------------------------------------------
Sobrinho = samuel,
Tio = joaquim
Sobrinho = sueli,
Tio = joaquim
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
os_primos(W, X) :-
    progenitor(Y, W),
    progenitor(Z, X),
    sao_irmaos(Y, Z).
/*
os_primos(Primo, PrimoDe).
------------------------------------------------
Primo = laura,
PrimoDe = samuel
Primo = laura,
PrimoDe = sueli
Primo = samuel,
PrimoDe = laura
Primo = sueli,
PrimoDe = laura
false

Problemas
- Os pares laura/samuel e laura/sueli se repetem são que invertidos.
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
primos(Primo) :-
    progenitor(ProgenitorX, Primo),
    progenitor(ProgenitorY, _),
    sao_irmaos(ProgenitorX, ProgenitorY),
    homem(Primo).
/*
primos(Primo).
Primo = samuel
false
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
primas(Prima) :-
    progenitor(ProgenitorX, Prima),
    progenitor(ProgenitorY, _),
    sao_irmaos(ProgenitorX, ProgenitorY),
    mulher(Prima).
/*
primas(Prima).
Prima = laura
Prima = laura
Prima = sueli
false

Problemas
- laura se repete
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avo(Avo, Neto) :- progenitor(Z, Neto), progenitor(Avo, Z).
% ?- avo(Avo, Neto).

avo_homem(Avo, Neto) :- avo(Avo, Neto), homem(Avo).
% ?- avo_homem(Avo, _).

avo_mulher(Avo, Neto) :- avo(Avo, Neto), mulher(Avo).
% ?- avo_mulher(Avo, _).


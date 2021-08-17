% PUNTO 1 
persona(Persona):-
    cree(Persona, _).

cree(gabriel, campanita).
cree(gabriel, elMagoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, elMagoCapria).
cree(macarena, campanita).

quiere(gabriel, suenio(ganarLoteria, [5,9])).
quiere(gabriel, suenio(futbolista, arsenal)).
quiere(juan, suenio(cantante, 100000)).
quiere(macarena, suenio(cantante, 10000)).

% Entraron en juego los functores en el predicado "quiere", que nos indica cual es el suenio que desean las personas

% PUNTO 2

esAmbiciosa(Persona):-
    persona(Persona),
    findall(Dificultad, dificultadDeSuenio(Persona, Dificultad), Lista),
    sumlist(Lista, Total),
    Total > 20.
    
dificultadDeSuenio(Persona, Dificultad):-
    quiere(Persona, Suenio),
    tipoSuenio(Suenio, Dificultad).

tipoSuenio(suenio(ganarLoteria, Numeros), Dificultad):-
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.
    

tipoSuenio(suenio(futbolista, arsenal), 3).

tipoSuenio(suenio(futbolista, aldosivi), 3).

tipoSuenio(suenio(futbolista, Equipo), 16):-
    Equipo \= arsenal,
    Equipo \= aldosivi.

tipoSuenio(suenio(cantante, Discos), 6):-
    Discos > 500000.

tipoSuenio(suenio(cantante, Discos), 4):-
    Discos =< 500000.

% PUNTO 3

tieneQuimica(Personaje, Persona):-
    cree(Persona, Personaje),
    requisitosPersonaje(Persona, Personaje).

requisitosPersonaje(Persona, campanita):-
    dificultadDeSuenio(Persona, Dificultad), 
    Dificultad < 5.

requisitosPersonaje(Persona, Personaje):-
    Personaje \= campanita,
    forall(quiere(Persona, Suenio), suenioPuro(Suenio)),
    not(esAmbiciosa(Persona)).

suenioPuro(suenio(futbolista, _)).

suenioPuro(suenio(cantante, Discos)):-
    Discos < 200000.

% PUNTO 4

esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrar(Personaje, Persona):-
    quiere(Persona, _),
    cree(_, Personaje),
    tieneQuimica(Personaje, Persona),
    personajeBackup(Personaje).

personajeBackup(Personaje):-
    not(estaEnfermo(Personaje)).

personajeBackup(Personaje):-
    esAmigo(Personaje, OtroPersonaje),
    personajeBackup(OtroPersonaje).
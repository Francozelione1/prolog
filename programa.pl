elecciones(2017).
elecciones(2019).

estudiantes(sistemas, 2019, juanPerez).
estudiantes(sistemas, 2019, unter).
estudiantes(sistemas, 2019, mathy).
estudiantes(sistemas, 2017, unter).
estudiantes(sistemas, 2017, mathy).
estudiantes(sistemas, 2017, raul).
estudiantes(sistemas, 2018, unter).

%votos(agosto29, 214, sistemas, 2017).
votos(franjaNaranja, 2000, sistemas, 2017).
votos(agosto29, 20000, sistemas, 2017).
votos(mayo, 15000, sistemas, 2017).

votos(franjaNaranja, 4, sistemas, 2019).
votos(agosto29, 504, sistemas, 2019).
votos(julio, 1100, sistemas, 2019).


%1
quienGano(Eleccion,Ganador):-
    elecciones(Eleccion),
    votos(Ganador, VotosGanador,_,Eleccion),
    forall(votos(_,Votos,_,Eleccion), VotosGanador >= Votos).
    

ganoPorAfano(AnioDeEleccion,PartidoGanador):-
    quienGano(AnioDeEleccion, PartidoGanador),
    votos(PartidoGanador,VotosGanador,_,AnioDeEleccion),
    votos(_,Votos,_,AnioDeEleccion),
    forall(votos(_,Votos,_,AnioDeEleccion) ,  (VotosGanador-Votos >= 500)).

/*ganoPorAfano(AnioDeEleccion,PartidoGanador):-
    quienGano(AnioDeEleccion, PartidoGanador),
    votos(PartidoGanador,VotosGanador,_,AnioDeEleccion),
    forall(votos(_,Votos,_,AnioDeEleccion) ,  (0 == VotosGanador-Votos)).

/*
sumar_lista(Lista, Suma) :-
    sumar_lista_aux(Lista, 0, Suma).
    
sumar_lista_aux([], Acumulador, Acumulador).
sumar_lista_aux([PrimerVino|Resto], AcumuladorParcial, Suma) :-
    vino(PrimerVino, _, PrecioVino),
    NuevoAcumulador is AcumuladorParcial + PrecioVino,
    sumar_lista_aux(Resto, NuevoAcumulador, Suma).

/*copiaxBaratax(Restaurante1,Restaurante2):-
    menu(Restaurante1, carta(_,_)),
    menu(Restaurante2, carta(_,_)),
    findall(X,menu(Restaurante1, carta(_,X)),PlatosPrimero),
    findall(Y,menu(Restaurante2, carta(_,Y)),PlatosSegundo),
    subset(PlatosPrimero, PlatosSegundo),
    findall(X,menu(Restaurante1, carta(X,_)),PrecioPlatosPrimero),
    findall(Y,menu(Restaurante2, carta(Y,_)),PrecioPlatosSegundo),
    sum_list(PrecioPlatosPrimero, TotalPlatosCopiados),
    sum_list(PrecioPlatosSegundo, TotalPlatosOriginales),
    TotalPlatosOriginales>TotalPlatosCopiados,
    restaurante(Restaurante1, MedallaCopiado, _),
    restaurante(Restaurante2, MedallaOriginal , _),
    MedallaOriginal>MedallaCopiado.

    
    5.	Cuál es el precio promedio de los menúes de cada restaurante, por persona. 
	En los platos, se considera el precio indicado ya que se asume que es para una persona.
	En los menú por pasos, el precio es el indicado más la suma de los precios de todos los vinos incluidos, 
    pero dividido en la cantidad de comensales. Los vinos importados pagan una tasa aduanera del 35% por sobre su precio publicado.


    
    

platosDeCartaRestaurante(Restaurante,Plato):-
    menu(Restaurante, carta(_,Plato)).*/
        
    

%2
ganaSiempreElMismo(Ganador):-
   votos(Ganador,_,_,_), 
   forall(quienGano(_,ElQueGano), Ganador == ElQueGano ).

%3
cantidadDeVotantes(Eleccion,CantEstudiantes):-
    elecciones(Eleccion),
    findall(X,estudiantes(_, Eleccion, X),Estudiantes),
    length(Estudiantes, CantEstudiantes).

cantidadDeVotosEleccion(Eleccion,Cantidad):-
    findall(X,votos(_,X,_,Eleccion), VotosRegistrados),
    sum_list(VotosRegistrados, Cantidad).
    
huboFraude(Eleccion):-
    cantidadDeVotantes(Eleccion,CantEstudiantes),
    cantidadDeVotosEleccion(Eleccion,Cantidad),
    Cantidad > CantEstudiantes.

%4
aniosFraude(ListaAnios):-
    findall(X,huboFraude(X), ListaAnios).

realizoAccion(franjaNaranja, lucha(salarioDocente)).
realizoAccion(franjaNaranja, gestionIndividual("Excepcion de correlativas", juanPerez, 2019)).
realizoAccion(agosto, gestionIndividual("hola", juan, 2020)).
realizoAccion(franjaNaranja, obra(2017)).
realizoAccion(franjaNaranja, obra(2020)).
realizoAccion(agosto29, lucha(salarioDocente)).
realizoAccion(agosto29, obra(2020)).
realizoAccion(agosto29, lucha(boletoEstudiantil)).
% 1 
gestionIndividual(gestionIndividual(_,_,_)).

esDemagogica(Partido):-
    realizoAccion(Partido,_),
    forall(realizoAccion(Partido,Accion), gestionIndividual(Accion)).
    
% 2
lucha(lucha(_)).

esBurocrata(Partido):-
    realizoAccion(Partido,_),
    forall(realizoAccion(Partido,Accion), not(lucha(Accion))).
    
% 3

obra(obra(_)).

accionGenuina(obra(Obra)):-
    realizoAccion(_,obra(Obra)),
    forall(elecciones(Anio), Obra \= Anio).

accionGenuina(gestionIndividual(_,Alumno,Aniox)):-
    alumnoRegular(Alumno, Aniox).

accionGenuina(lucha(_)).

alumnoRegular(juan, 2020).
alumnoRegular(juanPerez, 2019).

esTransparente(Partido):-
    realizoAccion(Partido,_),
    forall(realizoAccion(Partido,Accion), accionGenuina(Accion)).
    



/* quienGano(Eleccion,Ganador):-
    elecciones(Eleccion),
    votos(P1,Cant1,_,Eleccion),
    votos(P2,Cant2,_,Eleccion),
    P1 \= P2,
    Cant1 >= Cant2,
    Ganador = P1. */
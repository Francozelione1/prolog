% Hechos


tieneElemento(ana, agua).
tieneElemento(ana, vapor).
tieneElemento(ana, tierra).
tieneElemento(ana, hierro).
tieneElemento(beto, Elemento):-
    tieneElemento(ana,Elemento).
tieneElemento(cata, tierra).
tieneElemento(cata, agua).
tieneElemento(cata, aire).

elemento(pasto, [agua,tierra]).
elemento(hierro, [fuego,agua,tierra]).
elemento(huesos, [pasto,agua]).
elemento(presion, [hierro,vapor]).
elemento(vapor, [agua,fuego]).
elemento(play, [silicio, hierro, plastico]).
elemento(silicio, [tierra]).
elemento(plastico, [huesos,presion]).

esJugador(Jugador):-
    tieneElemento(Jugador,_).


herramienta(ana, circulo(50,3)).
herramienta(ana, cuchara(40)).
herramienta(beto, circulo(20,1)).
herramienta(beto, libro(inerte)).
herramienta(cata, libro(vida)).
herramienta(cata, circulo(100,5)).


tieneIngredientesPara(Jugador, ElementoDeseado):-
    tieneElemento(Jugador,_),
    elemento(ElementoDeseado,ListaDeElementosNecesarios),
    findall(X, tieneElemento(Jugador,X), ElementosJugador),
    subset(ListaDeElementosNecesarios, ElementosJugador).



estaCompuesto(Elemento, Elementos):-
    elemento(Elemento,Elementos).

estaVivo(agua).
estaVivo(fuego).
    
estaVivo(Elemento):-
    elemento(Elemento,CompuestoPor),
    member(agua, CompuestoPor).

estaVivo(Elemento):-
    elemento(Elemento,CompuestoPor),
    member(fuego, CompuestoPor).


%sirvePara(estaVivo(Elemento)):-
 %   herramienta(_,libro(vida)).

sirve(libro(vida), Elemento):-
    estaVivo(Elemento).

sirve(libro(inerte), Elemento):-
    elemento(Elemento,_),
    not(estaVivo(Elemento)).

sirve(herramienta(_,cuchara(Longitud)), Elemento):-
    elemento(Elemento,_),
    estaCompuesto(Elemento,ElementosCompuestos),
    length(ElementosCompuestos, Num),
    Num =< Longitud / 10.

    
    

/*Conocer las personas que puedeConstruir un elemento, para lo que se necesita tener los ingredientes ahora en el inventario y además contar con una
 o más herramientas que sirvan para construirlo. Para los elementos vivos sirve el libro de la vida 
(y para los elementos no vivos el libro inerte). Además, las cucharas y círculos sirven cuando soportan la cantidad de ingredientes del elemento 
(las cucharas soportan tantos ingredientes como centímetros de longitud/10, y los círculos alquímicos soportan tantos ingredientes como metros de diámetro * cantidad de niveles).
Por ejemplo, beto puede construir el silicio (porque tiene tierra y tiene el libro inerte, que le sirve para el silicio), pero no puede construir 
la presión (porque a pesar de tener hierro y vapor, no cuenta con herramientas que le sirvan para la presión). Ana, por otro lado, sí puede construir silicio y presión.*/

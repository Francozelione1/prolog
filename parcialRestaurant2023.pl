restaurante(panchoMayo, 2, barracas).
restaurante(finoli, 3, villaCrespo).
restaurante(superFinoli, 5, villaCrespo).
restaurante(noTanFinoli, 0, barracas).

menu(panchoMayo, carta(1400,hamburguesa)).
menu(panchoMayo, carta(1200, pancho)).
%menu(panchoMayo, carta(900, pancho)).
menu(finoli, carta(1500, pancho)).
menu(finoli, carta(2100, hamburguesa)).
%menu(finoli, carta(2000, hamburguesa)).
menu(finoli, pasos(4, 15000, [chateauMessi, francescoliSangiovese, susanaBalboaMalbec], 6)).
menu(noTanFinoli, pasos(2, 3000, [guinoPin, juanaDama],3)).
menu(finoli, platoDia(2000, fideos,60)).

vino( chateauMessi, francia, 5000).
vino( francescoliSangiovese, italia, 1000).
vino( susanaBalboaMalbec, argentina, 1200).
vino( christineLagardeCabernet, argentina, 5200).
vino( guinoPin, argentina, 500).
vino( juanaDama, argentina, 1000).

% menu (NOMBRE, pasos(PASOS, PRECIO, VINOSDISPONIBLES,CANTIDAD ESTIMADA DE GENTE QUE COMPARTE EL MENU))

estrellasPorBarrio(Barrio, Estrellas, Restaurante):-
    restaurante(Restaurante,EstrellasResto,Barrio),
    EstrellasResto > Estrellas.
   

restauranteSinEstrellas(restaurante(Restaurante,_,_)):-
    restaurante(Restaurante,0,_).


/* 3.	Si un restaurante está mal organizado, que es cuando tiene algún menú que tiene más pasos que la cantidad de vinos disponibles */

restauranteMalOrganizado(Restaurante):-
    menu(Restaurante, pasos(Pasos,_,VinosDisponibles,_)),
    length(VinosDisponibles, CantidadVinosDisponibles),
    Pasos > CantidadVinosDisponibles.


% o cuando tiene en su menú a la carta dos veces una misma comida con diferente precio.

restauranteMalOrganizado(Restaurante):-
    menu(Restaurante, carta(PrecioFijo, Comida)),
    menu(Restaurante, carta(Precio, Comida)),
    PrecioFijo \=Precio.
   
    
/* 4) Qué restaurante es copia barata de qué otro restaurante, lo que sucede cuando el primero tiene todos los platos a la carta 
que ofrece el otro restaurante, pero a un precio menor. Además, no puede tener más estrellas que el otro.   */



copiaBarataPlato(Restaurante1,Restaurante2,PlatoCopiado):-
    menu(Restaurante1, carta(Precio,PlatoCopiado)),
    menu(Restaurante2, carta(_,_)),
    restaurante(Restaurante1, MedallaCopiado,_),
    restaurante(Restaurante2, MedallaOriginal,_),
    MedallaOriginal > MedallaCopiado,
    forall(menu(Restaurante2, carta(Precio2,PlatoCopiado)), Precio2>Precio).

    
copiaBarata(Restaurante1,Restaurante2):-
    menu(Restaurante1, carta(_,_)),
    menu(Restaurante2, carta(_,_)),
    forall(menu(Restaurante1, carta(_,PlatoCopiado)), copiaBarataPlato(Restaurante1,Restaurante2,PlatoCopiado)).


precioPromedio(Restaurante,Precio):-
    menu(Restaurante, carta(Precio,_)).

precioPromedio(Restaurante,PrecioPromedio):-
    menu(Restaurante,pasos(_,_,_,_)),
    findall(Precio, menu(Restaurante, pasos(_,Precio,_,_)), ListaPrecios),
    findall(Vinos, menu(Restaurante, pasos(_,_,Vinos,_)), VinosIncluidos),
    findall(Personas, menu(Restaurante, pasos(_,_,_,Personas)), ListaPersonas),
    findall(PrecioVinos,totalDeVinos(VinosIncluidos,PrecioVinos),ListaTotalDeVinos),
    totalDeVinos(ListaTotalDeVinos, TotalVinos),
    sumlist(ListaPrecios, TotalPrecios),
    sumlist(ListaPersonas,TotalPersonas),
    PrecioPromedio is ((TotalPrecios + TotalVinos) / TotalPersonas).



totalDeVinos([],0).
totalDeVinos([PrimerVino|Resto],PrecioFinal):-
    precioVino(PrimerVino, PrecioVino),
    totalDeVinos(Resto,Precio),
    PrecioFinal is Precio + PrecioVino.

precioVino(Vino, PrecioFinal):-
    vino(Vino,Nacionalidad,PrecioVino),
    Nacionalidad \= argentina,
    PrecioFinal is PrecioVino * 1.35.

precioVino(Vino,PrecioFinal):-
    vino(Vino,Nacionalidad,PrecioVino),
    Nacionalidad == argentina,
    PrecioFinal is PrecioVino.





precioPromedio(Restaurante,PrecioPromedio):-
   menu(Restaurante, platoDia(_,_,_)).

precioSegunTiempo(Plato,PrecioFinal):-
    menu(_, platoDia(Precio,Plato,Tiempo)),
    Tiempo > 60,
    PrecioFinal is Precio.

precioSegunTiempo(Plato,PrecioFinal):-
    menu(_, platoDia(Precio,Plato,Tiempo)),
    Tiempo < 60,
    PrecioFinal is (Precio*0.5).
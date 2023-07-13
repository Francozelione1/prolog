/*Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que el sombrero lo mande a Slytherin.
Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que el sombrero lo mande a Hufflepuff.
Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna casa a la que odiaría ir

Para Gryffindor, lo más importante es tener coraje.
Para Slytherin, lo más importante es el orgullo y la inteligencia.
Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
Para Hufflepuff, lo más importante es ser amistoso.


Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago 
y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura.
*/

mago(harry, sangreMestiza).
mago(draco, sangrePura).
mago(hermione, sangreImpura).
mago(nico, sangrePura).

caracteristica(harry, coraje).
caracteristica(harry, amistad).
caracteristica(harry, orgullo).
caracteristica(harry, inteligencia).
caracteristica(nico, coraje).
caracteristica(nico, amistad).
caracteristica(nico, orgullo).
caracteristica(nico, inteligencia).
caracteristica(draco, inteligencia).
caracteristica(draco, orgullo).
caracteristica(hermione, inteligencia).
caracteristica(hermione, orgullo).
caracteristica(hermione, responsabilidad).

odiaria(harry, slytherin).
odiaria(draco, hufflepuff).
odiaria(nico, slytherin).


importante(gryffindor, coraje).
importante(slytherin, orgullo).
importante(slytherin, inteligencia).
%importante(ravenclaw, inteligencia).
%importante(ravenclaw, responsabilidad).
importante(hufflepuff, amistad).

/* 
Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago 
y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura. 

Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características
incluyen todo lo que se busca para los integrantes de esa casa, independientemente de si la casa le permite la entrada. 

Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter adecuado para la casa, 
la casa permite su entrada y 
además el mago no odiaría que lo manden a esa casa. 
Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer encontró una forma de hackear al sombrero.

Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y 
cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.*/

permiteEntrar(Mago,slytherin):-
    mago(Mago,Sangre),
    Sangre \= sangreImpura.

permiteEntrar(Mago,Casa):-
    importante(Casa,_),
    mago(Mago,_),
    Casa \= slytherin. 

caracteristicasDeUnMago(Mago,Caracteristicas):-
    mago(Mago,_),
    findall(Caracteristica, caracteristica(Mago,Caracteristica), Caracteristicas).
     
caracteristicasDeUnaCasa(Casa,Caracteristicas):-
    importante(Casa,_),
    findall(Caracteristica, importante(Casa,Caracteristica), Caracteristicas).

caracterApropiado(Mago,Casa):-
    importante(Casa,_),
    caracteristica(Mago,_),
    caracteristicasDeUnMago(Mago,CaracteristicasMago),
    caracteristicasDeUnaCasa(Casa,CaracteristicasDeUnaCasa),
    subset(CaracteristicasDeUnaCasa, CaracteristicasMago).

quedarSeleccionado(Mago,Casa):-
    mago(Mago,_),
    importante(Casa,_),
    caracterApropiado(Mago,Casa),
    permiteEntrar(Mago,Casa),
    not(odiaria(Mago, Casa)).
    

quedarSeleccionado(hermione,gryffindor).

cadenaDeAmistades([_]).
cadenaDeAmistades([Mago1,Mago2|Resto]):-
    caracteristica(Mago1, amistad),
    caracteristica(Mago2, amistad),
    permiteEntrar(Mago2,Casa2),
    permiteEntrar(Mago1,Casa2),
    cadenaDeAmistades([Mago2|Resto]).

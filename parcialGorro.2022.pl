% Hechos

% BASICAS
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico ).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).

% SEGURIDAD
necesidad(integridadFisica, seguridad).
necesidad(salud, seguridad).
necesidad(empleo, seguridad).

% SOCIAL
necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).


% RECONOCIMIENTO
necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).

% AUTOREALIZACION
necesidad(relacion, autorrealizacion).

% PLACER
necesidad(recreacion, placer).


nivelSuperior(placer, autorrealizacion).
nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).


separacionEntre(Necesidad1,Necesidad2, Separacion):-
    necesidad(Necesidad1,NivelA),
    necesidad(Necesidad2,NivelB),
    separacionNiveles(NivelA, NivelB, Separacion).

separacionNiveles(NivelA,NivelA, 0).
separacionNiveles(NivelA,NivelB,Separacion):-
    nivelSuperior(NivelB,NivelInferior),
    separacionNiveles(NivelA,NivelInferior,SeparacionPrevia),
    Separacion is SeparacionPrevia + 1.



%necesita(carla, alimentacion).
%necesita(carla, descanso).
necesita(carla, empleo).

%necesita(carla, exito).
necesita(juan, afecto).
%necesita(juan, exito).
necesita(roberto, amistad).
necesita(charly,afecto).

%4

necesidadDeMayorJerarquia(Persona, Necesidad):-
    necesita(Persona,Necesidad),
    gradoNecesita(Persona,Necesidad,Grado1),
    forall(gradoNecesita(Persona,_,Grado2), (Grado2>=Grado1) ).
    

gradoNecesita(Persona, Necesidad, Grado):-
    necesidad(Necesidad,Nivel),
    necesita(Persona,Necesidad),
    separacionNiveles(Nivel,placer,Grado).

/*  Saber si una persona pudo satisfacer por completo algún nivel de la pirámide.
Por ejemplo, Juan pudo satisfacer por completo el nivel fisiologico.
gradoNecesidad(Necesidad,Grado):-
    necesidad(Necesidad,Nivel),
    separacionNiveles(Nivel,placer,Grado).

 */


satisfajoTodoElNivel(Persona,Nivel):-
    necesita(Persona,_),
    necesidad(_,Nivel),
    forall(necesita(Persona,Necesidad), not(necesidad(Necesidad, Nivel))).

maximoNivelSatisfecho(Persona,Nivel):-
    necesita(Persona,_),
    satisfajoTodoElNivel(Persona,Nivel),
    gradoNecesita(Persona,_, Nivel),
    necesidadDeMayorJerarquia(Persona,Necesidad),
    gradoNecesita(Persona,Necesidad, NivelX),
    Nivel>=NivelX.
    
    

satisfaceTeoria(Persona):-
    necesita(Persona,_),
    necesidadDeMayorJerarquia(Persona,Necesidad),
    gradoNecesita(Persona,Necesidad,GradoDeMayorNecesidad),
    forall(gradoNecesita(Persona, _, Grado), GradoDeMayorNecesidad>=Grado).
    
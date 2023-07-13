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

necesidad(descanso, fisiologico).
necesidad(confianza, reconocimiento).


nivelSuperior(placer, autorrealizacion).
nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).


separacionEntre(NecesidadA,NecesidadB,Separacion):-
    necesidad(NecesidadA,NivelA),
    necesidad(NecesidadB,NivelB),
    separacionNiveles(NivelA,NivelB,Separacion).


separacionNiveles(Nivel,Nivel,0).
separacionNiveles(NivelA,NivelB,Separacion):-
    nivelSuperior(NivelB,NivelIntermedio),
    separacionNiveles(NivelA,NivelIntermedio,SepAnterior),
    Separacion is SepAnterior + 1.

/*  Carla necesita alimentarse, descansar y tener un empleo. 
Juan no necesita empleo pero busca alguien que le brinde afecto. Se anotó en la facu porque desea ser exitoso. 
Roberto quiere tener un millón de amigos. 
Manuel necesita una bandera para la liberación, no quiere más que España lo domine ¡no señor!.
Charly necesita alguien que lo emparche un poco y que limpie su cabeza.
  */

%necesita(juan, afecto).
necesita(juan, exito).
necesita(juan, confianza).
necesita(juan, respeto).
necesita(roberto, amistad).
necesita(manuel, libertad).
necesita(charly, afecto).
necesita(franco, alimentacion).



jerarquiaMayor(Persona, Necesidad):-
    jerarquiaNecesidad(Persona, Necesidad ,JerarquiaMayor),
    forall(jerarquiaNecesidad(Persona,_,Jerarquia), JerarquiaMayor>= Jerarquia).
    

nivelBasico(NivelBasico):-
    nivelSuperior(_,NivelBasico),
    not(nivelSuperior(NivelBasico, _)).

jerarquiaNecesidad(Persona,Necesidad,Jerarquia):-
    necesita(Persona,Necesidad),
    necesidad(Necesidad,Nivel),
    nivelBasico(NivelBasico),
    separacionNiveles(NivelBasico,Nivel, Jerarquia).
    
necesidadesPorNivel(Necesidad,Nivel):-
    necesidad(Necesidad,Nivel).
    
necesidadesPorPersona(Persona,Necesidades):-
    findall(X,necesita(Persona,X), Necesidades).
    
satisfaceUnNivel(Persona,Nivel):-
    necesidadesPorPersona(Persona, Necesidades),
    necesidadesPorNivel(_,Nivel),
    forall(necesidadesPorNivel(Necesidad,Nivel), not(member(Necesidad, Necesidades))).

    

  /*  
  jerarquiaNecesidad(Persona,Necesidad,Jerarquia):-
    necesita(Persona,Necesidad),
    necesidad(Necesidad,Nivel),
    nivelBasico(NivelBasico),
    separacionNiveles(NivelBasico,Nivel,Jerarquia).
  */  
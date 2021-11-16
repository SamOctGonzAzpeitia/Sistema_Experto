/*
Samuel OCtavio Gonzalez Azpeitia
A01704696
Proyecto Final 
Sistema experto en prolog que es un test vocacional
*/


:- use_module(library(pce)).
:- use_module(library(pce_style_item)).

main:-
	new(Menu, dialog('Sistema experto vocacional', size(500,500))),
	new(L, label(nombre, 'Bienvenidos a su test vocacional')),
	new(@texto, label(nombre, 'Segun la respuestas dadas tendra su resultado:')),
	new(@respl, label(nombre, '')),
	new(Salir, button('Salir', and(message(Menu,destroy), message(Menu, free)))),
	new(@boton, button('Realizar test', message(@prolog, botones))),
	send(Menu, append(L)), new(@btncarrera, button('¿Vocacion?')),
	send(Menu,display,L,point(100,20)),
	send(Menu,display,@boton,point(130,150)),
	send(Menu,display,@texto,point(50,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

vocaciones(ingenieria):- ingenieria,!.
vocaciones(medicina):- medicina,!.
vocaciones(leyes):-leyes,!.
vocaciones(sociales):-sociales,!.
vocaciones(artes):-artes,!.
vocaciones(administracion):-administracion,!.
vocaciones('No estoy entrenado para apoyarte').


ingenieria :-
	quiere_ingenieria,
	pregunta('¿Le gusta resolver problemas?'),
	pregunta('¿Le gustan las matemáticas?'),
	pregunta('¿Le gusta manejar equipos?'),
	pregunta('¿Considera que tiene capacidad de analisis?'),
	pregunta('¿Tienes habilidades manuales?'),
	pregunta('¿Facilidad para trabajo en equipo?'),
	pregunta('¿Tiene capacidad de innovación?').

medicina :-
	quiere_medicina,
	pregunta('¿Le gusta leer?'),
	pregunta('¿Se considera empático?'),
	pregunta('¿Le interesa la investigación?'),
	pregunta('¿Puede trabajar bajo presión?'),
	pregunta('¿Se considera paciente y dedicado?'),
	pregunta('¿Tiene un alto nivel de responsabilidad?').

leyes :-
	quiere_leyes,
	pregunta('¿Tiene el don para convencer?'),
	pregunta('¿Sabe negociar?'),
	pregunta('¿Se considera fuerte emocionalmente?'),
	pregunta('¿Es bueno argumentando?'),
	pregunta('¿Tiene buenas habilidades comunicativas?'),
	pregunta('¿Se considera ordenado?').

sociales :-
	quiere_sociales,
	pregunta('¿Le gusta leer?'),
	pregunta('¿Le interesa la sociedad y las personas?'),
	pregunta('¿Le interesa la política ?'),
	pregunta('¿Tiene buenas habilidades comunicativas?'),
	pregunta('¿Es critico a la hora de analizar situaciones?').

artes :-
	quiere_artes,
	pregunta('¿Tiene facilidad para imaginar?'),
	pregunta('¿Tiene habilidades motrices?'),
	pregunta('¿Considera que tiene pensamiento abstracto?'),
	pregunta('¿Tiene intgeligencia corporal?'),
	pregunta('¿Habilidades y destrezas manuales?').

administracion :-
	quiere_administracion,
	pregunta('¿Maneja bien sus tiempos?'),
	pregunta('¿Le gustan los negocios?'),
	pregunta('¿Habilidad para trabajar en equipo?'),
	pregunta('¿Se considera proactivo?'),
	pregunta('¿Considera que tiene pensamiento estrategico?').


%desconocido :- se_desconoce_vocacion.

quiere_ingenieria:-	pregunta('¿Le gusta resolver problemas?').
quiere_medicina:-	pregunta('¿Le gusta leer?').
quiere_leyes:-		pregunta('¿Tiene el don para convencer?').
quiere_sociales:-	pregunta('¿Le gusta leer?').
quiere_artes:-	pregunta('¿Maneja bien sus tiempos?').
quiere_administracion:-	pregunta('¿Presenta temblor en alguna de las extremidades superiores del cuerpo?').

:-dynamic si/1,no/1.


preguntar(Problema):-new(Di, dialog('Examen Vocacional')),
	new(L2, label(texto,'Responde las siguientes preguntas')),
	new(La, label(prob,Problema)),

	new(B1,button(si,and(message(Di,return,si)))),
	new(B2,button(no,and(message(Di,return,no)))),

	send(Di,append(L2)),
	send(Di,append(La)),
	send(Di,append(B1)),
	send(Di,append(B2)),

	send(Di,default_button,si),
	send(Di,open_centered),
	get(Di,confirm,Answer),
	write(Answer),send(Di,destroy),


	((Answer==si)->assert(si(Problema)); assert(no(Problema)),fail).

pregunta(S):- (si(S)->true; (no(S)->fail;preguntar(S))).
limpiar:- retract(si(_)),fail.
limpiar:- retract(no(_)),fail.
limpiar.


botones :-lim,
	send(@boton,free),
	send(@btncarrera,free),
	vocaciones(Enter),
	send(@texto, selection('De acuerdo con sus respuestas,usted es apto para:')),
	send(@respl, selection(Enter)),
	new(@boton, button('Iniciar su evaluación', message(@prolog, botones))),
	send(Menu,display,@boton,point(40,50)),
	send(Menu,display,@btncarrera,point(20,50)),
	limpiar.

lim:- send(@respl, selection('')).

limpiar2:-
	send(@texto,free),
	send(@respl,free),

	send(@boton,free).
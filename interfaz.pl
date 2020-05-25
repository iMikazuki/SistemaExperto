% declaracion de librerias

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
:-consult('hechos.pl').
:-pce_image_directory('./img').
resource(logo1,image,image('logo1.jpeg')).
resource(logo2,image,image('logo2.jpg')).
resource(logo3,image,image('logo3.jpg')).

% --------------------------PARA EL MENU PRINCIPAL------------------------------------
correr:-
    new(D, dialog),
    new(W,  window('CLAO EQUIPO 17', size(700, 250))),
    new(Imagen,label(icon,resource(logo1))),

    new(BtnIni,button('Consulta Nueva',and(message(@prolog,usuario)))),
    new(BtnAdqui,button('Modulo de Adquisicion',and(message(@prolog,moduloAdqui)))),
    new(BtnSalir,button('Salir',message(W,destroy ))),
    
    send(D, below, W),
    send(W,display,Imagen,point(0,0)),
    send_list(D,append,[BtnIni,BtnAdqui,BtnSalir]),
    send(D, open_centered).


% ---------------------------------------------------------------------------------------


% --------------------------PARA LA INTERFACE USUARIO--------------------------------- 


usuario:-
	new(D, dialog),
	new(W,  window('Preguntas', size(750, 500))),
		
	% SON LAS 4 PREGUNTAS GENERALES EN ETIQUETAS

	new(T,label(nombre,'Elija las opciones para recibir un consejo:')),
	new(P1,label(nombre,'1. Seleccione para quien va dirigido')),
	new(P2,label(nombre,'2. En que estado considera que esta el objeto/animal?')),
	new(P3,label(nombre,'3. Cuanto tiempo tiene el objeto/animal?')),
	new(P4,label(nombre,'4. Entre el 1 y 4, Cuanto estima el objeto/animal?')),
	new(Imagen3,label(icon,resource(logo3))),

		new(CmbTipo,menu('Tipo:',cycle)),
		send_list(CmbTipo,append,['Animal','Objeto']),

		new(CmbEstado,menu('Estado:',cycle)),
		send_list(CmbEstado,append,['Bueno/Perfecto','Regular','Malo/Enfermo']),

		new(CmbEdad,menu('Edad:',cycle)),
		send_list(CmbEdad,append,['Menos de 1 año','Entre 1 y 3 años','Entre 3 y 6 años','Mas de 6 años']),

		new(CmbEstima,menu('Estima:',cycle)),
		send_list(CmbEstima,append,['1','2','3','4']),
				
			send(D, below, W),
		
			send(W,display,T,point(40,15)),
		
			send(W,display,P1,point(40,40)),
			send(W,display,CmbTipo,point(40,65)),

			send(W,display,P2,point(40,100)),
			send(W,display,CmbEstado,point(40,125)),

			send(W,display,P3,point(40,160)),
			send(W,display,CmbEdad,point(40,185)),

			send(W,display,P4,point(40,220)),
			send(W,display,CmbEstima,point(40,245)),

			send(W,display,Imagen3,point(420,158)),

		
	new(BtnAceptar,button('Aceptar',and(message(@prolog,buscarArticulo,CmbTipo?selection,CmbEstado?selection,CmbEdad?selection,CmbEstima?selection), message(W, destroy)))),
	
	send(D,display,BtnAceptar,point(350,10)),

			send(D, open_centered),
			!.


% ----------------------------------------------------------------------------------------
% ----------------------AQUI ES DONDE SE BUSCA--------------------------------------------

buscarArticulo(A, B, C, D) :- 
	articulo(Articulo), 
	tipo(Articulo, A),
	estado(Articulo, B), 
	edad(Articulo, C), 
	estima(Articulo, D), 
	imagen(Articulo, Imagen),  
	descripcion(Articulo, Resultado), 
	resp(Resultado, Imagen).
							
	resp(R, I):-   
	new(D, dialog), 
	new(W,  window('Recomendacion', size(750, 500))), 
	new(R0,label(nombre,'Con base a la informacion obtenida le recomendamos:')),
	new(BtnAceptar,button('Explicacion',(message(@prolog,expli,R)))),

	new(R1,label(nombre,R)), 
	send(W,display,R0,point(40,15)),
	send(W,display,R1,point(40,55)), 
	send(D,display,BtnAceptar,point(300,10)),
	send(W, display, bitmap(I), point(10,70)),
	send(D, below, W),
	send(D, open_centered).


% ----------------------------------------------------------------------------------------
% ----------------------MODULO EXPLICACION--------------------------------------------

expli(A):- 
	descripcion(Articulo,A), 
	explicacion(Articulo,Resp),

    new(D, dialog),
    new(W,  window('Explicacion', size(700, 250))),
    
	new(R3,label(nombre,Resp)),
	send(W,display,R3,point(40,55)),  
    send(D, below, W),
    send(D, open_centered).


%-----------------------------------------------------------------------------------------
% --------------------------PARA EL MODULO DE ADQUISICION---------------------------------

moduloAdqui:-


	new(D, dialog),
	new(W,  window('Preguntas', size(750, 500))),
		
	% SON LAS 6 PREGUNTAS GENERALES EN ETIQUETAS
	new(Imagen2,label(icon,resource(logo2))),
	new(T,label(nombre,'Elija las opciones para poner una nueva entrada:')),
	new(P1,label(nombre,'1. Seleccione para quien va dirigido')),
	new(P2,label(nombre,'2. En que estado considera que esta el objeto/animal?')),
	new(P3,label(nombre,'3. Cuanto tiempo tiene el objeto/animal?')),
	new(P4,label(nombre,'4. Entre el 1 y 4, Cuanto estima el objeto/animal?')),
	new(P5,label(nombre,'5. Introduzca el nombre de la variable(articulo)')),
	new(TxtVariable,text_item('Nombre de la variable')),
	new(P6,label(nombre,'6. Introduzca una descripcion de la respuesta:')),
	new(TxtDescrip,text_item('Descripcion:')),
	new(P7,label(nombre,'7. Introduzca la explicacion de la respuesta:')),
	new(TxtExpli,text_item('Explicacion:')),
	new(P8,label(nombre,'8. Introduzca Numero de la img:')),
	new(TxtIMG,text_item('Imagen:')),

		new(CmbTipo,menu('Tipo:',cycle)),
		send_list(CmbTipo,append,['Animal','Objeto']),

		new(CmbEstado,menu('Estado:',cycle)),
		send_list(CmbEstado,append,['Bueno/Perfecto','Regular','Malo/Enfermo']),

		new(CmbEdad,menu('Edad:',cycle)),
		send_list(CmbEdad,append,['Menos de 1 año','Entre 1 y 3 años','Entre 3 y 6 años','Mas de 6 años']),

		new(CmbEstima,menu('Estima:',cycle)),
		send_list(CmbEstima,append,['1','2','3','4']),
					
			send(D, below, W),
		
			send(W,display,T,point(40,15)),
		
			send(W,display,P1,point(40,40)),
			send(W,display,CmbTipo,point(40,65)),

			send(W,display,P2,point(40,100)),
			send(W,display,CmbEstado,point(40,125)),

			send(W,display,P3,point(40,160)),
			send(W,display,CmbEdad,point(40,185)),

			send(W,display,P4,point(40,220)),
			send(W,display,CmbEstima,point(40,245)),

			send(W,display,P5,point(40,280)),
			send(W,display,TxtVariable,point(40,305)),

			send(W,display,P6,point(40,340)),
			send(W,display,TxtDescrip,point(40,365)), 

			send(W,display,P7,point(40,400)),
			send(W,display,TxtExpli,point(40,425)), 

			send(W,display,P8,point(380,40)),
			send(W,display,TxtIMG,point(380,65)),

			send(W,display,Imagen2,point(420,158)),
	
		new(BtnAceptar,button('Aceptar',and(message(@prolog,guardarNuevo,CmbTipo?selection,CmbEstado?selection,CmbEdad?selection,CmbEstima?selection, TxtVariable?selection, TxtDescrip?selection, TxtExpli?selection, TxtIMG?selection), message(W, destroy)))),
			
	send(D,display,BtnAceptar,point(300,10)),

			send(D, open_centered), !.


% --------------------------------------------------------------------------------------- 


guardarNuevo(A, B, C, D, X, Z, Y, I) :-
	assert(articulo(X)), 
	assert(tipo(X, A)), 
	assert(estado(X, B)), 
	assert(edad(X, C)), 
    assert(estima(X, D)),
	assert(descripcion(X, Z)), 
	assert(explicacion(X, Y)),
	atom_concat(I, '.jpg', I2), 
	assert(imagen(X,I2)).


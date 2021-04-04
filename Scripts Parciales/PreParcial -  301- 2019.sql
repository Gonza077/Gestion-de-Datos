

/*1) (1,5 pts) Listar todos los organizadores que organizaron un evento este año y no el año pasado.*/

SELECT org.dni_persona, per.nombre, per.apellido 
	FROM organizador org 
    INNER JOIN persona per 
		ON per.dni = org.dni_persona
	INNER JOIN evento eve 
		ON org.nro_evento = eve.nro_evento
	WHERE year(eve.fecha_hora_inicio) = year(now()) /*FECHA DE INICIO SEA IGUAL A 2019*/
		AND org.dni_persona NOT IN (SELECT org.dni_persona 
									FROM organizador org  /* OBTENGO TODOS LOS DNI DE LAS PERSONAS QUE FUERON ORGANIZADORES EN 2018*/
                                    INNER JOIN evento eve 
										ON org.nro_evento = eve.nro_evento
									WHERE year(fecha_hora_inicio) = '2018');  /*BUSCO LOS DNI DE LOS ORG QUE NO ESTAN DENTRO DE LOS QUE ORGANIZARON EVENTOS EN 2018*/

	
/*2) (2pts) Indicar lugares que se hayan utilizado en menos de 10 eventos durante este año. 
Mostrar: datos del lugar, la cantidad de eventos que se utilizo, si algun lugar nunca se utilizo indicar 0*/

SELECT lug.nombre, lug.direccion, ifnull(count(eve.nro_evento),0) 'Cantidad de eventos' 
	FROM lugar lug
    LEFT JOIN espectaculo esp
		ON lug.codigo = esp.codigo_lugar
	LEFT JOIN evento eve 
		ON esp.nro_evento = eve.nro_evento AND year(eve.fecha_hora_inicio) = '2019' AND eve.fecha_hora_inicio < NOW()
	GROUP BY 1,2
    HAVING count(eve.nro_evento) < 10;
    
/*Comentarios:
	1-Cuando en el enunciado diga listar todos los ... , y sino nunca se utilizo indicar "0" o "Sin asignar" Se debe usar LEFT JOIN O 
		RIGHT JOIN (depende como quede posicionada la tabla q vamos a joinear)
	2-Cuando usamos group by, todos los atributos que esten en el select y no sean funciones de grupo, deben estar en el group by.
		funciones de grupo: max(), avg(), sum(),count(), etc  en este caso el select tiene 3 atributos, 
		el count es de grupo por la tanto en mi group by van a quedar los otros dos atributos.
	3- HAVING es el where para los grupos. En este caso quiero q me muestre solo los grupos que en la "cantidad de eventos" sean menores a 10.*/
    
    
/*3) (2pts) Se desea conocer el o los espectaculos mas costosos en el ultimo año.*/    

SELECT MAX(costo_cont) INTO @precioMax
	FROM espectaculo
    WHERE year(fecha_hora_inicio) = '2019' AND fecha_hora_inicio < now();
SELECT nro_espectaculo, nombre, costo_cont
	FROM espectaculo
    WHERE costo_cont = @precioMax;

/*Comentarios: 
	1-Pensar bien al usar una variable, ya que solo se puede guardar un dato. no se puede guardar una tupla de registros.
		Se usa para guardar un maximo, minimo, promedio, etc
	2-Cuando trabajamos con fechas recordar validar que sean menor a la fecha actual. ej: year(fecha)=2019 AND fecha < now()
*/


/*5) (1,5pts) Se desea conocer el total de dinero gastado en recursos para cada
		evento. Calcular valor del recursos con los precios actuales*/

DROP TEMPORARY TABLE IF EXISTS tt_maxValores;
CREATE TEMPORARY TABLE tt_maxValores
SELECT codigo_recurso, max(fecha_desde) 'FechaMaxima' /*CREO LA TABLA TEMPORAL CON LA FECHA MAXIMA PARA CADA CODIGO.*/
	FROM valor_diario 
    where max(fecha_desde) <= now()
    GROUP BY 1;
    
SELECT eve.nro_evento, eve.descripcion, sum(alq.cantidad * vd.valor)
	FROM evento eve
	INNER JOIN alquiler alq ON eve.nro_evento = alq.nro_evento
	INNER JOIN valor_diario vd ON alq.codigo_recurso = vd.codigo_recurso
	INNER JOIN tt_maxValores tt ON vd.codigo_recurso = tt.codigo_recurso
	WHERE tt.FechaMaxima = vd.fecha_desde
    GROUP BY 1,2;
    
/*STORE PROCEDURE EJERCICIO 6*/

CALL ParticipacionesArtista('20-2115151-2');


CREATE DEFINER=`root`@`localhost` PROCEDURE `ParticipacionesArtista`(IN varCuit VARCHAR(30))
BEGIN

DROP TEMPORARY TABLE IF EXISTS tt_ParticipacionesArtista;

CREATE TEMPORARY TABLE tt_ParticipacionesArtista
SELECT art.cuit, art.nombre_comercial, art.descripcion 'DescripcionArtista', eve.descripcion 'DescripcionEvento', esp.nro_espectaculo, lug.nombre, eve.fecha_hora_inicio 'FechaEvento'
	FROM artista art
	INNER JOIN espectaculo esp
		ON art.cuit = esp.cuit_artista
	INNER JOIN evento eve
		ON esp.nro_evento = eve.nro_evento
    INNER JOIN lugar lug
		ON lug.codigo = esp.codigo_lugar
    WHERE art.cuit = varCuit;

SELECT * FROM tt_ParticipacionesArtista
WHERE year(FechaEvento) = 2019 AND FechaEvento < now(); 
    
END
    
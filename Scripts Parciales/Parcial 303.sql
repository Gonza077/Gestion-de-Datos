# Parcial 303
 
/* 1. De los artistas registrados listar sus datos y la cantidad de espectáculos en los que hayan
participado. De aquellos artistas que no hayan participado en ningún espectáculo indicar 0. */

select art. cuit, art.nombre, art.apellido, art.nombre_comercial,count(esp.nro_espectaculo) Participó
from artista art 
left join espectaculo esp on esp.cuit_artista=art.cuit
group by 1,2,3;

/* 2. De las personas que hayan participado en competencias listar aquellas que hayan salido más
de una vez entre los tres primeros puestos. Indicar datos de las personas y cantidad de veces en que el
puesto haya sido uno de los tres primeros. */

select pa.dni_persona, pe.nombre, pe.apellido, count(pa.puesto) Ganados
from participante pa
inner join persona pe on pe.dni=pa.dni_persona
where pa.puesto <= 3
group by pa.dni_persona
having Ganados >= 2;


/* 3. Listar los tipos de competencias que se realizaron el año pasado pero no este año. Indicar
Código y Descripción del Tipo de Competencia. */ listadoEventos

select tc.codigo, tc.descripcion, com.fecha_hora_ini
from competencia com
inner join tipo_competencia tc on tc.codigo=com.codigo_tipo_competencia
where year(com.fecha_hora_ini)=2018 and com.codigo_tipo_competencia not in(
																	select com.codigo_tipo_competencia
																	from competencia com
																	where year(com.fecha_hora_ini)=2019);
                                                
/* 4. Listar los recursos cuyo valor actual supere al promedio de los valores actuales. Indicar:
Código, descripción del recurso, valor actual y diferencia con el promedio de los valores actuales */
drop temporary table factual;
create temporary table factual(
select vd.codigo_recurso, max(vd.fecha_desde) fmax
from recurso r
inner join valor_diario vd on vd.codigo_recurso=r.codigo
group by 1);

drop temporary table vactual;
create temporary table vactual(
select vd.codigo_recurso, vd.valor
from valor_diario vd
inner join factual on vd.codigo_recurso=factual.codigo_recurso and vd.fecha_desde=factual.fmax);

select avg(va.valor)into @promactual
from vactual va;

select va.codigo_recurso, r.descripcion, va.valor, truncate(va.valor - @promactual,2) Diferencia
from recurso r
inner join vactual va on va.codigo_recurso=r.codigo
where va.valor > @promactual;

/* 5. Crear el evento “Día de la Madre 2019” con los mismos datos del Evento “Día de la Madre
2018” (considerar que la fecha este año es el 20/10/2019). Los espectáculos serán los mismos que los
del año 2018 */
start transaction;
select max(nro)+1 into @maxid from evento;

insert into evento (nro,descripcion,fecha_hora_ini,fecha_hora_fin)
	select @maxid,"Dia de la madre 2019", concat("2019-10-20"," ",time(fecha_hora_ini)),fecha_hora_fin
	from evento e where e.descripcion="concierto pop";

select distinct nro into @nro 
from evento e 
where e.descripcion="concierto pop";

insert into espectaculo(nro_evento,nro_espectaculo,nombre,fecha_hora_ini,fecha_hora_fin,costo_cont,cuit_artista,codigo_lugar)
	select @maxid,nro_espectaculo,nombre,fecha_hora_ini,fecha_hora_fin,costo_cont,cuit_artista,codigo_lugar 
    from espectaculo esp
    where esp.nro_evento=@nro;
	rollback;
select * from evento;
select * from espectaculo;

/* 6. Listar los lugares y la cantidad de espectáculos que se hayan realizado allí en un año en
particular. La cantidad de espectáculos debe calcularse en una función creada a tal efecto que reciba el
código del lugar y el año que se quiera listar. */

select lu.codigo, lu.direccion, cantespec(lu.codigo, 2019)
from lugar lu;




/* ejemplo de update */
start transaction;
update artista
set telefono='4382888'
where cuit='30-1111-4';
rollback;
select * from artista;

start transaction;
insert into artista(cuit,descripcion,email,actividad,nombre_comercial)
values('21-0092-4','ejemplo', 'ejemplo@gmail.com', 'musical', 'ejemplo');
rollback;





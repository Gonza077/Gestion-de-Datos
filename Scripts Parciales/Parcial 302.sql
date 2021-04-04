/* 1. Mostrar los tipos de competencias de los cuales haya sido jurado la
persona "Maria Lopez" y no haya sido nunca jurado la persona "Juan Perez" (los
nombres son ejemplos) */

select j.dni into @dni1
from jurado j
where j.nombre='Maria' and j.apellido='Lopez';

select j.dni into @dni2
from jurado j
where j.nombre='Juan' and j.apellido='Perez';

select com.codigo_tipo_competencia
from competencia com
inner join jurado j 
where j = @dni1 and com.codigo_tipo_competencia not in(select com.codigo_tipo_competencia
														from competencia com
                                                        where com.dni_jurado=@dni2);


/* 2. Recursos donde su valor actual supere al promedio de valores actuales,
indicando codigo, descripcion y valor */

drop temporary table if exists factual;
create temporary table factual(
select vd.codigo_recurso, max(vd.fecha_desde) fmax
from recurso r
inner join valor_diario vd on vd.codigo_recurso=r.codigo
group by 1);

drop temporary table if exists vactual;
create temporary table vactual(
select vd.codigo_recurso, vd.valor
from valor_diario vd
inner join factual on vd.codigo_recurso=factual.codigo_recurso and vd.fecha_desde=factual.fmax);

select avg(va.valor)into @promactual
from vactual va;

select va.codigo_recurso, r.descripcion, va.valor
from recurso r
inner join vactual va on va.codigo_recurso=r.codigo
where va.valor > @promactual;


/* 3. Crear un recurso nuevo y asociarle los mismos valores y a la misma
fecha que a un recurso ya creado */
 start transaction;
 select max(r.codigo)+1 into @maxcod
 from recurso r;
 
 insert into recurso (codigo, descripcion)
 value(@maxcod,'Recurso parcial');
 
 insert into valor_diario(codigo_recurso, fecha_desde, valor)
 select @maxcod,fecha_desde,valor
 from valor_diario vd
 where vd.codigo_recurso = 1;
 
 commit;

/* 4. Personas que se anotaron en menos de tres competencias, mostrando dni ,
nombre, apellido y cantidad de competencias a las que se inscribieron. Aquellos
que no se inscribienron en ningun evento mostrar 0 */
drop temporary table if exists compar;
create temporary table compar(						
select pa.dni_persona, com.nro_evento, com.codigo_tipo_competencia 
from competencia com
inner join participante pa on pa.nro_evento=com.nro_evento and com.codigo_tipo_competencia=pa.codigo_tipo_competencia);

select p.dni, p.nombre, p.apellido, count(c.codigo_tipo_competencia) cant
from persona p
left join compar c on c.dni_persona=p.dni
group by 1,2,3
having cant < 3;

/* 5. Mostrar número de evento, su descripción y su duración en días:horas, el
dni de los organizadores, ordenados por duración de manera descendente.*/ 

select ev.nro, ev.descripcion, datediff(ev.fecha_hora_fin, ev.fecha_hora_ini) 'Diferencia días', timediff(ev.fecha_hora_fin, ev.fecha_hora_ini) 'Diferencia horas' ,org.dni_persona
from evento ev
inner join organizador org on org.nro_evento=ev.nro
order by 3,4 desc;


/* 6.  Crear un procedimiento que,ingresando una competencia, muestre las
personas que salieron en los tres primeros lugares. */

USE `comuna_v4`;
DROP procedure IF EXISTS `podio`;

DELIMITER $$
USE `comuna_v4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `podio`(in evento int, in cod int)
BEGIN
select pa.dni_persona, pa.puesto 
from participante pa
inner join persona p on p.dni=pa.dni_persona
where pa.puesto <= 3 and pa.codigo_tipo_competencia = cod and pa.nro_evento=evento;
END$$

DELIMITER ;


call podio(1,1);

/* 1 Listar todos los organizadores que organizaron un evento este año y
 no el año pasado.*/
 
select per.dni, per.nombre, per.apellido
from organizador org
inner join evento eve on eve.nro=org.nro_evento
inner join persona per on per.dni=org.dni_persona
where year(eve.fecha_hora_ini)=year( current_date() ) and per.dni not in ( 
														select per.dni
														from organizador org
														inner join evento eve on eve.nro=org.nro_evento
														inner join persona per on per.dni=org.dni_persona
														where year(eve.fecha_hora_ini)= year( current_date() ) -1); 
                                                        # currentdate hace referencia a 2019,

/* 2.Indicar lugares que se hayan utilizado en menos de 10 eventos durante
este año. Mostrar: datos del lugar, la cantidad de eventos que se utilizo, si
algun lugar nunca se utilizo indicar 0 */
                                              
select lug.codigo,lug.nombre,lug.direccion,lug.url_gps,year(espec.fecha_hora_ini),count(espec.nro_evento)
from espectaculo espec
left join lugar lug on lug.codigo=espec.codigo_lugar
where year(espec.fecha_hora_ini)= year( current_date() ) # currentdate hace referencia a 2019,
group by lug.codigo
having count(espec.nro_evento) <10;

/* 3. Se desea conocer el o los espetáculos mas costosos en el ultimo año */

select max(costo_cont) into @maxValor    #Se busca el maximo valor del ultimo año
from espectaculo espec
where year(espec.fecha_hora_ini) = year( current_date() ) ;  # currentdate hace referencia a 2019,

select espec.nro_espectaculo, espec.nombre, espec.costo_cont 
from espectaculo espec
where espec.costo_cont = @maxValor ;

/* 4.Agregar a la competencia 1 del último evento ingresado, los mismos
participantes que se inscribieron a la competencia 1 del primer evento. */

start transaction;

select min(nro_evento) into @primerEvento from competencia;
select @primerEvento;

select max(nro_evento) into @ultimoEvento from competencia;
select @ultimoEvento;

insert into participante(dni_persona,nro_evento,codigo_tipo_competencia,fecha_hora_inscripcion,puesto)
select par.dni_persona,par.nro_evento,par.codigo_tipo_competencia,par.fecha_hora_inscripcion,par.puesto 
from participante par
where par.nro_evento=@primerEvento and par.codigo_tipo_competencia=1
;
#No esta termiando falta una parte
  
commit;
/*select * 
from competencia comp
inner join participante par on par.nro_evento=comp.nro_evento and par.codigo_tipo_competencia = comp.codigo_tipo_competencia 
order by comp.nro_evento;*/


/* 5. Se desea conocer el total de dinero gastado en recursos para cada
evento. Calcular valor del recursos con los precios actuales. */

drop temporary table if exists fechaActual;
create temporary table fechaActual
select vd.codigo_recurso, max(vd.fecha_desde) maxFecha
from valor_diario vd
group by codigo_recurso;

#select * from fechaActual;

drop temporary table if exists valorActual;
create temporary table valorActual
select vd.codigo_recurso,vd.valor
from fechaActual fa
inner join valor_diario vd on vd.fecha_desde= fa.maxFecha and vd.codigo_recurso =fa.codigo_recurso;

#select * from valorActual;

select alq.nro_evento,sum(cantidad * va.valor) GastosEvento
from alquiler alq
inner join valorActual va on va.codigo_recurso=alq.codigo_recurso
group by alq.nro_evento;

/* 6.Confeccionar un Store Procedure donde dado un artista determinado,
listar todos los eventos en los que participó este año, indicando descripción del
artista, descripción del evento, número de espectáculo, y nombre del lugar. */

DROP procedure IF EXISTS `buscoArtista`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscoArtista`(in cuit int)
BEGIN
select art.descripcion, eve.descripcion, espec.nro_espectaculo,lug.nombre
from espectaculo espec
inner join evento eve on eve.nro=espec.nro_evento
inner join lugar lug on lug.codigo=espec.codigo_lugar
inner join artista art on art.cuit=espec.cuit_artista
where art.cuit=cuit and year(espec.fecha_hora_ini)= year(current_date()); # currentdate hace referencia a 2019, para no escribirlo si no seria
END$$
DELIMITER ;

call buscoArtista(111111111)



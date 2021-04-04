# Parcial 305

/* Listar los eventos y sus espectáculos del 2019 indicando, 
descripción del evento, nombre del espectáculo, fecha y hora de inicio y fin del espectáculo, 
costo del espectáculo, nombre y dirección del lugar si ya lo tiene asignado
 y descripción del artista si ya hay uno. */
 
 select ev.descripcion, esp.nombre, esp.fecha_hora_ini, esp.fecha_hora_fin, esp.costo_cont, esp.nombre, 
 ifnull(lu.nombre, 'Sin asignar') Lugar, ifnull(art.nombre, 'Sin asignar') Artista 
 from evento ev 
 inner join espectaculo esp on esp.nro_evento=ev.nro
 left join lugar lu on lu.codigo=esp.codigo_lugar
 left join artista art on art.cuit=esp.cuit_artista
 where year(esp.fecha_hora_ini) = 2019;
 
 /* Indicar los eventos donde se realizaron más de 1 espectáculo indicando 
 número, descripción, fecha y hora de inicio, fecha y hora de fin del evento y la cantidad de espectáculos */
 select ev.nro, count(esp.nro_espectaculo) Cantidad, ev.descripcion, ev.fecha_hora_ini, ev.fecha_hora_fin 
 from espectaculo esp
 inner join evento ev on ev.nro=esp.nro_evento
 group by 1
 having Cantidad > 1;
 
 /* Indicar los jurados que no se han desempeñado como tales en ninguna competencia 
 indicando nombre, apellido y especialidades. */
 select ju.dni, ju.nombre, ju.apellido 
 from jurado ju
 where ju.dni not in(select com.dni_jurado
					from competencia com);
   
/* El jurado que ha actuado más veces que nadie como tal en competencias ya realizadas. 
Indicando nombre, apellido y especialidades del jurado 
y cantidad de competencias en las que fue jurado y la última fecha en que fue jurado */
drop temporary table jurados;
create temporary table jurados(
select com.dni_jurado, count(*) Cantidad, max(com.fecha_hora_ini) fmax
from competencia com
group by 1);
select max(Cantidad) into @maxcant
from jurados jus;
select ju.dni, concat(ju.nombre, ' ',ju.apellido) 'Nombre y apellido', jus.Cantidad, date(jus.fmax) 'Última fecha' 
from jurado ju
inner join jurados jus on jus.dni_jurado=ju.dni
where jus.Cantidad=@maxcant;

/* Crear el nuevo recurso "Escenario móvil" 
(por código si no es autoincremental asignar uno que no falle con sus datos) 
y asignarle el valor de $2500 a partir del día de la fecha */ 
 start transaction;
 select max(r.codigo)+1 into @maxcod
 from recurso r;
 insert into recurso (codigo, descripcion)
 value(@maxcod,'Escenario movil');
 insert into valor_diario(codigo_recurso, fecha_desde, valor)
 value(@maxcod, current_date(), 2500);
 rollback;
 
 select distinct vd.codigo_recurso, vd.valor, vd.fecha_desde from recurso
 inner join valor_diario vd;
 
 /* Crear un store procedure que dado una persona (como parámetro de entrada del sp) 
 liste todas las competencias donde ha participado. 
 Indicando descripción del evento, descripción de la competencia y descripción del tipo de competencia. 
 Luego invocar el store procedure (utilizar un dni que se encuentre en sus datos) */
 
call participaciones(4444);
 
 
 
/* 1. Listar artistas que no participaron en eventos. */ 
select art.cuit, art.nombre, art.nombre_comercial
from artista art
where art.cuit not in (select esp.cuit_artista
								from espectaculo esp);
                                
/* 2. Indicar personas que hayan participado en menos de 10 competencias durante este año. 
Mostrar: datos de la persona, la cantidad de competencias que participó, 
si una persona no participo en ninguna competencia indicar 0. */
drop temporary table com19;
create temporary table com19(						
select pa.dni_persona, com.nro_evento, com.codigo_tipo_competencia 
from competencia com
inner join participante pa on pa.nro_evento=com.nro_evento and com.codigo_tipo_competencia=pa.codigo_tipo_competencia
where year(com.fecha_hora_ini) = 2019);

select p.dni, p.nombre, p.apellido, count(c.codigo_tipo_competencia) cant
from persona p
left join com19 c on c.dni_persona=p.dni
group by 1,2,3
having cant <= 10;

/* 3. Mostrar el/los jurado/s que en más competencias hayan participado */
drop temporary table maspart;

create temporary table maspart(
select com.dni_jurado, count(*) Participo 
from competencia com
group by com.dni_jurado);

select max(mp.participo)into @maxveces
from maspart mp;

select j.dni, j.nombre, j.apellido, @maxveces participo
from maspart mp
inner join jurado j on j.dni=mp.dni_jurado
where mp.participo=@maxveces;

/* 4. Crear un espectáculo nuevo, asignarlo a un evento ya existente y a un artista nuevo. */
start transaction;
insert into artista(cuit, descripcion, telefono, email, actividad, nombre_comercial)
values('20-416349-1','ejemplo',231312,'ejemplo@gmail.com','stand up','grupo prueba');

select max(nro_espectaculo)+1 into @idesp
from espectaculo esp
where esp.nro_evento =1;

insert into espectaculo(nro_evento,nro_espectaculo,nombre,fecha_hora_ini,fecha_hora_fin, costo_cont,cuit_artista,codigo_lugar)
values(1,@idesp,'espEJEM',20180415170000,'20191023', '5000','20-416349-1',2);
rollback;

select * from evento ev
inner join espectaculo esp on esp.nro_evento=ev.nro;
select * from artista;



/* 5. Seleccionar los espectáculos que tengan un costo de contrato mayor al promedio de todos los espectáculos. 
Mostrando número de espectáculo, nombre, fecha y hora de inicio, fecha y hora de finalización, 
costo del contrato y el promedio de todos los espectáculos */

select avg(esp.costo_cont) into @costprom
from espectaculo esp;

select esp.nro_espectaculo, esp.nombre, esp.fecha_hora_ini, esp.fecha_hora_fin, esp.costo_cont, @costprom
from espectaculo esp
where esp.costo_cont > @costprom;

/* 6. Confeccionar un Store Procedure que ingresando un dni del organizador 
devuelva los eventos que organizó, nombre y fechas.*/ 

call organizadores(1111);


select distinct org.dni_persona, cantev(org.dni_persona,2018) 'Cantidad de eventos organizados'
from organizador org;

select * from organizador org inner join evento ev on org.nro_evento=ev.nro;






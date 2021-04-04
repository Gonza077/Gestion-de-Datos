
/*
VA alquileres
*/

/* SQL 2 */

select em.cuil, em.nombre,em.apellido, COUNT(ev.cuilempleado)
from empleados em 
LEFT join eventos ev 
on ev.cuilempleado = em.cuil
group by 1,2,3;

/* FIN SQL 2 */

/* SQL 3 */

select SUM(contrata.cantidad) into @cant_total
from contrata;

select ser.CodServicio, ser.DescServicio, sum(c.cantidad) cantidad, sum(c.cantidad) * 100 / @cant_total 'Porcentaje Total'
from  servicios ser
inner join   contrata c
on c.CodServicio = ser.CodServicio
group by 1,2
order by 3 desc;

/* FIN SQL 3 */


/* SQL 4 */

/* USANDO VARIABLES Y SUBCONSULTA */

select SUM(ie.valorpactado) INTO @vinstala
FROM instalaciones_eventos ie
WHERE ie.NroEvento = 5;

select ev.fechacontrato into @vfechacontrato
FROM eventos ev
WHERE ev.NroEvento = 5;

select SUM(c.cantidad * vs.valor) INTO @vservicios 
from  contrata c
INNER JOIN valores_servicios vs
ON vs.CodServicio = c.CodServicio
AND vs.fechadesde = (SELECT MAX(vsf.fechadesde)
						 FROM valores_servicios vsf
						 WHERE vsf.CodServicio = vs.CodServicio
                           AND vsf.fechadesde <= @vfechacontrato)
WHERE c.NroEvento = 5;

SELECT @vinstala + @vservicios;

/* FIN SQL 4 */



/* USAR PARA BORRAR LOS REGISTROS GENERADOS POR LAS DUDAS SI SE HIZO COMMIT*/

DELETE FROM valores_servicios 
WHERE FechaDesde = current_date();

/* FIN SQL 4 */

/* SQL 5 */

DROP procedure IF EXISTS NuevoTipoEvento;
DELIMITER $$
USE `va_alquileres`$$
CREATE PROCEDURE NuevoTipoEvento (in Descripcion varchar(20))
BEGIN
select max(te.CodTipoEvento) into @codigo
from tipos_evento te;
insert into tipos_evento(CodTipoEvento, DescTipoEvento) values (@codigo+1, descripcion);
END$$
DELIMITER ;

call NuevoTipoEvento('Fiesta electronica');


/* FIN SQL 5 */

/* SQL 6 */

start transaction;
drop temporary table if exists tt_valfecha;
create temporary table tt_valfecha
select vs.CodServicio, max(vs.fechadesde) FechaDesde
FROM valores_servicios vs
where vs.fechadesde <= current_date()
group by 1;

INSERT INTO valores_servicios
SELECT tt.CodServicio, current_date(), vs.valor * 1.20
FROM tt_valfecha tt
INNER JOIN valores_servicios vs
ON vs.CodServicio = tt.CodServicio
AND vs.fechadesde = tt.FechaDesde;

COMMIT;

/* FIN SQL 6 */

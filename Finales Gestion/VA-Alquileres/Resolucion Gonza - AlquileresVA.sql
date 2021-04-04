/* 1) Desarrolle las sentencias DDL requeridas para completar la
definición de la tabla CONTRATA
Copie el DDL que se obtiene con la herramienta al archivo a entregar */
/*

ALTER TABLE `va_alquileres`.`contrata` 
ADD CONSTRAINT `contrata_cod_servicio_fk`
  FOREIGN KEY (`CodServicio`)
  REFERENCES `va_alquileres`.`servicios` (`CodServicio`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `va_alquileres`.`contrata` 
ADD CONSTRAINT `contrata_instalaciones_servicios_fk`
  FOREIGN KEY (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  REFERENCES `va_alquileres`.`instalaciones_eventos` (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `va_alquileres`.`contrata` 
ADD INDEX `contrata_cuil_fk_idx` (`cuil` ASC) ;
;
ALTER TABLE `va_alquileres`.`contrata` 
ADD CONSTRAINT `contrata_cuil_fk`
  FOREIGN KEY (`cuil`)
  REFERENCES `va_alquileres`.`empleados` (`cuil`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
*/

/* 2) Indicar por empleado la cantidad de eventos que tuvo como coordinador. Mostrar CUIL, apellido, nombres y
cantidad de eventos. Aquellos empleados que no fueron coordinadores en ningún evento indicar 0. */

select emp.cuil,emp.nombre,emp.apellido,ifnull(count(eve.cuilEmpleado),0) cantEventos
from empleados emp
left join eventos eve 
	on eve.CuilEmpleado=emp.cuil
group by 1,2,3;

/* 3) Ranking de servicios contratados indicando: datos del servicio, suma de la cantidad del servicio contratado
para todos los eventos y porcentaje de esta suma sobre la suma total de las cantidades de servicios
contratados. Los servicios que no hayan sido contratados deberán figurar en la lista con cantidad total 0.
Ordenar el ranking en forma descendente por porcentaje. */

select sum(cont.cantidad) into @cantServicios
from contrata cont ;

select ser.CodServicio,ser.DescServicio, ifnull(sum(cont.cantidad),0)cantServContratados,sum(cont.cantidad) *100/@cantServicios porcServicios
from servicios ser
left join contrata cont  
	on cont.CodServicio=ser.CodServicio
group by 1,2
order by 4 DESC;

/* 4) Calcular el total a pagar del Evento 5. El total debe incluir: la suma de los valores pactados por las
instalaciones más la suma de los totales de servicios contratados. NOTA: el total de un servicio se calcula
como la cantidad del servicio contratada por el valor del servicio a la fecha del contrato del evento. */

select sum(inseve.valorpactado)into @valorInstalacion
from instalaciones_eventos inseve
where inseve.NroEvento=5;

SELECT fechacontrato into @fechaContrato
from eventos
where NroEvento=5;

select SUM(con.cantidad * vs.valor) INTO @valorServicios 
from  contrata con
INNER JOIN valores_servicios vs 
	ON vs.CodServicio = con.CodServicio AND vs.fechadesde = (SELECT MAX(vsf.fechadesde)
														FROM valores_servicios vsf
														WHERE vsf.CodServicio = vs.CodServicio
														AND vsf.fechadesde <= @fechaContrato)
WHERE con.NroEvento = 5;

select round(@valorServicios+@valorInstalacion,2) valorTotalDelEvento5;

/* 5) STORE PROCEDURE (SP): Desarrollar un SP que dada una nueva descripción de un tipo de evento lo registre
en la tabla correspondiente manteniendo la correlatividad de los códigos de tipos de evento */
call NuevoTipoEvento("Fiesta de disfraces");
DELETE FROM `va_alquileres`.`tipos_evento` WHERE (`CodTipoEvento` = '6');  #Para eliminar el evento agregado, si no se agrega cada vez que se ejecuta
/* 
CREATE DEFINER=`root`@`localhost` PROCEDURE `NuevoTipoEvento`(in Descripcion varchar(20))
BEGIN
select max(te.CodTipoEvento) into @codigo
from tipos_evento te;
insert into tipos_evento(CodTipoEvento, DescTipoEvento) values (@codigo+1, descripcion);
END 
*/

/*
6) Registrar los nuevos valores de servicios para la fecha de hoy en función de su valor anterior más un 20%.
*/
start transaction;
drop temporary table if exists ultFecha;
create temporary table ultFecha
select CodServicio, max(fechadesde) maxFecha
from valores_servicios
group by 1;

insert into valores_servicios
select vs.CodServicio,current_date,valor*1.2
from valores_servicios vs
inner join ultFecha uf on uf.CodServicio=vs.CodServicio and vs.fechadesde=uf.maxFecha;

commit;

#Verificacion de los datos insertados
select vs1.CodServicio, vs1.fechadesde fechaNueva,vs1.valor valorNuevo,vs2.fechadesde fechaVieja,vs2.valor valorViejo
from valores_servicios vs1
inner join ultFecha uf on uf.CodServicio=vs1.CodServicio and vs1.fechadesde=current_date()
inner join valores_servicios vs2 on vs2.CodServicio=uf.CodServicio and vs2.fechadesde=uf.maxFecha;

delete from valores_servicios where fechadesde=current_date;





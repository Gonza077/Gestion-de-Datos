/*
1) Desarrolle las sentencias DDL requeridas para completar
la definición de las tablas CHOFERES_TURNOS y VIAJES

ALTER TABLE `manolo_carpa_tigre`.`choferes_turnos` 
ADD PRIMARY KEY (`cuil`, `cod_turno`, `fecha_turno`);
;

ALTER TABLE `manolo_carpa_tigre`.`choferes_turnos` 
ADD INDEX `CF_turno_FK_idx` (`cod_turno` ASC) ;
;
ALTER TABLE `manolo_carpa_tigre`.`choferes_turnos` 
ADD CONSTRAINT `CF_cuil_FK`
  FOREIGN KEY (`cuil`)
  REFERENCES `manolo_carpa_tigre`.`choferes` (`cuil`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `CF_turno_FK`
  FOREIGN KEY (`cod_turno`)
  REFERENCES `manolo_carpa_tigre`.`turnos` (`cod_turno`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD INDEX `viajes_nro_contrato_FK_idx` (`nro_contrato` ASC) ;
;
ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD CONSTRAINT `viajes_nro_contrato_FK`
  FOREIGN KEY (`nro_contrato`)
  REFERENCES `manolo_carpa_tigre`.`contratos` (`nro_contrato`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD INDEX `viajes_choferes_turno_FK_idx` (`cuil` ASC, `cod_turno` ASC, `fecha_turno` ASC) ;
;
ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD CONSTRAINT `viajes_choferes_turno_FK`
  FOREIGN KEY (`cuil` , `cod_turno` , `fecha_turno`)
  REFERENCES `manolo_carpa_tigre`.`choferes_turnos` (`cuil` , `cod_turno` , `fecha_turno`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD INDEX `viajes_cod_tipo_viajes_FK_idx` (`cod_tipo_viaje` ASC) ;
;
ALTER TABLE `manolo_carpa_tigre`.`viajes` 
ADD CONSTRAINT `viajes_cod_tipo_viajes_FK`
  FOREIGN KEY (`cod_tipo_viaje`)
  REFERENCES `manolo_carpa_tigre`.`tipos_viajes` (`cod_tipo_viaje`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
*/

/* 
2) Ranking de móviles. Indicar: Patente, cantidad de kilómetros recorridos 
en todos los viajes que realizó elmóvil.
Ordenar por cantidad de kilómetros recorridos en forma descendente.*/
select vm.patente, sum(vm.km_fin-vm.km_ini) cantKilometrosRecorridos from 
viajes_moviles vm
group by vm.patente
order by cantKilometrosRecorridos DESC;


/* 
3) Lista de precios. Indicar código del tipo de viaje, descripción y valor actual. 
Si el tipo de viaje aún no tiene ningún precio registrado, mostrar igual el tipo de viaje 
indicando esta situación.  */
drop temporary table if exists fechaMax;
create temporary table fechaMax
select tpv.cod_tipo_viaje, max(tpv.fecha_desde) maxFecha 
from tipos_viajes_valores tpv
where tpv.fecha_desde<now()
group by tpv.cod_tipo_viaje;

select tipViaj.cod_tipo_viaje,tipViaj.desc_tipo_viaje,ifnull(tpv.valor_km,"No posee valor asignado") precioKm 
from tipos_viajes tipViaj
left join fechaMax fm 
	on tipViaj.cod_tipo_viaje=fm.cod_tipo_viaje
left join tipos_viajes_valores tpv 
	on tpv.cod_tipo_viaje=fm.cod_tipo_viaje and tpv.fecha_desde=fm.maxFecha;

/*
4) Importes adeudados: Listar los clientes que adeudan cuotas indicando: tipo y nro. de documento,
nombre, teléfono, cantidad de cuotas vencidas, importe total adeudado e importe total de recargo al día
de hoy. 
Recordar que las cuotas vencidas tienen un importe de recargo que se calcula: Recargo = cantidad de
días de mora * porcentaje de recargo vigente * importe de la cuota / 100.
Cantidad de días de mora = fecha actual – fecha vencimiento (Función DATEDIFF)
*/

select r1.PorcRecargoDiario into @porcDiario 
from recargos r1
where r1.FechaDesde in(select max(FechaDesde)from recargos r2);

select cli.tipo_doc,cli.nro_doc,cli.denominacion,cli.telefono, count(*), sum(cuo.importe) Importe, sum(round(datediff(current_date(),cuo.fecha_venc) * @porcDiario * (cuo.importe/100),2)) Recargo
from viajes via
inner join cuotas cuo 
	on cuo.nro_viaje=via.nro_viaje
inner join contratos c 
	on c.nro_contrato= via.nro_contrato
inner join clientes cli 
	on cli.tipo_doc=c.tipo_doc and  cli.nro_doc=c.nro_doc 
where cuo.fecha_pago is null 
group by 1,2,3,4;

/*
5) Disponibilidad de móviles: realizar un procedimiento almacenado que analice la disponibilidad de
móviles con una cierta capacidad o más (parámetro de entrada) para realizar un viaje casual. El
procedimiento deberá listar Patente y capacidad de los móviles disponibles.
Probar el procedimiento para la capacidad: 20
*/

call dispoMoviles(20);

/*
USE `manolo_carpa_tigre`;
DROP procedure IF EXISTS `dispoMoviles`;

DELIMITER $$
USE `manolo_carpa_tigre`$$
CREATE PROCEDURE `dispoMoviles` (in inCapacidad int)
BEGIN
select mov.patente,mov.capacidad 
from viajes via
inner join viajes_moviles vm 
	on via.nro_viaje=vm.nro_viaje
inner join moviles mov 
	on mov.patente=vm.patente
where via.fecha_reserva is null and via.hora_reserva is null and (via.estado!="Pendiente" or via.estado!="En proceso") and mov.capacidad>=20 and mov.fecha_baja is null;
END$$

DELIMITER ;
*/

/*
6) Actualización de precios: Debido a un aumento en los combustibles la empresa ha decidido un aumento
de precios para el valor por km de los tipos de viajes. El aumento regirá a partir del lunes próximo. El
aumento será de un 25% a los que tengan un importe menor a $100 y de 30% a los que tengan un
importe mayor o igual a $100.
*/

start transaction;

drop temporary table if exists ultFechas;
create temporary table ultFechas
select cod_tipo_viaje,max(fecha_desde) maxFecha
from tipos_viajes_valores
group by 1;

insert into tipos_viajes_valores
select tvv.cod_tipo_viaje,"2019-11-18",tvv.valor_km*1.25
from tipos_viajes_valores tvv
inner join ultFechas uf on tvv.cod_tipo_viaje=uf.cod_tipo_viaje and tvv.fecha_desde=uf.maxFecha
where tvv.valor_km<100;

insert into tipos_viajes_valores
select tvv.cod_tipo_viaje,"2019-11-18",tvv.valor_km*1.3
from tipos_viajes_valores tvv
inner join ultFechas uf on tvv.cod_tipo_viaje=uf.cod_tipo_viaje and tvv.fecha_desde=uf.maxFecha
where tvv.valor_km>=100;

commit;


#Verificacion de los datos, no es para nada
select tvv1.cod_tipo_viaje,tvv1.fecha_desde fechaNueva,tvv1.valor_km valorNuevo,tvv2.fecha_desde fechaVieja,tvv2.valor_km valorViejo
from tipos_viajes_valores tvv1
inner join ultFechas uf on uf.cod_tipo_viaje=tvv1.cod_tipo_viaje and tvv1.fecha_desde="2019-11-18"
inner join tipos_viajes_valores tvv2 on uf.cod_tipo_viaje=tvv2.cod_tipo_viaje and tvv2.fecha_desde=uf.maxFecha;

delete from tipos_viajes_valores 
where fecha_desde="2019-11-18";








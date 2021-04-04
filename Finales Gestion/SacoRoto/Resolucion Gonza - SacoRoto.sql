/* 2) Listado de prendas sin confeccionar: Listado de prendas que aún no se han terminado de confeccionar. Mostrar:
Nombre y apellido de la persona, descripción de la prenda, fecha del pedido, fecha fin estimada de la prenda,
fecha_entrega_requerida y cantidad de días de demora en función de la fecha requerida a hoy (función DATEDIFF).*/
select per.nombre,per.apellido,tp.desc_tipo_prenda,date(ped.fecha_hora_pedido),pren.fecha_fin_est,pren.fecha_entrega, datediff(current_date(),pren.fecha_entrega) diasDemora
from prendas pren
inner join personas per 
	on per.nro_persona=pren.nro_persona
inner join tipos_prendas tp 
	on tp.cod_tipo_prenda=pren.cod_tipo_prenda
inner join pedidos ped 
	on ped.nro_pedido=pren.nro_pedido
where pren.fecha_fin_real is null 
order by diasDemora DESC;

/* 3) Mostrar los tipos de prendas que nunca se han vendido. Indicando código del
tipo de prenda y descripción.*/

select * 
from tipos_prendas tp
where tp.cod_tipo_prenda not in (select pren.cod_tipo_prenda from prendas pren);

/* 4) Realizar el procedimiento "ult_prueba" que dada una fecha muestre por cada persona y
tipo de prenda, cuál fue la última prueba realizada.
Mostrar número y nombres de las personas, tipo de prenda, descripción del tipo de prenda y fecha de última prueba.
Si una persona tiene varias pruebas del mismo tipo de prenda el mismo día mostrar una sola vez.
Ordenar por fecha en forma descendente y por apellido en forma ascendente.
Probar el procedimiento con la fecha: 5/11/2013 */

call ult_prueba("2013/11/05");

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `ult_prueba`(in fechaComparacion date)
BEGIN
drop temporary table if exists ultPrueba;
create temporary table ultPrueba
select nro_persona,cod_tipo_prenda, max(fecha_prueba) ultimaFecha
from pruebas
where fecha_prueba <= fechaComparacion
group by 1,2;

select per.nro_persona,per.nombre,tp.cod_tipo_prenda,tp.desc_tipo_prenda, pr.fecha_prueba
from ultPrueba up
inner join personas per on per.nro_persona= up.nro_persona
inner join tipos_prendas tp on tp.cod_tipo_prenda=up.cod_tipo_prenda
inner join pruebas pr on pr.nro_persona= per.nro_persona and pr.cod_tipo_prenda=tp.cod_tipo_prenda and pr.fecha_prueba=up.ultimaFecha;

END*/

/* 5)a_ */

CREATE TABLE `saco_roto`.`unidades_medida` (
  `cod_unidad` INT NOT NULL AUTO_INCREMENT,
  `desc_unidad` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_unidad`));

/* 5)b_*/

start transaction;
insert into unidades_medida(desc_unidad)
select distinct unidad
from materiales;
commit;

/* 5)c_*/

ALTER TABLE `saco_roto`.`materiales` 
ADD COLUMN `cod_unidad` INT NOT NULL AFTER `unidad`;

/* 5)d */

start transaction;
update materiales
SET cod_unidad = (select um.cod_unidad from unidades_medida um where um.desc_unidad = materiales.unidad);
commit;

/* 5)e  */

ALTER TABLE `saco_roto`.`materiales` 
ADD CONSTRAINT `cod_unidadFK`
  FOREIGN KEY (`cod_unidad`)
  REFERENCES `saco_roto`.`unidades_medida` (`cod_unidad`)
  ON DELETE CASCADE
  ON UPDATE RESTRICT;

#Esto es para que se ejecute todo de manera automatica, no darle bola

ALTER TABLE `saco_roto`.`materiales` 
DROP FOREIGN KEY `cod_unidadFK`;
ALTER TABLE `saco_roto`.`materiales` 
DROP INDEX `cod_unidadFK` ;
;

DROP TABLE `saco_roto`.`unidades_medida`;

ALTER TABLE `saco_roto`.`materiales` 
DROP COLUMN `cod_unidad`;


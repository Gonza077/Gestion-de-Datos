-- Resolución Propuesta
-- Ejercicio 1 Tema 1
-- Listado de prendas sin confeccionar
-- inner join - is null - uso de función - order by

SELECT p.nombre, p.apellido, tp.desc_tipo_prenda, ped.fecha_hora_pedido, ps.fecha_fin_est, ps.fecha_entrega_requerida,
datediff(current_date(),ps.fecha_entrega_requerida) dias_demora
from prendas pr
inner join personas p on pr.nro_persona = p.nro_persona
inner join prendas ps on pr.cod_tipo_prenda = ps.cod_tipo_prenda 
inner join pedidos ped on ps.nro_pedido = ped.nro_pedido
inner join tipos_prendas tp on ps.cod_tipo_prenda = tp.cod_tipo_prenda
where ps.fecha_fin_real is null
ORDER BY dias_demora desc;

-- Ejercicio 2
-- Estadística de tipos de prenda
-- subconsulta

select tp.cod_tipo_prenda,tp.desc_tipo_prenda 
from tipos_prendas tp
where tp.cod_tipo_prenda not in (select pre.cod_tipo_prenda from prendas pre);

-- Ejercicio 3 
-- Ultima supervisión de pruebas
-- Procedimiento - tabla temporal

USE `saco_roto`;
DROP procedure IF EXISTS `ult_fecha_prueba`;

DELIMITER $$
USE `saco_roto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ult_fecha_prueba`()
BEGIN
drop temporary table if exists maxi;
create temporary table maxi
SELECT nro_persona, cod_tipo_prenda, max(fecha_prueba) ult_fecha
from pruebas
where fecha_prueba <= fecha_in
group by  1,2;

select p.apellido, p.nombre, pr.cod_tipo_prenda, desc_tipo_prenda,ult_fecha
from personas p 
inner join maxi on p.nro_persona = maxi.nro_persona
inner join pruebas pr on p.nro_persona = pr.nro_persona 
                      and pr.cod_tipo_prenda = maxi.cod_tipo_prenda 
                      and pr.fecha_prueba = ult_fecha
inner join tipos_prendas tp on pr.cod_tipo_prenda = tp.cod_tipo_prenda
order by ult_fecha desc, apellido asc;
END$$

DELIMITER ;

call `ult_fecha_prueba`("2013-11-05");

-- Ejercicio 4 Tema 1
-- Procedimiento: Agregar tabla en función de datos existentes
-- DDL - TCL - INSERT SELECT distinct - update 
-- a)
CREATE TABLE `saco_roto`.`unidades_medida` (
  `cod_unidad` INT NOT NULL AUTO_INCREMENT,
  `desc_unidad` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_unidad`));
-- b)
 start transaction;
	insert into unidades_medida (desc_unidad)
    select distinct mat.unidad
    from materiales mat;
 commit;
 
 -- c)
ALTER TABLE `saco_roto`.`materiales` 
ADD COLUMN `cod_unidad` INT NULL AFTER `unidad`;

-- d)

start transaction;
    update materiales
    SET cod_unidad = (select um.cod_unidad from unidades_medida um where um.desc_unidad = materiales.unidad);
commit;

-- e)
ALTER TABLE `saco_roto`.`materiales` 
DROP COLUMN `unidad`,
ADD INDEX `unidad_medida_fk_idx` (`cod_unidad` ASC);
ALTER TABLE `saco_roto`.`materiales` 
ADD CONSTRAINT `unidad_medida_fk`
  FOREIGN KEY (`cod_unidad`)
  REFERENCES `saco_roto`.`unidades_medida` (`cod_unidad`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

/*
1) Desarrolle las sentencias DDL requeridas para
completar la definición de las tablas EMPLEADO, COSTO_HORA_ARTESANO y ESPECIALIDAD y
sus relaciones con otras tablas.

CREATE TABLE `cosplay`.`empleado` (
  `legajo` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `cuil` VARCHAR(45) NULL,
  PRIMARY KEY (`legajo`));

CREATE TABLE `cosplay`.`costo_hora_artesano` (
  `legajo_empleado` INT(11) NOT NULL,
  `fecha_valor` VARCHAR(45) NOT NULL,
  `valor_hora` VARCHAR(45) NULL,
  PRIMARY KEY (`legajo_empleado`, `fecha_valor`));

ALTER TABLE `cosplay`.`costo_hora_artesano` 
ADD CONSTRAINT `cosHorArt_legajo_FK`
  FOREIGN KEY (`legajo_empleado`)
  REFERENCES `cosplay`.`empleado` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

CREATE TABLE `cosplay`.`especialidad` (
  `codigo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`codigo`));

CREATE TABLE `cosplay`.`artesano_especialidad` (
  `legajo` INT(11) NOT NULL,
  `codigo` INT(11) NOT NULL,
  PRIMARY KEY (`legajo`, `codigo`));

ALTER TABLE `cosplay`.`artesano_especialidad` 
ADD INDEX `artEspec_codigo_FK_idx` (`codigo` ASC) VISIBLE;
;
ALTER TABLE `cosplay`.`artesano_especialidad` 
ADD CONSTRAINT `artEspec_legajo_FK`
  FOREIGN KEY (`legajo`)
  REFERENCES `cosplay`.`empleado` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `artEspec_codigo_FK`
  FOREIGN KEY (`codigo`)
  REFERENCES `cosplay`.`especialidad` (`codigo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


CREATE TABLE `cosplay`.`control_calidad` (
  `nro_trabajo` INT NOT NULL,
  `nro_item` INT NOT NULL,
  `codigo_tipo_tarea` INT NOT NULL,
  `legajo_especialista` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  `aprobada` VARCHAR(45) NULL,
  `fecha_hora` DATETIME NULL,
  PRIMARY KEY (`nro_trabajo`, `nro_item`, `codigo_tipo_tarea`, `legajo_especialista`));
  
ALTER TABLE `cosplay`.`control_calidad` 
ADD INDEX `CC_legajo_FK_idx` (`legajo_especialista` ASC) VISIBLE,
ADD INDEX `CC_codigo_tipo_tarea_FK_idx` (`codigo_tipo_tarea` ASC) VISIBLE;
;
ALTER TABLE `cosplay`.`control_calidad` 
ADD CONSTRAINT `CC_legajo_FK`
  FOREIGN KEY (`legajo_especialista`)
  REFERENCES `cosplay`.`empleado` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `CC_codigo_tipo_tarea_FK`
  FOREIGN KEY (`codigo_tipo_tarea`)
  REFERENCES `cosplay`.`tipo_tarea` (`codigo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
CREATE TABLE `cosplay`.`ejecucion_tarea` (
  `nro_trabajo` INT NOT NULL,
  `nro_item` INT NOT NULL,
  `codigo_tipo_tarea` INT NOT NULL,
  `legajo_artesano` INT NOT NULL,
  `hs_trabajadas_reales` INT NULL,
  PRIMARY KEY (`nro_trabajo`, `nro_item`, `codigo_tipo_tarea`, `legajo_artesano`));

ALTER TABLE `cosplay`.`ejecucion_tarea` 
ADD INDEX `ejecTarea_legajo_FK_idx` (`legajo_artesano` ASC) VISIBLE;
;
ALTER TABLE `cosplay`.`ejecucion_tarea` 
ADD CONSTRAINT `ejecTarea_legajo_FK`
  FOREIGN KEY (`legajo_artesano`)
  REFERENCES `cosplay`.`empleado` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `ejecTarea_tarea_FK`
  FOREIGN KEY (`nro_trabajo` , `nro_item` , `codigo_tipo_tarea`)
  REFERENCES `cosplay`.`tarea` (`nro_trabajo` , `nro_item` , `codigo_tipo_tarea`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
*/

/*
2) Ranking de clientes. Indicar: Número de cliente, cuil/cuit, nombre, email, cantidad de
trabajos encargados y sumatoria de importes presupuestados. Ordenar sumatoria de importes
en forma descendente y por cantidad de trabajos en forma ascendente.
*/

select cli.nro,cli.cuil,cli.nombre,cli.email,count(tra.nro) cantTrabajos,sum(tra.importe_presup) sumDeImportes
from cliente cli
inner join trabajo tra 
	on tra.nro_cliente=cli.nro
group by 1,2,3
order by 6 desc, 5 asc;

/*
3)Lista de costo de materiales. Indicar código del material, descripción, unidad de medida,
color y valor actual.
*/
drop temporary table if exists ultFechas;
create temporary table ultFechas
select codigo_material,max(fecha_valor) maxFecha
from costo_material
where fecha_valor<current_date()
group by 1;

select mat.codigo,mat.descripcion,mat.unidad_medida,mat.color,cm.valor_unit
from costo_material cm
inner join ultFechas uf 
	on uf.codigo_material=cm.codigo_material and uf.maxFecha=cm.fecha_valor
inner join material mat 
	on mat.codigo=cm.codigo_material;

/*
4) Trabajos pendientes: Listar los trabajos que no estén terminados al día de hoy. Indicar
número de trabajo, fecha límite de confección, importe presupuestado, y para cada ítem del
trabajo que no esté finalizado indicar el número de ítem, el detalle, y por cada tarea no
completada el código del tipo de tarea, detalle de la tarea fecha y hora de inicio, horas
estimadas y sumatoria de horas reales trabajadas para dicha tarea.
*/

select tra.nro,tra.fecha_limite_conf,tra.importe_presup,it.nro_item,it.detalle,tar.codigo_tipo_tarea,tar.detalle,tar.fecha_hora_inicio,tar.hs_estimadas,ifnull(sum(ejt.hs_trabajadas_reales),0)
from trabajo tra
inner join item it 
	on it.nro_trabajo=tra.nro
inner join tarea tar 
	on it.nro_trabajo=tar.nro_trabajo and it.nro_item=tar.nro_item
left join ejecucion_tarea ejt 
	on ejt.nro_trabajo=tar.nro_trabajo and ejt.nro_item=tar.nro_item and tar.codigo_tipo_tarea=ejt.codigo_tipo_tarea #Se usa left por que puede haber tareas que nunca se realizaron y por eso no estan registradas
where tra.fecha_confirmacion is not null and tra.fecha_fin_confec is null and tar.fecha_hora_fin is null 
group by 1,2,3,4,5,6,7,8,9;

/*
5)
Artesanos excediendo el máximo de horas al mes: realizar un procedimiento almacenado que calcule las horas trabajadas reales totales por artesano en el mes 
(usando la fecha de inicio) y liste aquellos que exceden el máximo de horas que deberían haber trabajado en el mes. El procedimiento almacenado debe recibir 
como parámetros el mes, el año y el máximo de horas. Debe listar los artesanos indicando legajo, cuil, nombre, apellido, descripción de la especialidad, cantidad total de horas 
trabajadas y horas excedidas. Al finalizar invocar el procedimiento. Para realizar pruebas usar Octubre de 2018 y 10 hs
*/
call calculoHorasArtesano(2018,10,10);

/*
USE `cosplay`;
DROP procedure IF EXISTS `calculoHorasArtesano`;

DELIMITER $$
USE `cosplay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculoHorasArtesano`(in anio int, in mes int, in cantHoras int )
BEGIN
select art.legajo, art.cuil,art.nombre,art.apellido,esp.descripcion,sum(ej.hs_trabajadas_reales) cantHorasTrabajadas, sum(ej.hs_trabajadas_reales)-10 horasExcedidas
from ejecucion_tarea ej 
inner join tarea tar 
	on tar.nro_trabajo=ej.nro_trabajo and tar.nro_item=ej.nro_item and tar.codigo_tipo_tarea=ej.codigo_tipo_tarea
inner join empleado art 
	on art.legajo=ej.legajo_artesano
inner join artesano_especialidad ar_esp 
	on ar_esp.legajo_artesano=art.legajo
inner join especialidad esp 
	on esp.codigo=ar_esp.codigo_especialidad
where year(tar.fecha_hora_inicio)=2018 and month(tar.fecha_hora_inicio)=10 and art.tipo="Artesano"
group by 1,2,3,4,5
having sum(ej.hs_trabajadas_reales)> 10 ;
END$$

DELIMITER ;
*/

/*
6) Actualización de precios: Debido al aumento en los costos de los proveedores, la empresa debe actualizar los costos de los materiales. El aumento regirá a partir del lunes próximo. 
El aumento en los materiales será de un 30% a los que tengan un importe menor a $2000 y de 20% a los que tengan un importe mayor o igual a $2000.
*/
start transaction;
drop temporary table if exists ultFechas;
create temporary table  ultFechas
select codigo_material,max(fecha_valor) maxFecha
from costo_material 
where fecha_valor < current_date
group by 1;

insert into costo_material
select cm.codigo_material,"2019/11/18",cm.valor_unit*1.3
from costo_material cm
inner join ultFechas uf 
	on uf.codigo_material=cm.codigo_material and uf.maxFecha=cm.fecha_valor
where cm.valor_unit<2000;

insert into costo_material
select cm.codigo_material,"2019/11/18",cm.valor_unit*1.2
from costo_material cm
inner join ultFechas uf 
	on uf.codigo_material=cm.codigo_material and uf.maxFecha=cm.fecha_valor
where cm.valor_unit>=2000;

commit;

#Verificacion de los datos insertados
select cm1.codigo_material,cm1.fecha_valor fechaNueva,cm1.valor_unit valorNuevo,cm2.fecha_valor fechaVieja,cm2.valor_unit valorViejo
from costo_material cm1 
inner join ultFechas uf 
	on cm1.codigo_material=uf.codigo_material and  cm1.fecha_valor="2019/11/18"
inner join costo_material cm2 
	on cm2.codigo_material=uf.codigo_material and  cm2.fecha_valor=uf.maxFecha;

delete from costo_material 
where fecha_valor="2019/11/18";





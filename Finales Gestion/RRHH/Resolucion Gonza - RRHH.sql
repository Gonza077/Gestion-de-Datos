/* 
1)Desarrolle las sentencias DDL requeridas para completar la definición
de la tabla PROCESO_SELECCION

ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
CHANGE COLUMN `cod_area` `cod_area` INT(3) NOT NULL ,
CHANGE COLUMN `cod_puesto` `cod_puesto` INT(3) NOT NULL ,
CHANGE COLUMN `fecha_solic` `fecha_solic` DATE NOT NULL ,
CHANGE COLUMN `tipo_doc` `tipo_doc` CHAR(7) NOT NULL ,
CHANGE COLUMN `nro_doc` `nro_doc` INT(9) NOT NULL ,
CHANGE COLUMN `fecha_hora` `fecha_hora` DATETIME NOT NULL ,
CHANGE COLUMN `legajo` `legajo` INT(9) NOT NULL ,
CHANGE COLUMN `cod_estado` `cod_estado` INT(3) NOT NULL ,
ADD PRIMARY KEY (`fecha_hora`, `nro_doc`, `tipo_doc`, `fecha_solic`, `cod_puesto`, `cod_area`);
;

ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD INDEX `PS_solicitudes_puesto_FK_idx` (`cod_area` ASC, `cod_puesto` ASC, `fecha_solic` ASC) ;
;
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD CONSTRAINT `PS_solicitudes_puesto_FK`
  FOREIGN KEY (`cod_area` , `cod_puesto` , `fecha_solic`)
  REFERENCES `recursos_humanos`.`solicitudes_puestos` (`cod_area` , `cod_puesto` , `fecha_solic`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD INDEX `PS_legajo_FK_idx` (`legajo` ASC) ;
;
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD CONSTRAINT `PS_legajo_FK`
  FOREIGN KEY (`legajo`)
  REFERENCES `recursos_humanos`.`empleados` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD INDEX `PS_persona_FK_idx` (`tipo_doc` ASC, `nro_doc` ASC) ;
;
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD CONSTRAINT `PS_persona_FK`
  FOREIGN KEY (`tipo_doc` , `nro_doc`)
  REFERENCES `recursos_humanos`.`personas` (`tipo_doc` , `nro_doc`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD INDEX `PS_estados_FK_idx` (`cod_estado` ASC) ;
;
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD CONSTRAINT `PS_estados_FK`
  FOREIGN KEY (`cod_estado`)
  REFERENCES `recursos_humanos`.`estados` (`cod_estado`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
*/

/* 
2)Indicar de los empleados que actualmente trabajan en el área de RRHH, de cuántas personas han realizado
registro en el proceso de selección en el presente año. Mostrar Legajo, apellido y nombres del empleado y
cantidad de personas de las que han realizado registro en el proceso de selección. Aquellos empleados que
actualmente trabajan en el área de RRHH y que no han hecho registro en el proceso de selección listarlos con
cantidad en cero.
NOTAS:
- para saber donde trabajan los empleados actualmente buscar el último cambio de puesto del empleado a la
fecha de hoy y luego verificar si el empleado trabaja en el área de RRHH en ese cambio.
- para la cantidad de personas se cuentan las distintas personas para las cuales el empleado de RRHH tiene
registros en la tabla proceso de selección.) 
*/

select cod_area into @area 
from areas
where denominacion="RRHH";

drop temporary table if exists ultimaFechaTrabajo;
create temporary table ultimaFechaTrabajo
select legajo, max(fecha_ini) ultFecha 
from empleados_puestos
where fecha_ini <= current_date()
group by 1;

select emple.legajo,emple.nombre,emple.apellido, count(distinct(concat(ps.tipo_doc," ",ps.nro_doc))) cantPersonas
from ultimaFechaTrabajo uft
inner join empleados_puestos ep on ep.legajo=uft.legajo and ep.fecha_ini=uft.ultFecha
inner join empleados emple on emple.legajo=uft.legajo
left join proceso_seleccion ps on ps.legajo=uft.legajo
where ps.fecha_hora>='01-01-2018' and ep.cod_area=@area
group by 1,2,3;

/* 
3)Ranking de solicitudes para puestos de trabajo indicando: código y denominación del área, código y descripción
del puesto de trabajo, cantidad de solicitudes registradas, porcentaje de solicitudes por puesto sobre la cantidad
total de solicitudes registradas y suma de las cantidades de puestos solicitados. Ordenar el ranking en forma
descendente por porcentaje de solicitudes.
NOTA: el porcentaje deberá calcularse con solo dos dígitos decimales.
*/

select count(sp.fecha_solic) into @cantSolicitudes
from solicitudes_puestos sp;

select ar.cod_area,ar.denominacion,pue.cod_puesto,pue.descripcion,count(sp.fecha_solic) cantSolicitudes, round((count(sp.fecha_solic)*100)/@cantSolicitudes,2) porcSolicitudes,sum(sp.cant_puestos_solic)cantPuestosSoli
from solicitudes_puestos sp
inner join areas ar on sp.cod_area=ar.cod_area
inner join puestos_de_trabajo pue on pue.cod_puesto=sp.cod_puesto
group by 1,2,3,4
order by 5 DESC;

/*
4)STORE PROCEDURE (SP): Desarrollar un SP para el registro inicial del proceso de selección, recibiendo como
parámetros la fecha del día y el legajo del empleado que lanza el proceso.
Tener en cuenta que para cada solicitud de puesto de trabajo activa (no tiene fecha de cancelación) se
deberán registrar las personas que continuarán luego el proceso de selección:
Las personas seleccionadas:
- No deben ser o haber sido empleados de la empresa
- No deben estar participando ya del proceso de selección para la solicitud
- Debe haber una coincidencia en al menos dos de las competencias requeridas para el puesto de trabajo como
excluyentes y las competencias que la persona incluyó en su curriculum.
Recordar que el estado para estos registros será: Iniciado

CREATE PROCEDURE `proceso_seleccion` (in fechaInicio date, in legajoEmp int) 
BEGIN

select cod_estado into @codEstado
from estados
where descripcion="Iniciado";

INSERT INTO proceso_seleccion
SELECT sp.cod_area,sp.cod_puesto,sp.fecha_solic,c.tipo_doc,c.nro_doc,fechaInicio,legajoEmp," ",@codEstado
FROM solicitudes_puestos sp
INNER JOIN puestos_competencias pc ON pc.cod_area = sp.cod_area AND pc.cod_puesto = sp.cod_puesto
INNER JOIN curriculum c ON c.cod_competencia = pc.cod_competencia
WHERE sp.fecha_canc IS NOT NULL AND pc.excluyente = 'SI' 
AND CONCAT(c.tipo_doc, c.nro_doc) NOT IN (SELECT CONCAT(e.tipo_doc, e.nro_doc)
										  FROM empleados e)
AND CONCAT(c.tipo_doc, c.nro_doc) NOT IN (SELECT CONCAT(ps.tipo_doc, ps.nro_doc)
										    FROM  proceso_seleccion ps
											WHERE ps.cod_area = sp.cod_area
											AND ps.cod_puesto = sp.cod_puesto
											AND ps.fecha_solic = sp.fecha_solic)
group by 1,2,3,4,5
having count(distinct(c.cod_competencia)) >= 2;
END
*/

/*
6) Registrar los nuevos valores hora para los puestos de trabajo para ser aplicados a partir del primer día del mes
que viene. Los nuevos valores tendrán el siguiente incremento: para aquellos valores hora menores a $150 se
realizará un incremento del 25%, para los mayores o iguales a $150 el incremento será de un 20%.
*/
start transaction;

drop temporary table if exists ultSalarios;
create temporary table ultSalarios
select cod_area,cod_puesto, max(fecha) maxFecha
from salario
where fecha<current_date()
group by 1,2;

#select * from ultSalarios;

insert into salario
select sa.cod_area,sa.cod_puesto,"2019/12/01",sa.valor_hora*1.25
from salario sa 
inner join ultSalarios us on sa.cod_area=us.cod_area and sa.cod_puesto=us.cod_puesto and sa.fecha=us.maxFecha
where sa.valor_hora<150;

insert into salario
select sa.cod_area,sa.cod_puesto,"2019/12/01",sa.valor_hora*1.2
from salario sa 
inner join ultSalarios us on sa.cod_area=us.cod_area and sa.cod_puesto=us.cod_puesto and sa.fecha=us.maxFecha
where sa.valor_hora>=150;

#Verificacion de los datos, no es para nada
select sa1.cod_area,sa1.cod_puesto,sa1.fecha,sa1.valor_hora,sa2.fecha,sa2.valor_hora
from salario sa1
inner join ultSalarios us on us.cod_area=sa1.cod_area and us.cod_puesto=sa1.cod_puesto and sa1.fecha="2019/12/01"
inner join salario sa2 on us.cod_area=sa2.cod_area and us.cod_puesto=sa2.cod_puesto and sa2.fecha=us.maxFecha;

commit;

delete from salario where fecha="2019/12/01";






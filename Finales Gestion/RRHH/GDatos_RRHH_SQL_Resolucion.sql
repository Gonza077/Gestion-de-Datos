--- 2 
select a.cod_area INTO @area
FROM areas a
where a.denominacion = 'RRHH';

drop temporary table if exists TTempleados_fecha;
create temporary table TTempleados_fecha(
select legajo, max(ep.fecha_ini) 'fecha'
from empleados_puestos ep
where ep.fecha_ini <= current_date()
group by 1);

SELECT tt.legajo, e.apellido, e.nombre, count(distinct(concat(ps.tipo_doc, ps.nro_doc))) cantidad
FROM TTempleados_fecha tt 
INNER JOIN empleados_puestos ep
ON ep.legajo = tt.legajo
AND ep.fecha_ini = tt.fecha
INNER JOIN empleados e
ON e.legajo = tt.legajo
LEFT JOIN proceso_seleccion ps
ON ps.legajo = tt.legajo
WHERE ps.fecha_hora >= '01-01-2018'
AND ep.cod_area = @area
GROUP BY 1,2,3;

-- 3

SELECT count(*) INTO @cant_solic
FROM solicitudes_puestos sp;

SELECT sp.cod_area, a.denominacion, sp.cod_puesto, pt.descripcion, COUNT(*), round(COUNT(*) * 100 / @cant_solic,2) '% Solic',
SUM(sp.cant_puestos_solic) 'Cant.Puestos'
FROM solicitudes_puestos sp
INNER JOIN areas a
ON a.cod_area = sp.cod_area
INNER JOIN puestos_de_trabajo pt
ON pt.cod_puesto = sp.cod_puesto
group by 1,2,3,4
ORDER BY 5 desc;

-- 4

USE `recursos_humanos`;
DROP procedure IF EXISTS `procesoseleccion_ri`;

DELIMITER $$
USE `recursos_humanos`$$
CREATE PROCEDURE `procesoseleccion_ri` (in wfecha datetime, in wlegajo int)
BEGIN

select e.cod_estado INTO @westado from estados e;

INSERT INTO proceso_seleccion
SELECT sp.cod_area, sp.cod_puesto, sp.fecha_solic, c.tipo_doc, c.nro_doc, wfecha, wlegajo, '', westado
FROM solicitudes_puestos sp
INNER JOIN puestos_competencias pc
ON pc.cod_area = sp.cod_area
AND pc.cod_puesto = sp.cod_puesto
INNER JOIN curriculum c
ON c.cod_competencia = pc.cod_competencia
LEFT JOIN empleados e
ON e.tipo_doc = c.tipo_doc
AND e.nro_doc = c.nro_doc
LEFT JOIN proceso_seleccion ps
ON ps.cod_area = sp.cod_area
AND ps.cod_puesto = sp.cod_puesto
AND ps.fecha_solic = sp.fecha_solic
and ps.tipo_doc = c.tipo_doc
AND ps.nro_doc = c.nro_doc
WHERE sp.fecha_canc is not null
AND pc.excluyente = 'SI'
AND ps.legajo is null
AND ps.nro_doc IS NULL
group by 1,2,3,4,5
having count(distinct(c.cod_competencia)) >= 2;

END$$

DELIMITER ;


SELECT 
    sp.cod_area,
    sp.cod_puesto,
    sp.fecha_solic,
    c.tipo_doc,
    c.nro_doc,
    COUNT(DISTINCT (c.cod_competencia))
FROM
    solicitudes_puestos sp
        INNER JOIN
    puestos_competencias pc ON pc.cod_area = sp.cod_area
        AND pc.cod_puesto = sp.cod_puesto
        INNER JOIN
    curriculum c ON c.cod_competencia = pc.cod_competencia
WHERE
    sp.fecha_canc IS NOT NULL
        AND pc.excluyente = 'SI'
        AND CONCAT(c.tipo_doc, c.nro_doc) NOT IN (SELECT CONCAT(e.tipo_doc, e.nro_doc)
													FROM empleados e)
        AND CONCAT(c.tipo_doc, c.nro_doc) NOT IN (SELECT CONCAT(ps.tipo_doc, ps.nro_doc)
													FROM  proceso_seleccion ps
													WHERE ps.cod_area = sp.cod_area
													 AND ps.cod_puesto = sp.cod_puesto
												     AND ps.fecha_solic = sp.fecha_solic)
group by 1,2,3,4,5
having count(distinct(c.cod_competencia)) >= 2;

-- 4
start transaction;
	drop temporary table if exists TTsalarios_fecha;
	create temporary table TTsalarios_fecha(
	select s.cod_area, s.cod_puesto, max(s.fecha) 'fecha'
	from salario s
	where s.fecha <= current_date()
	group by 1,2);
    
    INSERT INTO salario
	SELECT tt.cod_area, tt.cod_puesto, '01-03-2018', round(s.valor_hora * 1.25,2)
	FROM ttsalarios_fecha tt
    INNER JOIN salario s
    ON s.cod_area = tt.cod_area
    and s.cod_puesto = tt.cod_puesto
    AND s.fecha = tt.fecha
    WHERE s.valor_hora >= 150;
    
	    INSERT INTO salario
	SELECT tt.cod_area, tt.cod_puesto, '01-03-2018', round(s.valor_hora * 1.20,2)
	FROM ttsalarios_fecha tt
    INNER JOIN salarios s
    ON s.cod_area = tt.cod_area
    and s.cod_puesto = tt.cod_puesto
    AND s.fecha = tt.fecha
    WHERE s.valor_hora  < 150;
commit;


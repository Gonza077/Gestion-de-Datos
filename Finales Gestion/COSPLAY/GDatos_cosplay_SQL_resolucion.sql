#Ejercicio 1 

SELECT cli.nro,
       cli.cui,
       cli.nombre,
       cli.email,
       count(trabajo.nro),
       sum(trabajo.importe_presup)
FROM cliente cli
JOIN trabajo ON cli.nro = trabajo.nro_cliente
GROUP BY cli.nro, cli.cui, cli.nombre, cli.email
ORDER BY sum(trabajo.importe_presup) DESC , count(trabajo.nro) ASC;

#Ejercicio 2

CREATE TEMPORARY TABLE mat_ultFec AS
  (SELECT codigo_material,
          max(fecha_valor) ult_fec
   FROM costo_material
   WHERE fecha_valor <=current_date()
   GROUP BY codigo_material);


SELECT mat.codigo,
       mat.descripcion,
       mat.unidad_medida,
       mat.color,
       costo.valor_unit
FROM material mat
JOIN costo_material costo ON costo.codigo_material = mat.codigo
JOIN mat_ultFec ON mat_ultFec.codigo_material = costo.codigo_material
AND mat_ultFec.ult_fec = costo.fecha_valor;

#Ejercicio 3 

SELECT nro,
       fecha_limite_conf,
       importe_presup,
       item.nro_item,
       item.detalle,
       tarea.codigo_tipo_tarea,
       tarea.detalle,
       tarea.fecha_hora_inicio,
       tarea.hs_estimadas
FROM trabajo
JOIN item ON trabajo.nro = item.nro_trabajo
JOIN tarea ON tarea.nro_item = item.nro_item
AND tarea.nro_trabajo = item.nro_trabajo
WHERE fecha_confirmacion IS NOT NULL
  AND fecha_fin_confec IS NULL
  AND tarea.fecha_hora_fin IS NULL;

  #Ejercicio 4	
  SELECT nro,
       fecha_limite_conf,
       importe_presup,
       item.nro_item,
       item.detalle,
       tarea.codigo_tipo_tarea,
       tarea.detalle,
       tarea.fecha_hora_inicio,
       tarea.hs_estimadas,
       sum(ifnull(ejecucion_tarea.hs_trabajadas_reales,0))
FROM trabajo
JOIN item ON trabajo.nro = item.nro_trabajo
JOIN tarea ON tarea.nro_item = item.nro_item
AND tarea.nro_trabajo = item.nro_trabajo
LEFT JOIN ejecucion_tarea 
	ON tarea.nro_trabajo=ejecucion_tarea.nro_trabajo
	AND tarea.nro_item=ejecucion_tarea.nro_item
    AND tarea.codigo_tipo_tarea=ejecucion_tarea.codigo_tipo_tarea
WHERE fecha_confirmacion IS NOT NULL
  AND fecha_fin_confec IS NULL
  AND tarea.fecha_hora_fin IS NULL
group by nro,
       fecha_limite_conf,
       importe_presup,
       item.nro_item,
       item.detalle,
       tarea.codigo_tipo_tarea,
       tarea.detalle,
       tarea.fecha_hora_inicio,
       tarea.hs_estimadas; 
       

# Ejercicio 5
CREATE DEFINER=`gestiondatos`@`localhost` PROCEDURE `hs_exceso`(in anio int,in mes int, in mh float)
BEGIN
select art.legajo, art.nombre, art.apellido,
	esp.descripcion, 
    sum(ifnull(hs_trabajadas_reales,0)) hs_totales,
    sum(ifnull(hs_trabajadas_reales,0))-mh exceso
from empleado art
join artesano_especialidad art_esp
	on art.legajo=art_esp.legajo_artesano
join especialidad esp
	on art_esp.codigo_especialidad=esp.codigo
join ejecucion_tarea ejec
	on art.legajo=ejec.legajo_artesano
join tarea tar
	ON tar.nro_trabajo=ejec.nro_trabajo
	AND tar.nro_item=ejec.nro_item
    AND tar.codigo_tipo_tarea=ejec.codigo_tipo_tarea
where year(tar.fecha_hora_inicio)=anio
and month(tar.fecha_hora_inicio)=mes
and tipo='artesano'
group by art.legajo, art.nombre, art.apellido,
	esp.codigo,esp.descripcion
having hs_totales>mh;

END

call hs_exceso(2018,10,10);

# Ejercicio 6
drop temporary table if exists fec_costo_act;
create temporary table fec_costo_act
select codigo_material, max(fecha_valor) ult_fec
from costo_material cm
where fecha_valor<=current_date
group by codigo_material;

begin;

insert into costo_material
select cm.codigo_material, '20181008', cm.valor_unit*1.2
from costo_material cm
join fec_costo_act fca
	on cm.codigo_material=fca.codigo_material
    and cm.fecha_valor=fca.ult_fec
where cm.valor_unit>=2000;

insert into costo_material
select cm.codigo_material, '20181008', cm.valor_unit*1.3
from costo_material cm
join fec_costo_act fca
	on cm.codigo_material=fca.codigo_material
    and cm.fecha_valor=fca.ult_fec
where cm.valor_unit<2000;

select *
from costo_material

commit;
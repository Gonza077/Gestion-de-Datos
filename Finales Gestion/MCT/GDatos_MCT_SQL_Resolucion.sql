/* SQL 1*/
select vm.patente, sum(vm.km_fin - vm.km_ini) kms
from viajes_moviles vm
group by vm.patente
order by kms desc;


/* SQL 2*/
drop temporary table if exists val_act;
create temporary table val_act
(
 select cod_tipo_viaje, max(fecha_desde) fec_val
 from tipos_viajes_valores
 where fecha_desde <= current_date
 group by cod_tipo_viaje
);

select tv.desc_tipo_viaje, vv.valor_km
from tipos_viajes tv
     left join val_act tt
           on  tt.cod_tipo_viaje=tv.cod_tipo_viaje
		left join tipos_viajes_valores vv
           on vv.cod_tipo_viaje=tt.cod_tipo_viaje
               and vv.fecha_desde=tt.fec_val;

/* SQL 3*/
select r.PorcRecargoDiario INTO @recargo 
FROM recargos r 
WHERE r.FechaDesde = (select max(r1.fechadesde) FROM recargos r1);

select @recargo;

SELECT cli.tipo_doc, cli.nro_doc, cli.denominacion, cli.telefono,
	   SUM(cu.importe) Importe , 
       SUM(ROUND(@recargo * (datediff(current_date(), cu.fecha_venc)) * cu.importe / 100,2)) Recargo
from  cuotas cu
INNER JOIN viajes v
ON v.nro_viaje = cu.nro_viaje
INNER JOIN contratos co
ON co.nro_contrato = v.nro_contrato
INNER JOIN clientes cli
ON cli.tipo_doc = co.tipo_doc
AND cli.nro_doc = co.nro_doc
WHERE cu.fecha_pago is null AND cu.fecha_venc < current_date()
GROUP BY 1,2,3,4;


/* SQL 5*/

USE `manolo_carpa_tigre`;
DROP procedure IF EXISTS `sp_moviles_disp`;

DELIMITER $$
USE `manolo_carpa_tigre`$$
CREATE PROCEDURE `sp_moviles_disp` (in wcapacidad INT)
BEGIN
select m.patente, m.capacidad
from moviles m
where m.fecha_baja is null
AND m.patente not in
( select vm.patente
 from viajes v
   inner join viajes_moviles vm
         on v.nro_viaje=vm.nro_viaje
 where v.fecha_cancelacion is null
   AND v.estado = 'En Proceso'
   OR (v.fecha_ini = curdate()
   and v.estado = 'Pendiente'))
   And m.capacidad >= wcapacidad;

END$$

DELIMITER ;

CALL sp_moviles_disp(20);

/* SQL 6*/

START transaction;
	drop temporary table if exists val_act;
	create temporary table val_act
	(
		select cod_tipo_viaje, max(fecha_desde) fec_val
		from tipos_viajes_valores
		where fecha_desde <= current_date
		group by cod_tipo_viaje
	);

	INSERT INTO tipos_viajes_valores
    SELECT tvc.cod_tipo_viaje, '2018-07-09', tvc.valor_km * 1.30
    from tipos_viajes_valores tvc
    INNER JOIN val_act va
    ON va.cod_tipo_viaje = tvc.cod_tipo_viaje
    AND va.fec_val = tvc.fecha_desde
    WHERE tvc.valor_km >= 100;
    
    INSERT INTO tipos_viajes_valores
	SELECT tvc.cod_tipo_viaje, '2018-07-09',tvc.valor_km * 1.25
    from tipos_viajes_valores tvc
    INNER JOIN val_act va
    ON va.cod_tipo_viaje = tvc.cod_tipo_viaje
    AND va.fec_val = tvc.fecha_desde
    WHERE tvc.valor_km < 100;
commit;

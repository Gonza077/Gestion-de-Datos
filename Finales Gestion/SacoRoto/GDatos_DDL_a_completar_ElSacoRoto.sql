# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : saco_roto


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `saco_roto`;

CREATE DATABASE `saco_roto`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `saco_roto`;

#
# Structure for the `materiales` table : 
#

DROP TABLE IF EXISTS `materiales`;

CREATE TABLE `materiales` (
  `cod_material` int(11) NOT NULL,
  `desc_material` varchar(20) NOT NULL,
  `unidad` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `medidas` table : 
#

DROP TABLE IF EXISTS `medidas`;

CREATE TABLE `medidas` (
  `cod_medida` int(11) NOT NULL,
  `desc_medida` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `nro_persona` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `telefono` varchar(20) default NULL,
  `direccion` varchar(50) default NULL,
  `fecha_nac` date default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`nro_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pedidos` table : 
#

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `nro_pedido` int(11) NOT NULL,
  `fecha_hora_pedido` datetime NOT NULL,
  `nro_persona_cliente` int(11) NOT NULL,
  PRIMARY KEY  (`nro_pedido`),
  KEY `pedidos_cliente_fk` (`nro_persona_cliente`),
  CONSTRAINT `pedidos_cliente_fk` FOREIGN KEY (`nro_persona_cliente`) REFERENCES `personas` (`nro_persona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `prendas` table : 
#

DROP TABLE IF EXISTS `prendas`;

CREATE TABLE `prendas` (
  `nro_persona` int(11) NOT NULL,
  `cod_tipo_prenda` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `fecha_fin_est` date default NULL,
  `fecha_fin_real` date default NULL,
  `fecha_entrega` date default NULL,
  `comentarios` varchar(200) default NULL,
  `fecha_medicion` date default NULL,
  `precio_pactado` decimal(11,0) default NULL,
  `confirmada` tinyint(1) default '0',
  `cantidad` int(11) default NULL,
  PRIMARY KEY  (`nro_persona`,`cod_tipo_prenda`,`nro_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `prendas_materiales` table : 
#

DROP TABLE IF EXISTS `prendas_materiales`;

CREATE TABLE `prendas_materiales` (
  `nro_persona` int(11) NOT NULL,
  `cod_tipo_prenda` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `cod_material` int(11) NOT NULL,
  `cant_estimada` decimal(11,0) NOT NULL default '0',
  `cant_real` decimal(11,0) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `prendas_medidas` table : 
#

DROP TABLE IF EXISTS `prendas_medidas`;

CREATE TABLE `prendas_medidas` (
  `nro_persona` int(11) NOT NULL,
  `cod_tipo_prenda` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `cod_medida` int(11) NOT NULL,
  `medicion` decimal(11,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `prendas_sastres` table : 
#

DROP TABLE IF EXISTS `prendas_sastres`;

CREATE TABLE `prendas_sastres` (
  `nro_persona` int(11) NOT NULL,
  `cod_tipo_prenda` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `cuil` varchar(20) NOT NULL,
  `tarea` varchar(200) default NULL,
  `hs_estimadas` decimal(11,0) NOT NULL default '0',
  `hs_reales` decimal(11,0) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pruebas` table : 
#

DROP TABLE IF EXISTS `pruebas`;

CREATE TABLE `pruebas` (
  `nro_persona` int(11) NOT NULL,
  `cod_tipo_prenda` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `fecha_prueba` date NOT NULL,
  `comentarios_sastre` varchar(200) default NULL,
  `comentarios_persona` varchar(200) default NULL,
  `info_ajustes` varchar(200) default NULL,
  PRIMARY KEY  (`nro_persona`,`cod_tipo_prenda`,`nro_pedido`,`fecha_prueba`),
  CONSTRAINT `pruebas_prendas_fk` FOREIGN KEY (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`) REFERENCES `prendas` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `sastres` table : 
#

DROP TABLE IF EXISTS `sastres`;

CREATE TABLE `sastres` (
  `cuil` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `direccion` varchar(50) default NULL,
  `cbu` varchar(22) NOT NULL,
  `cuil_jefe` varchar(20) default NULL,
  PRIMARY KEY  (`cuil`),
  KEY `sastres_jefe_sastre_fk` (`cuil_jefe`),
  CONSTRAINT `sastres_jefe_sastre_fk` FOREIGN KEY (`cuil_jefe`) REFERENCES `sastres` (`cuil`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_prendas` table : 
#

DROP TABLE IF EXISTS `tipos_prendas`;

CREATE TABLE `tipos_prendas` (
  `cod_tipo_prenda` int(11) NOT NULL,
  `desc_tipo_prenda` varchar(50) NOT NULL,
  PRIMARY KEY  (`cod_tipo_prenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_hora_sastres` table : 
#

DROP TABLE IF EXISTS `valores_hora_sastres`;

CREATE TABLE `valores_hora_sastres` (
  `fecha_desde` date NOT NULL,
  `valor_hora` decimal(11,0) NOT NULL,
  PRIMARY KEY  (`fecha_desde`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_materiales` table : 
#

DROP TABLE IF EXISTS `valores_materiales`;

CREATE TABLE `valores_materiales` (
  `cod_material` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor_material` decimal(11,0) NOT NULL,
  PRIMARY KEY  (`cod_material`,`fecha_desde`),
  CONSTRAINT `valores_materiales_materiales_fk` FOREIGN KEY (`cod_material`) REFERENCES `materiales` (`cod_material`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `materiales` table  (LIMIT 0,500)
#

INSERT INTO `materiales` (`cod_material`, `desc_material`, `unidad`) VALUES 
  (1,'Tela Metálica','m2'),
  (2,'Raso','m2'),
  (3,'Botón plateado','c/u'),
  (4,'Botón forrado','c/u'),
  (5,'Seda','m2'),
  (6,'Hilo dorado','m'),
  (7,'Alpaca','m2'),
  (8,'Cashmilon','m2');

COMMIT;

#
# Data for the `medidas` table  (LIMIT 0,500)
#

INSERT INTO `medidas` (`cod_medida`, `desc_medida`) VALUES 
  (1,'Hombros'),
  (2,'Cintura'),
  (3,'Cadera'),
  (4,'Pierna'),
  (5,'Brazo');

COMMIT;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`nro_persona`, `nombre`, `apellido`, `telefono`, `direccion`, `fecha_nac`, `email`) VALUES 
  (1,'Roger','Bacon','111-111111','Moreno 1111','1981-11-11','rogba81@gmail.com'),
  (2,'Denis','Papin','222-222222','Salta 222','1982-12-22','dpapin@yahoo.com.ar'),
  (3,'Mary','Quant','333-333333','Maipu 333 3° C','1983-03-13','jety@gmail.com'),
  (4,'Raúl','Pérez','444-444444','Ituzaingo 444','1984-04-14','perezperez@gmail.com'),
  (5,'Sandra','Vargas','555-555555','Ituzaingo 444','1985-05-15','sandiva85@gmail.com'),
  (6,'Andrea','Vargas','666-666666','Catamarca 666','1986-06-16','andreavargas@yahoo.com.ar'),
  (7,'Christiaan','Huygens','777-777777','Nansen 777','1987-07-17','chris@huygens.com.ar');

COMMIT;

#
# Data for the `pedidos` table  (LIMIT 0,500)
#

INSERT INTO `pedidos` (`nro_pedido`, `fecha_hora_pedido`, `nro_persona_cliente`) VALUES 
  (1,'2013-10-11 10:10:00',1),
  (2,'2013-10-17 14:10:00',2),
  (3,'2013-10-24 09:10:00',3),
  (4,'2013-11-07 14:10:00',4),
  (5,'2013-11-15 11:14:00',6),
  (6,'2013-11-16 17:00:00',7),
  (7,'2013-11-27 09:00:00',1);

COMMIT;

#
# Data for the `prendas` table  (LIMIT 0,500)
#

INSERT INTO `prendas` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`, `fecha_fin_est`, `fecha_fin_real`, `fecha_entrega`, `comentarios`, `fecha_medicion`, `precio_pactado`, `confirmada`, `cantidad`) VALUES 
  (1,2,7,'2013-12-17',NULL,'2013-12-23','Es para la graduación del hijo, tiene que estar para esa fecha si o si','2013-12-02',NULL,0,1),
  (2,1,1,'2013-11-05','2013-11-17','2013-11-07','Color verde','2013-10-18',933,1,1),
  (2,4,2,'2013-11-01','2013-11-05','2013-11-01','Corto justo a la cintura','2013-10-24',557,1,2),
  (3,13,3,'2013-11-15','2013-11-13','2013-11-17','Mas largo que necesite tacos para que no se arrastre','2013-10-31',2954,1,1),
  (4,12,4,'2013-12-25',NULL,'2013-12-30','Traje del Novio \"Blanco\"','2013-11-13',2913,1,1),
  (5,8,4,'2013-12-25',NULL,'2013-12-30','Vestido largo, sencillo y sin breteles','2013-11-13',6573,1,1),
  (5,9,4,'2013-12-25','2013-11-27','2013-12-30','Identica tela a la del vestido','2013-11-13',921,1,2),
  (6,11,4,'2013-12-29',NULL,'2014-01-01','Sencillo, color salmón, cómodo para la fiesta','2013-11-13',3651,1,1),
  (6,13,6,'2013-11-28',NULL,'2013-12-02','Rojo con detalles en dorado. Cliente jodido','2013-11-21',3231,1,1),
  (7,1,5,'2013-12-07',NULL,'2013-12-11','La camisa aplia en el cuello. Traje negro camisa azul francia','2013-11-21',1472,1,1),
  (7,2,6,'2013-11-29','2013-11-30','2013-11-29','No le gusta las mangas muy cortas y aplia la espalda que no restrinja el movimiento color gris','2013-11-21',568,1,2);

COMMIT;

#
# Data for the `prendas_materiales` table  (LIMIT 0,500)
#

INSERT INTO `prendas_materiales` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`, `cod_material`, `cant_estimada`, `cant_real`) VALUES 
  (2,1,1,1,6,7),
  (2,1,1,3,11,12),
  (2,4,2,1,4,7),
  (2,4,2,3,8,8),
  (3,13,3,5,9,7),
  (3,13,3,6,12,9),
  (4,12,4,3,11,11),
  (4,12,4,7,8,5),
  (5,8,4,2,3,1),
  (5,8,4,5,15,4),
  (5,9,4,5,2,2),
  (5,9,4,6,5,4),
  (6,11,4,2,2,0),
  (6,11,4,5,8,2),
  (6,11,4,6,5,0),
  (6,13,6,5,8,4),
  (6,13,6,6,5,1),
  (7,1,5,4,11,0),
  (7,1,5,7,6,2),
  (7,2,6,1,4,6),
  (7,2,6,3,11,11);

COMMIT;

#
# Data for the `prendas_medidas` table  (LIMIT 0,500)
#

INSERT INTO `prendas_medidas` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`, `cod_medida`, `medicion`) VALUES 
  (2,1,1,1,58),
  (2,1,1,2,75),
  (2,1,1,3,78),
  (2,1,1,5,47),
  (2,4,2,1,56),
  (2,4,2,2,70),
  (3,13,3,1,45),
  (3,13,3,2,76),
  (3,13,3,3,96),
  (3,13,3,4,70),
  (4,12,4,1,61),
  (4,12,4,2,80),
  (4,12,4,3,85),
  (4,12,4,4,77),
  (4,12,4,5,60),
  (5,8,4,2,68),
  (5,8,4,3,83),
  (5,8,4,4,72),
  (5,9,4,1,43),
  (5,9,4,5,55),
  (6,11,4,1,50),
  (6,11,4,2,67),
  (6,11,4,3,82),
  (6,11,4,4,74),
  (6,13,6,1,45),
  (6,13,6,2,62),
  (6,13,6,3,73),
  (6,13,6,4,69),
  (7,1,5,1,60),
  (7,1,5,2,80),
  (7,1,5,3,86),
  (7,1,5,4,80),
  (7,1,5,5,60),
  (7,2,6,1,60),
  (7,2,6,2,80),
  (7,2,6,3,86),
  (7,2,6,5,60);

COMMIT;

#
# Data for the `prendas_sastres` table  (LIMIT 0,500)
#

INSERT INTO `prendas_sastres` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`, `cuil`, `tarea`, `hs_estimadas`, `hs_reales`) VALUES 
  (1,2,7,'12-12121212-1','todo',4,0),
  (2,1,1,'12-12121212-1','medición y materiales',5,7),
  (2,1,1,'16-16161616-1','confección',17,9),
  (2,1,1,'17-17171717-1','ajustes',3,3),
  (2,4,2,'14-14141414-1','confeccion y materiales',7,12),
  (2,4,2,'17-17171717-1','medicion y ajuste',8,6),
  (3,13,3,'12-12121212-1','medicion, materiales y confeccion',23,32),
  (3,13,3,'14-14141414-1','ajustes',4,7),
  (4,12,4,'10-10101010-1','pantalon y saco',20,12),
  (4,12,4,'12-12121212-1','camisa y chaleco',12,8),
  (4,12,4,'17-17171717-1','ajustes',16,9),
  (5,8,4,'12-12121212-1','medicion, materiales y confeccion',45,39),
  (5,8,4,'16-16161616-1','ajustes',14,2),
  (5,9,4,'16-16161616-1','todo',8,15),
  (6,11,4,'10-10101010-1','todo',32,18),
  (6,13,6,'10-10101010-1','medicion, materiales y confeccion',23,0),
  (6,13,6,'14-14141414-1','ajustes',4,0),
  (7,1,5,'10-10101010-1','confeccion',14,4),
  (7,1,5,'12-12121212-1','medición y materiales',3,1),
  (7,1,5,'17-17171717-1','ajuste',2,1),
  (7,2,6,'14-14141414-1','materiales y medicion',5,4),
  (7,2,6,'17-17171717-1','confeccion y ajustes',5,7);

COMMIT;

#
# Data for the `pruebas` table  (LIMIT 0,500)
#

INSERT INTO `pruebas` (`nro_persona`, `cod_tipo_prenda`, `nro_pedido`, `fecha_prueba`, `comentarios_sastre`, `comentarios_persona`, `info_ajustes`) VALUES 
  (2,1,1,'2013-10-26','es ligeremente grande','me queda como carpa','marcado los ajustes con alfileres'),
  (2,1,1,'2013-10-29','arreglar un par de costuras mal hechas en los hombros','molestan las costuras','descoser y rehacer'),
  (2,1,1,'2013-11-02','le queda bien','conforme',NULL),
  (2,4,2,'2013-10-28','acortar de largo','un poco largo','acortar 2 cm'),
  (2,4,2,'2013-10-29','largo justo',NULL,NULL),
  (3,13,3,'2013-11-03','el cliente está loco','es feo','ni idea que quiere, mostrarle lo mismo de nuevo'),
  (3,13,3,'2013-11-06','ahora le gusta','está hermoso','coser de acuerdo a los alfileres'),
  (3,13,3,'2013-11-13','Cliente conforme',NULL,NULL),
  (4,12,4,'2013-12-04',NULL,NULL,NULL),
  (4,12,4,'2013-12-15',NULL,NULL,NULL),
  (4,12,4,'2013-12-20',NULL,NULL,NULL),
  (5,8,4,'2013-12-04',NULL,NULL,NULL),
  (5,8,4,'2013-12-22',NULL,NULL,NULL),
  (5,8,4,'2013-12-24',NULL,NULL,NULL),
  (5,9,4,'2013-12-08',NULL,NULL,NULL),
  (5,9,4,'2013-12-19',NULL,NULL,NULL),
  (5,9,4,'2013-12-21',NULL,NULL,NULL),
  (6,11,4,'2013-12-11',NULL,NULL,NULL),
  (6,11,4,'2013-12-21',NULL,NULL,NULL),
  (6,11,4,'2013-12-27',NULL,NULL,NULL),
  (6,13,6,'2013-11-24','Le queda perfecto, se queja porque quiere un descuento','es incómodo','no hay ajustes'),
  (7,1,5,'2013-12-03',NULL,NULL,NULL),
  (7,1,5,'2013-12-05',NULL,NULL,NULL),
  (7,2,6,'2013-11-22',NULL,NULL,NULL);

COMMIT;

#
# Data for the `sastres` table  (LIMIT 0,500)
#

INSERT INTO `sastres` (`cuil`, `nombre`, `apellido`, `direccion`, `cbu`, `cuil_jefe`) VALUES 
  ('10-10101010-1','Samuel','Colt','Arijon 1010','1010101010101010101010','15-15151515-1'),
  ('11-11111111-1','Enrico',' Fermi','Juan Manuel de Rosas 1111','1111111111111111111111','13-13131313-1'),
  ('12-12121212-1','Robert',' Fulton','Bs. As. 1212','1212121212121212121212','13-13131313-1'),
  ('13-13131313-1','Joseph',' Guillotín','Lima 1313','1313131313131313131313',NULL),
  ('14-14141414-1','Auguste',' Lacoste','Avellaneda 141','1414141414141414141414','13-13131313-1'),
  ('15-15151515-1','Nikola','Tesla','Laprida 151','1515151515151515151515',NULL),
  ('16-16161616-1','Denis','Papin','Italia 1616','1616161616161616161616','15-15151515-1'),
  ('17-17171717-1','Ángelo',' Salmoraighi','Francia 1717','1717171717171717171717','13-13131313-1');

COMMIT;

#
# Data for the `tipos_prendas` table  (LIMIT 0,500)
#

INSERT INTO `tipos_prendas` (`cod_tipo_prenda`, `desc_tipo_prenda`) VALUES 
  (1,'Traje'),
  (2,'Saco cruzado'),
  (3,'Vestido de Noche'),
  (4,'Chaleco'),
  (5,'Vestido de Novia Tipo 1'),
  (6,'Vestido de 15'),
  (7,'Vestido de Novia Tipo 2'),
  (8,'Vestido de Novia Tipo 3'),
  (9,'Chall'),
  (10,'Vestido Corto Madrina'),
  (11,'Vestido Largo Madrina'),
  (12,'Traje del Novio'),
  (13,'Vestido de fiesta largo');

COMMIT;

#
# Data for the `valores_hora_sastres` table  (LIMIT 0,500)
#

INSERT INTO `valores_hora_sastres` (`fecha_desde`, `valor_hora`) VALUES 
  ('2009-10-01',20),
  ('2009-10-20',22),
  ('2009-11-05',28),
  ('2009-11-29',35),
  ('2010-01-02',38);

COMMIT;

#
# Data for the `valores_materiales` table  (LIMIT 0,500)
#

INSERT INTO `valores_materiales` (`cod_material`, `fecha_desde`, `valor_material`) VALUES 
  (1,'2013-10-01',20),
  (1,'2013-10-31',24),
  (1,'2013-11-22',34),
  (1,'2013-12-20',39),
  (2,'2013-10-01',70),
  (2,'2013-11-09',95),
  (2,'2013-11-28',119),
  (2,'2013-12-19',138),
  (3,'2013-10-04',0),
  (3,'2013-11-06',0),
  (3,'2013-11-12',0),
  (3,'2013-12-27',0),
  (4,'2013-10-05',0),
  (4,'2013-11-02',0),
  (4,'2013-11-20',0),
  (4,'2013-11-30',0),
  (4,'2013-12-21',0),
  (5,'2013-10-03',140),
  (5,'2013-10-27',168),
  (5,'2013-11-20',189),
  (5,'2013-11-29',238),
  (6,'2013-10-03',8),
  (6,'2013-10-24',10),
  (6,'2013-11-05',11),
  (6,'2013-12-21',16),
  (7,'2013-10-02',62),
  (7,'2013-11-05',74),
  (7,'2013-12-04',105),
  (7,'2013-12-27',122);

COMMIT;


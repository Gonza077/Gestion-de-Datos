# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : viejos_amigos_instalaciones


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `VA_alquileres`;

CREATE DATABASE `VA_alquileres`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `VA_alquileres`;

#
# Structure for the `contrata` table : 
#

DROP TABLE IF EXISTS `contrata`;

CREATE TABLE `contrata` (
  `NroEvento` int(11) NOT NULL,
  `CodInstalacion` int(11) NOT NULL,
  `fechadesde` date NOT NULL,
  `horadesde` time NOT NULL,
  `CodServicio` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `empleados` table : 
#

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `cuil` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `fechanac` date NOT NULL,
  `fechaing` date NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_evento` table : 
#

DROP TABLE IF EXISTS `tipos_evento`;

CREATE TABLE `tipos_evento` (
  `CodTipoEvento` int(11) NOT NULL,
  `DescTipoEvento` varchar(20) NOT NULL,
  PRIMARY KEY  (`codtipoevento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `organizadores` table : 
#

DROP TABLE IF EXISTS `organizadores`;

CREATE TABLE `organizadores` (
  `cuit` varchar(20) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  `direccion` varchar(50) default NULL,
  PRIMARY KEY  (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `eventos` table : 
#

DROP TABLE IF EXISTS `eventos`;

CREATE TABLE `eventos` (
  `NroEvento` int(11) NOT NULL,
  `fechacontrato` date NOT NULL,
  `representante` varchar(50) NOT NULL,
  `telrepresentante` varchar(20) NOT NULL,
  `CodTipoEvento` int(11) NOT NULL,
  `CuitOrganizador` varchar(20) NOT NULL,
  `CuilEmpleado` varchar(20) NOT NULL,
  PRIMARY KEY  (`NroEvento`),
  KEY `evento_fk` (`CodTipoEvento`),
  KEY `evento_fk1` (`CuitOrganizador`),
  KEY `cuil_empleado` (`CuilEmpleado`),
  CONSTRAINT `evento_fk` FOREIGN KEY (`CodTipoEvento`) REFERENCES `tipos_evento` (`CodTipoEvento`) ON UPDATE CASCADE,
  CONSTRAINT `evento_fk1` FOREIGN KEY (`CuitOrganizador`) REFERENCES `organizadores` (`cuit`) ON UPDATE CASCADE,
  CONSTRAINT `evento_fk2` FOREIGN KEY (`CuilEmpleado`) REFERENCES `empleados` (`cuil`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones` table : 
#

DROP TABLE IF EXISTS `instalaciones`;

CREATE TABLE `instalaciones` (
  `CodInstalacion` int(11) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `CantMaxPer` int(11) NOT NULL,
  `TipoInstalacion` varchar(20) NOT NULL,
  PRIMARY KEY  (`CodInstalacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones_eventos` table : 
#

DROP TABLE IF EXISTS `instalaciones_eventos`;

CREATE TABLE `instalaciones_eventos` (
  `NroEvento` int(11) NOT NULL,
  `CodInstalacion` int(11) NOT NULL,
  `fechadesde` date NOT NULL,
  `horadesde` time NOT NULL,
  `fechahasta` date NOT NULL,
  `horahasta` time NOT NULL,
  `cantpersonas` int(11) NOT NULL,
  `valorpactado` decimal(9,3) NOT NULL,
  PRIMARY KEY  (`NroEvento`,`codinstalacion`,`fechadesde`,`horadesde`),
  KEY `utiliza_fk1` (`codinstalacion`),
  CONSTRAINT `utiliza_fk` FOREIGN KEY (`NroEvento`) REFERENCES `eventos` (`NroEvento`) ON UPDATE CASCADE,
  CONSTRAINT `utiliza_fk1` FOREIGN KEY (`codinstalacion`) REFERENCES `instalaciones` (`codinstalacion`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `CodServicio` INT NOT NULL,
  `DescServicio` varchar(50) NOT NULL,
  PRIMARY KEY  (`CodServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones_servicios` table : 
#

DROP TABLE IF EXISTS `instalaciones_servicios`;

CREATE TABLE `instalaciones_servicios` (
  `CodInstalacion` int(11) NOT NULL,
  `CodServicio` int NOT NULL,
  PRIMARY KEY  (`CodInstalacion`,`CodServicio`),
  CONSTRAINT `instalaciones_servicios_fk` FOREIGN KEY (`CodInstalacion`) REFERENCES `instalaciones` (`CodInstalacion`) ON UPDATE CASCADE,
  CONSTRAINT `instalaciones_servicios_fk1` FOREIGN KEY (`CodServicio`) REFERENCES `servicios` (`CodServicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_evento_instalaciones` table : 
#

DROP TABLE IF EXISTS `tipos_evento_instalaciones`;

CREATE TABLE `tipos_evento_instalaciones` (
  `codtipoevento` int(11) NOT NULL,
  `CodInstalacion` int(11) NOT NULL,
  PRIMARY KEY  (`codtipoevento`,`CodInstalacion`),
  KEY `tipos_evento_instalaciones_fk1` (`CodInstalacion`),
  CONSTRAINT `tipos_evento_instalaciones_fk` FOREIGN KEY (`codtipoevento`) REFERENCES `tipos_evento` (`codtipoevento`) ON UPDATE CASCADE,
  CONSTRAINT `tipos_evento_instalaciones_fk1` FOREIGN KEY (`CodInstalacion`) REFERENCES `instalaciones` (`CodInstalacion`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_servicios` table : 
#

DROP TABLE IF EXISTS `valores_servicios`;

CREATE TABLE `valores_servicios` (
  `CodServicio` int NOT NULL,
  `fechadesde` date NOT NULL,
  `valor` DECIMAL(9,3) NOT NULL,
  PRIMARY KEY  (`CodServicio`,`fechadesde`),
  CONSTRAINT `valores_servicios_servicios_fk` FOREIGN KEY (`CodServicio`) REFERENCES `servicios` (`CodServicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `contrata` table  (LIMIT 0,500)
#

INSERT INTO `contrata` (`NroEvento`, `CodInstalacion`, `fechadesde`, `horadesde`, `CodServicio`, `cantidad`) VALUES 
  (1,9,'2016-03-09','21:00:00',4,1200),
  (1,9,'2016-03-09','21:00:00',5,1200),
  (1,9,'2016-03-09','21:00:00',6,1),
  (1,9,'2016-03-09','21:00:00',10,1),
  (1,9,'2016-03-09','21:00:00',11,1),
  (2,1,'2016-05-02','21:00:00',4,80),
  (2,1,'2016-05-02','21:00:00',11,1),
  (2,2,'2016-05-03','01:00:00',4,120),
  (2,2,'2016-05-03','01:00:00',5,120),
  (2,2,'2016-05-03','01:00:00',6,1),
  (2,2,'2016-05-03','01:00:00',11,1),
  (3,7,'2016-05-20','21:00:00',7,3),
  (3,7,'2016-05-20','21:00:00',12,150),
  (4,1,'2016-07-17','17:00:00',4,80),
  (4,1,'2016-07-17','17:00:00',5,80),
  (4,1,'2016-07-17','17:00:00',6,1),
  (4,1,'2016-07-17','17:00:00',10,1),
  (4,1,'2016-07-17','17:00:00',11,1),
  (4,2,'2016-07-17','17:00:00',4,120),
  (4,2,'2016-07-17','17:00:00',5,120),
  (4,2,'2016-07-17','17:00:00',6,1),
  (4,2,'2016-07-17','17:00:00',10,1),
  (4,2,'2016-07-17','17:00:00',11,1),
  (4,8,'2016-07-17','17:00:00',4,240),
  (4,8,'2016-07-17','17:00:00',5,240),
  (4,8,'2016-07-17','17:00:00',6,1),
  (4,8,'2016-07-17','17:00:00',10,1),
  (4,8,'2016-07-17','17:00:00',11,1),
  (5,4,'2016-06-17','13:00:00',2,1),
  (5,4,'2016-06-17','13:00:00',7,1),
  (5,4,'2016-06-17','13:00:00',8,1),
  (5,4,'2016-06-17','13:00:00',9,1),
  (5,11,'2016-06-17','13:00:00',2,1),
  (5,11,'2016-06-17','13:00:00',7,1),
  (5,11,'2016-06-17','13:00:00',8,1),
  (5,11,'2016-06-17','13:00:00',9,1),
  (5,13,'2016-06-17','16:00:00',2,1),
  (5,13,'2016-06-17','16:00:00',7,1),
  (5,13,'2016-06-17','16:00:00',8,1),
  (5,13,'2016-06-17','16:00:00',9,1);

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

INSERT INTO `empleados` (`cuil`, `nombre`, `apellido`, `fechanac`, `fechaing`, `direccion`, `telefono`, `email`) VALUES 
  ('11-11111111-1','Eliseo','Garcia','1971-01-01','2000-01-01','Tucuman 111 piso 1 dpto 1','411-111111','eliseogarcia@gmail.com'),
  ('22-22222222-2','Andres','Tiagio','1972-02-02','2000-02-02','San Juan 2222','422-222222','atiagio@gmail.com'),
  ('33-33333333-3','Aquiles','Ruis','1973-03-03','2000-03-03','Uriburi 3333','433-333333','aqiru@gmail.com'),
  ('44-44444444-4','Gonzalo','Gonzalez','1974-04-04','2002-04-04','Buenos Aires 44','444-444444','gongon@gmail.com'),
  ('55-55555555-5','Bruno','Díaz','1975-05-05','2002-05-05','Laprida 5555','455-555555','batman@gmail.com');

COMMIT;

#
# Data for the `tipos_evento` table  (LIMIT 0,500)
#

INSERT INTO `tipos_evento` (`codtipoevento`, `desctipoevento`) VALUES 
  (1,'Casamiento'),
  (2,'Reunion'),
  (3,'Competencia'),
  (4,'Fiesta'),
  (5,'Recital');

COMMIT;

#
# Data for the `organizadores` table  (LIMIT 0,500)
#

INSERT INTO `organizadores` (`cuit`, `razon_social`, `telefono`, `email`, `direccion`) VALUES 
  ('66-66666666-6','Reuniones Improvisadas','466-666666','contacto@reunionesimprovisadas.com.ar','Mendoza 6666 dpto 6'),
  ('77-77777777-7','Casorio por conveniencia','477-777777','info@reunionesimprovisadas.com.ar','Cordoba 777'),
  ('88-88888888-8','Torneos Ganar o Perder','488-888888','info@torneosgp.com','Lima 888'),
  ('99-99999999-9','Roll & Rock','499-999999','info@rollnrock.com.ar','Valparaiso 999');

COMMIT;

#
# Data for the `eventos` table  (LIMIT 0,500)
#

INSERT INTO `eventos` (`NroEvento`, `fechacontrato`, `representante`, `telrepresentante`, `codtipoevento`, `cuitorganizador`, `cuilempleado`) VALUES 
  (1,'2016-02-10','Diana Prince','155-111111',1,'77-77777777-7','55-55555555-5'),
  (2,'2016-03-03','James Howlett','155-222222',4,'66-66666666-6','44-44444444-4'),
  (3,'2016-03-21','Barbara Gordon','155-333333',5,'99-99999999-9','33-33333333-3'),
  (4,'2016-04-18','Kurt Wagner','155-444444',4,'66-66666666-6','22-22222222-2'),
  (5,'2016-04-18','Sara Pezzini','155-555555',4,'88-88888888-8','22-22222222-2');

COMMIT;

#
# Data for the `instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones` (`CodInstalacion`, `ubicacion`, `cantmaxper`, `tipoinstalacion`) VALUES 
  (1,'norte',100,'Carpa'),
  (2,'sureste',150,'Salón'),
  (3,'sur',300,'Pileta'),
  (4,'noreste',50,'Cancha de tenis'),
  (5,'noreste',20,'Cancha de paddle'),
  (6,'oeste',3500,'Cancha de futbol'),
  (7,'este',6000,'Estadio Cubierto'),
  (8,'centro',300,'Carpa'),
  (9,'suroeste',1500,'Salón'),
  (11,'noreste',50,'Cancha de tenis'),
  (12,'noreste',20,'Cancha de paddle'),
  (13,'noreste',50,'Cancha de tenis'),
  (14,'noreste',20,'Cancha de paddle');

COMMIT;

#
# Data for the `instalaciones_eventos` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones_eventos` (`NroEvento`, `codinstalacion`, `fechadesde`, `horadesde`, `fechahasta`, `horahasta`, `cantpersonas`, `valorpactado`) VALUES 
  (1,9,'2016-03-09','21:00:00','2016-03-10','08:00:00',1200,32373),
  (2,1,'2016-05-02','21:00:00','2016-05-03','01:00:00',80,2158),
  (2,2,'2016-05-03','01:00:00','2016-05-03','08:00:00',120,3238),
  (3,7,'2016-05-20','21:00:00','2016-05-21','08:00:00',4000,107910),
  (4,1,'2016-07-17','17:00:00','2016-07-18','08:00:00',80,2158),
  (4,2,'2016-07-17','17:00:00','2016-07-18','08:00:00',120,3238),
  (4,8,'2016-07-17','17:00:00','2016-07-18','08:00:00',240,4905),
  (5,4,'2016-06-17','13:00:00','2016-06-17','17:00:00',40,1080),
  (5,11,'2016-06-17','13:00:00','2016-06-17','19:00:00',40,750),
  (5,13,'2016-06-17','16:00:00','2016-06-17','20:00:00',40,1080);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`CodServicio`, `DescServicio`) VALUES 
  (1,'arbitros para partido de futbol'),
  (2,'ball bays para canchas'),
  (3,'bañeros para competencia de natacion'),
  (4,'catering'),
  (5,'cotillon: disfraces, sombreros y souvenires'),
  (6,'decorado salon o carpa'),
  (7,'emergencias: paramedicos y transporte'),
  (8,'jueces de linea para tenis'),
  (9,'juez de silla para tenis o paddle'),
  (10,'musica y show'),
  (11,'dj, equipo de musica y luces'),
  (12,'seguridad');

COMMIT;

#
# Data for the `instalaciones_servicios` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones_servicios` (`codinstalacion`, `CodServicio`) VALUES 
  (1,4),
  (1,5),
  (1,6),
  (1,10),
  (1,11),
  (2,4),
  (2,5),
  (2,6),
  (2,10),
  (2,11),
  (3,3),
  (3,7),
  (4,2),
  (4,7),
  (4,8),
  (4,9),
  (5,2),
  (5,7),
  (5,9),
  (6,1),
  (6,7),
  (7,7),
  (7,12),
  (8,4),
  (8,5),
  (8,6),
  (8,10),
  (8,11),
  (9,4),
  (9,5),
  (9,6),
  (9,10),
  (9,11),
  (11,2),
  (11,7),
  (11,8),
  (11,9),
  (12,2),
  (12,7),
  (12,9),
  (13,2),
  (13,7),
  (13,8),
  (13,9),
  (14,2),
  (14,7),
  (14,9);

COMMIT;

#
# Data for the `tipos_evento_instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `tipos_evento_instalaciones` (`CodTipoEvento`, `CodInstalacion`) VALUES 
  (1,1),
  (2,1),
  (4,1),
  (1,2),
  (2,2),
  (4,2),
  (3,3),
  (3,4),
  (3,5),
  (3,6),
  (5,7),
  (1,8),
  (2,8),
  (4,8),
  (1,9),
  (2,9),
  (4,9),
  (3,11),
  (3,12),
  (3,13),
  (3,14);

COMMIT;

#
# Data for the `valores_servicios` table  (LIMIT 0,500)
#

INSERT INTO `valores_servicios` (`codservicio`, `fechadesde`, `valor`) VALUES 
  (1,'2016-01-04',800),
  (1,'2016-04-05',984),
  (1,'2016-06-12',1191),
  (2,'2016-01-04',200),
  (2,'2016-04-05',246),
  (2,'2016-06-12',297),
  (3,'2016-01-04',500),
  (3,'2016-04-05',615),
  (3,'2016-06-12',744),
  (4,'2016-01-04',100),
  (4,'2016-02-15',115),
  (4,'2016-06-12',148),
  (5,'2016-01-04',800),
  (5,'2016-02-15',75),
  (5,'2016-06-12',96),
  (6,'2016-01-04',10000),
  (6,'2016-02-15',11500),
  (6,'2016-06-12',14889),
  (7,'2016-01-04',5000),
  (7,'2016-04-05',6152),
  (7,'2016-06-12',7444),
  (8,'2016-01-04',100),
  (8,'2016-04-05',123),
  (8,'2016-06-12',148),
  (9,'2016-01-04',50),
  (9,'2016-04-05',61),
  (9,'2016-06-12',74),
  (10,'2016-01-04',1000),
  (10,'2016-02-15',1150),
  (10,'2016-06-12',1488),
  (11,'2016-01-04',2500),
  (11,'2016-04-05',3076),
  (11,'2016-07-12',3200),
  (12,'2016-01-04',2000),
  (12,'2016-04-05',2461),
  (12,'2016-07-07',2977);

COMMIT;


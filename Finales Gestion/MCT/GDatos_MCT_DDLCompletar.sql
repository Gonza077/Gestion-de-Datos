-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: manolo_carpa_tigre
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `choferes`
--
DROP database IF EXISTS manolo_carpa_tigre;
CREATE database manolo_carpa_tigre;
USE manolo_carpa_tigre;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `choferes` (
  `cuil` char(20) NOT NULL,
  `carnet` varchar(20) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `nom_ape` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choferes`
--

LOCK TABLES `choferes` WRITE;
/*!40000 ALTER TABLE `choferes` DISABLE KEYS */;
INSERT INTO `choferes` VALUES ('12-12121212-1','3-12121212-B3','1982-06-01','Helen Keller','121-212121','San Mart','helen@kellerfoundation.org'),('13-13131313-1','3-13131313-B3','1988-08-08','Edmund Hillary','131-313131','Cerrito 1313','edhi@gmail.com'),('14-14141414-1','3-14141414-B5','1972-02-03','Marya Salom','141-414141','Francia 141 Bis','radioactivo@gmail.com'),('15-15151515-1','3-15151515-B5','1980-02-29','Blaise Pascal','151-515151','Cordoba 1515',NULL),('16-16161616-1','3-16161616-b5','1976-08-14','Victor Hugo','161-616161','Espa',NULL);
/*!40000 ALTER TABLE `choferes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choferes_turnos`
--

DROP TABLE IF EXISTS `choferes_turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `choferes_turnos` (
  `cuil` char(20) NOT NULL,
  `cod_turno` int(11) NOT NULL,
  `fecha_turno` date NOT NULL
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choferes_turnos`
--

LOCK TABLES `choferes_turnos` WRITE;
/*!40000 ALTER TABLE `choferes_turnos` DISABLE KEYS */;
INSERT INTO `choferes_turnos` VALUES ('12-12121212-1',1,'2013-09-17'),('12-12121212-1',1,'2013-11-26'),('12-12121212-1',1,'2018-04-17'),('12-12121212-1',1,'2018-06-26'),('13-13131313-1',1,'2013-09-12'),('13-13131313-1',1,'2013-11-15'),('13-13131313-1',1,'2018-04-12'),('13-13131313-1',1,'2018-06-15'),('14-14141414-1',1,'2013-09-07'),('14-14141414-1',1,'2013-09-14'),('14-14141414-1',1,'2018-04-07'),('14-14141414-1',1,'2018-04-14'),('15-15151515-1',1,'2013-09-21'),('15-15151515-1',1,'2013-10-05'),('15-15151515-1',1,'2013-10-13'),('15-15151515-1',1,'2013-10-21'),('15-15151515-1',1,'2013-10-23'),('15-15151515-1',1,'2013-10-26'),('15-15151515-1',1,'2013-11-10'),('15-15151515-1',1,'2013-11-21'),('15-15151515-1',1,'2018-04-21'),('15-15151515-1',1,'2018-05-05'),('15-15151515-1',1,'2018-05-13'),('15-15151515-1',1,'2018-05-21'),('15-15151515-1',1,'2018-05-23'),('15-15151515-1',1,'2018-05-26'),('15-15151515-1',1,'2018-06-10'),('15-15151515-1',1,'2018-06-21'),('16-16161616-1',1,'2013-11-21'),('16-16161616-1',1,'2018-06-21'),('12-12121212-1',2,'2013-10-05'),('12-12121212-1',2,'2013-10-13'),('12-12121212-1',2,'2013-10-26'),('12-12121212-1',2,'2013-11-15'),('12-12121212-1',2,'2018-05-05'),('12-12121212-1',2,'2018-05-13'),('12-12121212-1',2,'2018-05-26'),('12-12121212-1',2,'2018-06-15'),('13-13131313-1',2,'2013-09-07'),('13-13131313-1',2,'2013-09-21'),('13-13131313-1',2,'2013-10-23'),('13-13131313-1',2,'2013-11-10'),('13-13131313-1',2,'2018-04-07'),('13-13131313-1',2,'2018-04-21'),('13-13131313-1',2,'2018-05-23'),('13-13131313-1',2,'2018-06-10'),('14-14141414-1',2,'2013-09-12'),('14-14141414-1',2,'2013-09-17'),('14-14141414-1',2,'2013-10-21'),('14-14141414-1',2,'2018-04-12'),('14-14141414-1',2,'2018-04-17'),('14-14141414-1',2,'2018-05-21'),('16-16161616-1',2,'2013-09-14'),('16-16161616-1',2,'2013-11-21'),('16-16161616-1',2,'2018-04-14'),('16-16161616-1',2,'2018-06-21'),('12-12121212-1',3,'2013-09-07'),('12-12121212-1',3,'2013-09-14'),('12-12121212-1',3,'2013-11-10'),('12-12121212-1',3,'2018-04-07'),('12-12121212-1',3,'2018-04-14'),('12-12121212-1',3,'2018-06-10'),('13-13131313-1',3,'2013-10-13'),('13-13131313-1',3,'2013-10-21'),('13-13131313-1',3,'2018-05-13'),('13-13131313-1',3,'2018-05-21'),('14-14141414-1',3,'2013-09-21'),('14-14141414-1',3,'2013-10-05'),('14-14141414-1',3,'2013-11-15'),('14-14141414-1',3,'2018-04-21'),('14-14141414-1',3,'2018-05-05'),('14-14141414-1',3,'2018-06-15'),('16-16161616-1',3,'2013-09-12'),('16-16161616-1',3,'2013-09-17'),('16-16161616-1',3,'2013-10-23'),('16-16161616-1',3,'2013-10-26'),('16-16161616-1',3,'2018-04-12'),('16-16161616-1',3,'2018-04-17'),('16-16161616-1',3,'2018-05-23'),('16-16161616-1',3,'2018-05-26');
/*!40000 ALTER TABLE `choferes_turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `tipo_doc` varchar(5) NOT NULL,
  `nro_doc` char(20) NOT NULL,
  `denominacion` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tipo_doc`,`nro_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES ('cuit','11-11111111-1','Reuniones Improvisadas','111-111111','H. Quintana 1111','contacto@reunionesimprovisadas.com.ar'),('cuit','22-22222222-2','Club Viejos Amigos','222-222222','Viedma 2222','compras@clubva.com.ar'),('cuit','33-33333333-3','Taller El Desarmadero','333-333333','Grandoli 3333','desarmar@argentina.com.ar'),('cuit','44-44444444-4','Avicenna','444-444444','Arijon 444 bis','avicena@gmail.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratos` (
  `nro_contrato` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `tipo_doc` varchar(5) NOT NULL,
  `nro_doc` char(20) NOT NULL,
  PRIMARY KEY (`nro_contrato`),
  KEY `contratos_clientes_fk` (`tipo_doc`,`nro_doc`),
  CONSTRAINT `contratos_clientes_fk` FOREIGN KEY (`tipo_doc`, `nro_doc`) REFERENCES `clientes` (`tipo_doc`, `nro_doc`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
INSERT INTO `contratos` VALUES (1,'2013-08-29',NULL,'cuit','22-22222222-2'),(2,'2013-09-04',NULL,'cuit','44-44444444-4'),(3,'2013-09-11',NULL,'cuit','11-11111111-1'),(4,'2013-09-24',NULL,'cuit','22-22222222-2'),(5,'2013-10-13','NO quiere que salga tarde el viaje','cuit','44-44444444-4'),(6,'2013-10-25',NULL,'cuit','33-33333333-3'),(7,'2013-11-15',NULL,'cuit','11-11111111-1'),(8,'2013-11-20',NULL,'cuit','22-22222222-2'),(9,'2018-03-29',NULL,'cuit','22-22222222-2'),(10,'2018-04-04',NULL,'cuit','44-44444444-4'),(11,'2018-04-11',NULL,'cuit','11-11111111-1'),(12,'2018-04-24',NULL,'cuit','22-22222222-2'),(13,'2018-05-13','NO quiere que salga tarde el viaje','cuit','44-44444444-4'),(14,'2018-05-25',NULL,'cuit','33-33333333-3'),(15,'2018-06-15',NULL,'cuit','11-11111111-1'),(16,'2018-06-20',NULL,'cuit','22-22222222-2');
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuotas` (
  `nro_viaje` int(11) NOT NULL,
  `fecha_venc` date NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `importe` decimal(9,3) NOT NULL,
  `recargo` decimal(9,3) DEFAULT NULL,
  PRIMARY KEY (`nro_viaje`,`fecha_venc`),
  CONSTRAINT `cuotas_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuotas`
--

LOCK TABLES `cuotas` WRITE;
/*!40000 ALTER TABLE `cuotas` DISABLE KEYS */;
INSERT INTO `cuotas` VALUES (2,'2013-08-29','2013-08-25',3000.000,637.200),(2,'2013-09-29','2013-10-04',3000.000,649.305),(2,'2013-10-30','2013-10-31',3000.000,763.842),(2,'2013-11-29',NULL,3000.000,NULL),(2,'2013-12-30',NULL,3000.000,NULL),(5,'2013-10-05','2013-10-10',8000.000,2177.709),(5,'2013-11-05','2013-11-02',8000.000,1859.544),(5,'2013-12-05',NULL,8000.000,NULL),(5,'2014-01-05',NULL,8000.000,NULL),(5,'2014-02-04',NULL,8000.000,NULL),(6,'2013-09-11','2013-09-12',3200.000,669.510),(6,'2013-10-12','2013-10-08',3200.000,717.259),(6,'2013-11-12',NULL,3200.000,NULL),(6,'2013-12-12',NULL,3200.000,NULL),(6,'2014-01-12',NULL,3200.000,NULL),(7,'2013-09-24','2013-09-29',10000.000,2969.324),(7,'2013-10-25','2013-10-26',10000.000,2088.008),(7,'2013-11-24','2013-11-21',10000.000,2809.005),(7,'2013-12-25',NULL,10000.000,NULL),(7,'2014-01-24',NULL,10000.000,NULL),(8,'2013-11-13','2013-11-16',8.400,2.099),(8,'2013-12-13',NULL,8.400,NULL),(8,'2014-01-13',NULL,8.400,NULL),(8,'2014-02-12',NULL,8.400,NULL),(8,'2014-03-15',NULL,8.400,NULL),(13,'2013-10-25','2013-10-25',4400.000,1070.359),(13,'2013-11-24',NULL,4400.000,NULL),(13,'2013-12-25',NULL,4400.000,NULL),(13,'2014-01-24',NULL,4400.000,NULL),(13,'2014-02-24',NULL,4400.000,NULL),(14,'2013-10-25',NULL,3200.000,NULL),(14,'2013-11-24',NULL,3200.000,NULL),(14,'2013-12-25',NULL,3200.000,NULL),(14,'2014-01-24',NULL,3200.000,NULL),(14,'2014-02-24',NULL,3200.000,NULL),(15,'2013-12-15',NULL,12.000,NULL),(15,'2014-01-15',NULL,12.000,NULL),(15,'2014-02-14',NULL,12.000,NULL),(15,'2014-03-17',NULL,12.000,NULL),(15,'2014-04-17',NULL,12.000,NULL),(16,'2013-11-20',NULL,12.000,NULL),(16,'2013-12-20',NULL,12.000,NULL),(16,'2014-01-20',NULL,12.000,NULL),(16,'2014-02-19',NULL,12.000,NULL),(16,'2014-03-22',NULL,12.000,NULL),(19,'2018-03-29','2018-03-25',3000.000,NULL),(19,'2018-04-29','2018-05-04',3000.000,NULL),(19,'2018-05-30','2018-05-31',3000.000,NULL),(19,'2018-06-29',NULL,3000.000,NULL),(19,'2018-07-30',NULL,3000.000,NULL),(22,'2018-05-05','2018-05-10',8000.000,NULL),(22,'2018-06-05','2018-06-02',8000.000,NULL),(22,'2018-07-05',NULL,8000.000,NULL),(22,'2018-08-05',NULL,8000.000,NULL),(22,'2018-09-04',NULL,8000.000,NULL),(23,'2018-04-11','2018-04-12',3200.000,NULL),(23,'2018-05-12','2018-05-08',3200.000,NULL),(23,'2018-06-12',NULL,3200.000,NULL),(23,'2018-07-12',NULL,3200.000,NULL),(23,'2018-08-12',NULL,3200.000,NULL),(24,'2018-04-24','2018-04-29',10000.000,NULL),(24,'2018-05-25','2018-05-26',10000.000,NULL),(24,'2018-06-24','2018-06-21',10000.000,NULL),(24,'2018-07-25',NULL,10000.000,NULL),(24,'2018-08-24',NULL,10000.000,NULL),(25,'2018-06-13','2018-06-16',8.400,NULL),(25,'2018-07-13',NULL,8.400,NULL),(25,'2018-08-13',NULL,8.400,NULL),(25,'2018-09-12',NULL,8.400,NULL),(25,'2018-10-15',NULL,8.400,NULL),(30,'2018-05-25','2018-05-25',4400.000,NULL),(30,'2018-06-24',NULL,4400.000,NULL),(30,'2018-07-25',NULL,4400.000,NULL),(30,'2018-08-24',NULL,4400.000,NULL),(30,'2018-09-24',NULL,4400.000,NULL),(31,'2018-05-25',NULL,3200.000,NULL),(31,'2018-06-24',NULL,3200.000,NULL),(31,'2018-07-25',NULL,3200.000,NULL),(31,'2018-08-24',NULL,3200.000,NULL),(31,'2018-09-24',NULL,3200.000,NULL),(32,'2018-07-15',NULL,12.000,NULL),(32,'2018-08-15',NULL,12.000,NULL),(32,'2018-09-14',NULL,12.000,NULL),(32,'2018-10-17',NULL,12.000,NULL),(32,'2018-11-17',NULL,12.000,NULL),(33,'2018-06-20',NULL,12.000,NULL),(33,'2018-07-20',NULL,12.000,NULL),(33,'2018-08-20',NULL,12.000,NULL),(33,'2018-09-19',NULL,12.000,NULL),(33,'2018-10-22',NULL,12.000,NULL);
/*!40000 ALTER TABLE `cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moviles`
--

DROP TABLE IF EXISTS `moviles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moviles` (
  `patente` varchar(7) NOT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `modelo` varchar(20) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `fecha_ult_service` date DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `fecha_baja` date DEFAULT NULL,
  PRIMARY KEY (`patente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moviles`
--

LOCK TABLES `moviles` WRITE;
/*!40000 ALTER TABLE `moviles` DISABLE KEYS */;
INSERT INTO `moviles` VALUES ('APB 333','Wolksvagen','Gol',1995,'2012-09-25',4,NULL),('FGD 111','Mercedez Benz','Sprinter',2008,'2013-04-02',20,NULL),('HDP 666','Marcopolo Scania','K 380',2009,NULL,60,NULL),('OQL 222','Fiat','Duna',1993,'1997-03-25',3,'1997-03-26'),('TQM 999','Chevrolet','Impala',1972,'1977-03-25',4,NULL),('VSS 777','Marcopolo Scania','K 112',1994,'2002-04-01',30,'2002-04-02');
/*!40000 ALTER TABLE `moviles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recargos`
--

DROP TABLE IF EXISTS `recargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recargos` (
  `FechaDesde` date NOT NULL,
  `PorcRecargoDiario` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`FechaDesde`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recargos`
--

LOCK TABLES `recargos` WRITE;
/*!40000 ALTER TABLE `recargos` DISABLE KEYS */;
INSERT INTO `recargos` VALUES ('2013-01-01',0.010),('2018-01-01',0.020);
/*!40000 ALTER TABLE `recargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_viajes`
--

DROP TABLE IF EXISTS `tipos_viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_viajes` (
  `cod_tipo_viaje` int(11) NOT NULL,
  `desc_tipo_viaje` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_viaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_viajes`
--

LOCK TABLES `tipos_viajes` WRITE;
/*!40000 ALTER TABLE `tipos_viajes` DISABLE KEYS */;
INSERT INTO `tipos_viajes` VALUES (1,'Urbano'),(2,'Corta Distancia'),(3,'Media Distancia'),(4,'Nacional (hasta 1000 km)'),(5,'Nacional (más de 1000 km)');
/*!40000 ALTER TABLE `tipos_viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_viajes_valores`
--

DROP TABLE IF EXISTS `tipos_viajes_valores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_viajes_valores` (
  `cod_tipo_viaje` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor_km` decimal(9,3) NOT NULL,
  PRIMARY KEY (`cod_tipo_viaje`,`fecha_desde`),
  CONSTRAINT `valores_tipos_viajes_tipos_viajes_fk` FOREIGN KEY (`cod_tipo_viaje`) REFERENCES `tipos_viajes` (`cod_tipo_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_viajes_valores`
--

LOCK TABLES `tipos_viajes_valores` WRITE;
/*!40000 ALTER TABLE `tipos_viajes_valores` DISABLE KEYS */;
INSERT INTO `tipos_viajes_valores` VALUES (1,'2013-07-26',1.000),(1,'2013-09-06',1.100),(1,'2013-10-10',1.600),(1,'2013-11-10',1.900),(1,'2013-12-02',2.100),(1,'2018-01-02',20.000),(2,'2013-07-26',3.200),(2,'2013-09-09',3.520),(2,'2013-10-23',5.120),(2,'2013-11-06',6.080),(2,'2018-01-02',25.000),(2,'2018-03-05',30.000),(3,'2013-09-08',5.500),(3,'2013-11-07',7.500),(3,'2014-01-10',10.000),(3,'2018-02-01',101.000),(4,'2013-08-22',10.000),(4,'2013-10-06',15.000),(4,'2018-03-01',150.000);
/*!40000 ALTER TABLE `tipos_viajes_valores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turnos` (
  `cod_turno` int(11) NOT NULL,
  `desc_turno` varchar(20) DEFAULT NULL,
  `hora_desde` time DEFAULT NULL,
  `hora_hasta` time DEFAULT NULL,
  PRIMARY KEY (`cod_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
INSERT INTO `turnos` VALUES (1,'Matutino','06:00:00','14:00:00'),(2,'Vespertino','14:00:00','22:00:00'),(3,'Nocturno','22:00:00','06:00:00');
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes`
--

DROP TABLE IF EXISTS `viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes` (
  `nro_viaje` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_ini` date NOT NULL,
  `hora_ini` time NOT NULL,
  `cant_pasajeros` int(11) DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `destinos` varchar(500) DEFAULT NULL,
  `fecha_reserva` date DEFAULT NULL,
  `hora_reserva` time DEFAULT NULL,
  `duracion_est` decimal(9,3) DEFAULT NULL,
  `km_estimados` decimal(9,3) DEFAULT NULL,
  `importe` decimal(9,3) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `origen` varchar(50) DEFAULT NULL,
  `nro_contrato` int(11) DEFAULT NULL,
  `cuil` char(20) DEFAULT NULL,
  `cod_turno` int(11) DEFAULT NULL,
  `fecha_turno` date DEFAULT NULL,
  `cod_tipo_viaje` int(11) DEFAULT NULL,
  `fecha_cancelacion` date DEFAULT NULL,
  PRIMARY KEY (`nro_viaje`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes`
--

LOCK TABLES `viajes` WRITE;
/*!40000 ALTER TABLE `viajes` DISABLE KEYS */;
INSERT INTO `viajes` VALUES (1,'2013-09-07','15:00:00',3,'2013-09-07','18:00:00','Quilmes',NULL,NULL,3.000,270.000,800.000,'Terminado','Pellegrini 111',NULL,'13-13131313-1',2,'2013-09-07',NULL,NULL),(2,'2013-09-12','11:00:00',3,'2013-09-13','06:00:00','Neuquen, Bariloche','2013-08-29','08:00:00',20.000,1800.000,15000.000,'Terminado',NULL,1,NULL,NULL,NULL,NULL,NULL),(3,'2013-09-14','03:00:00',1,'2013-09-15','17:00:00','Neuquen, Rosario',NULL,NULL,36.000,3240.000,32400.000,'Terminado','Italia 3333',NULL,'12-12121212-1',3,'2013-09-14',4,NULL),(4,'2013-09-14','08:00:00',12,'2013-09-15','02:00:00','Rawson',NULL,NULL,18.000,1620.000,16200.000,'Terminado','Bv. Segu',NULL,'14-14141414-1',1,'2013-09-14',4,NULL),(5,'2013-09-17','08:00:00',1,'2013-09-19','13:00:00','Neuquen, Bariloche, Villa La Angostura, Rosario','2013-09-04','10:00:00',50.000,4500.000,40000.000,'Terminado',NULL,2,NULL,NULL,NULL,NULL,NULL),(6,'2013-09-21','12:30:00',6,'2013-09-22','09:40:00','Iguazú','2013-09-11','12:00:00',20.000,1800.000,16000.000,'Terminado',NULL,3,NULL,NULL,NULL,NULL,NULL),(7,'2013-10-05','08:00:00',12,'2013-10-07','20:25:00','Neuquen, Mendoza, Rosario','2013-09-24','09:00:00',60.000,5400.000,50000.000,'Terminado',NULL,4,NULL,NULL,NULL,NULL,NULL),(8,'2013-10-13','08:30:00',1,'2013-10-13','09:00:00','General Motors','2013-10-13','15:00:00',0.700,28.000,42.000,'Terminado',NULL,5,NULL,NULL,NULL,NULL,NULL),(9,'2013-10-21','23:00:00',32,'2013-10-23','07:00:00','La Plata, Rosario',NULL,NULL,8.000,720.000,3960.000,'Terminado','Espa',NULL,'13-13131313-1',3,'2013-10-21',3,NULL),(10,'2013-10-23','14:00:00',2,'2013-10-25','19:00:00','Zarate, Rosario',NULL,NULL,5.500,495.000,2722.500,'Terminado','Bs As 1010',NULL,'13-13131313-1',2,'2013-10-23',3,NULL),(11,'2013-10-26','12:00:00',2,'2013-10-27','06:45:00','San Mart',NULL,NULL,20.000,1800.000,27000.000,'Terminado','Francia 1111',NULL,'15-15151515-1',1,'2013-10-26',4,NULL),(12,'2013-11-10','18:00:00',13,'2013-11-10','20:00:00','Villa Gdor Galvez, Roldan',NULL,NULL,2.000,80.000,486.400,'Terminado','Tucuman 121',NULL,'13-13131313-1',2,'2013-11-10',2,NULL),(13,'2013-11-15','10:00:00',40,'2013-11-16','08:00:00','Mendoza, San Juan, Mendoza, Rosario','2013-10-25','07:00:00',24.000,2160.000,22000.000,'Terminado',NULL,6,NULL,NULL,NULL,NULL,NULL),(14,'2013-11-22','12:00:00',2,NULL,NULL,'Bariloche','2013-10-25','07:10:00',18.000,1620.000,16000.000,'Pendiente',NULL,6,NULL,NULL,NULL,NULL,NULL),(15,'2013-11-22','08:00:00',1,NULL,NULL,'Roldan','2013-11-15','14:00:00',1.000,40.000,60.000,'Pendiente',NULL,7,NULL,NULL,NULL,NULL,NULL),(16,'2013-11-26','08:00:00',1,NULL,NULL,'Roldan','2013-11-20','09:00:00',1.000,40.000,60.000,'Cancelado',NULL,8,NULL,NULL,NULL,NULL,'2013-11-21'),(17,'2013-11-21','07:00:00',2,'2013-11-21','15:00:00','Sgo del Estero',NULL,NULL,9.000,810.000,NULL,'En Proceso','Arijon 171',NULL,'16-16161616-1',1,'2013-11-21',3,NULL),(18,'2018-04-07','15:00:00',3,'2018-04-07','18:00:00','Quilmes',NULL,NULL,3.000,270.000,800.000,'Terminado','Pellegrini 111',NULL,'13-13131313-1',2,'2018-04-07',NULL,NULL),(19,'2018-04-12','11:00:00',3,'2018-04-13','06:00:00','Neuquen, Bariloche','2018-03-29','08:00:00',20.000,1800.000,15000.000,'Terminado',NULL,9,NULL,NULL,NULL,NULL,NULL),(20,'2018-04-14','03:00:00',1,'2018-04-15','17:00:00','Neuquen, Rosario',NULL,NULL,36.000,3240.000,32400.000,'Terminado','Italia 3333',NULL,'12-12121212-1',3,'2018-04-14',4,NULL),(21,'2018-04-14','08:00:00',12,'2018-04-15','02:00:00','Rawson',NULL,NULL,18.000,1620.000,16200.000,'Terminado','Bv. Segu',NULL,'14-14141414-1',1,'2018-04-14',4,NULL),(22,'2018-04-17','08:00:00',1,'2018-04-19','13:00:00','Neuquen, Bariloche, Villa La Angostura, Rosario','2018-04-04','10:00:00',50.000,4500.000,40000.000,'Terminado',NULL,10,NULL,NULL,NULL,NULL,NULL),(23,'2018-04-21','12:30:00',6,'2018-04-22','09:40:00','Iguaz','2018-04-11','12:00:00',20.000,1800.000,16000.000,'Terminado',NULL,11,NULL,NULL,NULL,NULL,NULL),(24,'2018-05-05','08:00:00',12,'2018-05-07','20:25:00','Neuquen, Mendoza, Rosario','2018-04-24','09:00:00',60.000,5400.000,50000.000,'Terminado',NULL,12,NULL,NULL,NULL,NULL,NULL),(25,'2018-05-13','08:30:00',1,'2018-05-13','09:00:00','General Motors','2018-05-13','15:00:00',0.700,28.000,42.000,'Terminado',NULL,13,NULL,NULL,NULL,NULL,NULL),(26,'2018-05-21','23:00:00',32,'2018-05-23','07:00:00','La Plata, Rosario',NULL,NULL,8.000,720.000,3960.000,'Terminado','Espa',NULL,'13-13131313-1',3,'2018-05-21',3,NULL),(27,'2018-05-23','14:00:00',2,'2018-05-25','19:00:00','Zarate, Rosario',NULL,NULL,5.500,495.000,2722.500,'Terminado','Bs As 1010',NULL,'13-13131313-1',2,'2018-05-23',3,NULL),(28,'2018-05-26','12:00:00',2,'2018-05-27','06:45:00','San Mart',NULL,NULL,20.000,1800.000,27000.000,'Terminado','Francia 1111',NULL,'15-15151515-1',1,'2018-05-26',4,NULL),(29,'2018-06-10','18:00:00',13,'2018-06-10','20:00:00','Villa Gdor Galvez, Roldan',NULL,NULL,2.000,80.000,486.400,'Terminado','Tucuman 121',NULL,'13-13131313-1',2,'2018-06-10',2,NULL),(30,'2018-06-15','10:00:00',40,'2018-06-16','08:00:00','Mendoza, San Juan, Mendoza, Rosario','2018-05-25','07:00:00',24.000,2160.000,22000.000,'Terminado',NULL,14,NULL,NULL,NULL,NULL,NULL),(31,'2018-07-22','12:00:00',2,NULL,NULL,'Bariloche','2018-05-25','07:10:00',18.000,1620.000,16000.000,'Pendiente',NULL,14,NULL,NULL,NULL,NULL,NULL),(32,'2018-07-22','08:00:00',1,NULL,NULL,'Roldan','2018-06-15','14:00:00',1.000,40.000,60.000,'Pendiente',NULL,15,NULL,NULL,NULL,NULL,NULL),(33,'2018-07-26','08:00:00',1,NULL,NULL,'Roldan','2018-06-20','09:00:00',1.000,40.000,60.000,'Cancelado',NULL,16,NULL,NULL,NULL,NULL,'2018-06-21'),(34,'2018-07-02','14:00:00',2,NULL,NULL,'Sgo del Estero',NULL,NULL,9.000,810.000,20000.000,'En Proceso','Arijon 171',NULL,'16-16161616-1',1,'2018-06-21',3,NULL);
/*!40000 ALTER TABLE `viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes_choferes`
--

DROP TABLE IF EXISTS `viajes_choferes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes_choferes` (
  `nro_viaje` int(11) NOT NULL,
  `cuil` char(20) NOT NULL,
  PRIMARY KEY (`nro_viaje`,`cuil`),
  KEY `viajes_choferes_choferes_fk` (`cuil`),
  CONSTRAINT `viajes_choferes_choferes_fk` FOREIGN KEY (`cuil`) REFERENCES `choferes` (`cuil`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_choferes_viajes_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes_choferes`
--

LOCK TABLES `viajes_choferes` WRITE;
/*!40000 ALTER TABLE `viajes_choferes` DISABLE KEYS */;
INSERT INTO `viajes_choferes` VALUES (6,'12-12121212-1'),(14,'12-12121212-1'),(5,'13-13131313-1'),(7,'13-13131313-1'),(15,'13-13131313-1'),(8,'14-14141414-1'),(16,'14-14141414-1'),(2,'15-15151515-1'),(5,'15-15151515-1'),(13,'15-15151515-1'),(7,'16-16161616-1'),(13,'16-16161616-1');
/*!40000 ALTER TABLE `viajes_choferes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes_moviles`
--

DROP TABLE IF EXISTS `viajes_moviles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes_moviles` (
  `nro_viaje` int(11) NOT NULL,
  `patente` varchar(7) NOT NULL,
  `km_ini` decimal(9,3) DEFAULT NULL,
  `km_fin` decimal(9,3) DEFAULT NULL,
  PRIMARY KEY (`nro_viaje`,`patente`),
  KEY `viajes_moviles_moviles_fk` (`patente`),
  CONSTRAINT `viajes_moviles_moviles_fk` FOREIGN KEY (`patente`) REFERENCES `moviles` (`patente`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_moviles_viajes_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes_moviles`
--

LOCK TABLES `viajes_moviles` WRITE;
/*!40000 ALTER TABLE `viajes_moviles` DISABLE KEYS */;
INSERT INTO `viajes_moviles` VALUES (1,'APB 333',80000.000,80408.000),(2,'TQM 999',220987.000,222038.000),(3,'OQL 222',120000.000,121987.000),(4,'VSS 777',400982.000,403335.000),(5,'APB 333',80408.000,82576.000),(6,'FGD 111',0.000,1237.000),(7,'VSS 777',403335.000,408879.000),(8,'TQM 999',223000.000,223012.000),(9,'HDP 666',43987.000,45087.000),(10,'APB 333',82576.000,83110.000),(11,'OQL 222',122000.000,123345.000),(12,'FGD 111',1237.000,1351.000),(13,'HDP 666',45087.000,49375.000),(14,'TQM 999',NULL,NULL),(15,'APB 333',NULL,NULL),(16,'APB 333',NULL,NULL),(17,'TQM 999',NULL,NULL);
/*!40000 ALTER TABLE `viajes_moviles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-28 13:47:58

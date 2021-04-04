DROP database IF exists `recursos_humanos`;
CREATE DATABASE  IF NOT EXISTS `recursos_humanos` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `recursos_humanos`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: recursos_humanos
-- ------------------------------------------------------
-- Server version	5.1.73-community

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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `cod_area` int(3) NOT NULL,
  `denominacion` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Produccion'),(2,'RRHH'),(3,'Ventas'),(4,'Finanzas'),(5,'SI & TI');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competencias`
--

DROP TABLE IF EXISTS `competencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competencias` (
  `cod_competencia` int(3) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `categoria` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cod_competencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencias`
--

LOCK TABLES `competencias` WRITE;
/*!40000 ALTER TABLE `competencias` DISABLE KEYS */;
INSERT INTO `competencias` VALUES (1,'Responsabilidad','Generica'),(2,'Capacidad Critica','Generica'),(3,'Trabajo en Equipo','Generica'),(4,'Capacidad de Expresion Oral ','Generica'),(5,'Capacidad de Expresion Escrita','Generica'),(6,'ERP','Especifica'),(7,'Produccion Just in Time','Especifica'),(8,'Programación CNC','Especifica'),(9,'Centros de Maquinado ','Especifica'),(10,'Linea de Produccion Continua','Especifica'),(11,'Liquidacion Payroll','Especifica'),(12,'Sistema CAS','Especifica'),(13,'Pruebas de Confianza en linea','Especifica'),(14,'Aplicacion e Interpretacion de Psicometria','Especifica'),(15,'Pronosticos Anuales','Especifica'),(16,'Controles SOA','Especifica'),(17,'Elaboración de Flujo','Especifica'),(18,'UML','Especifica'),(19,'Metodologias Agiles','Especifica'),(20,'Virtualizacion','Especifica'),(21,'Redes TCP/IP','Especifica'),(22,'Gestion de Riesgo','Especifica'),(23,'Gestion de Proyecto','Especifica');
/*!40000 ALTER TABLE `competencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum`
--

DROP TABLE IF EXISTS `curriculum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum` (
  `tipo_doc` char(7) NOT NULL,
  `nro_doc` int(9) NOT NULL,
  `cod_competencia` int(3) NOT NULL,
  `fecha_curric` date NOT NULL,
  `nivel` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tipo_doc`,`nro_doc`,`cod_competencia`),
  KEY `curriculum_competencias_fk_idx` (`cod_competencia`),
  KEY `curriculum_personas_fk_idx` (`tipo_doc`,`nro_doc`),
  CONSTRAINT `curriculum_competencias_fk` FOREIGN KEY (`cod_competencia`) REFERENCES `competencias` (`cod_competencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `curriculum_personas_fk` FOREIGN KEY (`tipo_doc`, `nro_doc`) REFERENCES `personas` (`tipo_doc`, `nro_doc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum`
--

LOCK TABLES `curriculum` WRITE;
/*!40000 ALTER TABLE `curriculum` DISABLE KEYS */;
INSERT INTO `curriculum` VALUES ('DNI',738443,13,'2017-05-22','Semi Senior'),('DNI',738443,15,'2017-05-22','Senior'),('DNI',738443,18,'2017-05-22','Junior'),('DNI',6896446,8,'2016-09-09','Junior'),('DNI',6896446,20,'2016-09-09','Junior'),('DNI',11569774,3,'2016-04-05',NULL),('DNI',11569774,6,'2016-04-05','Junior'),('DNI',11569774,7,'2016-04-05','Junior'),('DNI',11569774,10,'2016-04-05','Senior'),('DNI',13296823,1,'2016-07-21',NULL),('DNI',13296823,8,'2016-07-21','Junior'),('DNI',13296823,13,'2016-07-21','Senior'),('DNI',13296823,16,'2016-07-21','Junior'),('DNI',13296823,17,'2016-07-21','Junior'),('DNI',13296823,20,'2016-07-21','Semi Senior'),('DNI',13296823,22,'2016-10-26','Junior'),('DNI',20129509,20,'2017-07-16','Junior'),('DNI',28873314,10,'2016-07-15','Junior'),('DNI',28873314,11,'2016-07-15','Junior'),('DNI',28873314,17,'2016-07-15','Semi Senior'),('DNI',37858885,9,'2016-05-21','Semi Senior'),('DNI',37858885,13,'2016-05-21','Semi Senior'),('DNI',37858885,20,'2016-05-21','Junior'),('DNI',37858885,23,'2016-05-21','Semi Senior'),('DNI',58827141,5,'2016-05-19',NULL),('DNI',58827141,12,'2016-05-19','Senior'),('DNI',61290816,3,'2016-06-15',NULL),('DNI',61290816,5,'2016-06-15',NULL),('DNI',61710880,10,'2016-06-15','Semi Senior'),('DNI',89781343,1,'2017-05-14',NULL),('DNI',89781343,23,'2017-05-14','Semi Senior'),('DNI',95256449,2,'2017-05-14',NULL),('DNI',95256449,6,'2017-09-19','Junior'),('DNI',95256449,10,'2017-09-19','Senior'),('DNI',95256449,17,'2017-09-19','Semi Senior'),('DNI',95256449,23,'2017-09-19','Junior'),('DNI',95694310,8,'2017-09-19','Senior'),('DNI',95694310,11,'2017-09-19','Senior'),('DNI',95694310,12,'2017-09-19','Semi Senior'),('DNI',95694310,13,'2017-09-19','Junior'),('DNI',95694310,21,'2017-09-19','Semi Senior'),('DNI',95694310,22,'2017-09-19','Senior'),('DNI',95953056,1,'2016-06-15',NULL),('DNI',95953056,9,'2016-06-15','Senior'),('DNI',95953056,21,'2016-06-15','Semi Senior');
/*!40000 ALTER TABLE `curriculum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `legajo` int(9) NOT NULL AUTO_INCREMENT,
  `tipo_doc` char(3) DEFAULT NULL,
  `nro_doc` int(9) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `usuario` varchar(50) NOT NULL,
  `contraseña` varchar(50) NOT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`legajo`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (101,'DNI',22222222,'Liu','Xiaobo','Calle Falsa 123','4202020','lxia@gmail.com','LiuXiaobo','Liu1234','1992-09-12','1994-09-12'),(112,'DNI',44444444,'Muhammad','Yunus','Dorrego 1245','4222222','muhammadyunus@gmail.com','MuhammadYunus','Muhammad1234','1992-09-12','1994-09-12'),(113,'DNI',66666666,'Carlos','Saavedra Lamas','San Martin 143','4242424','csl@gmail.com','CarlosSaavedra Lamas','Carlos1234','1992-09-12','1994-09-12'),(114,'DNI',11111111,'Mairead','Corrigan','Rosario 876','4111111','CorriganMairead@micorreo.com','MaireadCorrigan','Mairead1234','1993-02-12','2018-02-13'),(115,'DNI',13131313,'Léon','Jouhaux','Buenos Aires 1003','4131313','JouhauxLéon@micorreo.com','LéonJouhaux','Léon1234','1993-02-12',NULL),(116,'DNI',15151515,'Carl','von Ossietzky','Corrientes 024','4151515','von OssietzkyCarl@micorreo.com','Carlvon Ossietzky','Carl1234','1993-02-12',NULL),(117,'DNI',17171717,'Jane','Addams','Avellaneda 74','4171717','AddamsJane@micorreo.com','JaneAddams','Jane1234','1993-02-12',NULL),(118,'DNI',12121212,'Andrei Dmitrievich','Sakharov','Uruguay 350','4121212','SakharovAndrei Dmitrievich@micorreo.com','Andrei DmitrievichSakharov','Andrei Dmitrievich1234','2007-09-12',NULL),(119,'DNI',14141414,'Emily','Greene Balch','Mendoza 684','4141414','Greene BalchEmily@micorreo.com','EmilyGreene Balch','Emily1234','2007-09-12',NULL),(120,'DNI',16161616,'Ralph','Lane','Alvear 335','4161616','LaneRalph@micorreo.com','RalphLane','Ralph1234','2007-09-12',NULL),(121,'DNI',33333333,'Martti','Ahtisaari','Zeballos 1341','4212121','m.ahtisaari@gmail.com','MarttiAhtisaari','Martti1234','2008-02-12','2008-12-12'),(122,'DNI',55555555,'Desmond Mpilo','Tutu','Oroño 009','4232323','dtutu@gmail.com','Desmond MpiloTutu','Desmond Mpilo1234','2008-05-21','2008-12-12'),(123,'DNI',10101010,'Tenzin','Gyatso','Entre Rios 555','4101010','GyatsoTenzin@micorreo.com','TenzinGyatso','Tenzin1234','2008-10-28','2008-12-12');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados_puestos`
--

DROP TABLE IF EXISTS `empleados_puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados_puestos` (
  `legajo` int(9) NOT NULL,
  `fecha_ini` date NOT NULL,
  `cod_area` int(3) NOT NULL,
  `cod_puesto` int(3) NOT NULL,
  PRIMARY KEY (`legajo`,`fecha_ini`),
  KEY `empleados_puestos_puestos_areas_fk_idx` (`cod_area`,`cod_puesto`),
  CONSTRAINT `empleados_puestos_puestos_areas_fk` FOREIGN KEY (`cod_area`, `cod_puesto`) REFERENCES `puestos_areas` (`cod_area`, `cod_puesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados_puestos`
--

LOCK TABLES `empleados_puestos` WRITE;
/*!40000 ALTER TABLE `empleados_puestos` DISABLE KEYS */;
INSERT INTO `empleados_puestos` VALUES (101,'2004-09-12',1,1),(101,'1994-09-12',1,3),(101,'1993-07-12',1,4),(112,'1993-07-12',1,4),(122,'2008-05-21',1,4),(101,'1992-09-12',1,8),(118,'2007-09-12',1,8),(112,'1994-09-12',2,5),(112,'1999-09-12',2,6),(116,'1993-02-12',2,8),(119,'2007-09-12',2,8),(120,'2007-09-12',3,8),(112,'1992-09-12',3,9),(115,'1993-02-12',3,9),(122,'2009-03-21',3,9),(114,'1993-02-12',4,8),(117,'1993-02-12',4,8),(114,'1995-02-12',4,10),(114,'2000-02-12',4,11),(113,'1992-09-12',5,8),(121,'2008-02-12',5,8),(113,'1993-07-12',5,12),(121,'2010-02-12',5,12),(113,'2004-09-12',5,13),(123,'2010-10-28',5,13),(113,'2016-05-05',5,14);
/*!40000 ALTER TABLE `empleados_puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `cod_estado` int(3) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Iniciado'),(2,'Entrevista'),(3,'Contrato'),(4,'Rechazo');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `tipo_doc` char(7) NOT NULL,
  `nro_doc` int(9) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tipo_doc`,`nro_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES ('DNI',738443,'Francesca','Alvarez','Capitán Roberto Carbajo 876','(1678) 598-3523','AlvarezFrancesca@micorreo.com'),('DNI',6896446,'Delfina','Fernandez','Brasil 456','(1580) 351-3697','FernandezDelfina@micorreo.com'),('DNI',11569774,'Emma','Perez','Berna 231','(1650) 607-4027','PerezEmma@micorreo.com'),('DNI',13296823,'Benicio','Diaz','Balcarce 234','(1503) 714-6920','DiazBenicio@micorreo.com'),('DNI',20129509,'Benicio','Fernandez','Bolivia 654','(1520) 319-1069','FernandezBenicio@micorreo.com'),('DNI',28873314,'Mateo','Gonzalez','Camilo Segura 334','(1231) 924-7288','GonzalezMateo@micorreo.com'),('DNI',37858885,'Francesca','Diaz','Barranca Yaco 345','(1715) 139-4608','DiazFrancesca@micorreo.com'),('DNI',58827141,'Olivia','Martinez','Bolivia 654','(1386) 278-9699','MartinezOlivia@micorreo.com'),('DNI',61290816,'Lorenzo','Lopez','Bach 123','(1769) 650-7530','LopezLorenzo@micorreo.com'),('DNI',61710880,'Felipe','Alvarez','Brasil 456','(1617) 646-6316','AlvarezFelipe@micorreo.com'),('DNI',89781343,'Catalina','Fernandez','Bolivia 654','(1469) 236-7688','FernandezCatalina@micorreo.com'),('DNI',95256449,'Felipe','Gomez','Bernardo de Irigoyen 876','(1681) 326-6721','GomezFelipe@micorreo.com'),('DNI',95694310,'Emma','Garcia','Bernardino del Pozo 654','(1786) 318-0613','GarciaEmma@micorreo.com'),('DNI',95953056,'Lorenzo','Sanchez','Balcarce 234','(1586) 660-6814','SanchezLorenzo@micorreo.com'),('DNI',97726529,'Lorenzo','Perez','Brigadier General Jose Maria de Rosas 65','(1650) 109-4893','PerezLorenzo@micorreo.com');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso_seleccion`
--

DROP TABLE IF EXISTS `proceso_seleccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proceso_seleccion` (
  `cod_area` int(3) DEFAULT NULL,
  `cod_puesto` int(3) DEFAULT NULL,
  `fecha_solic` date DEFAULT NULL,
  `tipo_doc` char(7) DEFAULT NULL,
  `nro_doc` int(9) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `legajo` int(9) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  `cod_estado` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso_seleccion`
--

LOCK TABLES `proceso_seleccion` WRITE;
/*!40000 ALTER TABLE `proceso_seleccion` DISABLE KEYS */;
INSERT INTO `proceso_seleccion` VALUES (1,3,'2016-05-15','DNI',61290816,'2016-05-20 16:00:00',116,'Se presento tarde',2),(1,3,'2016-05-15','DNI',89781343,'2016-05-20 10:00:00',119,'Ninguna',3),(1,3,'2016-05-15','DNI',97726529,'2016-05-20 12:00:00',116,'Se presento tarde',2),(1,3,'2016-06-14','DNI',13296823,'2016-06-19 14:00:00',116,'Se presento tarde',3),(1,3,'2017-03-27','DNI',37858885,'2017-04-01 10:00:00',116,'Se presento tarde',4),(1,3,'2017-03-27','DNI',95256449,'2017-04-01 11:00:00',116,'Su Cv es acorde a lo solicitado',2),(1,4,'2016-05-07','DNI',28873314,'2016-05-12 08:00:00',119,'Se presento tarde',4),(1,4,'2016-05-07','DNI',37858885,'2016-05-12 16:00:00',116,'Ninguna',2),(1,4,'2016-05-07','DNI',97726529,'2016-05-12 14:00:00',119,'Ninguna',2),(1,8,'2017-04-03','DNI',61710880,'2017-04-08 13:00:00',119,'Ninguna',3),(1,8,'2017-04-03','DNI',95694310,'2017-04-08 16:00:00',119,'Ninguna',4),(2,5,'2016-05-10','DNI',37858885,'2016-05-15 11:00:00',116,'Ninguna',2),(2,5,'2016-05-10','DNI',89781343,'2016-05-15 12:00:00',119,'Se presento tarde',1),(2,5,'2016-05-10','DNI',95694310,'2016-05-15 10:00:00',116,'Se presento tarde',2),(2,6,'2016-10-13','DNI',13296823,'2016-05-18 08:00:00',119,'Ninguna',4),(2,8,'2016-08-20','DNI',11569774,'2016-08-25 14:00:00',116,'Se presento tarde',1),(2,8,'2016-08-20','DNI',28873314,'2016-08-25 15:00:00',119,'Se presento tarde',3),(2,8,'2017-09-05','DNI',11569774,'2017-09-10 13:00:00',116,'Su Cv es acorde a lo solicitado',2),(2,8,'2017-09-05','DNI',37858885,'2017-09-10 17:00:00',116,'Se presento tarde',3),(2,8,'2017-09-05','DNI',95694310,'2017-09-10 16:00:00',119,'Ninguna',1),(4,8,'2017-07-26','DNI',11569774,'2017-07-31 16:00:00',119,'Se presento tarde',4),(4,8,'2017-07-26','DNI',28873314,'2017-07-31 12:00:00',119,'Se presento tarde',1),(4,8,'2017-07-26','DNI',61290816,'2017-07-31 16:00:00',116,'Su Cv es acorde a lo solicitado',3),(4,8,'2017-07-26','DNI',95256449,'2017-07-31 09:00:00',116,'Se presento tarde',4),(4,8,'2017-07-26','DNI',95694310,'2017-07-31 10:00:00',116,'Se presento tarde',2),(4,8,'2017-09-19','DNI',6896446,'2017-09-24 08:00:00',116,'Su Cv es acorde a lo solicitado',1),(4,8,'2017-09-19','DNI',13296823,'2017-09-24 12:00:00',119,'Su Cv es acorde a lo solicitado',2),(4,8,'2017-09-19','DNI',37858885,'2017-09-24 13:00:00',116,'Ninguna',1),(4,8,'2017-09-19','DNI',37858885,'2017-09-24 14:00:00',119,'Se presento tarde',3),(4,8,'2017-09-19','DNI',61290816,'2017-09-24 15:00:00',116,'Presenta rasgos de demencia',1),(4,8,'2017-09-19','DNI',61710880,'2017-09-24 10:00:00',119,'Su Cv es acorde a lo solicitado',2),(4,8,'2017-09-19','DNI',61710880,'2017-09-24 16:00:00',116,'Su Cv es acorde a lo solicitado',3),(4,8,'2017-09-19','DNI',89781343,'2017-09-24 17:00:00',116,'Se presento tarde',3),(4,8,'2018-01-07','DNI',6896446,'2018-02-06 11:00:00',116,'Su Cv es acorde a lo solicitado',2),(4,10,'2016-01-28','DNI',6896446,'2016-02-02 10:00:00',116,'Se presento tarde',2),(4,10,'2016-01-28','DNI',95694310,'2016-02-02 15:00:00',119,'Se presento tarde',1),(4,10,'2016-01-28','DNI',97726529,'2016-02-02 12:00:00',116,'Ninguna',3),(4,10,'2017-09-01','DNI',28873314,'2017-09-06 15:00:00',119,'Su Cv es acorde a lo solicitado',3),(4,10,'2017-09-01','DNI',95694310,'2017-09-06 10:00:00',119,'Se presento tarde',4),(4,10,'2017-09-01','DNI',97726529,'2017-09-06 14:00:00',116,'Ninguna',4),(4,10,'2017-09-01','DNI',97726529,'2017-09-06 17:00:00',119,'Ninguna',2),(5,13,'2016-07-13','DNI',95694310,'2016-07-18 10:00:00',116,'Su Cv es acorde a lo solicitado',3),(5,14,'2017-08-04','DNI',6896446,'2017-08-09 09:00:00',116,'Ninguna',3),(5,14,'2017-08-04','DNI',95694310,'2017-08-09 11:00:00',116,'Ninguna',3);
/*!40000 ALTER TABLE `proceso_seleccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos_areas`
--

DROP TABLE IF EXISTS `puestos_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puestos_areas` (
  `cod_area` int(3) NOT NULL,
  `cod_puesto` int(3) NOT NULL,
  PRIMARY KEY (`cod_area`,`cod_puesto`),
  KEY `puestos_areas_puestos_de_trabajo_fk_idx` (`cod_puesto`),
  CONSTRAINT `puestos_areas_areas_fk` FOREIGN KEY (`cod_area`) REFERENCES `areas` (`cod_area`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `puestos_areas_puestos_de_trabajo_fk` FOREIGN KEY (`cod_puesto`) REFERENCES `puestos_de_trabajo` (`cod_puesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos_areas`
--

LOCK TABLES `puestos_areas` WRITE;
/*!40000 ALTER TABLE `puestos_areas` DISABLE KEYS */;
INSERT INTO `puestos_areas` VALUES (1,1),(1,3),(1,4),(2,5),(5,5),(2,6),(1,8),(2,8),(3,8),(4,8),(5,8),(3,9),(4,10),(4,11),(5,12),(5,13),(5,14);
/*!40000 ALTER TABLE `puestos_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos_competencias`
--

DROP TABLE IF EXISTS `puestos_competencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puestos_competencias` (
  `cod_area` int(3) NOT NULL,
  `cod_puesto` int(3) NOT NULL,
  `cod_competencia` int(3) NOT NULL,
  `nivel` varchar(15) DEFAULT NULL,
  `excluyente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_area`,`cod_puesto`,`cod_competencia`),
  KEY `puestos_competencias_competencias_fk` (`cod_competencia`),
  CONSTRAINT `puestos_competencias_competencias_fk` FOREIGN KEY (`cod_competencia`) REFERENCES `competencias` (`cod_competencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `puestos_competencias_puestos_areas_fk` FOREIGN KEY (`cod_area`, `cod_puesto`) REFERENCES `puestos_areas` (`cod_area`, `cod_puesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos_competencias`
--

LOCK TABLES `puestos_competencias` WRITE;
/*!40000 ALTER TABLE `puestos_competencias` DISABLE KEYS */;
INSERT INTO `puestos_competencias` VALUES (1,1,5,NULL,'Si'),(1,1,6,'Senior','Si'),(1,1,7,'Semi Senior','Si'),(1,3,4,NULL,'Si'),(1,3,5,NULL,'Si'),(1,3,8,'Semi Senior','Si'),(1,3,9,'Semi Senior','Si'),(1,4,4,NULL,'Si'),(1,4,5,NULL,'Si'),(1,4,9,'Junior','No'),(1,4,10,'Junior','No'),(1,8,1,NULL,'Si'),(1,8,3,NULL,'Si'),(1,8,4,NULL,'Si'),(2,5,1,NULL,'Si'),(2,5,2,NULL,'Si'),(2,5,3,NULL,'Si'),(2,5,4,NULL,'Si'),(2,5,5,NULL,'Si'),(2,5,11,'Junior','No'),(2,5,12,'Semi Senior','Si'),(2,6,1,NULL,'Si'),(2,6,2,NULL,'Si'),(2,6,3,NULL,'Si'),(2,6,4,NULL,'Si'),(2,6,5,NULL,'Si'),(2,6,13,'Junior','Si'),(2,6,14,'Semi Senior','Si'),(2,8,1,NULL,'Si'),(2,8,3,NULL,'Si'),(2,8,4,NULL,'Si'),(3,8,1,NULL,'Si'),(3,8,3,NULL,'Si'),(3,8,4,NULL,'Si'),(3,9,1,NULL,'Si'),(3,9,2,NULL,'Si'),(3,9,3,NULL,'Si'),(3,9,4,NULL,'Si'),(3,9,5,NULL,'Si'),(3,9,15,'Junior','No'),(4,8,1,NULL,'Si'),(4,8,3,NULL,'Si'),(4,8,4,NULL,'Si'),(4,10,1,NULL,'Si'),(4,10,2,NULL,'Si'),(4,10,3,NULL,'Si'),(4,10,4,NULL,'Si'),(4,10,5,NULL,'Si'),(4,10,16,'Junior','No'),(4,10,17,'Semi Senior','Si'),(4,11,1,NULL,'Si'),(4,11,2,NULL,'Si'),(4,11,3,NULL,'Si'),(4,11,4,NULL,'Si'),(4,11,5,NULL,'Si'),(5,5,1,NULL,'Si'),(5,5,2,NULL,'Si'),(5,5,3,NULL,'Si'),(5,5,4,NULL,'Si'),(5,5,5,NULL,'Si'),(5,5,18,'Semi Senior','Si'),(5,5,19,'Junior','Si'),(5,8,1,NULL,'Si'),(5,8,3,NULL,'Si'),(5,8,4,NULL,'Si'),(5,12,1,NULL,'Si'),(5,12,2,NULL,'Si'),(5,12,3,NULL,'Si'),(5,12,4,NULL,'Si'),(5,12,5,NULL,'Si'),(5,12,20,'Junior','No'),(5,12,21,'Junior','Si'),(5,13,1,NULL,'Si'),(5,13,2,NULL,'Si'),(5,13,3,NULL,'Si'),(5,13,4,NULL,'Si'),(5,13,5,NULL,'Si'),(5,13,16,'Semi Senior','Si'),(5,13,22,'Junior','Si'),(5,14,1,NULL,'Si'),(5,14,2,NULL,'Si'),(5,14,3,NULL,'Si'),(5,14,4,NULL,'Si'),(5,14,5,NULL,'Si'),(5,14,22,'Senior','Si'),(5,14,23,'Senior','Si');
/*!40000 ALTER TABLE `puestos_competencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos_de_trabajo`
--

DROP TABLE IF EXISTS `puestos_de_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puestos_de_trabajo` (
  `cod_puesto` int(3) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_puesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos_de_trabajo`
--

LOCK TABLES `puestos_de_trabajo` WRITE;
/*!40000 ALTER TABLE `puestos_de_trabajo` DISABLE KEYS */;
INSERT INTO `puestos_de_trabajo` VALUES (1,'Jefe de Produccion'),(3,'Encargado de Mantenimiento'),(4,'Operario'),(5,'Analista'),(6,'Coordinador de RRHH'),(8,'Pasante'),(9,'Agente'),(10,'Tesorero'),(11,'Analista Financiero'),(12,'Soporte Tecnico'),(13,'Auditor de Sistemas'),(14,'Director de Sistemas');
/*!40000 ALTER TABLE `puestos_de_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salario`
--

DROP TABLE IF EXISTS `salario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salario` (
  `cod_area` int(3) NOT NULL,
  `cod_puesto` int(3) NOT NULL,
  `fecha` date NOT NULL,
  `valor_hora` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cod_area`,`cod_puesto`,`fecha`),
  CONSTRAINT `salario_puestos_areas_fk` FOREIGN KEY (`cod_area`, `cod_puesto`) REFERENCES `puestos_areas` (`cod_area`, `cod_puesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salario`
--

LOCK TABLES `salario` WRITE;
/*!40000 ALTER TABLE `salario` DISABLE KEYS */;
INSERT INTO `salario` VALUES (1,1,'2016-11-08','177.78'),(1,1,'2016-11-19','357.49'),(1,1,'2018-07-17','479.39'),(1,3,'2016-08-05','475.1'),(1,3,'2018-10-11','490.52'),(1,3,'2018-11-10','375.7'),(1,4,'2016-12-12','450.59'),(1,4,'2017-02-27','331.35'),(1,4,'2018-04-05','213.10999999999999'),(1,8,'2016-02-08','156.99'),(1,8,'2016-02-14','132.66'),(1,8,'2016-04-02','321.45'),(2,5,'2017-07-13','213.76999999999998'),(2,5,'2017-10-10','129.91'),(2,5,'2018-12-28','261.08000000000004'),(2,6,'2016-01-09','355.95'),(2,6,'2018-09-05','177.55'),(2,6,'2018-11-19','123.03'),(2,8,'2017-01-13','492.8'),(2,8,'2017-04-21','52.620000000000005'),(2,8,'2018-05-03','178.52'),(3,8,'2016-12-13','285.78000000000003'),(3,8,'2017-08-07','186.94'),(3,8,'2018-10-16','299.99'),(3,9,'2016-12-22','258.43'),(3,9,'2018-02-10','231.68'),(3,9,'2018-05-12','494.41'),(4,8,'2016-02-25','356.58000000000004'),(4,8,'2016-11-20','305.18'),(4,8,'2017-01-02','363.71000000000004'),(4,10,'2018-04-09','140.17000000000002'),(4,10,'2018-05-27','234.73000000000002'),(4,10,'2018-06-25','105.9'),(4,11,'2016-09-20','380.83000000000004'),(4,11,'2017-06-11','139.59'),(4,11,'2017-11-24','44.410000000000004'),(5,5,'2017-03-01','142.78'),(5,5,'2017-03-13','312.03000000000003'),(5,5,'2018-01-23','343.24'),(5,8,'2016-02-04','9.879999999999995'),(5,8,'2016-08-09','268.3'),(5,12,'2017-04-17','437.23'),(5,12,'2017-04-18','122.9'),(5,12,'2018-05-14','224.51'),(5,13,'2017-07-24','473.62'),(5,13,'2017-08-06','209.34'),(5,13,'2018-12-24','88.05'),(5,14,'2016-06-14','486.38'),(5,14,'2017-02-10','223.48000000000002'),(5,14,'2017-05-21','400.76');
/*!40000 ALTER TABLE `salario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitudes_puestos`
--

DROP TABLE IF EXISTS `solicitudes_puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitudes_puestos` (
  `cod_area` int(3) NOT NULL,
  `cod_puesto` int(3) NOT NULL,
  `fecha_solic` date NOT NULL,
  `cant_puestos_solic` int(4) DEFAULT NULL,
  `cant_puestos_cubiertos` int(4) DEFAULT NULL,
  `cant_hs_trabajo` int(9) DEFAULT NULL,
  `fecha_canc` date DEFAULT NULL,
  PRIMARY KEY (`cod_area`,`cod_puesto`,`fecha_solic`),
  CONSTRAINT `solicitudes_puestos_puestos_areas_fk` FOREIGN KEY (`cod_area`, `cod_puesto`) REFERENCES `puestos_areas` (`cod_area`, `cod_puesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitudes_puestos`
--

LOCK TABLES `solicitudes_puestos` WRITE;
/*!40000 ALTER TABLE `solicitudes_puestos` DISABLE KEYS */;
INSERT INTO `solicitudes_puestos` VALUES (1,3,'2016-05-15',9,0,8,'2016-06-15'),(1,3,'2016-06-14',4,3,7,NULL),(1,3,'2017-03-27',7,5,10,NULL),(1,4,'2016-05-07',6,4,4,NULL),(1,8,'2017-04-03',4,2,5,NULL),(2,5,'2016-05-10',3,2,4,NULL),(2,6,'2016-10-13',7,5,7,NULL),(2,8,'2016-08-20',1,0,6,'2016-09-20'),(2,8,'2017-09-05',8,3,5,NULL),(4,8,'2017-07-26',9,6,10,NULL),(4,8,'2017-09-19',6,2,5,NULL),(4,8,'2018-01-07',3,0,9,'2018-02-07'),(4,10,'2016-01-28',4,4,4,'2016-02-28'),(4,10,'2017-09-01',4,4,5,'2017-10-01'),(5,13,'2016-07-13',9,1,6,NULL),(5,14,'2017-08-04',2,2,8,'2017-09-04');
/*!40000 ALTER TABLE `solicitudes_puestos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-20  8:55:25

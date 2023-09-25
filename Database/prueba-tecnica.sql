-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: pruebatecnica
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `CourseCode` varchar(50) NOT NULL,
  `FechaAlta` datetime NOT NULL,
  `Estado` int NOT NULL,
  `CantidadEgresados` int NOT NULL,
  `FechaEntrega` datetime NOT NULL,
  `MedioEntrega` varchar(45) DEFAULT NULL,
  `Vendedor` varchar(45) DEFAULT NULL,
  `ColegioNivel` varchar(45) NOT NULL,
  `ColegioNombre` varchar(45) NOT NULL,
  `ColegioCurso` varchar(45) NOT NULL,
  `ColegioLocalidad` varchar(45) NOT NULL,
  `Comision` int NOT NULL,
  `Total` decimal(8,2) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `CourseCode_UNIQUE` (`CourseCode`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
INSERT INTO `contratos` VALUES (100,'KLH536','2023-09-21 00:58:26',1,23,'2023-11-20 14:30:00',NULL,NULL,'Secundaria','IPEM N° 315','5B','San Francisco',11,11111.00),(101,'KLL136','2023-02-02 16:30:00',1,19,'2023-03-05 16:30:00',NULL,NULL,'Secundaria','IPEM N° 65','4B','San Francisco',9,60800.00),(102,'TGH611','2023-03-12 16:50:00',1,29,'2023-03-25 11:10:00',NULL,NULL,'Secundaria','EEMPA N° 264','2C','Frontera',6,11111.00),(103,'ZZL333','2023-03-22 17:10:00',1,32,'2023-04-15 09:30:00',NULL,NULL,'Primaria','FASTA I.C','4A','Las Varillas',15,144000.00),(104,'TGH650','2023-05-06 18:20:00',1,30,'2023-06-05 14:20:00',NULL,NULL,'Secundaria','PABLO  VI','6D','San Francisco',1,11111.00),(105,'WERW3','2023-01-01 12:19:02',1,25,'2023-01-23 11:13:00',NULL,NULL,'Secundaria','RAVETTI','1B','Córdoba',12,11111.00),(115,'KLL1326','2023-07-02 11:31:00',1,27,'2023-07-25 11:30:00',NULL,NULL,'Secundaria','IPEM N° 665','3B','San Francisco',4,0.00);
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_producto`
--

DROP TABLE IF EXISTS `detalle_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_producto` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_producto`
--

LOCK TABLES `detalle_producto` WRITE;
/*!40000 ALTER TABLE `detalle_producto` DISABLE KEYS */;
INSERT INTO `detalle_producto` VALUES (1,'Pantalón',4500.00),(2,'Corbata',3200.00),(3,'Remera',4000.00),(4,'Gorro',2500.00),(5,'Zapatos',9000.00),(6,'Medias',1600.00),(7,'Camisa',12500.00),(8,'Pullover',7950.00);
/*!40000 ALTER TABLE `detalle_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ContractId` int NOT NULL,
  `ItemId` int NOT NULL,
  `CreateDate` datetime NOT NULL,
  `UpdateDate` datetime DEFAULT NULL,
  `Enabled` int NOT NULL,
  `Deleted` int NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `ContractId_idx` (`ContractId`),
  KEY `ItemId_idx` (`ItemId`),
  CONSTRAINT `ContractId` FOREIGN KEY (`ContractId`) REFERENCES `contratos` (`Id`),
  CONSTRAINT `ItemId` FOREIGN KEY (`ItemId`) REFERENCES `detalle_producto` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (2,102,4,'2023-03-12 16:50:00',NULL,1,0,'Admin'),(3,103,1,'2023-03-12 16:50:00',NULL,1,0,'Admin'),(4,101,2,'2023-07-02 07:50:00',NULL,1,0,'Admin'),(5,102,5,'2023-03-12 16:51:00',NULL,1,0,'Admin');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-24 23:28:02

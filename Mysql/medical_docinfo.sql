-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: medical
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
-- Table structure for table `docinfo`
--

DROP TABLE IF EXISTS `docinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docinfo` (
  `docid` int(11) NOT NULL AUTO_INCREMENT,
  `dname` varchar(45) DEFAULT NULL,
  `dphone` varchar(45) DEFAULT NULL,
  `daddress` varchar(45) DEFAULT NULL,
  `dfield` int(11) DEFAULT NULL,
  PRIMARY KEY (`docid`),
  KEY `field_idx` (`dfield`),
  CONSTRAINT `docinfo_ibfk_1` FOREIGN KEY (`dfield`) REFERENCES `field` (`fieldid`) ON DELETE SET NULL,
  CONSTRAINT `docinfo_ibfk_2` FOREIGN KEY (`dfield`) REFERENCES `field` (`fieldid`) ON DELETE SET NULL,
  CONSTRAINT `field` FOREIGN KEY (`dfield`) REFERENCES `field` (`fieldid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docinfo`
--

LOCK TABLES `docinfo` WRITE;
/*!40000 ALTER TABLE `docinfo` DISABLE KEYS */;
INSERT INTO `docinfo` VALUES (1,'Raj','9283747282','Jp Nagar',1),(2,'Priya','9384758675','Jayanagar',2),(3,'Suraj','9875648576','Vijaynagar',3),(4,'Shetty','9684756348','RRnagar',4),(5,'Leela','9485748563','Kengeri',5),(6,'Harish','9485746578','Jayangar',6),(7,'Shreyas','8576465786','Indranagar',7),(8,'Kavya','9876586746','Jp nagar',1),(9,'Preeti','9384756374','Majestic',2),(10,'George','8374938473','Banshankari',3),(11,'Ramesh','8475938475','Magadi ',4),(12,'Poorvi','9384759283','Jambu Savari',5),(13,'Guru','8394837294','Electronic City',6),(14,'Neeta','9283729390','Jayanagar',7),(15,'Sandya','9387399234','Malleshwaram',1);
/*!40000 ALTER TABLE `docinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-08 11:47:56

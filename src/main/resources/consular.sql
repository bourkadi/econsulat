-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: consular
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu18.04.1

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
-- Table structure for table `attestation`
--

DROP TABLE IF EXISTS `attestation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attestation` (
  `idattestation` int(11) NOT NULL AUTO_INCREMENT,
  `createdDate` int(11) NOT NULL,
  `content` text NOT NULL,
  `user` int(11) NOT NULL COMMENT 'creator of the attestation\n',
  `person` int(11) NOT NULL,
  `attestation_type` int(11) NOT NULL,
  PRIMARY KEY (`idattestation`),
  KEY `fk_attestation_user1_idx` (`user`),
  KEY `fk_attestation_person1_idx` (`person`),
  KEY `fk_attestation_attestation_type1_idx` (`attestation_type`),
  FULLTEXT KEY `fl_attestaton_content` (`content`),
  CONSTRAINT `fk_attestation_attestation_type1` FOREIGN KEY (`attestation_type`) REFERENCES `attestation_type` (`idattestation_type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_attestation_person1` FOREIGN KEY (`person`) REFERENCES `person` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_attestation_user1` FOREIGN KEY (`user`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=dec8 COMMENT='A service given to the citizen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attestation`
--

LOCK TABLES `attestation` WRITE;
/*!40000 ALTER TABLE `attestation` DISABLE KEYS */;
/*!40000 ALTER TABLE `attestation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attestation_type`
--

DROP TABLE IF EXISTS `attestation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attestation_type` (
  `idattestation_type` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`idattestation_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attestation_type`
--

LOCK TABLES `attestation_type` WRITE;
/*!40000 ALTER TABLE `attestation_type` DISABLE KEYS */;
INSERT INTO `attestation_type` VALUES (1,'Attestation de Célibat'),(2,'Act de Naissance'),(3,'Déclaration sur l\'honneur');
/*!40000 ALTER TABLE `attestation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulate`
--

DROP TABLE IF EXISTS `consulate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consulate` (
  `idconsulat` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `longName` varchar(45) DEFAULT NULL,
  `country` int(11) NOT NULL,
  PRIMARY KEY (`idconsulat`),
  KEY `fk_consulat_country1_idx` (`country`),
  CONSTRAINT `fk_consulat_country1` FOREIGN KEY (`country`) REFERENCES `country` (`idcountry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulate`
--

LOCK TABLES `consulate` WRITE;
/*!40000 ALTER TABLE `consulate` DISABLE KEYS */;
INSERT INTO `consulate` VALUES (3,'DUBAI','LE CONSULAT GENERAL DU MAROC A DUBAI',1),(4,'ABU DHABI','AMBASSADE DU ROYUAME A ABU DHABI',1);
/*!40000 ALTER TABLE `consulate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `idcountry` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `longName` varchar(45) DEFAULT NULL,
  `continent` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcountry`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='A country table, contains many consulates, ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'UAE','United Arab Emirates','ASIA'),(2,'France','La République Française','Europe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `idperson` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `cnie` varchar(45) NOT NULL COMMENT 'CNIE or ETAT CIVIL',
  `ic` varchar(45) NOT NULL COMMENT 'IC, le numéro consulaire, imported from the CONSULAIRE app or just created',
  `consulate` int(11) NOT NULL,
  PRIMARY KEY (`idperson`),
  KEY `fk_person_consulate1_idx` (`consulate`),
  FULLTEXT KEY `fl_person_name` (`name`,`lastName`),
  FULLTEXT KEY `fl_person_cnie` (`cnie`),
  FULLTEXT KEY `fl_person_ic` (`ic`),
  CONSTRAINT `fk_person_consulate1` FOREIGN KEY (`consulate`) REFERENCES `consulate` (`idconsulat`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='A citizen, mostly imported from the CONSULAIRE app';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'amine','bourkadi','2017-03-07','jddnen','bfdbde',3);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `idrole` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idrole`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='roles of the users, defines ACL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN'),(2,'SAISI');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `createdDate` int(11) NOT NULL,
  `consulate` int(11) NOT NULL,
  `connected` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `last_connected_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`iduser`),
  KEY `fk_user_consulat1_idx` (`consulate`),
  CONSTRAINT `fk_user_consulat1` FOREIGN KEY (`consulate`) REFERENCES `consulate` (`idconsulat`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='user of the system, attached to an entity, mostly a consulat';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'amine','cd06978490e672682031fd13de989a5311c078718571b2d3f9c1aa039161da3feac29ead85d7b1609b367a1181f985e75f0ba95574c9d666f480bd3444826623',12345,3,1,1,11111),(3,'moh','12345667889',12345678,3,1,1,132467889);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_role`
--

DROP TABLE IF EXISTS `user_has_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_role` (
  `iduser` int(11) NOT NULL,
  `role_idrole` int(11) NOT NULL,
  PRIMARY KEY (`iduser`,`role_idrole`),
  KEY `fk_user_has_role_role1_idx` (`role_idrole`),
  KEY `fk_user_has_role_user_idx` (`iduser`),
  CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_idrole`) REFERENCES `role` (`idrole`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_role_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_role`
--

LOCK TABLES `user_has_role` WRITE;
/*!40000 ALTER TABLE `user_has_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-03 21:49:06

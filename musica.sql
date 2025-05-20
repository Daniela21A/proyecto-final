-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: musica
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `id_album` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `anio` int DEFAULT NULL,
  `artista_id` int DEFAULT NULL,
  PRIMARY KEY (`id_album`),
  KEY `artista_id` (`artista_id`),
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`artista_id`) REFERENCES `artista` (`id_artista`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'The Fame Monster',2009,1),(2,'Born to Die',2012,2),(3,'After Hours',2020,3),(4,'IGOR',2019,4),(5,'Sweetener',2018,5),(6,'Blurryface',2015,6),(7,'Hybrid Theory',2000,7),(8,'Chocolate Starfish and the Hot Dog Flavored Water',2000,8),(9,'Demon Days',2005,9),(10,'Night Visions',2012,10);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artista`
--

DROP TABLE IF EXISTS `artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artista` (
  `id_artista` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `nacionalidad` varchar(50) DEFAULT NULL,
  `genero_id` int DEFAULT NULL,
  PRIMARY KEY (`id_artista`),
  KEY `genero_id` (`genero_id`),
  CONSTRAINT `artista_ibfk_1` FOREIGN KEY (`genero_id`) REFERENCES `genero` (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artista`
--

LOCK TABLES `artista` WRITE;
/*!40000 ALTER TABLE `artista` DISABLE KEYS */;
INSERT INTO `artista` VALUES (1,'Lady Gaga','Estados Unidos',1),(2,'Lana Del Rey','Estados Unidos',1),(3,'The Weeknd','Canadá',1),(4,'Tyler, The Creator','Estados Unidos',1),(5,'Ariana Grande','Estados Unidos',1),(6,'Twenty One Pilots','Estados Unidos',2),(7,'Linkin Park','Estados Unidos',2),(8,'Limp Bizkit','Estados Unidos',2),(9,'Gorillaz','Reino Unido',2),(10,'Imagine Dragons','Estados Unidos',2);
/*!40000 ALTER TABLE `artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cancion`
--

DROP TABLE IF EXISTS `cancion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancion` (
  `id_cancion` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `duracion` time DEFAULT NULL,
  `album_id` int DEFAULT NULL,
  PRIMARY KEY (`id_cancion`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `cancion_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id_album`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancion`
--

LOCK TABLES `cancion` WRITE;
/*!40000 ALTER TABLE `cancion` DISABLE KEYS */;
INSERT INTO `cancion` VALUES (1,'Bad Romance','00:04:54',1),(2,'Alejandro','00:04:34',1),(3,'Dance in the Dark','00:04:49',1),(4,'Video Games','00:04:42',2),(5,'Born to Die','00:04:46',2),(6,'Summertime Sadness','00:04:25',2),(7,'Blinding Lights','00:03:20',3),(8,'Save Your Tears','00:03:36',3),(9,'In Your Eyes','00:03:57',3),(10,'EARFQUAKE','00:03:10',4),(11,'A BOY IS A GUN*','00:03:30',4),(12,'I THINK','00:03:32',4),(13,'no tears left to cry','00:03:25',5),(14,'God is a woman','00:03:17',5),(15,'breathin','00:03:18',5),(16,'Stressed Out','00:03:22',6),(17,'Ride','00:03:34',6),(18,'Tear in My Heart','00:03:08',6),(19,'In the End','00:03:36',7),(20,'Crawling','00:03:29',7),(21,'One Step Closer','00:02:35',7),(22,'My Way','00:04:32',8),(23,'Rollin (Air Raid Vehicle)','00:03:33',8),(24,'Boiler','00:05:45',8),(25,'Feel Good Inc.','00:03:41',9),(26,'DARE','00:04:04',9),(27,'Dirty Harry','00:03:43',9),(28,'Radioactive','00:03:06',10),(29,'Demons','00:02:57',10),(30,'It\'s Time','00:03:59',10);
/*!40000 ALTER TABLE `cancion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genero` (
  `id_genero` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (1,'Pop'),(2,'Rock');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-19 18:04:08

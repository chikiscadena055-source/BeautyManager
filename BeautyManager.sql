-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: salon_belleza_prueba
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `cita_producto`
--

DROP TABLE IF EXISTS `cita_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita_producto` (
  `id_Cita` int NOT NULL,
  `id_Producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_Cita`,`id_Producto`),
  KEY `id_Producto` (`id_Producto`),
  CONSTRAINT `cita_producto_ibfk_1` FOREIGN KEY (`id_Cita`) REFERENCES `citas` (`id_Cita`),
  CONSTRAINT `cita_producto_ibfk_2` FOREIGN KEY (`id_Producto`) REFERENCES `productos` (`id_Producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita_producto`
--

LOCK TABLES `cita_producto` WRITE;
/*!40000 ALTER TABLE `cita_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `cita_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_Cita` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL,
  `estado` varchar(50) NOT NULL,
  `id_Cliente` int NOT NULL,
  `id_Empleado` int NOT NULL,
  `id_Servicio` int NOT NULL,
  PRIMARY KEY (`id_Cita`),
  KEY `id_Cliente` (`id_Cliente`),
  KEY `id_Empleado` (`id_Empleado`),
  KEY `id_Servicio` (`id_Servicio`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_Cliente`) REFERENCES `clientes` (`id_Cliente`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_Empleado`) REFERENCES `empleados` (`id_Empleado`),
  CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`id_Servicio`) REFERENCES `servicios` (`id_Servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (4,'2026-11-20 09:00:00','Programada',1,1,1),(5,'2026-11-21 10:30:00','Confirmada',2,1,2),(6,'2026-11-22 14:00:00','Pendiente',3,1,3);
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_Cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_Cliente`),
  UNIQUE KEY `cedula` (`cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Ana Gómez','12345678','Calle 10','3001234567','ana@gmail.com'),(2,'Ana Gómez','10010001','Calle 10 #15-20','3001111111','ana.gomez@email.com'),(3,'Luis Martínez','10010002','Carrera 20 #30-15','3002222222','luis.martinez@email.com'),(4,'María Rodríguez','10010003','Calle 5 #12-40','3003333333','maria.rodriguez@email.com'),(5,'Carlos Pérez','10010004','Avenida 68 #45-22','3004444444','carlos.perez@email.com'),(6,'Laura Fernández','10010005','Carrera 7 #80-10','3005555555','laura.fernandez@email.com'),(7,'Jorge Ramírez','10010006','Calle 100 #25-30','3006666666','jorge.ramirez@email.com'),(8,'Sofía Castro','10010007','Carrera 15 #90-50','3007777777','sofia.castro@email.com'),(9,'Andrés Morales','10010008','Calle 45 #18-60','3008888888','andres.morales@email.com'),(10,'Valentina Herrera','10010009','Avenida Boyacá #70-15','3009999999','valentina.herrera@email.com'),(11,'Daniel Torres','10010010','Carrera 30 #50-25','3010000000','daniel.torres@email.com'),(12,'laura martinez','987654321','Calle 10 # 20-30','3001234567','laura.prueba@gmail.com'),(13,'mabel cadena','12345685','Carrera 14 # 102 - 23','3124567897','mabel.prueba@gmail.com'),(14,'Ana Perez','32547891','Diagonal 115 a # 1-41','3228576945','ana.prueba@gmail.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id_Empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `pass_Empleado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Empleado`),
  UNIQUE KEY `cedula` (`cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Carlos Ruiz','11111111','Estilista','carlos@salon.com','PBKDF2$120000$RJuO7gI3t/ix+qYO7yHi2A==$P8Qf6XivvKhFkpQeQ8HMwvl8izli9rW+ag3YNcUM1VQ='),(10,'Pedro Sánchez','55555555','Estilista','pedro@salon.com',NULL),(11,'Camila Rojas','66666666','Manicurista','camila@salon.com',NULL),(12,'Diego López','77777777','Barbero','diego@salon.com',NULL),(13,'Valeria Gómez','88888888','Colorista','valeria@salon.com',NULL),(14,'Sofia Gomes','12123654','Administrador','sofia.prueba@gmail.com','PBKDF2$120000$xWUhFA2C4ZIXP1cBZ/8fQg==$OvZw33ULkqbIkSEG0VSj+xGdeUzM6/Slk4kPRLvtwJQ=');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_Producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id_Producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio_empleado`
--

DROP TABLE IF EXISTS `servicio_empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio_empleado` (
  `id_Empleado` int NOT NULL,
  `id_Servicio` int NOT NULL,
  PRIMARY KEY (`id_Empleado`,`id_Servicio`),
  KEY `id_Servicio` (`id_Servicio`),
  CONSTRAINT `servicio_empleado_ibfk_1` FOREIGN KEY (`id_Empleado`) REFERENCES `empleados` (`id_Empleado`),
  CONSTRAINT `servicio_empleado_ibfk_2` FOREIGN KEY (`id_Servicio`) REFERENCES `servicios` (`id_Servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio_empleado`
--

LOCK TABLES `servicio_empleado` WRITE;
/*!40000 ALTER TABLE `servicio_empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicio_empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id_Servicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_Servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Corte de cabello',30000.00,'Corte y lavado'),(2,'Manicure',25000.00,'Manicure básica'),(3,'Pedicure',35000.00,'Pedicure completa'),(4,'Corte Básico',25000.00,'Incluye lavado y secado'),(5,'Corte Premium',40000.00,'Incluye hidratación capilar'),(6,'Manicure Clásica',20000.00,'Manicure tradicional'),(7,'Pedicure Spa',35000.00,'Pedicure con exfoliación');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-22  0:50:05

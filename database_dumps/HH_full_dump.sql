/*
SQLyog Ultimate v13.1.9 (64 bit)
MySQL - 10.3.34-MariaDB-0+deb10u1 : Database - hardware_hub
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hardware_hub` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `hardware_hub`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category` */

insert  into `category`(`id`,`category_name`) values 
(1,'Laptops'),
(2,'GPUs');

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salutation_id` tinyint(3) unsigned DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `insert_trs` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `customers` */

insert  into `customers`(`id`,`first_name`,`last_name`,`salutation_id`,`email`,`password`,`street`,`zip`,`city`,`insert_trs`) values 
(1,'elyes','Brinis',1,'briniselyes@gmail.com',NULL,'Hoehenweg 14','42551','verlbert','2023-05-15 21:30:24'),
(2,'tim','test',1,NULL,NULL,NULL,NULL,NULL,NULL),
(3,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `order_history` */

DROP TABLE IF EXISTS `order_history`;

CREATE TABLE `order_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `status` enum('inCart','ordered') COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `order_history` */

insert  into `order_history`(`id`,`order_id`,`status`,`timestamp`) values 
(1,1,'inCart','2023-05-31 16:23:34');

/*Table structure for table `order_products` */

DROP TABLE IF EXISTS `order_products`;

CREATE TABLE `order_products` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `pieces` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `insert_ts` datetime NOT NULL,
  `update_ts` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `order_products` */

insert  into `order_products`(`id`,`order_id`,`product_id`,`pieces`,`insert_ts`,`update_ts`) values 
(1,1,1,3,'2023-05-31 16:23:34','2023-05-31 16:23:42');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` mediumint(8) unsigned NOT NULL,
  `status_id` enum('inCart','ordered') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status_id` enum('pending','payed','initialised','error') COLLATE utf8mb4_unicode_ci NOT NULL,
  `insert_ts` datetime NOT NULL,
  `update_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `orders` */

insert  into `orders`(`id`,`customer_id`,`status_id`,`payment_status_id`,`insert_ts`,`update_ts`) values 
(1,1,'inCart','pending','2023-05-31 16:23:34',NULL);

/*Table structure for table `product_imgs` */

DROP TABLE IF EXISTS `product_imgs`;

CREATE TABLE `product_imgs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `img_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_oder` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_imgs` */

insert  into `product_imgs`(`id`,`product_id`,`img_path`,`img_oder`) values 
(1,1,'/img/products/Samsung_GalaxyBook_3.png',0),
(2,2,'/img/products/Xiaomi_Redmibook_14.png',0),
(3,3,'/img/products/Apple_Macbook_Pro.png',0),
(4,4,'/img/products/ASUS_Zenbook_3_Deluxe.png',0);

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`specs`)),
  `price_netto` decimal(20,2) NOT NULL,
  `dimensions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`dimensions`)),
  `category_id` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`description`,`specs`,`price_netto`,`dimensions`,`category_id`) values 
(20,'Dell XPS 13','13.3\" Ultrabook - Intel Core i7, 16GB RAM, 512GB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"512GB SSD\"}',1799.99,'{\"length\": \"11.6 inches\", \"width\": \"7.8 inches\", \"height\": \"0.6 inches\"}',1),
(21,'MacBook Pro 16','16\" Laptop - Intel Core i9, 32GB RAM, 1TB SSD','{\"processor\": \"Intel Core i9\", \"ram\": \"32GB\", \"storage\": \"1TB SSD\"}',2499.99,'{\"length\": \"14.1 inches\", \"width\": \"9.7 inches\", \"height\": \"0.6 inches\"}',1),
(22,'HP Spectre x360','13.3\" 2-in-1 Laptop - Intel Core i5, 8GB RAM, 256GB SSD','{\"processor\": \"Intel Core i5\", \"ram\": \"8GB\", \"storage\": \"256GB SSD\"}',1099.99,'{\"length\": \"12.0 inches\", \"width\": \"8.6 inches\", \"height\": \"0.7 inches\"}',1),
(23,'Lenovo ThinkPad X1 Carbon','14\" Ultrabook - Intel Core i7, 16GB RAM, 512GB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"512GB SSD\"}',1699.99,'{\"length\": \"12.7 inches\", \"width\": \"8.5 inches\", \"height\": \"0.6 inches\"}',1),
(5,'ASUS ROG Zephyrus G14','14\" Gaming Laptop - AMD Ryzen 9, 16GB RAM, 1TB SSD','{\"processor\": \"AMD Ryzen 9\", \"ram\": \"16GB\", \"storage\": \"1TB SSD\"}',1499.99,'{\"length\": \"12.8 inches\", \"width\": \"8.7 inches\", \"height\": \"0.7 inches\"}',1),
(6,'Acer Swift 3','14\" Laptop - Intel Core i5, 8GB RAM, 512GB SSD','{\"processor\": \"Intel Core i5\", \"ram\": \"8GB\", \"storage\": \"512GB SSD\"}',799.99,'{\"length\": \"12.7 inches\", \"width\": \"8.6 inches\", \"height\": \"0.6 inches\"}',1),
(7,'Microsoft Surface Laptop 4','13.5\" Laptop - Intel Core i7, 16GB RAM, 512GB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"512GB SSD\"}',1499.99,'{\"length\": \"12.1 inches\", \"width\": \"8.8 inches\", \"height\": \"0.6 inches\"}',1),
(8,'Razer Blade 15','15.6\" Gaming Laptop - Intel Core i7, 16GB RAM, 1TB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"1TB SSD\"}',1999.99,'{\"length\": \"13.98 inches\", \"width\": \"9.25 inches\", \"height\": \"0.7 inches\"}',1),
(9,'Dell Inspiron 15','15.6\" Laptop - Intel Core i5, 8GB RAM, 256GB SSD','{\"processor\": \"Intel Core i5\", \"ram\": \"8GB\", \"storage\": \"256GB SSD\"}',699.99,'{\"length\": \"14.33 inches\", \"width\": \"9.8 inches\", \"height\": \"0.7 inches\"}',1),
(10,'Lenovo Legion 5','15.6\" Gaming Laptop - AMD Ryzen 7, 16GB RAM, 512GB SSD','{\"processor\": \"AMD Ryzen 7\", \"ram\": \"16GB\", \"storage\": \"512GB SSD\"}',1299.99,'{\"length\": \"14.29 inches\", \"width\": \"10.22 inches\", \"height\": \"1.03 inches\"}',1),
(11,'NVIDIA GeForce RTX 3080','Graphics Card - 10GB GDDR6X, PCIe 4.0','{\"memory\": \"10GB GDDR6X\", \"interface\": \"PCIe 4.0\"}',899.99,'{\"length\": \"11.2 inches\", \"width\": \"4.4 inches\", \"height\": \"2-slot\"}',2),
(12,'AMD Radeon RX 6900 XT','Graphics Card - 16GB GDDR6, PCIe 4.0','{\"memory\": \"16GB GDDR6\", \"interface\": \"PCIe 4.0\"}',1199.99,'{\"length\": \"12.4 inches\", \"width\": \"5.5 inches\", \"height\": \"2.5-slot\"}',2),
(13,'EVGA GeForce GTX 1660 Super','Graphics Card - 6GB GDDR6, PCIe 3.0','{\"memory\": \"6GB GDDR6\", \"interface\": \"PCIe 3.0\"}',299.99,'{\"length\": \"7.5 inches\", \"width\": \"4.4 inches\", \"height\": \"2-slot\"}',2),
(14,'MSI GeForce RTX 3070 Gaming X Trio','Graphics Card - 8GB GDDR6, PCIe 4.0','{\"memory\": \"8GB GDDR6\", \"interface\": \"PCIe 4.0\"}',699.99,'{\"length\": \"12.8 inches\", \"width\": \"5.5 inches\", \"height\": \"2.7-slot\"}',2),
(15,'ASUS ROG Strix GeForce RTX 3090','Graphics Card - 24GB GDDR6X, PCIe 4.0','{\"memory\": \"24GB GDDR6X\", \"interface\": \"PCIe 4.0\"}',1999.99,'{\"length\": \"13.8 inches\", \"width\": \"5.4 inches\", \"height\": \"3-slot\"}',2),
(1,'Samsung GalaxyBook 3','13.3\" Laptop - Intel Core i5, 8GB RAM, 256GB SSD','{\"processor\": \"Intel Core i5\", \"ram\": \"8GB\", \"storage\": \"256GB SSD\"}',899.99,'{\"length\": \"12.0 inches\", \"width\": \"8.0 inches\", \"height\": \"0.6 inches\"}',1),
(2,'Xiaomi Redmibook 14','14\" Laptop - AMD Ryzen 5, 8GB RAM, 512GB SSD','{\"processor\": \"AMD Ryzen 5\", \"ram\": \"8GB\", \"storage\": \"512GB SSD\"}',699.99,'{\"length\": \"12.7 inches\", \"width\": \"8.5 inches\", \"height\": \"0.7 inches\"}',1),
(3,'Apple Macbook Pro','16\" Laptop - Intel Core i7, 16GB RAM, 1TB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"1TB SSD\"}',2199.99,'{\"length\": \"14.1 inches\", \"width\": \"9.7 inches\", \"height\": \"0.6 inches\"}',1),
(4,'ASUS Zenbook 3 Deluxe','14\" Ultrabook - Intel Core i7, 16GB RAM, 512GB SSD','{\"processor\": \"Intel Core i7\", \"ram\": \"16GB\", \"storage\": \"512GB SSD\"}',1599.99,'{\"length\": \"12.7 inches\", \"width\": \"8.5 inches\", \"height\": \"0.5 inches\"}',1);

/* Trigger structure for table `orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `insert_order_trigger` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `insert_order_trigger` AFTER INSERT ON `orders` FOR EACH ROW 
    BEGIN
	INSERT INTO order_history (order_id, status, timestamp)
	VALUES (NEW.id, NEW.status_id, NOW());
    END */$$


DELIMITER ;

/* Trigger structure for table `orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `update_order_status_trigger` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `update_order_status_trigger` AFTER UPDATE ON `orders` FOR EACH ROW 
    BEGIN
	IF NEW.status_id <> OLD.status_id THEN
		INSERT INTO order_history (order_id, status, timestamp)
		VALUES (NEW.id, NEW.status_id, NOW());
	END IF;
    END */$$


DELIMITER ;

/* Procedure structure for procedure `add_product_to_cart` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_product_to_cart` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product_to_cart`(IN product_id INT, IN user_id INT)
BEGIN
    DECLARE order_id INT;
    DECLARE product_count INT;
    
    -- Überprüfen, ob der Benutzer bereits eine offene Bestellung hat
    SELECT id INTO order_id
    FROM orders
    WHERE customer_id = user_id AND status_id = 'inCart';
    
    IF order_id IS NULL THEN
        -- Keine offene Bestellung vorhanden, eine neue Bestellung erstellen
        INSERT INTO orders (customer_id, status_id, payment_status_id, insert_ts, update_ts)
        VALUES (user_id, 'inCart', 'pending', NOW(), NULL);
        
        SET order_id = LAST_INSERT_ID();
    END IF;
    
    -- Überprüfen, ob das Produkt bereits in der Bestellung vorhanden ist
    SET product_count = (
        SELECT COUNT(*)
        FROM order_products
        WHERE order_id = order_id AND product_id = product_id
    );
    
    IF product_count = 0 THEN
        -- Das Produkt ist noch nicht in der Bestellung, Produkt zur Bestellungsprodukte-Tabelle hinzufügen
        INSERT INTO order_products (order_id, product_id, pieces, insert_ts, update_ts)
        VALUES (order_id, product_id, 1, NOW(), NOW());
    ELSE
        -- Das Produkt ist bereits in der Bestellung, die Anzahl der Pieces erhöhen
        UPDATE order_products
        SET pieces = pieces + 1, update_ts = NOW()
        WHERE order_id = order_id AND product_id = product_id;
    END IF;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `optimizer` */

/*!50003 DROP PROCEDURE IF EXISTS  `optimizer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `optimizer`()
BEGIN
    SET @dbase = 'hardware_hub';
    SELECT GROUP_CONCAT(information_schema.TABLES.TABLE_NAME) INTO @tablenames FROM information_schema.TABLES WHERE information_schema.TABLES.TABLE_SCHEMA = @dbase;
    SET @optimize = CONCAT('optimize table ', @tablenames);
    PREPARE stmt FROM @optimize;
    EXECUTE stmt;  
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_order_status` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_order_status` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_order_status`()
BEGIN

	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

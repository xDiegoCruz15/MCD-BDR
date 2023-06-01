CREATE DATABASE  IF NOT EXISTS `e-commer`;
USE `e-commer`;


SET FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='';
SET UNIQUE_CHECKS=0;




DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` varchar(32) NOT NULL,
  `customer_unique_id` varchar(32) DEFAULT NULL,
  `customer_zip_code_prefix` varchar(5) DEFAULT NULL,
  `customer_city` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `customer_state` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `customers_FK` (`customer_zip_code_prefix`),
  CONSTRAINT `customers_FK` FOREIGN KEY (`customer_zip_code_prefix`) REFERENCES `geolocation` (`geolocation_zip_code_prefix`)
) CHARSET=utf8mb3;

insert into customers (
	`customer_id`,
	`customer_unique_id`,
	`customer_zip_code_prefix`,
	`customer_city`,
	`customer_state`
) values
('06b8999e2fba1a1fbc88172c00ba8bc7', '861eff4711a542e4b93843c6dd7febb0', '14409', 'franca', 'SP'),
('18955e83d337fd6b2def6b18a428ac77', '290c77bc529b7ac935b93aa66c333dc3', '09790', 'sao bernardo do campo', 'SP'),
('4e7b3e00288586ebd08712fdd0374a03', '060e732b5b29e8181a18229c7b0b2b5e', '01151', 'sao paulo', 'SP'),
('b2b6027bc5c5109e529d4dc6358b12c3', '259dac757896d24d7702b9acbbff3f3c', '08775', 'mogi das cruzes', 'SP'),
('4f2d8ab171c80ec8364f7c12e35b23ad', '345ecd01c38d18a9036ed96c73b8d066', '13056', 'campinas', 'SP'),
('879864dab9bc3047522c92c82e1212b8', '4c93744516667ad3b8f1fb645a3116a4', '89254', 'jaragua do sul', 'SC'),
('fd826e7cf63160e536e0908c76c3f441', 'addec96d2e059c80c30fe6871d30d177', '04534', 'sao paulo', 'SP'),
('5e274e7a0c3809e14aba7ad5aae0d407', '57b2a98a409812fe9618067b6b8ebe4f', '35182', 'timoteo', 'MG');


DROP TABLE IF EXISTS `geolocation`;
CREATE TABLE `geolocation` (
  `geolocation_zip_code_prefix` varchar(5) NOT NULL,
  `geolocation_city` varchar(50) NOT NULL,
  `geolocation_state` varchar(2) NOT NULL,
  `geolocation_lat` double DEFAULT NULL,
  `geolocation_lng` double DEFAULT NULL,
  `geolocation_count` int DEFAULT NULL,
  PRIMARY KEY (`geolocation_zip_code_prefix`,`geolocation_city`,`geolocation_state`)
)CHARSET=utf8mb3;



DROP TABLE IF EXISTS `order_items`;

CREATE TABLE `order_items` (
  `order_id` varchar(32) NOT NULL,
  `order_item_id` int NOT NULL,
  `product_id` varchar(32) DEFAULT NULL,
  `seller_id` varchar(32) DEFAULT NULL,
  `shipping_limit_date` datetime DEFAULT NULL,
  `price` double DEFAULT NULL,
  `freight_value` double DEFAULT NULL,
  PRIMARY KEY (`order_id`,`order_item_id`),
  KEY `order_items_FK_1` (`product_id`),
  KEY `order_items_FK_2` (`seller_id`),
  CONSTRAINT `order_items_FK` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_FK_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `order_items_FK_2` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`seller_id`)
) CHARSET=utf8mb3;


DROP TABLE IF EXISTS `order_payments`;
CREATE TABLE `order_payments` (
  `order_id` varchar(32) NOT NULL,
  `payment_sequential` int NOT NULL,
  `payment_type` varchar(32) DEFAULT NULL,
  `payment_installments` int DEFAULT NULL,
  `payment_value` double DEFAULT NULL,
  PRIMARY KEY (`payment_sequential`,`order_id`),
  KEY `order_payments_FK` (`order_id`),
  CONSTRAINT `order_payments_FK` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) CHARSET=utf8mb3;




DROP TABLE IF EXISTS `order_reviews`;
CREATE TABLE `order_reviews` (
  `review_id` varchar(32) NOT NULL,
  `order_id` varchar(32) NOT NULL,
  `review_score` int DEFAULT NULL,
  `review_comment_title` varchar(50) DEFAULT NULL,
  `review_comment_message` varchar(500) DEFAULT NULL,
  `review_creation_date` date DEFAULT NULL,
  `review_answer_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`,`order_id`),
  KEY `order_reviews_FK` (`order_id`),
  CONSTRAINT `order_reviews_FK` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) CHARSET=utf8mb3;




DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` varchar(32) NOT NULL,
  `customer_id` varchar(32) DEFAULT NULL,
  `order_status` varchar(24) DEFAULT NULL,
  `order_purchase_timestamp` datetime DEFAULT NULL,
  `order_approved_at` datetime DEFAULT NULL,
  `order_delivered_carrier_date` datetime DEFAULT NULL,
  `order_delivered_customer_date` datetime DEFAULT NULL,
  `order_estimated_delivery_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_FK` (`customer_id`),
  CONSTRAINT `orders_FK` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) CHARSET=utf8mb3;
insert into orders (
	`order_id`,
	`customer_id`,
	`order_status`,
	`order_purchase_timestamp`,
	`order_approved_at`,
	`order_delivered_carrier_date`,
	`order_delivered_customer_date`,
	`order_estimated_delivery_date`
) values
('e481f51cbdc54678b7cc49136f2d6af7', '9ef432eb6251297304e76186b10a928d', 'delivered', '2017-10-02 10:56:33', '2017-10-02 11:07:15', '2017-10-04 19:55:00', '2017-10-10 21:25:13', '2017-10-18 00:00:00'),
('53cdb2fc8bc7dce0b6741e2150273451', 'b0830fb4747a6c6d20dea0b8c802d7ef', 'delivered', '2018-07-24 20:41:37', '2018-07-26 03:24:27', '2018-07-26 14:31:00', '2018-08-07 15:27:45', '2018-08-13 00:00:00'),
('47770eb9100c2d0c44946d9cf07ec65d', '41ce2a54c0b03bf3443c3d931a367089', 'delivered', '2018-08-08 08:38:49', '2018-08-08 08:55:23', '2018-08-08 13:50:00', '2018-08-17 18:06:29', '2018-09-04 00:00:00'),
('949d5b44dbf5de918fe9c16f97b45f8a', 'f88197465ea7920adcdbec7375364d82', 'delivered', '2017-11-18 19:28:06', '2017-11-18 19:45:59', '2017-11-22 13:39:59', '2017-12-02 00:28:42', '2017-12-15 00:00:00'),
('ad21c59c0840e6cb83a9ceb5573f8159', '8ab97904e6daea8866dbdbc4fb7aad2c', 'delivered', '2018-02-13 21:18:39', '2018-02-13 22:20:29', '2018-02-14 19:46:34', '2018-02-16 18:17:02', '2018-02-26 00:00:00'),
('a4591c265e18cb1dcee52889e2d8acc3', '503740e9ca751ccdda7ba28e9ab8f608', 'delivered', '2017-07-09 21:57:05', '2017-07-09 22:10:13', '2017-07-11 14:58:04', '2017-07-26 10:57:55', '2017-08-01 00:00:00'),
('136cce7faa42fdb2cefd53fdc79a6098', 'ed0271e0b7da060a393796590e7b737a', 'invoiced', '2017-04-11 12:22:08', '2017-04-13 13:25:17', NULL, NULL, '2017-05-09 00:00:00');




DROP TABLE IF EXISTS `product_translation`;
CREATE TABLE `product_translation` (
  `product_category_name` varchar(50) NOT NULL,
  `product_category_name_english` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_category_name`)
) CHARSET=utf8mb3;




DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` varchar(32) NOT NULL,
  `product_category_name` varchar(50) DEFAULT NULL,
  `product_name_lenght` int DEFAULT NULL,
  `product_description_lenght` int DEFAULT NULL,
  `product_photos_qty` int DEFAULT NULL,
  `product_weight_g` int DEFAULT NULL,
  `product_length_cm` int DEFAULT NULL,
  `product_height_cm` int DEFAULT NULL,
  `product_width_cm` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `products_FK` (`product_category_name`),
  CONSTRAINT `products_FK` FOREIGN KEY (`product_category_name`) REFERENCES `product_translation` (`product_category_name`)
) CHARSET=utf8mb3;
insert into products (
	`product_id`,
	`product_category_name`,
	`product_name_lenght`,
	`product_description_lenght`,
	`product_photos_qty`,
	`product_weight_g`,
	`product_length_cm`,
	`product_height_cm`,
	`product_width_cm`
) values
('1e9e8ef04dbcff4541ed26657ea517e5', 'perfumaria', 40, 287, 1, 225, 16, 10, 14),
('3aa071139cb16b67ca9e5dea641aaa2f', 'artes', 44, 276, 1, 1000, 30, 18, 20),
('96bd76ec8810374ed1b65e291975717f', 'esporte_lazer', 46, 250, 1, 154, 18, 9, 15),
('cef67bcfe19066a932b7673e239eb23d', 'bebes', 27, 261, 1, 371, 26, 4, 26),
('9dc1a7de274444849c219cff195d0b71', 'utilidades_domesticas', 37, 402, 4, 625, 20, 17, 13),
('41d3672d4792049fa1779bb35283ed13', 'instrumentos_musicais', 60, 745, 1, 200, 38, 5, 11),
('732bd381ad09e530fe0a5f457d81becb', 'cool_stuff', 56, 1272, 4, 18350, 70, 24, 44),
('2548af3e6e77a690cf3eb6368e9ab61e', 'moveis_decoracao', 56, 184, 2, 900, 40, 8, 40),
('37cc742be07708b53a98702e77a21a02', 'eletrodomesticos', 57, 163, 1, 400, 27, 13, 17),
('8c92109888e8cdf9d66dc7e463025574', 'brinquedos', 36, 1156, 1, 600, 17, 10, 12),
('14aa47b7fe5c25522b47b4b29c98dcb9', 'cama_mesa_banho', 54, 630, 1, 1100, 16, 10, 16),
('03b63c5fc16691530586ae020c345514', 'bebes', 49, 728, 4, 7150, 50, 19, 45);



DROP TABLE IF EXISTS `sellers`;
CREATE TABLE `sellers` (
  `seller_id` varchar(32) NOT NULL,
  `seller_zip_code_prefix` varchar(5) DEFAULT NULL,
  `seller_city` varchar(50) DEFAULT NULL,
  `seller_state` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`seller_id`),
  KEY `sellers_FK` (`seller_zip_code_prefix`),
  CONSTRAINT `sellers_FK` FOREIGN KEY (`seller_zip_code_prefix`) REFERENCES `geolocation` (`geolocation_zip_code_prefix`)
) CHARSET=utf8mb3;
insert into sellers (
	`seller_id`,
	`seller_zip_code_prefix`,
	`seller_city`,
	`seller_state`
) values
('3442f8959a84dea7ee197c632cb2df15', '13023', 'campinas', 'SP'),
('d1b65fc7debc3361ea86b5f14c68d2e2', '13844', 'mogi guacu', 'SP'),
('ce3ad9de960102d0677a81f5d0bb7b2d', '20031', 'rio de janeiro', 'RJ'),
('c0f3eea2e14555b6faeea3dd58c1b1c3', '04195', 'sao paulo', 'SP'),
('51a04a8a6bdcb23deccc82b0b80742cf', '12914', 'braganca paulista', 'SP'),
('c240c4061717ac1806ae6ee72be3533b', '20920', 'rio de janeiro', 'RJ'),
('e49c26c3edfa46d227d5121a6b6e4d37', '55325', 'brejao', 'PE'),
('1b938a7ec6ac5061a66a3766e0e75f90', '16304', 'penapolis', 'SP'),
('768a86e36ad6aae3d03ee3c6433d61df', '01529', 'sao paulo', 'SP'),
('ccc4bbb5f32a6ab2b7066a4130f114e3', '80310', 'curitiba', 'PR'),
('8cb7c5ddf41f4d506eba76e9a4702a25', '75110', 'anapolis', 'GO'),
('a7a9b880c49781da66651ccf4ba9ac38', '13530', 'itirapina', 'SP'),
('8bd0f31cf0a614c658f6763bd02dea69', '01222', 'sao paulo', 'SP'),
('05a48cc8859962767935ab9087417fbb', '05372', 'sao paulo', 'SP');


SET FOREIGN_KEY_CHECKS=1;
SET SQL_MODE=@OLD_SQL_MODE;
SET UNIQUE_CHECKS=1;



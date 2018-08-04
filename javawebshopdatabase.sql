/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : javawebshopdatabase

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-20 20:07:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_ID` int(11) NOT NULL,
  `provincial` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `counties` varchar(30) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `mailNum` varchar(50) DEFAULT NULL,
  `phoneNum` varchar(50) DEFAULT NULL,
  `user_id` int(8) NOT NULL,
  PRIMARY KEY (`address_ID`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('3', '浙江省', '台州市', '椒江区', '建设街道190号', '洛小熠', '111111', '15633792691', '10');
INSERT INTO `address` VALUES ('4', '浙江省', '台州市', '椒江区', '玉环街道111号', '东方末', '111111', '17633298714', '10');
INSERT INTO `address` VALUES ('5', '河北省', '石家庄市', '裕华区', '南二环东路20号河北师范大学新校区', '聂离', '051130', '19556218718', '10');
INSERT INTO `address` VALUES ('6', '浙江省', '台州市', '椒江区', '111', '陆风', '111111', '11111111111', '22');
INSERT INTO `address` VALUES ('7', '浙江省', '台州市', '椒江区', '1111', '11', '111111', '11111111111', '52');

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_id` int(8) NOT NULL AUTO_INCREMENT,
  `admin_username` varchar(20) NOT NULL,
  `admin_passwd` varchar(20) NOT NULL,
  `admin_image` varchar(50) NOT NULL,
  `admin_email` varchar(30) NOT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `validateCode` varchar(50) DEFAULT NULL,
  `registerTime` datetime DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'jack', '1111', 'people.png', '1551073921@qq1.com', null, null, '1', '1111', '2017-09-10 00:00:00');
INSERT INTO `admin` VALUES ('2', 'Bob', '6666', 'p_1.jpg', '1551073921@qq2.com', '19823189211', '北京五环', '1', '786.11598041386221551073921@qq.com', '2017-11-28 15:12:07');
INSERT INTO `admin` VALUES ('3', 'Tony', '1111', 'p_4.jpg', '1551073921@qq.com', null, null, '1', null, null);

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `food_id` int(8) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(20) NOT NULL,
  `food_price` double(30,2) NOT NULL,
  `food_description` varchar(200) NOT NULL,
  `food_imgurl` varchar(50) DEFAULT NULL,
  `Type_id` int(8) NOT NULL,
  `addFoodTime` datetime DEFAULT NULL,
  `buyCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `book_ibfk_1` (`Type_id`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`Type_id`) REFERENCES `food_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('2', '茅山长青', '123.00', '茅山长青是未经发酵制成的茶，保留了鲜叶的...11111', 'maoshanchangq.jpg', '1', '2017-12-20 17:16:42', '563');
INSERT INTO `food` VALUES ('3', '恒顺蜂蜜醋', '20.00', '纯粮制造', 'p_39.jpg', '14', '2017-12-01 09:55:18', '9020');
INSERT INTO `food` VALUES ('4', '红富士苹果', '4.50', '红富士苹果的简介红富士苹果果实近圆形,果...', 'p_2.jpg', '7', '2017-12-03 19:43:46', '221');
INSERT INTO `food` VALUES ('5', '老村长酒', '100.00', '老村长酒产自中国东北黑龙江，为东北特色低...', 'p_42.jpg', '16', '2017-12-01 10:40:44', '56');
INSERT INTO `food` VALUES ('7', '土豆片', '4.00', '土豆片，好吃又美味！', 'timg.jpg', '10', '2017-12-03 19:48:24', '101028');
INSERT INTO `food` VALUES ('8', '土豆泥', '3.00', '土豆泥', 'ni.jpg', '10', '2017-12-04 20:49:18', '212');
INSERT INTO `food` VALUES ('9', '可比克薯片', '3.00', '可比克薯片', '12.jpg', '10', '2017-12-04 21:10:52', '200');
INSERT INTO `food` VALUES ('10', '加多宝凉茶', '3.00', '加多宝凉茶', 'AD_03.png', '13', '2017-12-05 10:30:56', '13001015');
INSERT INTO `food` VALUES ('11', '蜂蜜柚子茶', '3.00', '蜂蜜柚子茶', 'AD_04.png', '13', '2017-12-05 10:31:45', '23');
INSERT INTO `food` VALUES ('12', '益昌香滑奶茶', '3.00', '小饿小困，喝益昌香滑奶茶', 'AD_06.png', '13', '2017-12-05 10:33:52', '50');
INSERT INTO `food` VALUES ('13', '科罗娜啤酒', '34.00', '墨西哥原装进口', 'p_44.jpg', '16', '2017-12-05 14:13:37', '46');
INSERT INTO `food` VALUES ('14', '衡水老白干', '10.00', '衡水老白干', 'p_41.jpg', '16', '2017-12-05 14:15:06', '67');
INSERT INTO `food` VALUES ('15', '红酒', '1000.00', '美味的味道', 'p_40.jpg', '16', '2017-12-05 14:15:59', '10000');
INSERT INTO `food` VALUES ('16', '茅台', '123.00', '风格最完美的酱香型大曲酒之典型，故“酱香型”又称“茅香型”。其酒质晶亮透明，微有黄色，酱香突出，令人陶醉，敞杯不饮，香气扑鼻，开怀畅饮，满口生香，饮后空杯，留香更大，持久不散', 'p_43.jpg', '16', '2017-12-05 14:24:31', '3456');
INSERT INTO `food` VALUES ('17', '五粮液', '123.00', '天下三千年，五粮成玉液。五粮液酒是浓香型...', 'p_46.jpg', '16', '2017-12-05 14:25:31', '55555658');
INSERT INTO `food` VALUES ('18', '西凤酒', '234.00', '西凤酒产于陝西省凤翔县柳林镇西凤酒厂。是我国和世界上最古老的酒种之一。其属凤香型大曲酒，被人们赞为它是“凤型”白酒的典型代表。', 'timg (1).jpg', '16', '2017-12-05 14:26:08', '789');
INSERT INTO `food` VALUES ('19', '洋河大曲', '678.00', '江苏省泗阳县的洋河酒厂所产，曾被列为中国的八大名酒之一，至今已有三百多年的历史。 “甜、绵、软、净、香”是洋河大曲的特色', 'timg (2).jpg', '16', '2017-12-05 14:27:18', '10007');
INSERT INTO `food` VALUES ('20', '古井贡酒', '567.00', '该酒产于安徽省亳州市古井酒厂。魏王曹操在...', '122.jpg', '16', '2017-12-05 14:28:22', '123');
INSERT INTO `food` VALUES ('21', '盼盼', '3.00', '居家必备', 'timg (3).jpg', '10', '2017-12-05 15:01:51', '456');
INSERT INTO `food` VALUES ('22', '小当家', '0.50', '干脆面，小时候的味道！', '111.jpg', '10', '2017-12-05 15:02:40', '891');
INSERT INTO `food` VALUES ('23', '比目鱼', '100.00', '黄油比目鱼,红烧比目鱼,清蒸鲽鱼身,深夜...', 'p_21.jpg', '17', '2017-12-05 15:21:18', '12346');
INSERT INTO `food` VALUES ('24', '中国龙虾', '12.00', '为中国特有种，分别于中国南海和东海南部近岸海区', 'p_25.jpg', '17', '2017-12-05 15:23:27', '3467');
INSERT INTO `food` VALUES ('25', '虾米', '30.00', '小虾米，海的味道\r\n', 'p_24.jpg', '17', '2017-12-05 15:24:29', '7823');
INSERT INTO `food` VALUES ('26', '海鱼', '200.00', '海鱼', 'timg (4).jpg', '17', '2017-12-05 15:25:09', '1278');
INSERT INTO `food` VALUES ('27', '葵花籽油', '70.00', '葵花籽油，植物的味道', 'p_32.jpg', '14', '2017-12-05 15:32:28', '6735');
INSERT INTO `food` VALUES ('28', '食盐', '2.00', '调味食用盐', 'p_37.jpg', '14', '2017-12-05 15:33:12', '1268');
INSERT INTO `food` VALUES ('29', '酱油', '3.00', '酱油', 'p_39.jpg', '14', '2017-12-05 15:33:39', '55555');
INSERT INTO `food` VALUES ('30', '芹菜', '3.00', '一、好处 芹菜具有一定药理和治疗价值。现代药理研究表明芹菜具有降血压、降血脂的作用。由于它们的根、茎、叶和籽...', 'timg (5).jpg', '6', '2017-12-20 09:17:54', '0');
INSERT INTO `food` VALUES ('31', '芒果', '20.00', '新鲜的芒果', 'timg (6).jpg', '7', '2017-12-20 09:18:55', '0');
INSERT INTO `food` VALUES ('32', '草莓', '12.00', '万物皆苦,只有你是草莓味,又像是闪着波光缓缓流淌的清澈河流,轻轻绕在我们心间。仅仅是侧颜就令人感叹神来之手', '11111.jpg', '7', '2017-12-20 09:20:56', '0');
INSERT INTO `food` VALUES ('33', '营养快线', '5.00', '营养快线，美味...', 'timg (7).jpg', '13', '2017-12-20 09:22:54', '0');

-- ----------------------------
-- Table structure for `food_type`
-- ----------------------------
DROP TABLE IF EXISTS `food_type`;
CREATE TABLE `food_type` (
  `type_id` int(8) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food_type
-- ----------------------------
INSERT INTO `food_type` VALUES ('1', '茶品类');
INSERT INTO `food_type` VALUES ('2', '豆制品类');
INSERT INTO `food_type` VALUES ('3', '菌菇类');
INSERT INTO `food_type` VALUES ('4', '粮食五谷类');
INSERT INTO `food_type` VALUES ('5', '禽蛋类');
INSERT INTO `food_type` VALUES ('6', '蔬菜类');
INSERT INTO `food_type` VALUES ('7', '水果类');
INSERT INTO `food_type` VALUES ('8', '奶制品类');
INSERT INTO `food_type` VALUES ('9', '营养品类');
INSERT INTO `food_type` VALUES ('10', '零食类');
INSERT INTO `food_type` VALUES ('13', '饮品类');
INSERT INTO `food_type` VALUES ('14', '调味品类');
INSERT INTO `food_type` VALUES ('16', '酒类');
INSERT INTO `food_type` VALUES ('17', '海鲜类');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` int(8) NOT NULL,
  `order_time` datetime NOT NULL,
  `order_state` varchar(5) NOT NULL,
  `address` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_ibfk_1` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('2', '10', '2017-12-13 15:26:18', '前台已删除', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('4', '10', '2017-12-13 15:34:07', '后台已删除', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('5', '10', '2017-12-13 15:39:40', '已完成', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('6', '10', '2017-12-13 15:41:31', '已完成', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('7', '10', '2017-12-13 15:42:19', '已完成', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('8', '10', '2017-12-13 15:45:11', '已完成', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('9', '10', '2017-12-13 15:46:39', '已发货', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('10', '10', '2017-12-13 15:49:07', '已发货', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('11', '10', '2017-12-13 15:49:57', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('12', '10', '2017-12-13 17:09:13', '已支付', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('13', '10', '2017-12-13 17:16:03', '已支付', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('14', '10', '2017-12-13 17:17:39', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('15', '10', '2017-12-13 17:17:57', '未支付', null);
INSERT INTO `orders` VALUES ('16', '10', '2017-12-14 14:29:04', '未支付', null);
INSERT INTO `orders` VALUES ('17', '10', '2017-12-14 15:17:51', '未支付', null);
INSERT INTO `orders` VALUES ('18', '10', '2017-12-14 15:18:37', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('19', '10', '2017-12-14 15:22:10', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('20', '10', '2017-12-14 15:27:32', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('21', '10', '2017-12-14 15:28:01', '已支付', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('22', '10', '2017-12-14 16:11:19', '未支付', null);
INSERT INTO `orders` VALUES ('23', '10', '2017-12-14 16:13:52', '已完成', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('24', '10', '2017-12-14 20:06:51', '未支付', null);
INSERT INTO `orders` VALUES ('25', '10', '2017-12-14 20:07:02', '已完成', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('26', '10', '2017-12-14 20:09:32', '已完成', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('27', '10', '2017-12-14 20:11:12', '已完成', '收货人【洛小熠】,收货地址【浙江省台州市椒江区建设街道190号】,邮编【111111】,手机号码【15633792691】');
INSERT INTO `orders` VALUES ('28', '10', '2017-12-15 08:32:37', '已完成', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('29', '10', '2017-12-18 16:32:32', '已支付', '收货人【东方末】,收货地址【浙江省台州市椒江区玉环街道111号】,邮编【111111】,手机号码【17633298714】');
INSERT INTO `orders` VALUES ('30', '10', '2017-12-18 20:13:22', '未支付', null);
INSERT INTO `orders` VALUES ('31', '22', '2017-12-20 08:44:09', '未支付', null);
INSERT INTO `orders` VALUES ('32', '22', '2017-12-20 08:44:43', '未支付', null);
INSERT INTO `orders` VALUES ('33', '22', '2017-12-20 14:52:59', '已支付', '收货人【陆风】,收货地址【浙江省台州市椒江区111】,邮编【111111】,手机号码【11111111111】');
INSERT INTO `orders` VALUES ('34', '22', '2017-12-20 15:07:19', '已支付', '收货人【陆风】,收货地址【浙江省台州市椒江区111】,邮编【111111】,手机号码【11111111111】');
INSERT INTO `orders` VALUES ('35', '22', '2017-12-20 15:25:24', '已支付', '收货人【陆风】,收货地址【浙江省台州市椒江区111】,邮编【111111】,手机号码【11111111111】');
INSERT INTO `orders` VALUES ('36', '10', '2017-12-20 15:33:48', '已支付', '收货人【聂离】,收货地址【河北省石家庄市裕华区南二环东路20号河北师范大学新校区】,邮编【051130】,手机号码【19556218718】');
INSERT INTO `orders` VALUES ('37', '52', '2017-12-20 17:11:15', '后台已删除', '收货人【11】,收货地址【浙江省台州市椒江区1111】,邮编【111111】,手机号码【11111111111】');

-- ----------------------------
-- Table structure for `order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `order_detail_id` int(8) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) NOT NULL,
  `food_id` int(8) NOT NULL,
  `count` int(5) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_detail_ibfk_1` (`order_id`),
  KEY `order_detail_ibfk_2` (`food_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('2', '2', '9', '100');
INSERT INTO `order_detail` VALUES ('5', '4', '17', '1');
INSERT INTO `order_detail` VALUES ('7', '5', '2', '1');
INSERT INTO `order_detail` VALUES ('10', '8', '2', '1');
INSERT INTO `order_detail` VALUES ('11', '9', '2', '1');
INSERT INTO `order_detail` VALUES ('12', '10', '8', '100');
INSERT INTO `order_detail` VALUES ('13', '11', '8', '100');
INSERT INTO `order_detail` VALUES ('14', '12', '10', '1');
INSERT INTO `order_detail` VALUES ('15', '13', '17', '1');
INSERT INTO `order_detail` VALUES ('16', '14', '17', '1');
INSERT INTO `order_detail` VALUES ('17', '15', '17', '1');
INSERT INTO `order_detail` VALUES ('18', '16', '17', '1');
INSERT INTO `order_detail` VALUES ('19', '17', '17', '1');
INSERT INTO `order_detail` VALUES ('20', '17', '10', '10');
INSERT INTO `order_detail` VALUES ('21', '18', '17', '100');
INSERT INTO `order_detail` VALUES ('22', '18', '10', '1');
INSERT INTO `order_detail` VALUES ('23', '19', '10', '1000');
INSERT INTO `order_detail` VALUES ('24', '20', '4', '100');
INSERT INTO `order_detail` VALUES ('25', '21', '7', '1');
INSERT INTO `order_detail` VALUES ('26', '22', '17', '1');
INSERT INTO `order_detail` VALUES ('27', '23', '12', '16');
INSERT INTO `order_detail` VALUES ('28', '24', '17', '1');
INSERT INTO `order_detail` VALUES ('29', '25', '7', '1');
INSERT INTO `order_detail` VALUES ('30', '26', '10', '1');
INSERT INTO `order_detail` VALUES ('31', '27', '23', '1');
INSERT INTO `order_detail` VALUES ('32', '28', '7', '1');
INSERT INTO `order_detail` VALUES ('33', '29', '10', '6');
INSERT INTO `order_detail` VALUES ('34', '30', '17', '1');
INSERT INTO `order_detail` VALUES ('35', '31', '20', '1');
INSERT INTO `order_detail` VALUES ('36', '32', '3', '1');
INSERT INTO `order_detail` VALUES ('37', '33', '10', '3');
INSERT INTO `order_detail` VALUES ('38', '34', '22', '1');
INSERT INTO `order_detail` VALUES ('39', '34', '28', '1');
INSERT INTO `order_detail` VALUES ('40', '35', '7', '10');
INSERT INTO `order_detail` VALUES ('41', '35', '10', '1');
INSERT INTO `order_detail` VALUES ('42', '36', '10', '1');
INSERT INTO `order_detail` VALUES ('43', '36', '7', '1');
INSERT INTO `order_detail` VALUES ('44', '37', '7', '1');
INSERT INTO `order_detail` VALUES ('45', '37', '10', '2');

-- ----------------------------
-- Table structure for `person`
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `PERSON_ID` int(11) NOT NULL,
  `IDNumber` varchar(30) NOT NULL,
  `RealName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`PERSON_ID`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`PERSON_ID`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('1', '1111111', '雷蒙');
INSERT INTO `person` VALUES ('2', '1111111', '赵达');
INSERT INTO `person` VALUES ('3', '1111111', '杨青玄');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_username` varchar(20) DEFAULT NULL,
  `user_passwd` varchar(20) DEFAULT NULL,
  `user_email` varchar(20) DEFAULT NULL,
  `user_telephone` varchar(30) DEFAULT NULL,
  `user_address` varchar(50) DEFAULT NULL,
  `user_image` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `validateCode` varchar(50) DEFAULT NULL,
  `registerTime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('10', 'jack', '1111', '1551073921@qq1.com', '18823167241', '天山中队', 'p_1.jpg', '1', '264.71612812454191551073921@qq.com', '2017-11-22 09:22:24');
INSERT INTO `users` VALUES ('11', 'Toney', '1111', '19332156341@163.com', '', '', 'psb (1).jpg', '0', '403.965301706424718332162377@163.com', '2017-11-27 20:43:20');
INSERT INTO `users` VALUES ('22', '李四', '1111', '1551073921@qq2.com', null, null, null, '1', null, null);
INSERT INTO `users` VALUES ('24', '1', null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('26', '1', null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('39', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('40', null, null, null, null, null, null, '1', null, null);
INSERT INTO `users` VALUES ('41', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('42', null, null, null, null, null, null, '1', null, null);
INSERT INTO `users` VALUES ('48', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('49', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('50', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('51', null, null, null, null, null, null, '0', null, null);
INSERT INTO `users` VALUES ('52', 'Bob', '1111', '1551073921@qq.com', '11111111111', '111', 'p_4.jpg', '1', '174.045737764153781551073921@qq.com', '2017-12-20 17:05:53');

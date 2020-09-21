/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : shoper

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2020-09-21 22:34:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for db_keys
-- ----------------------------
DROP TABLE IF EXISTS `db_keys`;
CREATE TABLE `db_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL COMMENT '关键字',
  `site` varchar(255) DEFAULT NULL COMMENT '站点：1 台湾，2 菲律宾',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for db_product
-- ----------------------------
DROP TABLE IF EXISTS `db_product`;
CREATE TABLE `db_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keys_id` int(11) NOT NULL COMMENT '关键字id',
  `shop_id` varchar(255) DEFAULT NULL COMMENT '商店id',
  `search_id` int(11) DEFAULT NULL COMMENT '搜索id',
  `item_id` varchar(255) DEFAULT NULL COMMENT '商品id',
  `cat_id` varchar(255) DEFAULT NULL COMMENT '分类id',
  `ads_id` int(11) DEFAULT NULL COMMENT '广告id',
  `label_ids` varchar(255) DEFAULT NULL COMMENT '标签id',
  `campaign_id` int(11) DEFAULT NULL COMMENT '活动id',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `brand` varchar(255) DEFAULT NULL COMMENT '品牌',
  `price_min` int(11) DEFAULT NULL COMMENT '最低价格',
  `price_max` int(11) DEFAULT NULL COMMENT '最高价格',
  `ads_keyword` varchar(255) DEFAULT NULL COMMENT '广告关键字',
  `free_shipping` varchar(255) DEFAULT NULL COMMENT '是否免运',
  `is_preferred_plus_seller` varchar(255) DEFAULT NULL COMMENT '是否为优选卖家',
  `rating_star` double(7,6) DEFAULT NULL COMMENT '评分',
  `cmt_count` int(11) DEFAULT NULL COMMENT '评价数',
  `view_count` int(11) DEFAULT NULL COMMENT '观看数量',
  `liked_count` int(11) DEFAULT NULL COMMENT '喜欢数量',
  `shop_location` varchar(255) DEFAULT NULL COMMENT '地区',
  `flag` varchar(255) DEFAULT NULL COMMENT '???',
  `sold` int(11) DEFAULT NULL COMMENT '？？？可能为当月销售额',
  `historical_sold` int(11) DEFAULT NULL COMMENT '历史销售数量',
  `ranking` int(11) DEFAULT NULL COMMENT '排名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `serach_time` datetime DEFAULT NULL COMMENT '搜索时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1951 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for db_search
-- ----------------------------
DROP TABLE IF EXISTS `db_search`;
CREATE TABLE `db_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_id` int(11) DEFAULT NULL COMMENT '关键字id',
  `key` varchar(255) DEFAULT NULL,
  `order_type` varchar(255) DEFAULT NULL COMMENT '排序方式：2 低到高 1. 高到低',
  `search_type` varchar(255) DEFAULT NULL COMMENT '查询方式：1 综合排名；2 最新；3：最热销；4：价格',
  `total_count` int(11) DEFAULT NULL COMMENT '总条数',
  `total_ads_count` int(11) DEFAULT NULL COMMENT '广告条数',
  `ori_totalCount` int(11) DEFAULT NULL COMMENT '排除广告条数',
  `suggestion_algorithm` int(11) DEFAULT NULL COMMENT '建议算法？？',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for db_word
-- ----------------------------
DROP TABLE IF EXISTS `db_word`;
CREATE TABLE `db_word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL COMMENT '关键字',
  `word` varchar(255) DEFAULT NULL COMMENT '词语',
  `num` int(11) DEFAULT NULL COMMENT '出现数量',
  `sold` int(20) DEFAULT NULL COMMENT '销量',
  `history_sold` int(11) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5489 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- View structure for v_avg
-- ----------------------------
DROP VIEW IF EXISTS `v_avg`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_avg` AS select `a`.`search_type` AS `搜索類型`,`a`.`key` AS `關鍵字`,((`b`.`price_min` + `b`.`price_max`) / 2) AS `平均價`,`b`.`serach_time` AS `時間` from (`db_search` `a` left join `db_product` `b` on((`a`.`id` = `b`.`search_id`))) ;

-- ----------------------------
-- View structure for v_avg_ads
-- ----------------------------
DROP VIEW IF EXISTS `v_avg_ads`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_avg_ads` AS select `a`.`search_type` AS `搜索類型`,`a`.`key` AS `關鍵字`,((`b`.`price_min` + `b`.`price_max`) / 2) AS `平均價`,`b`.`serach_time` AS `時間` from (`db_search` `a` left join `db_product` `b` on((`a`.`id` = `b`.`search_id`))) where (`b`.`ads_id` is not null) ;

-- ----------------------------
-- View structure for v_key_box
-- ----------------------------
DROP VIEW IF EXISTS `v_key_box`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_key_box` AS select `db_keys`.`key` AS `關鍵字` from `db_keys` group by `db_keys`.`key` ;

-- ----------------------------
-- View structure for v_product
-- ----------------------------
DROP VIEW IF EXISTS `v_product`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_product` AS select `a`.`key` AS `關鍵字`,`a`.`search_type` AS `搜索類型`,`b`.`item_id` AS `商品id`,`b`.`product_name` AS `商品名稱`,(`b`.`price_min` / 100000) AS `最小價格`,(`b`.`price_max` / 100000) AS `最大價格`,if(isnull(`b`.`ads_keyword`),'',`b`.`ads_keyword`) AS `廣告`,if((`b`.`free_shipping` = 1),'包郵','不包郵') AS `包郵`,`b`.`rating_star` AS `評分`,`b`.`cmt_count` AS `評論數`,`b`.`view_count` AS `瀏覽數`,`b`.`liked_count` AS `喜歡數`,`b`.`sold` AS `近期銷售數`,`b`.`historical_sold` AS `總銷售數`,`b`.`ranking` AS `排名`,date_format(`b`.`create_time`,'%Y-%m-%d') AS `創建日期`,`b`.`serach_time` AS `日期` from (`db_search` `a` left join `db_product` `b` on((`a`.`id` = `b`.`search_id`))) ;

-- ----------------------------
-- View structure for v_search_type_box
-- ----------------------------
DROP VIEW IF EXISTS `v_search_type_box`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_search_type_box` AS select `db_search`.`search_type` AS `搜索類型` from `db_search` group by `db_search`.`search_type` ;

-- ----------------------------
-- View structure for v_word
-- ----------------------------
DROP VIEW IF EXISTS `v_word`;
CREATE ALGORITHM=UNDEFINED DEFINER=`shoper`@`%` SQL SECURITY DEFINER VIEW `v_word` AS select `db_word`.`key` AS `關鍵字`,`db_word`.`word` AS `詞`,`db_word`.`num` AS `出現次數`,`db_word`.`sold` AS `近期銷售額`,`db_word`.`history_sold` AS `總銷售額`,`db_word`.`view_count` AS `瀏覽數`,`db_word`.`create_time` AS `時間` from `db_word` ;

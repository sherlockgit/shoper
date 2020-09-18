/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.112_3306
Source Server Version : 50645
Source Host           : 192.168.1.112:3306
Source Database       : gbm_shop

Target Server Type    : MYSQL
Target Server Version : 50645
File Encoding         : 65001

Date: 2020-09-18 20:11:39
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB AUTO_INCREMENT=752 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for db_search
-- ----------------------------
DROP TABLE IF EXISTS `db_search`;
CREATE TABLE `db_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_id` int(11) DEFAULT NULL COMMENT '关键字id',
  `key` varchar(255) DEFAULT NULL,
  `order_type` int(11) DEFAULT NULL COMMENT '排序方式：1 低到高 2. 高到低',
  `search_type` int(11) DEFAULT NULL COMMENT '查询方式：1 综合排名；2 最新；3：最热销；4：价格',
  `total_count` int(11) DEFAULT NULL COMMENT '总条数',
  `total_ads_count` int(11) DEFAULT NULL COMMENT '广告条数',
  `ori_totalCount` int(11) DEFAULT NULL COMMENT '排除广告条数',
  `suggestion_algorithm` int(11) DEFAULT NULL COMMENT '建议算法？？',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

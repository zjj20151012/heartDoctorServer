/*
 Navicat Premium Data Transfer

 Source Server         : heartDoctor
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost
 Source Database       : heartDoctor

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : utf-8

 Date: 07/03/2017 09:46:10 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `user_regist`
-- ----------------------------
DROP TABLE IF EXISTS `user_regist`;
CREATE TABLE `user_regist` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_regist`
-- ----------------------------
BEGIN;
INSERT INTO `user_regist` VALUES ('1', 'zjj'), ('2', 'tl');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

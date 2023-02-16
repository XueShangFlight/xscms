/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Schema         : dev_hhcms_test

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 16/02/2023 17:51:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xs_admin
-- ----------------------------
DROP TABLE IF EXISTS `xs_admin`;
CREATE TABLE `xs_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` int(10) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_admin
-- ----------------------------
INSERT INTO `xs_admin` VALUES (1, 'xsadmin', 'XSAdmin', '0f195d1782120f225325b8836a0b70aa', '4RqJiI', '/uploads/default/avatar_admin.png', '1206324968@qq.com', 0, 1676539654, '127.0.0.1', 1491635035, 1676539654, '75a07bc2-77e9-4d54-b7aa-bcdd40580ec9', 'normal');

-- ----------------------------
-- Table structure for xs_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `xs_admin_log`;
CREATE TABLE `xs_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_admin_log
-- ----------------------------
INSERT INTO `xs_admin_log` VALUES (1, 1, 'xsadmin', '/xsadmin.php/files/hhtpl', '', '{\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', 1676540404);
INSERT INTO `xs_admin_log` VALUES (2, 1, 'xsadmin', '/xsadmin.php/files/hhtpl', '', '{\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', 1676540917);
INSERT INTO `xs_admin_log` VALUES (3, 1, 'xsadmin', '/xsadmin.php/files/hhtpl', '', '{\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', 1676540924);
INSERT INTO `xs_admin_log` VALUES (4, 1, 'xsadmin', '/xsadmin.php/files/hhtpl', '', '{\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', 1676540953);

-- ----------------------------
-- Table structure for xs_advdata
-- ----------------------------
DROP TABLE IF EXISTS `xs_advdata`;
CREATE TABLE `xs_advdata`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片路径',
  `imagewidth` int(4) NOT NULL DEFAULT 0 COMMENT '广告宽度',
  `imageheight` int(4) NOT NULL DEFAULT 0 COMMENT '广告高度',
  `color` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '#fff' COMMENT '颜色',
  `advtype_id` int(10) NULL DEFAULT 0 COMMENT '广告分类',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `linkurl` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '###' COMMENT '链接地址',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `opentype` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'navigate' COMMENT '小程序跳转方式',
  `hit` int(4) NULL DEFAULT 0 COMMENT '点击率',
  `weigh` int(10) NOT NULL DEFAULT 1 COMMENT '排序',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_advdata
-- ----------------------------
INSERT INTO `xs_advdata` VALUES (1, '首页轮播1', '/uploads/editor/file/20220315/2b8f99a0a2087813eda90e0e391e4ff4.jpg', 0, 0, '#fff', 1, 1, '###', '', 'navigate', 0, 2, 1646294807, 1676539866, NULL);

-- ----------------------------
-- Table structure for xs_advtype
-- ----------------------------
DROP TABLE IF EXISTS `xs_advtype`;
CREATE TABLE `xs_advtype`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `domain` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性域名',
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片',
  `weigh` int(5) NULL DEFAULT 1 COMMENT '排序',
  `switch` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新日期',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_advtype
-- ----------------------------
INSERT INTO `xs_advtype` VALUES (1, 1, '', '首页轮播广告', '', 1, 1, 1646294103, 1646294103, NULL);

-- ----------------------------
-- Table structure for xs_article
-- ----------------------------
DROP TABLE IF EXISTS `xs_article`;
CREATE TABLE `xs_article`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标签',
  `istop` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `ishot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否热门',
  `arctype_id` int(4) NOT NULL DEFAULT 0 COMMENT '文章分类',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标题',
  `ftitle` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '副标题',
  `intro` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '简介',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'seo标题',
  `keyword` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关键词',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '描述',
  `linkurl` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '跳转链接',
  `source` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '来源',
  `author` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '作者',
  `image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '缩略图',
  `file` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '下载文件',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `weigh` int(5) NOT NULL DEFAULT 1 COMMENT '排序',
  `hit` int(4) NOT NULL DEFAULT 0 COMMENT '点击率',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新日期',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `arctype_id`(`arctype_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_arttype
-- ----------------------------
DROP TABLE IF EXISTS `xs_arttype`;
CREATE TABLE `xs_arttype`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `domain` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性域名',
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片',
  `weigh` smallint(1) NULL DEFAULT 1 COMMENT '排序',
  `switch` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新日期',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_arttype
-- ----------------------------
INSERT INTO `xs_arttype` VALUES (1, 1, '', '公司新闻', '', 1, 1, 1646217763, 1646217763, NULL);
INSERT INTO `xs_arttype` VALUES (2, 2, '', '小程序案例', '', 2, 1, 1646288869, 1646289547, NULL);

-- ----------------------------
-- Table structure for xs_attachment
-- ----------------------------
DROP TABLE IF EXISTS `xs_attachment`;
CREATE TABLE `xs_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` int(10) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_attachment
-- ----------------------------
INSERT INTO `xs_attachment` VALUES (1, '', 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `xs_attachment` VALUES (2, '', 1, 0, '/uploads/20220228/4673c552d18f64c937b319a022d0da7d.png', '750', '450', 'png', 0, 'homeBg.png', 673733, 'image/png', '', 1646031547, 1646031547, 1646031547, 'local', 'e7c59c83b490a09981ab46b06b77314c961e8af4');
INSERT INTO `xs_attachment` VALUES (3, '', 1, 0, '/uploads/20220302/f8394f088524272186804cfbf07aab59.jpg', '132', '132', 'jpg', 0, 'avatar.jpg', 4341, 'image/jpeg', '', 1646213856, 1646213856, 1646213856, 'local', '901e875d1a8a0c825549a462f347fd7f232a9dc5');
INSERT INTO `xs_attachment` VALUES (4, '', 1, 0, '/uploads/20220303/b29bf7b1d9906177e90eeb1bccc2cfcb.jpg', '800', '800', 'jpg', 0, 'apple2.jpg', 64234, 'image/jpeg', '', 1646280173, 1646280173, 1646280173, 'local', '3815608fbf7db7bb9a8d8f0f02c94997af615421');
INSERT INTO `xs_attachment` VALUES (5, '', 1, 0, '/uploads/20220303/1613f2bf8ff8fa1ceae9ea7888a91bbb.jpg', '800', '800', 'jpg', 0, 'apple1.jpg', 57445, 'image/jpeg', '', 1646280180, 1646280180, 1646280180, 'local', '920055096532a70ecd0393bad97a66c2158eb554');
INSERT INTO `xs_attachment` VALUES (6, '', 1, 0, '/uploads/20220303/a5745441332a26ceb9da40ba31bc4031.png', '64', '64', 'png', 0, 'ico2.png', 2606, 'image/png', '', 1646298232, 1646298232, 1646298232, 'local', 'cfaeae824a3bcf98ea6c342b7dba953bd809d7f3');
INSERT INTO `xs_attachment` VALUES (7, '', 1, 0, '/uploads/editor/image/20220315/a16fd77017c64ecd50585f3b49c3dc87.png', '677', '555', 'png', 0, 'cms.png', 204242, 'image/png', '', 1647313501, 1647313501, 1647313501, 'local', 'e777b8fd5c2b24ce48b44edb27b0131b51e08c68');
INSERT INTO `xs_attachment` VALUES (8, '', 1, 0, '/uploads/editor/media/20220315/e54a631fb80e38238e06192020ba96f0.mp4', '', '', 'mp4', 0, 'test.mp4', 3936050, 'video/mp4', '', 1647313942, 1647313942, 1647313942, 'local', '1b036522981f0f20dcf12924c62297df6350f4ca');
INSERT INTO `xs_attachment` VALUES (9, '', 1, 0, '/uploads/editor/file/20220315/2b8f99a0a2087813eda90e0e391e4ff4.jpg', '960', '960', 'jpg', 0, 'avatar2.jpg', 62381, 'image/jpeg', '', 1647314943, 1647314943, 1647314943, 'local', 'e02dc9bf2fdccb68f0fdee7405206a73a05eca2b');
INSERT INTO `xs_attachment` VALUES (10, '', 1, 0, '/uploads/20220315/f8394f088524272186804cfbf07aab59.jpg', '132', '132', 'jpg', 0, 'avatar.jpg', 4341, 'image/jpeg', '', 1647333081, 1647333081, 1647333081, 'local', '901e875d1a8a0c825549a462f347fd7f232a9dc5');

-- ----------------------------
-- Table structure for xs_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `xs_auth_group`;
CREATE TABLE `xs_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则ID',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_auth_group
-- ----------------------------
INSERT INTO `xs_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `xs_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `xs_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `xs_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `xs_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for xs_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `xs_auth_group_access`;
CREATE TABLE `xs_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '权限分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_auth_group_access
-- ----------------------------
INSERT INTO `xs_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for xs_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `xs_auth_rule`;
CREATE TABLE `xs_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '节点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_auth_rule
-- ----------------------------
INSERT INTO `xs_auth_rule` VALUES (92, 'file', 0, 'addon', '插件管理', 'fa fa-cubes', '', '', '可在线安装、卸载、禁用、启用、配置、升级插件，插件升级前请做好备份。', 1, 'addtabs', '', 'cjgl', 'chajianguanli', 1645784546, 1646214085, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (93, 'file', 92, 'addon/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (94, 'file', 92, 'addon/config', '配置', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'pz', 'peizhi', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (95, 'file', 92, 'addon/install', '安装', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'az', 'anzhuang', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (96, 'file', 92, 'addon/uninstall', '卸载', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xz', 'xiezai', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (97, 'file', 92, 'addon/state', '禁用启用', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'jyqy', 'jinyongqiyong', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (98, 'file', 92, 'addon/local', '本地上传', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bdsc', 'bendishangchuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (99, 'file', 92, 'addon/upgrade', '更新插件', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'gxcj', 'gengxinchajian', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (100, 'file', 92, 'addon/downloaded', '已装插件', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'yzcj', 'yizhuangchajian', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (101, 'file', 92, 'addon/get_table_list', '获取插件相关表', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hqcjxgb', 'huoquchajianxiangguanbiao', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (102, 'file', 92, 'addon/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (103, 'file', 92, 'addon/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (104, 'file', 92, 'addon/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (105, 'file', 92, 'addon/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (106, 'file', 289, 'advdata', '广告列表', 'fa fa-chain-broken', '', '', '', 1, 'addtabs', '', 'gglb', 'guanggaoliebiao', 1645784546, 1645786425, 1, 'normal');
INSERT INTO `xs_auth_rule` VALUES (107, 'file', 106, 'advdata/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (108, 'file', 106, 'advdata/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (109, 'file', 106, 'advdata/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (110, 'file', 106, 'advdata/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (111, 'file', 106, 'advdata/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (112, 'file', 106, 'advdata/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (113, 'file', 106, 'advdata/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (114, 'file', 106, 'advdata/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (115, 'file', 106, 'advdata/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (116, 'file', 289, 'advtype', '广告分类', 'fa fa-yelp', '', '', '', 1, 'addtabs', '', 'ggfl', 'guanggaofenlei', 1645784546, 1645786409, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (117, 'file', 116, 'advtype/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (118, 'file', 116, 'advtype/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (119, 'file', 116, 'advtype/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (120, 'file', 116, 'advtype/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (121, 'file', 116, 'advtype/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (122, 'file', 116, 'advtype/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (123, 'file', 116, 'advtype/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (124, 'file', 116, 'advtype/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (125, 'file', 116, 'advtype/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (126, 'file', 290, 'article/type/1', '新闻列表', 'fa fa-bookmark-o', 'article/index?type=1', '', '', 1, 'addtabs', '', 'xwlb', 'xinwenliebiao', 1645784546, 1646014972, 1, 'normal');
INSERT INTO `xs_auth_rule` VALUES (127, 'file', 126, 'article/import/type/1', '导入', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'dr', 'daoru', 1645784546, 1646017228, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (128, 'file', 126, 'article/index/type/1', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (129, 'file', 126, 'article/recyclebin/type/1', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (130, 'file', 126, 'article/add/type/1', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (131, 'file', 126, 'article/edit/type/1', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (132, 'file', 126, 'article/del/type/1', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (133, 'file', 126, 'article/destroy/type/1', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (134, 'file', 126, 'article/restore/type/1', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (135, 'file', 126, 'article/multi/type/1', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (136, 'file', 290, 'arttype/type/1', '新闻类目', 'fa fa-hourglass-o', 'arttype/index?type=1', '', '', 1, 'addtabs', '', 'xwlm', 'xinwenleimu', 1645784546, 1646014988, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (137, 'file', 136, 'arttype/import/type/1', '导入', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'dr', 'daoru', 1645784546, 1646017145, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (138, 'file', 136, 'arttype/index/type/1', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1646016788, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (139, 'file', 136, 'arttype/recyclebin/type/1', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (140, 'file', 136, 'arttype/add/type/1', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (141, 'file', 136, 'arttype/edit/type/1', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (142, 'file', 136, 'arttype/del/type/1', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (143, 'file', 136, 'arttype/destroy/type/1', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (144, 'file', 136, 'arttype/restore/type/1', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (145, 'file', 136, 'arttype/multi/type/1', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (146, 'file', 0, 'category', '分类管理', '  fa fa-list', '', '', '用于管理网站的所有分类,分类可进行无限级分类,分类类型请在常规管理->系统配置->字典配置中添加', 1, NULL, '', 'flgl', 'fenleiguanli', 1645784546, 1646021124, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (147, 'file', 146, 'category/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (148, 'file', 146, 'category/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (149, 'file', 146, 'category/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (150, 'file', 146, 'category/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (151, 'file', 146, 'category/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (152, 'file', 0, 'command', '在线命令管理', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'zxmlgl', 'zaixianminglingguanli', 1645784546, 1646021125, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (153, 'file', 152, 'command/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (154, 'file', 152, 'command/detail', '详情', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xq', 'xiangqing', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (155, 'file', 152, 'command/execute', '执行', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zx', 'zhixing', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (156, 'file', 152, 'command/command', '执行命令', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zxml', 'zhixingmingling', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (157, 'file', 152, 'command/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (158, 'file', 152, 'command/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (159, 'file', 152, 'command/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (160, 'file', 152, 'command/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (161, 'file', 0, 'dashboard', '控制台', '  fa fa-dashboard', '', '', '用于展示当前系统中的统计数据、统计报表及重要实时数据', 1, 'addtabs', '', 'kzt', 'kongzhitai', 1645784546, 1645786653, 100, 'normal');
INSERT INTO `xs_auth_rule` VALUES (162, 'file', 161, 'dashboard/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (163, 'file', 161, 'dashboard/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (164, 'file', 161, 'dashboard/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (165, 'file', 161, 'dashboard/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (166, 'file', 161, 'dashboard/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (167, 'file', 291, 'links', '友情链接', 'fa fa-chain', '', '', '', 1, 'addtabs', '', 'yqlj', 'youqinglianjie', 1645784546, 1645785731, 9, 'normal');
INSERT INTO `xs_auth_rule` VALUES (168, 'file', 167, 'links/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (169, 'file', 167, 'links/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (170, 'file', 167, 'links/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (171, 'file', 167, 'links/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (172, 'file', 167, 'links/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (173, 'file', 167, 'links/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (174, 'file', 167, 'links/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (175, 'file', 167, 'links/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (176, 'file', 167, 'links/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784546, 1645784546, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (177, 'file', 291, 'message', '留言记录', 'fa fa-paper-plane-o', '', '', '', 1, 'addtabs', '', 'lyjl', 'liuyanjilu', 1645784547, 1645785753, 8, 'normal');
INSERT INTO `xs_auth_rule` VALUES (178, 'file', 177, 'message/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (179, 'file', 177, 'message/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (180, 'file', 177, 'message/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (181, 'file', 177, 'message/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (182, 'file', 177, 'message/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (183, 'file', 177, 'message/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (184, 'file', 291, 'pages', '单页管理', 'fa fa-file-text-o', '', '', '', 1, 'addtabs', '', 'dygl', 'danyeguanli', 1645784547, 1645785679, 10, 'normal');
INSERT INTO `xs_auth_rule` VALUES (185, 'file', 184, 'pages/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (186, 'file', 184, 'pages/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (187, 'file', 184, 'pages/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (188, 'file', 184, 'pages/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (189, 'file', 184, 'pages/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (190, 'file', 184, 'pages/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (191, 'file', 184, 'pages/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (192, 'file', 184, 'pages/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (193, 'file', 184, 'pages/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (194, 'file', 292, 'product', '产品列表', 'fa fa-cube', '', '', '', 1, 'addtabs', '', 'cplb', 'chanpinliebiao', 1645784547, 1646214056, 1, 'normal');
INSERT INTO `xs_auth_rule` VALUES (195, 'file', 194, 'product/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (196, 'file', 194, 'product/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (197, 'file', 194, 'product/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (198, 'file', 194, 'product/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (199, 'file', 194, 'product/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (200, 'file', 194, 'product/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (201, 'file', 194, 'product/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (202, 'file', 194, 'product/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (203, 'file', 194, 'product/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (204, 'file', 292, 'protype', '产品分类', 'fa fa-flag-o', '', '', '', 1, 'addtabs', '', 'cpfl', 'chanpinfenlei', 1645784547, 1645786008, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (205, 'file', 204, 'protype/import', 'Import', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (206, 'file', 204, 'protype/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (207, 'file', 204, 'protype/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (208, 'file', 204, 'protype/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (209, 'file', 204, 'protype/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (210, 'file', 204, 'protype/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (211, 'file', 204, 'protype/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (212, 'file', 204, 'protype/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (213, 'file', 204, 'protype/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (224, 'file', 0, 'auth', '权限管理', 'fa fa-black-tie', '', '', '', 1, 'addtabs', '', 'qxgl', 'quanxianguanli', 1645784547, 1646015129, 30, 'normal');
INSERT INTO `xs_auth_rule` VALUES (225, 'file', 224, 'auth/admin', '管理员管理', 'fa fa-address-book-o', '', '', '一个管理员可以有多个角色组,左侧的菜单根据管理员所拥有的权限进行生成', 1, 'addtabs', '', 'glygl', 'guanliyuanguanli', 1645784547, 1645786484, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (226, 'file', 225, 'auth/admin/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (227, 'file', 225, 'auth/admin/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (228, 'file', 225, 'auth/admin/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (229, 'file', 225, 'auth/admin/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (230, 'file', 225, 'auth/admin/selectpage', '下拉搜索', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xlss', 'xialasousuo', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (231, 'file', 224, 'auth/adminlog', '管理员日志', 'fa fa-address-card-o', '', '', '管理员可以查看自己所拥有的权限的管理员日志', 1, 'addtabs', '', 'glyrz', 'guanliyuanrizhi', 1645784547, 1645786496, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (232, 'file', 231, 'auth/adminlog/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (233, 'file', 231, 'auth/adminlog/detail', '详情', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xq', 'xiangqing', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (234, 'file', 231, 'auth/adminlog/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (235, 'file', 231, 'auth/adminlog/selectpage', 'Selectpage', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Selectpage', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (236, 'file', 224, 'auth/group', '角色组', 'fa fa-user-o', '', '', '角色组可以有多个,角色有上下级层级关系,如果子角色有角色组和管理员的权限则可以派生属于自己组别下级的角色组或管理员', 1, 'addtabs', '', 'jsz', 'juesezu', 1645784547, 1645786526, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (237, 'file', 236, 'auth/group/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (238, 'file', 236, 'auth/group/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (239, 'file', 236, 'auth/group/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (240, 'file', 236, 'auth/group/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (241, 'file', 224, 'auth/rule', '规则管理', 'fa fa-bars', '', '', '规则通常对应一个控制器的方法,同时左侧的菜单栏数据也从规则中体现,通常建议通过控制台进行生成规则节点', 1, 'addtabs', '', 'gzgl', 'guizeguanli', 1645784547, 1646015156, 10, 'normal');
INSERT INTO `xs_auth_rule` VALUES (242, 'file', 241, 'auth/rule/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (243, 'file', 241, 'auth/rule/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (244, 'file', 241, 'auth/rule/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (245, 'file', 241, 'auth/rule/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (246, 'file', 241, 'auth/rule/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (247, 'file', 0, 'general', '系统设置', 'fa fa-certificate', '', '', '', 1, 'addtabs', '', 'xtsz', 'xitongshezhi', 1645784547, 1646015140, 20, 'normal');
INSERT INTO `xs_auth_rule` VALUES (248, 'file', 247, 'general/attachment', '附件管理', 'fa fa-file-pdf-o', '', '', '主要用于管理上传到服务器或第三方存储的数据', 1, 'addtabs', '', 'fjgl', 'fujianguanli', 1645784547, 1645786622, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (249, 'file', 248, 'general/attachment/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (250, 'file', 248, 'general/attachment/select', '选择附件', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xzfj', 'xuanzefujian', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (251, 'file', 248, 'general/attachment/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (252, 'file', 248, 'general/attachment/del', '删除附件', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'scfj', 'shanchufujian', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (253, 'file', 248, 'general/attachment/classify', '归类', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'gl', 'guilei', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (254, 'file', 248, 'general/attachment/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (255, 'file', 248, 'general/attachment/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (256, 'file', 247, 'general/config', '系统配置', '  fa fa-cogs', '', '', '可以在此增改系统的变量和分组,也可以自定义分组和变量,如果需要删除请从数据库中删除', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (257, 'file', 256, 'general/config/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (258, 'file', 256, 'general/config/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (259, 'file', 256, 'general/config/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (260, 'file', 256, 'general/config/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (261, 'file', 256, 'general/config/selectpage', 'Selectpage', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Selectpage', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (262, 'file', 256, 'general/config/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (263, 'file', 247, 'general/profile', '个人配置', 'fa fa-user', '', '', '', 1, NULL, '', 'grpz', 'gerenpeizhi', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (264, 'file', 263, 'general/profile/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (265, 'file', 263, 'general/profile/update', '更新个人信息', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'gxgrxx', 'gengxingerenxinxi', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (266, 'file', 263, 'general/profile/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (267, 'file', 263, 'general/profile/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (268, 'file', 263, 'general/profile/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (269, 'file', 263, 'general/profile/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (270, 'file', 0, 'user', '会员管理', 'fa fa-user', '', '', '', 1, 'addtabs', '', 'hygl', 'huiyuanguanli', 1645784547, 1646015116, 40, 'normal');
INSERT INTO `xs_auth_rule` VALUES (271, 'file', 270, 'user/group', '会员组管理', 'fa fa-users', '', '', '', 1, NULL, '', 'hyzgl', 'huiyuanzuguanli', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (272, 'file', 271, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (273, 'file', 271, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (274, 'file', 271, 'user/group/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (275, 'file', 271, 'user/group/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (276, 'file', 271, 'user/group/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (277, 'file', 270, 'user/rule', '会员规则管理', 'fa fa-bullseye', '', '', '', 0, 'addtabs', '', 'hygzgl', 'huiyuanguizeguanli', 1645784547, 1647483271, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (278, 'file', 277, 'user/rule/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (279, 'file', 277, 'user/rule/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (280, 'file', 277, 'user/rule/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (281, 'file', 277, 'user/rule/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (282, 'file', 277, 'user/rule/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (283, 'file', 270, 'user/user', '会员管理', 'fa fa-user-o', '', '', '', 1, 'addtabs', '', 'hygl', 'huiyuanguanli', 1645784547, 1645785406, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (284, 'file', 283, 'user/user/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (285, 'file', 283, 'user/user/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (286, 'file', 283, 'user/user/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (287, 'file', 283, 'user/user/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (288, 'file', 283, 'user/user/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1645784547, 1645784547, 0, 'normal');
INSERT INTO `xs_auth_rule` VALUES (289, 'file', 0, 'adv', '广告管理', 'fa fa-fa', '', '', '', 1, 'addtabs', '', 'gggl', 'guanggaoguanli', 1645784934, 1646015105, 50, 'normal');
INSERT INTO `xs_auth_rule` VALUES (290, 'file', 0, 'news', '新闻管理', 'fa fa-bell', '', '', '', 1, 'addtabs', '', 'xwgl', 'xinwenguanli', 1645785166, 1646033709, 80, 'normal');
INSERT INTO `xs_auth_rule` VALUES (291, 'file', 0, 'website', '网站管理', 'fa fa-map', '', '', '', 1, 'addtabs', '', 'wzgl', 'wangzhanguanli', 1645785611, 1646013965, 90, 'normal');
INSERT INTO `xs_auth_rule` VALUES (292, 'file', 0, 'products', '产品管理', 'fa fa-shopping-bag', '', '', '', 1, 'addtabs', '', 'cpgl', 'chanpinguanli', 1645785881, 1646015067, 60, 'normal');
INSERT INTO `xs_auth_rule` VALUES (293, 'file', 0, 'cases', '案例管理', 'fa fa-gratipay', '', '', '', 1, 'addtabs', '', 'algl', 'anliguanli', 1646014056, 1646014056, 70, 'normal');
INSERT INTO `xs_auth_rule` VALUES (294, 'file', 293, 'arttype/type/2', '案例类目', 'fa fa-hdd-o', 'arttype/index?type=2', '', '', 1, 'addtabs', '', 'allm', 'anlileimu', 1646014876, 1646014876, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (295, 'file', 293, 'article/type/2', '案例列表', 'fa fa-list-alt', 'article/index?type=2', '', '', 1, 'addtabs', '', 'allb', 'anliliebiao', 1646014958, 1646014958, 1, 'normal');
INSERT INTO `xs_auth_rule` VALUES (296, 'file', 294, 'arttype/import/type/2', '导入', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'dr', 'daoru', 1646017393, 1646017674, 9, 'normal');
INSERT INTO `xs_auth_rule` VALUES (297, 'file', 294, 'arttype/index/type/2', '查看', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'zk', 'zhakan', 1645784546, 1646016788, 8, 'normal');
INSERT INTO `xs_auth_rule` VALUES (298, 'file', 294, 'arttype/recyclebin/type/2', '回收站', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'hsz', 'huishouzhan', 1646017798, 1646017844, 7, 'normal');
INSERT INTO `xs_auth_rule` VALUES (299, 'file', 294, 'arttype/add/type/2', '添加', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'tj', 'tianjia', 1646017837, 1646017868, 6, 'normal');
INSERT INTO `xs_auth_rule` VALUES (300, 'file', 294, 'arttype/edit/type/2', '编辑', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'bj', 'bianji', 1646017902, 1646018045, 5, 'normal');
INSERT INTO `xs_auth_rule` VALUES (301, 'file', 294, 'arttype/del/type/2', '删除', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'sc', 'shanchu', 1646017938, 1646018048, 4, 'normal');
INSERT INTO `xs_auth_rule` VALUES (302, 'file', 294, 'arttype/destroy/type/2', '真实删除', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'zssc', 'zhenshishanchu', 1646017977, 1646018046, 3, 'normal');
INSERT INTO `xs_auth_rule` VALUES (303, 'file', 294, 'arttype/restore/type/2', '还原', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'hy', 'huanyuan', 1646018002, 1646018049, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (304, 'file', 294, 'arttype/multi/type/2', '批量更新', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'plgx', 'pilianggengxin', 1646018026, 1646018050, 1, 'normal');
INSERT INTO `xs_auth_rule` VALUES (305, 'file', 295, 'article/import/type/2', '导入', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'dr', 'daoru', 1646018123, 1646018248, 9, 'normal');
INSERT INTO `xs_auth_rule` VALUES (306, 'file', 295, 'article/index/type/2', '查看', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'zk', 'zhakan', 1645784546, 1646016788, 8, 'normal');
INSERT INTO `xs_auth_rule` VALUES (307, 'file', 295, 'article/recyclebin/type/2', '回收站', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'hsz', 'huishouzhan', 1646017798, 1646017844, 7, 'normal');
INSERT INTO `xs_auth_rule` VALUES (308, 'file', 295, 'article/add/type/2', '添加', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'tj', 'tianjia', 1646017837, 1646017868, 6, 'normal');
INSERT INTO `xs_auth_rule` VALUES (309, 'file', 295, 'article/edit/type/2', '编辑', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'bj', 'bianji', 1646017902, 1646018045, 5, 'normal');
INSERT INTO `xs_auth_rule` VALUES (310, 'file', 295, 'article/del/type/2', '删除', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'sc', 'shanchu', 1646017938, 1646018048, 4, 'normal');
INSERT INTO `xs_auth_rule` VALUES (311, 'file', 295, 'article/destroy/type/2', '真实删除', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'zssc', 'zhenshishanchu', 1646017977, 1646018046, 3, 'normal');
INSERT INTO `xs_auth_rule` VALUES (312, 'file', 295, 'article/restore/type/2', '还原', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'hy', 'huanyuan', 1646018002, 1646018049, 2, 'normal');
INSERT INTO `xs_auth_rule` VALUES (313, 'file', 295, 'article/multi/type/2', '批量更新', 'fa fa-circle-o', '', '', '', 0, 'addtabs', '', 'plgx', 'pilianggengxin', 1646018026, 1646018050, 1, 'normal');

-- ----------------------------
-- Table structure for xs_category
-- ----------------------------
DROP TABLE IF EXISTS `xs_category`;
CREATE TABLE `xs_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_category
-- ----------------------------
INSERT INTO `xs_category` VALUES (1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1491635035, 1491635035, 1, 'normal');
INSERT INTO `xs_category` VALUES (2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1491635035, 1491635035, 2, 'normal');
INSERT INTO `xs_category` VALUES (3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1491635035, 1491635035, 3, 'normal');
INSERT INTO `xs_category` VALUES (4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1491635035, 1491635035, 4, 'normal');
INSERT INTO `xs_category` VALUES (5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1491635035, 1491635035, 5, 'normal');
INSERT INTO `xs_category` VALUES (6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1491635035, 1491635035, 6, 'normal');
INSERT INTO `xs_category` VALUES (7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1491635035, 1491635035, 7, 'normal');
INSERT INTO `xs_category` VALUES (8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1491635035, 1491635035, 8, 'normal');
INSERT INTO `xs_category` VALUES (9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1491635035, 1491635035, 9, 'normal');
INSERT INTO `xs_category` VALUES (10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1491635035, 1491635035, 10, 'normal');
INSERT INTO `xs_category` VALUES (11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1491635035, 1491635035, 11, 'normal');
INSERT INTO `xs_category` VALUES (12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1491635035, 1491635035, 12, 'normal');
INSERT INTO `xs_category` VALUES (13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1491635035, 1491635035, 13, 'normal');

-- ----------------------------
-- Table structure for xs_command
-- ----------------------------
DROP TABLE IF EXISTS `xs_command`;
CREATE TABLE `xs_command`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '命令',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回结果',
  `executetime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '执行时间',
  `createtime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('successed','failured') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线命令表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_command
-- ----------------------------
INSERT INTO `xs_command` VALUES (1, 'crud', '[\"--table=xs_advtype\"]', 'php think crud --table=xs_advtype', 'Build Successed', 1645784250, 1645784250, 1645784250, 'successed');
INSERT INTO `xs_command` VALUES (2, 'crud', '[\"--table=xs_advdata\",\"--relation=xs_advtype\",\"--relationmode=belongsto\",\"--relationforeignkey=advtype_id\",\"--relationprimarykey=id\",\"--relationfields=name\"]', 'php think crud --table=xs_advdata --relation=xs_advtype --relationmode=belongsto --relationforeignkey=advtype_id --relationprimarykey=id --relationfields=name', 'Build Successed', 1645784317, 1645784317, 1645784317, 'successed');
INSERT INTO `xs_command` VALUES (3, 'crud', '[\"--table=xs_arttype\"]', 'php think crud --table=xs_arttype', 'Build Successed', 1645784340, 1645784340, 1645784340, 'successed');
INSERT INTO `xs_command` VALUES (4, 'crud', '[\"--table=xs_article\",\"--relation=xs_arttype\",\"--relationmode=belongsto\",\"--relationforeignkey=arctype_id\",\"--relationprimarykey=id\",\"--relationfields=name\"]', 'php think crud --table=xs_article --relation=xs_arttype --relationmode=belongsto --relationforeignkey=arctype_id --relationprimarykey=id --relationfields=name', 'Build Successed', 1645784366, 1645784367, 1645784367, 'successed');
INSERT INTO `xs_command` VALUES (5, 'crud', '[\"--table=xs_protype\"]', 'php think crud --table=xs_protype', 'Build Successed', 1645784417, 1645784417, 1645784417, 'successed');
INSERT INTO `xs_command` VALUES (6, 'crud', '[\"--table=xs_product\",\"--relation=xs_protype\",\"--relationmode=belongsto\",\"--relationforeignkey=protype_id\",\"--relationprimarykey=id\",\"--relationfields=name\"]', 'php think crud --table=xs_product --relation=xs_protype --relationmode=belongsto --relationforeignkey=protype_id --relationprimarykey=id --relationfields=name', 'Build Successed', 1645784457, 1645784457, 1645784457, 'successed');
INSERT INTO `xs_command` VALUES (7, 'crud', '[\"--table=xs_pages\"]', 'php think crud --table=xs_pages', 'Build Successed', 1645784479, 1645784479, 1645784479, 'successed');
INSERT INTO `xs_command` VALUES (8, 'crud', '[\"--table=xs_links\"]', 'php think crud --table=xs_links', 'Build Successed', 1645784500, 1645784500, 1645784500, 'successed');
INSERT INTO `xs_command` VALUES (9, 'crud', '[\"--table=xs_message\"]', 'php think crud --table=xs_message', 'Build Successed', 1645784505, 1645784505, 1645784505, 'successed');
INSERT INTO `xs_command` VALUES (10, 'crud', '[\"--table=xs_title\"]', 'php think crud --table=xs_title', 'Build Successed', 1645784520, 1645784520, 1645784520, 'successed');
INSERT INTO `xs_command` VALUES (11, 'menu', '[\"--controller=all-controller\"]', 'php think menu --controller=all-controller', 'Build Successed!', 1645784546, 1645784546, 1645784547, 'successed');

-- ----------------------------
-- Table structure for xs_config
-- ----------------------------
DROP TABLE IF EXISTS `xs_config`;
CREATE TABLE `xs_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_config
-- ----------------------------
INSERT INTO `xs_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '雪殇CMS系统', '', 'required', '', NULL);
INSERT INTO `xs_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.17', '', 'required', '', NULL);
INSERT INTO `xs_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '', NULL);
INSERT INTO `xs_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', NULL);
INSERT INTO `xs_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', '', NULL);
INSERT INTO `xs_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"默认\",\"page\":\"单页\",\"article\":\"文章\",\"test\":\"Test\"}', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"基础配置\",\"company\":\"公司配置\",\"oss\":\"阿里OSS配置\",\"email\":\"邮件配置\",\"dictionary\":\"字典配置\",\"user\":\"会员配置\"}', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `xs_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '', '');
INSERT INTO `xs_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '', '');
INSERT INTO `xs_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '', '');
INSERT INTO `xs_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'string', 'password', '', '', '', '');
INSERT INTO `xs_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `xs_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '', '');
INSERT INTO `xs_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '{\"category1\":\"分类一\",\"category2\":\"分类二\",\"custom\":\"自定义\"}', '', '', '', NULL);
INSERT INTO `xs_config` VALUES (20, 'company_name', 'company', '公司名称', '公司名称', 'string', '雪殇CMS', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (21, 'company_address', 'company', '公司地址', '请输入公司地址', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (22, 'company_wburl', 'company', '微博链接', '微博链接', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (24, 'company_tel', 'company', '电话', '请输入电话', 'string', '', '', 'tel', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (25, 'company_phone', 'company', '手机', '手机', 'string', '', '', 'mobile', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (26, 'company_email', 'company', '邮箱', '邮箱', 'string', '', '', 'email', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (27, 'company_qq', 'company', 'QQ', 'QQ', 'string', '', '', 'qq', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (28, 'company_wximage', 'company', '微信二维码', '微信二维码，建议大小：180*180px,等比例亦可', 'image', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (29, 'company_xcximage', 'company', '小程序二维码', '小程序二维码，建议大小：180*180px,等比例亦可', 'image', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (30, 'keywords', 'basic', '站点关键词', '站点关键词', 'text', '雪殇CMS系统站点关键词', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (31, 'description', 'basic', '站点描述', '站点描述信息', 'text', '雪殇CMS系统站点描述', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (32, 'sys_code', 'basic', '可放代码', '您可以把第三方的代码放在这里，例如：百度统计代码', 'text', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (33, 'AccessKeyId', 'oss', 'AccessKeyId', 'AccessKeyId', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (34, 'AccessKeySecret', 'oss', 'AccessKeySecret', 'AccessKeySecret', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (35, 'endpoint', 'oss', '上传节点', '上传节点', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (36, 'Bucket', 'oss', '存储空间名称', '存储空间名称，没有就自动创建', 'string', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (37, 'switch', 'oss', '是否启用', '', 'switch', '0', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `xs_config` VALUES (38, 'isdel', 'oss', '删除本地存储', '注：打开表示上传至阿里云存储后自动删除本地备份文件', 'switch', '0', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');

-- ----------------------------
-- Table structure for xs_district
-- ----------------------------
DROP TABLE IF EXISTS `xs_district`;
CREATE TABLE `xs_district`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级 0 1 2 省市区县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_ems
-- ----------------------------
DROP TABLE IF EXISTS `xs_ems`;
CREATE TABLE `xs_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮箱验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_links
-- ----------------------------
DROP TABLE IF EXISTS `xs_links`;
CREATE TABLE `xs_links`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片',
  `linkurl` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '###' COMMENT '跳转链接',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `weigh` int(5) NULL DEFAULT 1 COMMENT '排序',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '友情链接表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_links
-- ----------------------------
INSERT INTO `xs_links` VALUES (1, 1, '北京大学', '', '###', 1, 1, 1646290304, 1646290304, NULL);

-- ----------------------------
-- Table structure for xs_message
-- ----------------------------
DROP TABLE IF EXISTS `xs_message`;
CREATE TABLE `xs_message`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT 0 COMMENT '用户id',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `tname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '在线反馈' COMMENT '类目名称',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `address` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系地址',
  `images` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '反馈图集',
  `msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '留言信息',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否处理:0=待处理,1=已处理',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布时间',
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0.0.0.0' COMMENT 'IP',
  `remsg` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '回复内容',
  `retime` int(10) NULL DEFAULT NULL COMMENT '回复时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '留言记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_pages
-- ----------------------------
DROP TABLE IF EXISTS `xs_pages`;
CREATE TABLE `xs_pages`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `ftitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '副标题',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性域名',
  `image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '简介',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `linkurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'seo标题',
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '关键词',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `weigh` int(5) NOT NULL DEFAULT 1 COMMENT '排序',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单页表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_pages
-- ----------------------------
INSERT INTO `xs_pages` VALUES (1, 1, '关于我们', '', '', '/uploads/20220303/a5745441332a26ceb9da40ba31bc4031.png', '关于我们 简介', '<p>\r\n	关于我们 内容\r\n</p>', '', '', '', '', 1, 1, 1646031597, 1655971482, NULL);

-- ----------------------------
-- Table structure for xs_product
-- ----------------------------
DROP TABLE IF EXISTS `xs_product`;
CREATE TABLE `xs_product`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标签',
  `istop` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `ishot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否热门',
  `protype_id` int(10) NOT NULL DEFAULT 0 COMMENT '所属分类',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `intro` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '简介',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'seo标题',
  `keyword` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '关键词',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `linkurl` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '跳转链接',
  `image` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `images` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '产品组图',
  `file` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '下载文件',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `switch` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `weigh` int(5) NOT NULL DEFAULT 1 COMMENT '排序',
  `hit` int(4) NOT NULL DEFAULT 0 COMMENT '点击率',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `protype_id`(`protype_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_product
-- ----------------------------
INSERT INTO `xs_product` VALUES (1, '', 0, 0, 19, '富士山超大红苹果', '富士山超大红苹果，又甜又脆，可口怡人！', '', '', '', '', '/uploads/20220303/b29bf7b1d9906177e90eeb1bccc2cfcb.jpg', '/uploads/20220303/1613f2bf8ff8fa1ceae9ea7888a91bbb.jpg,/uploads/20220303/b29bf7b1d9906177e90eeb1bccc2cfcb.jpg', '', '<p>富士山超大红苹果，又甜又脆，可口怡人！</p><p>富士山超大红苹果，又甜又脆，可口怡人！</p><p>富士山超大红苹果，又甜又脆，可口怡人！<br></p>', 1, 1, 0, 1646280191, 1646288697, NULL);
INSERT INTO `xs_product` VALUES (2, '', 0, 0, 18, '精品果切', '精品果切简介', '', '', '', '', '', '', '', '<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/7f25892b02fb188.jpg\" style=\"vertical-align:middle;\" alt=\"7f25892b02fb188.jpg\" /> \r\n<p>\r\n	《英雄联盟手游》即将在3.1版本“艾欧尼亚守护者”中迎来元素崛起，在元素峡谷模式中，三种不同的元素亚龙与远古巨龙将出没于召唤师峡谷！迫不及待想要体验全新的元素峡谷？隆哥今天就给大家带来了关于元素峡谷的详细介绍，赶紧来一睹为快吧~\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<span style=\"letter-spacing:1.8px;\">为了给玩家提供更好的游戏体验，让每一条亚龙都赋予玩家足够的力量，我们决定暂时不将云端亚龙加入本次测试，并将在后续持续探索优化亚龙的增益效果以及改进元素峡谷整体体验，让我们拭目以待！关于</span><span style=\"letter-spacing:1.8px;\">炼狱、山脉、海洋亚龙等相关改动如下：</span> \r\n</p>\r\n<p style=\"text-align:center;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>元素亚龙刷新机制</strong> \r\n</p>\r\n<p>\r\n	<strong>01</strong> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	在每局比赛进行到五分钟时，元素亚龙将随机刷新，在上一条亚龙被击杀后五分钟，新亚龙将再次出现，<span style=\"color:#5F9CEF;\"><strong>前两条元素亚龙必然不同</strong></span>。\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	当第二条元素亚龙被击杀，<span style=\"color:#5F9CEF;\"><strong>召唤师</strong></span><span style=\"color:#5F9CEF;\"><strong>峡谷地形将根据第三条元素亚龙的种类进行改变</strong></span>，且之后刷新的每一条元素亚龙都与第三条相同。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/a20e8f0a8542143.jpg\" style=\"vertical-align:middle;\" alt=\"a20e8f0a8542143.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"letter-spacing:1.8px;\">当</span><span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>某一支队伍击杀三条元素亚龙</strong></span><span style=\"letter-spacing:1.8px;\">后，便可获得与当前元素地形所对应的</span><span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>元素龙魂</strong></span><span style=\"letter-spacing:1.8px;\">。</span> \r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>元素亚龙全新BUFF</strong> \r\n</p>\r\n<p>\r\n	<strong>02</strong> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	元素峡谷模式下，元素亚龙拥有了全新BUFF效果！\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>炼狱亚龙</strong></span><span style=\"letter-spacing:1.8px;\">BUFF将为英雄提供4%额外的攻击力与法术强度。获得</span><span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>炼狱亚龙龙魂</strong></span><span style=\"letter-spacing:1.8px;\">后，英雄的普攻与伤害性技能将在目标处制造小范围爆炸，并造成可观的自适应伤害，该效果有三秒冷却时间。</span> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<strong><span style=\"color:#5F9CEF;letter-spacing:1.8px;\">山脉亚龙</span></strong><span style=\"letter-spacing:1.8px;color:#000000;\">BUFF</span><span style=\"letter-spacing:1.8px;\">将为英雄提供6%的护甲与魔法抗性。获得<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>山脉亚龙龙魂</strong></span>后，英雄将在没有受到伤害的五秒后获得一个强力护盾效果。</span> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"color:#5F9CEF;\"><strong>海洋亚龙</strong></span><span style=\"letter-spacing:1.8px;\">BUFF则将每五秒为英雄回复2.5%的已损生命值，获得<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>海洋亚龙龙魂</strong></span>后，对敌方造成的伤害能在四秒内为英雄回复额外生命值。</span> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<strong>元素峡谷地形改变</strong> \r\n<p>\r\n	<strong>03</strong> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	元素峡谷中最大的地形改变，也将与三种元素亚龙对应。\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"color:#5F9CEF;\"><strong>炼狱峡谷地形</strong></span>对应炼狱亚龙，野区中苍蓝雕文魔像与绯红印记树怪周围的<span style=\"color:#5F9CEF;\"><strong>部分墙体将被摧毁</strong></span>，同时<span style=\"color:#5F9CEF;\"><strong>爆炸果实也将有所增加</strong></span>。炼狱峡谷地形变化可以让英雄更为便捷的穿越野区，提高打野支援效率。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/2327c0848e8c00a.jpg\" style=\"vertical-align:middle;\" alt=\"2327c0848e8c00a.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"color:#5F9CEF;\"><strong>山脉峡谷</strong></span><span style=\"color:#5F9CEF;\"><strong>地形</strong></span>对应山脉亚龙，平地而起的<span style=\"color:#5F9CEF;\"><strong>全新墙体</strong></span>将让野区与亚龙区域地形更加复杂，增加了英雄穿越野区的风险。\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	同时变相缩紧的战斗区域也将让遭遇战更为激烈，而那些如薇恩等拥有可借助墙体打出额外技能效果的英雄，在山脉峡谷地形中将获得更大的操作空间。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/80000fecbfd042a.jpg\" style=\"vertical-align:middle;width:563px;height:304px;\" alt=\"80000fecbfd042a.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	<span style=\"color:#5F9CEF;\"><strong>海洋峡谷地形</strong></span>对应海洋亚龙，全新的草丛将破土而出，<span style=\"color:#5F9CEF;\"><strong>部分现有草丛</strong></span>也将野蛮生长，<strong><span style=\"color:#5F9CEF;\">扩大面积</span></strong>。此外，草丛中摇曳的花朵将让海洋峡谷更加生机勃勃，不过这些草丛也将为狩猎者提供可乘之机，英雄独自进入野区的风险将大大提高。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/b852ef45f1297d1.jpg\" style=\"vertical-align:middle;width:563px;height:304px;\" alt=\"b852ef45f1297d1.jpg\" /> \r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>远古巨龙刷新及BUFF</strong> \r\n</p>\r\n<p>\r\n	<strong>04</strong> \r\n</p>\r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	除了三种元素亚龙外，元素峡谷模式中将出现强大的<span style=\"color:#3E3E3E;\">远古巨龙</span>，普通模式中的远古元素巨龙将被取代，<span style=\"color:#5F9CEF;\"><strong>在对阵一方获得龙魂后</strong></span>，元素亚龙将不再出现，<span style=\"color:#5F9CEF;\"><strong>五分钟后远古巨龙将在亚龙坑出生</strong></span>。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/8438be8cfee3b13.jpg\" style=\"vertical-align:middle;\" alt=\"8438be8cfee3b13.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	每次远古巨龙击杀都将在五分钟后重生，直至对局结束。<span style=\"color:#5F9CEF;\"><strong>击杀远古巨龙</strong></span>的一方将得到一个强大的<span style=\"color:#5F9CEF;\"><strong>增益BUFF</strong></span>，该BUFF可以使英雄攻击敌人时，对其额外造成一个持续<span style=\"color:#5F9CEF;\"><strong>三秒</strong></span>，<span style=\"color:#5F9CEF;\"><strong>每秒造成60点真实伤害的效果</strong></span>，并且当<span style=\"color:#5F9CEF;\"><strong>敌方英雄生命值低于20%</strong></span>时，拥有远古巨龙buff一方将对其“<span style=\"color:#5F9CEF;\"><strong>一击必杀</strong></span>”。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/6e326d624d2ec5a.jpg\" style=\"vertical-align:middle;\" alt=\"6e326d624d2ec5a.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	远古巨龙BUFF可<span style=\"color:#5F9CEF;\"><strong>持续三分钟</strong></span>，并在英雄死亡后消失。在元素峡谷模式下，无论元素龙魂亦或远古巨龙BUFF，其强大的效果势必让亚龙坑成为游戏全期的战略必争要地，战术博弈与团队碰撞将为游戏带来全新的打法和节奏。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/fdc55227974e23f.jpg\" style=\"vertical-align:middle;width:563px;height:304px;\" alt=\"fdc55227974e23f.jpg\" /> \r\n<p style=\"text-align:justify;white-space:normal;\">\r\n	值得注意的是，元素峡谷模式中的<span style=\"color:#5F9CEF;\"><strong>积分面板也会做出优化调整</strong></span>，在面板上方会显示双方队伍获取的元素亚龙数量与种类，并显示变更后的地形元素属性，更为直观的帮助召唤师判断局势，做出下一步决策。\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/0757d9af37689a5.jpg\" style=\"vertical-align:middle;\" alt=\"0757d9af37689a5.jpg\" /> \r\n<p>\r\n	以上便是英雄联盟手游元素峡谷模式介绍。我们会根据这次限时测试收集大家的反馈进行调整规划！隆哥也将持续为大家带来有关3.1版本“艾欧尼亚守护者”的最新消息~\r\n</p>\r\n<p>\r\n	<strong>申请体验服资格 抢鲜体验新内容</strong> \r\n</p>\r\n<p>\r\n	<span style=\"letter-spacing:1.8px;\">体验服3.1版本“艾欧尼亚守护者”今日已更新上线！<span style=\"color:#3E3E3E;letter-spacing:1.8px;\">想要抢先体验元素峡谷的召唤师，赶快来获取体验服资格吧！</span>本次<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>体验服招募数量提升</strong></span>，欢迎各位召唤师踊跃报名参与~扫码前往<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>掌上英雄联盟</strong></span>-<span style=\"letter-spacing:1.8px;color:#5F9CEF;\"><strong>英雄联盟手游体验服</strong></span></span><span style=\"letter-spacing:1.8px;color:#000000;\">专题</span><span style=\"letter-spacing:1.8px;color:#000000;\">页</span><span style=\"letter-spacing:1.8px;\">面，了解更多信息：</span> \r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/c9eb0ab17e4a59b.jpg\" style=\"vertical-align:middle;\" alt=\"c9eb0ab17e4a59b.jpg\" /> \r\n<p>\r\n	<strong>龙魂商店更新 </strong> \r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	龙魂商店上新啦！<span style=\"color:#5F9CEF;\"><strong>3月18日00:00-4月18日23:59</strong></span>，<span style=\"color:#5F9CEF;\"><strong>暴风女神 迦娜</strong></span>（商城皮肤）限时上架龙魂商店~\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/af389c92e39910f.jpg\" style=\"vertical-align:middle;\" alt=\"af389c92e39910f.jpg\" /> \r\n<p style=\"white-space:normal;\">\r\n	同时还有“<span style=\"color:#5F9CEF;\"><strong>可爱风暴</strong></span>”、“<span style=\"color:#5F9CEF;\"><strong>求你了好不好</strong></span>？”表情、“<span style=\"color:#5F9CEF;\"><strong>冰火之歌</strong></span>”回城特效、“<strong><span style=\"color:#5F9CEF;\">胜利头像框</span></strong>”长期加入道具兑换，召唤师们是不是已经心动了呢?\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/7ded66d78d750ee.jpg\" style=\"vertical-align:middle;\" alt=\"7ded66d78d750ee.jpg\" /> \r\n<p>\r\n	<strong>WRL1早知道</strong> \r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	《英雄联盟手游》职业联赛全新突破，12支战队将争夺首个冠军荣耀！隆哥也给大家带来了本次WRL1的详细赛制规则，究竟哪支战队能获得第一个WRL1冠军呢？让我们一起期待<span style=\"color:#0080FF;\"><strong>3月19日17:00</strong></span>正式开赛吧！\r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<br />\r\n</p>\r\n<p style=\"white-space:normal;\">\r\n	<br />\r\n</p>\r\n<img class=\"rich_pages wxw-img\" src=\"/uploads/editor/image/20220317/47f05e85d83794d.jpg\" style=\"vertical-align:middle;\" alt=\"47f05e85d83794d.jpg\" /> \r\n<p>\r\n	点击“<span style=\"color:#FF8124;\"><strong>阅读原文</strong></span>”\r\n</p>\r\n<p>\r\n	新版本内容抢先看\r\n</p>', 1, 1, 0, 1647510099, 1647510118, NULL);

-- ----------------------------
-- Table structure for xs_protype
-- ----------------------------
DROP TABLE IF EXISTS `xs_protype`;
CREATE TABLE `xs_protype`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(4) NOT NULL DEFAULT 0 COMMENT '父级id',
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片',
  `weigh` int(5) NULL DEFAULT 1 COMMENT '排序',
  `switch` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新日期',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_protype
-- ----------------------------
INSERT INTO `xs_protype` VALUES (1, 0, '蔬菜豆制品', '', 1, 1, 1646212970, 1646213450, NULL);
INSERT INTO `xs_protype` VALUES (2, 0, '肉蛋水产', '', 1, 1, 1646213435, 1646213573, NULL);
INSERT INTO `xs_protype` VALUES (3, 0, '时令水果', '', 1, 1, 1646213465, 1646213465, NULL);
INSERT INTO `xs_protype` VALUES (4, 0, '粮油调味', '', 1, 1, 1646213480, 1646213480, NULL);
INSERT INTO `xs_protype` VALUES (5, 0, '冰冻冷藏', '', 1, 1, 1646213493, 1646213493, NULL);
INSERT INTO `xs_protype` VALUES (6, 0, '酒水乳饮', '', 1, 1, 1646213509, 1646213509, NULL);
INSERT INTO `xs_protype` VALUES (7, 0, '休闲零食', '/uploads/20220302/f8394f088524272186804cfbf07aab59.jpg', 1, 1, 1646213519, 1646213857, NULL);
INSERT INTO `xs_protype` VALUES (8, 0, '个护清洁', '', 1, 1, 1646213529, 1646213529, NULL);
INSERT INTO `xs_protype` VALUES (9, 1, '根茎类', '', 1, 1, 1646213631, 1646213631, NULL);
INSERT INTO `xs_protype` VALUES (10, 1, '叶菜类', '', 1, 1, 1646213644, 1646213656, NULL);
INSERT INTO `xs_protype` VALUES (11, 1, '菌菇类', '', 1, 1, 1646213665, 1646213665, NULL);
INSERT INTO `xs_protype` VALUES (12, 1, '芽苗类', '', 1, 1, 1646213689, 1646213689, NULL);
INSERT INTO `xs_protype` VALUES (13, 1, '豆制品', '', 1, 1, 1646213704, 1646213767, NULL);
INSERT INTO `xs_protype` VALUES (14, 1, '葱姜蒜椒', '', 1, 1, 1646213737, 1646213761, NULL);
INSERT INTO `xs_protype` VALUES (15, 1, '净菜', '', 1, 1, 1646213755, 1646213755, NULL);
INSERT INTO `xs_protype` VALUES (16, 3, '浆果', '', 1, 1, 1646213792, 1646213792, NULL);
INSERT INTO `xs_protype` VALUES (17, 3, '热带水果', '', 1, 1, 1646213805, 1646213805, NULL);
INSERT INTO `xs_protype` VALUES (18, 3, '果切', '', 1, 1, 1646213818, 1646213818, NULL);
INSERT INTO `xs_protype` VALUES (19, 16, '苹果', '', 1, 1, 1646281111, 1646281111, NULL);

-- ----------------------------
-- Table structure for xs_sms
-- ----------------------------
DROP TABLE IF EXISTS `xs_sms`;
CREATE TABLE `xs_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_test
-- ----------------------------
DROP TABLE IF EXISTS `xs_test`;
CREATE TABLE `xs_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '省市',
  `json` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime(0) NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time(0) NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) NULL DEFAULT NULL COMMENT '刷新时间(int)',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '测试表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_test
-- ----------------------------
INSERT INTO `xs_test` VALUES (1, 0, 12, '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', '{\"a\":\"1\",\"b\":\"2\"}', 0.00, 0, '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for xs_title
-- ----------------------------
DROP TABLE IF EXISTS `xs_title`;
CREATE TABLE `xs_title`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tables` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '关联表',
  `tid` int(4) NOT NULL DEFAULT 0 COMMENT '关联表ID',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `keyword` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '页面关键词',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '页面描述',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '发布日期',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新日期',
  `deletetime` int(10) NULL DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tables`(`tables`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'SEO表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_user
-- ----------------------------
DROP TABLE IF EXISTS `xs_user`;
CREATE TABLE `xs_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '积分',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` int(10) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` int(10) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_user
-- ----------------------------
INSERT INTO `xs_user` VALUES (1, 1, 'admin', 'admin', '4f40b48fe15681f712c4c7ef2c5279dc', 'JGI4DR', 'admin@163.com', '13888888888', '', 0, 0, '2017-04-08', '', 0.00, 0, 1, 1, 1646982747, 1646982791, '127.0.0.1', 0, '127.0.0.1', 1491635035, 0, 1646982791, '', 'normal', '');

-- ----------------------------
-- Table structure for xs_user_group
-- ----------------------------
DROP TABLE IF EXISTS `xs_user_group`;
CREATE TABLE `xs_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '权限节点',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_user_group
-- ----------------------------
INSERT INTO `xs_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for xs_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `xs_user_money_log`;
CREATE TABLE `xs_user_money_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更余额',
  `before` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更前余额',
  `after` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员余额变动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `xs_user_rule`;
CREATE TABLE `xs_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xs_user_rule
-- ----------------------------
INSERT INTO `xs_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `xs_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `xs_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1491635035, 1646987125, 12, 'normal');
INSERT INTO `xs_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `xs_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `xs_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `xs_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `xs_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `xs_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `xs_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `xs_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `xs_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');

-- ----------------------------
-- Table structure for xs_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `xs_user_score_log`;
CREATE TABLE `xs_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员积分变动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_user_token
-- ----------------------------
DROP TABLE IF EXISTS `xs_user_token`;
CREATE TABLE `xs_user_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `expiretime` int(10) NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员Token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xs_version
-- ----------------------------
DROP TABLE IF EXISTS `xs_version`;
CREATE TABLE `xs_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '版本表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

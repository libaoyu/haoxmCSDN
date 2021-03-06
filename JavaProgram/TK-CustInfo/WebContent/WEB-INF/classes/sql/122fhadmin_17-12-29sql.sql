﻿/*
Navicat MySQL Data Transfer

Source Server         : 118.190.78.122
Source Server Version : 50631
Source Host           : 118.190.78.122:3306
Source Database       : fhadmin_

Target Server Type    : MYSQL
Target Server Version : 50631
File Encoding         : 65001

Date: 2017-12-29 11:31:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `clicks`
-- ----------------------------
DROP TABLE IF EXISTS `clicks`;
CREATE TABLE `clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clickNumber` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `updatetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clicks
-- ----------------------------

-- ----------------------------
-- Table structure for `db_fhdb`
-- ----------------------------
DROP TABLE IF EXISTS `db_fhdb`;
CREATE TABLE `db_fhdb` (
  `FHDB_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `BACKUP_TIME` varchar(32) DEFAULT NULL COMMENT '备份时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `SQLPATH` varchar(300) DEFAULT NULL COMMENT '存储位置',
  `TYPE` int(1) NOT NULL COMMENT '类型',
  `DBSIZE` varchar(10) DEFAULT NULL COMMENT '文件大小',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHDB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_fhdb
-- ----------------------------
INSERT INTO `db_fhdb` VALUES ('26da360588a3440a9f9b23b339c20f93', 'admin', '2017-04-10 03:43:59', 'sys_app_user', 'e:/mysql_backup/20170410/sys_app_user_20170410034359.sql', '2', '2.921', 'admin备份单表');

-- ----------------------------
-- Table structure for `db_timingbackup`
-- ----------------------------
DROP TABLE IF EXISTS `db_timingbackup`;
CREATE TABLE `db_timingbackup` (
  `TIMINGBACKUP_ID` varchar(100) NOT NULL,
  `JOBNAME` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `CREATE_TIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `STATUS` int(1) NOT NULL COMMENT '类型',
  `FHTIME` varchar(30) DEFAULT NULL COMMENT '时间规则',
  `TIMEEXPLAIN` varchar(100) DEFAULT NULL COMMENT '规则说明',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TIMINGBACKUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_timingbackup
-- ----------------------------
INSERT INTO `db_timingbackup` VALUES ('c7d2f6b901294ebb971e6c4cc4fc9c76', 'all_225979', '2017-04-10 03:42:20', 'all', '2', '3/3 * * * * ?', '每个月的 每周 每天 每小时执行一次', 'sddd');

-- ----------------------------
-- Table structure for `oa_datajur`
-- ----------------------------
DROP TABLE IF EXISTS `oa_datajur`;
CREATE TABLE `oa_datajur` (
  `DATAJUR_ID` varchar(100) NOT NULL,
  `DEPARTMENT_IDS` varchar(5000) DEFAULT NULL COMMENT '部门ID组合',
  `STAFF_ID` varchar(100) DEFAULT NULL COMMENT '员工ID',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DATAJUR_ID`),
  KEY `FSTAFF` (`STAFF_ID`) USING BTREE,
  CONSTRAINT `oa_datajur_ibfk_1` FOREIGN KEY (`STAFF_ID`) REFERENCES `oa_staff` (`STAFF_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_datajur
-- ----------------------------
INSERT INTO `oa_datajur` VALUES ('9fd17463ffd7487ab90e683c76026655', '(\'d41af567914a409893d011aa53eda797\',\'3e7227e11dc14b4d9e863dd1a1fcedf6\',\'0956d8c279274fca92f4091f2a69a9ad\',\'fh\')', '9fd17463ffd7487ab90e683c76026655', 'a6c6695217ba4a4dbfe9f7e9d2c06730');

-- ----------------------------
-- Table structure for `oa_department`
-- ----------------------------
DROP TABLE IF EXISTS `oa_department`;
CREATE TABLE `oa_department` (
  `DEPARTMENT_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `HEADMAN` varchar(30) DEFAULT NULL COMMENT '负责人',
  `TEL` varchar(50) DEFAULT NULL COMMENT '电话',
  `FUNCTIONS` varchar(255) DEFAULT NULL COMMENT '部门职能',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '地址',
  `PATH` varchar(255) DEFAULT NULL COMMENT '上级机构代码路径',
  `LEVE` varchar(100) DEFAULT NULL COMMENT '等级',
  PRIMARY KEY (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_department
-- ----------------------------

-- ----------------------------
-- Table structure for `oa_fhfile`
-- ----------------------------
DROP TABLE IF EXISTS `oa_fhfile`;
CREATE TABLE `oa_fhfile` (
  `FHFILE_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '文件名',
  `FILEPATH` varchar(100) DEFAULT NULL COMMENT '路径',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '上传时间',
  `BZ` varchar(100) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '长传者',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL COMMENT '部门ID',
  `FILESIZE` varchar(10) DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`FHFILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_fhfile
-- ----------------------------

-- ----------------------------
-- Table structure for `oa_staff`
-- ----------------------------
DROP TABLE IF EXISTS `oa_staff`;
CREATE TABLE `oa_staff` (
  `STAFF_ID` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(100) DEFAULT NULL COMMENT '编码',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL COMMENT '部门',
  `FUNCTIONS` varchar(255) DEFAULT NULL COMMENT '职责',
  `TEL` varchar(20) DEFAULT NULL COMMENT '电话',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `SEX` varchar(10) DEFAULT NULL COMMENT '性别',
  `BIRTHDAY` varchar(32) DEFAULT NULL COMMENT '出生日期',
  `NATION` varchar(10) DEFAULT NULL COMMENT '民族',
  `JOBTYPE` varchar(30) DEFAULT NULL COMMENT '岗位类别',
  `JOBJOINTIME` varchar(32) DEFAULT NULL COMMENT '参加工作时间',
  `FADDRESS` varchar(100) DEFAULT NULL COMMENT '籍贯',
  `POLITICAL` varchar(30) DEFAULT NULL COMMENT '政治面貌',
  `PJOINTIME` varchar(32) DEFAULT NULL COMMENT '入团时间',
  `SFID` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `MARITAL` varchar(10) DEFAULT NULL COMMENT '婚姻状况',
  `DJOINTIME` varchar(32) DEFAULT NULL COMMENT '进本单位时间',
  `POST` varchar(30) DEFAULT NULL COMMENT '现岗位',
  `POJOINTIME` varchar(32) DEFAULT NULL COMMENT '上岗时间',
  `EDUCATION` varchar(10) DEFAULT NULL COMMENT '学历',
  `SCHOOL` varchar(30) DEFAULT NULL COMMENT '毕业学校',
  `MAJOR` varchar(30) DEFAULT NULL COMMENT '专业',
  `FTITLE` varchar(30) DEFAULT NULL COMMENT '职称',
  `CERTIFICATE` varchar(30) DEFAULT NULL COMMENT '职业资格证',
  `CONTRACTLENGTH` int(2) NOT NULL COMMENT '劳动合同时长',
  `CSTARTTIME` varchar(32) DEFAULT NULL COMMENT '签订日期',
  `CENDTIME` varchar(32) DEFAULT NULL COMMENT '终止日期',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '现住址',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '绑定账号ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`STAFF_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_staff
-- ----------------------------
INSERT INTO `oa_staff` VALUES ('9fd17463ffd7487ab90e683c76026655', 'www', 'www', 'ww', 'd76e0d11a48f47feae0319249e2ee4fd', 'ww', 'ww', 'www', '男', '2016-04-27', 'ww', 'ww', '2016-05-03', 'ww', 'ww', '2016-04-25', 'ww', '未婚', '2016-05-09', 'ww', '2016-05-17', 'w', 'w', 'w', 'w', 'www', '2', '2016-05-23', '2016-05-16', 'w', 'w5', 'www');

-- ----------------------------
-- Table structure for `section_record`
-- ----------------------------
DROP TABLE IF EXISTS `section_record`;
CREATE TABLE `section_record` (
  `RECORD_ID` varchar(100) NOT NULL DEFAULT '',
  `STR_INDEX` varchar(100) NOT NULL COMMENT '唯一标识',
  `VISIT_TYPE` varchar(100) DEFAULT NULL COMMENT '门诊类型(门诊或住院)',
  `VISIT_DATE` timestamp NULL DEFAULT NULL COMMENT '诊疗时间',
  `PATIENT_ID` varchar(100) DEFAULT NULL COMMENT '患者id',
  `PATIENT_NAME` varchar(200) DEFAULT NULL COMMENT '患者姓名',
  `SEX` varchar(20) DEFAULT NULL COMMENT '患者性别',
  `PHONE_NUMBER` varchar(50) DEFAULT NULL COMMENT '患者电话',
  `TIMES` varchar(20) DEFAULT NULL COMMENT '就诊次数',
  `EMP_CODE` varchar(100) DEFAULT NULL COMMENT '医生编号',
  `EMP_NAME` varchar(100) DEFAULT NULL COMMENT '医生姓名',
  `SECTION_CODE` varchar(100) DEFAULT NULL COMMENT '科室编号',
  `SECTION_NAME` varchar(100) DEFAULT NULL COMMENT '科室名',
  `LEVEL` int(20) DEFAULT NULL COMMENT '评价星数',
  `COMMON_EVAL` varchar(100) DEFAULT NULL COMMENT '常规评价项',
  `EVALUATE` varchar(2000) DEFAULT NULL COMMENT '评价详情',
  `CREATE_USER` varchar(200) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(200) DEFAULT NULL COMMENT '修改人',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `BATCH_NUM` varchar(100) DEFAULT NULL COMMENT '批次号',
  `DOCTORTYPE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of section_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_app_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_user`;
CREATE TABLE `sys_app_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_app_user
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_codeeditor`
-- ----------------------------
DROP TABLE IF EXISTS `sys_codeeditor`;
CREATE TABLE `sys_codeeditor` (
  `CODEEDITOR_ID` varchar(100) NOT NULL,
  `TYPE` varchar(30) DEFAULT NULL COMMENT '类型',
  `FTLNMAME` varchar(30) DEFAULT NULL COMMENT '文件名',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `CODECONTENT` text COMMENT '代码',
  PRIMARY KEY (`CODEEDITOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_codeeditor
-- ----------------------------
INSERT INTO `sys_codeeditor` VALUES ('a449439b29bc40c4b84fa5cc1e31537c', 'createCode', 'mysql_SQL_Template', '2017-06-12 17:55:05', 'SET FOREIGN_KEY_CHECKS=0;\n\n-- ----------------------------\n-- Table structure for `${tabletop}${objectNameUpper}`\n-- ----------------------------\nDROP TABLE IF EXISTS `${tabletop}${objectNameUpper}`;\nCREATE TABLE `${tabletop}${objectNameUpper}` (\n 		`${objectNameUpper}_ID` varchar(100) NOT NULL,\n	<#list fieldList as var>\n		<#if var[1] == \'Integer\'>\n		`${var[0]}` int(${var[5]}) NOT NULL COMMENT \'${var[2]}\',\n		<#elseif var[1] == \'Double\'>\n		`${var[0]}` double(${var[5]},${var[6]}) DEFAULT NULL COMMENT \'${var[2]}\',\n		<#else>\n		`${var[0]}` varchar(${var[5]}) DEFAULT NULL COMMENT \'${var[2]}\',\n		</#if>\n	</#list>\n  		PRIMARY KEY (`${objectNameUpper}_ID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8;\n');

-- ----------------------------
-- Table structure for `sys_createcode`
-- ----------------------------
DROP TABLE IF EXISTS `sys_createcode`;
CREATE TABLE `sys_createcode` (
  `CREATECODE_ID` varchar(100) NOT NULL,
  `PACKAGENAME` varchar(50) DEFAULT NULL COMMENT '包名',
  `OBJECTNAME` varchar(50) DEFAULT NULL COMMENT '类名',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `FIELDLIST` varchar(5000) DEFAULT NULL COMMENT '属性集',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '描述',
  `FHTYPE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CREATECODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_createcode
-- ----------------------------
INSERT INTO `sys_createcode` VALUES ('002ea762e3e242a7a10ea5ca633701d8', 'system', 'Buttonrights', 'sys_,fh,BUTTONRIGHTS', 'NAME,fh,String,fh,名称,fh,是,fh,无,fh,255Q313596790', '2016-01-16 23:20:36', '按钮权限', 'single');
INSERT INTO `sys_createcode` VALUES ('043843a286f84549ad3fa71aac827f6f', 'system', 'FHlog', 'SYS_,fh,FHLOG', 'USERNAME,fh,String,fh,用户名,fh,是,fh,无,fh,100,fh,0Q313596790CZTIME,fh,Date,fh,操作时间,fh,否,fh,无,fh,32,fh,0Q313596790CONTENT,fh,String,fh,事件,fh,是,fh,无,fh,255,fh,0Q313596790', '2016-05-10 21:10:16', '操作日志记录', 'single');
INSERT INTO `sys_createcode` VALUES ('0ee023606efb45b9a3baaa072e502161', 'information', 'FtestMx', 'FH_,fh,FTESTMX', 'TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255,fh,0Q313596790CHANGDU,fh,Integer,fh,长度,fh,是,fh,无,fh,11,fh,0Q313596790', '2016-04-21 01:52:11', '主表测试(明细)', 'sontable');
INSERT INTO `sys_createcode` VALUES ('1be959583e82473b82f6e62087bd0d38', 'information', 'Attached', 'TB_,fh,ATTACHED', 'NAME,fh,String,fh,NAME,fh,是,fh,无,fh,255,fh,0Q313596790FDESCRIBE,fh,String,fh,FDESCRIBE,fh,是,fh,无,fh,255,fh,0Q313596790PRICE,fh,Double,fh,PRICE,fh,是,fh,无,fh,11,fh,2Q313596790CTIME,fh,Date,fh,CTIME,fh,否,fh,无,fh,32,fh,0Q313596790', '2016-04-21 17:07:59', '主表测试', 'fathertable');
INSERT INTO `sys_createcode` VALUES ('3da8e8bd757c44148d89931a54d29c88', 'system', 'UserPhoto', 'SYS_,fh,USERPHOTO', 'USERNAME,fh,String,fh,用户名,fh,否,fh,无,fh,30,fh,0Q313596790PHOTO0,fh,String,fh,原图,fh,否,fh,无,fh,100,fh,0Q313596790PHOTO1,fh,String,fh,头像1,fh,否,fh,无,fh,100,fh,0Q313596790PHOTO2,fh,String,fh,头像2,fh,否,fh,无,fh,100,fh,0Q313596790PHOTO3,fh,String,fh,头像3,fh,否,fh,无,fh,100,fh,0Q313596790', '2016-06-05 17:54:25', '用户头像', 'single');
INSERT INTO `sys_createcode` VALUES ('4173a8c56a504dd6b6213d2b9cd3e91b', 'information', 'AttachedMx', 'TB_,fh,ATTACHEDMX', 'NAME,fh,String,fh,NAME,fh,是,fh,无,fh,255,fh,0Q313596790TITLE,fh,String,fh,TITLE,fh,是,fh,无,fh,255,fh,0Q313596790CTIME,fh,Date,fh,CTIME,fh,否,fh,无,fh,32,fh,0Q313596790PRICE,fh,Double,fh,PRICE,fh,是,fh,无,fh,11,fh,2Q313596790', '2016-04-21 17:09:40', '主表测试(明细)', 'sontable');
INSERT INTO `sys_createcode` VALUES ('41e07fb03763434daef41cd99d0406c3', 'system', 'LogInImg', 'SYS_,fh,LOGINIMG', 'NAME,fh,String,fh,文件名,fh,是,fh,无,fh,30,fh,0Q313596790FILEPATH,fh,String,fh,路径,fh,是,fh,无,fh,100,fh,0Q313596790TYPE,fh,Integer,fh,状态,fh,是,fh,无,fh,2,fh,0Q313596790FORDER,fh,Integer,fh,排序,fh,是,fh,无,fh,3,fh,0Q313596790', '2016-06-03 17:53:22', '登录页面背景图片', 'single');
INSERT INTO `sys_createcode` VALUES ('49d985e081ed44e6b34ba1b8c5466e39', 'fhdb', 'TimingBackUp', 'DB_,fh,TIMINGBACKUP', 'JOBNAME,fh,String,fh,任务名称,fh,否,fh,无,fh,50Q313596790CREATE_TIME,fh,Date,fh,创建时间,fh,否,fh,无,fh,32Q313596790TABLENAME,fh,String,fh,表名,fh,是,fh,无,fh,50Q313596790TYPE,fh,Integer,fh,类型,fh,否,fh,无,fh,1Q313596790FHTIME,fh,String,fh,时间规则,fh,是,fh,无,fh,30Q313596790TIMEEXPLAIN,fh,String,fh,规则说明,fh,是,fh,无,fh,100Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790', '2016-04-09 11:53:38', '定时备份', 'single');
INSERT INTO `sys_createcode` VALUES ('4def60c58aa148b7998270978660ef30', 'fhoa', 'Fhfile', 'OA_,fh,FHFILE', 'NAME,fh,String,fh,文件名,fh,是,fh,无,fh,30,fh,0Q313596790FILEPATH,fh,String,fh,路径,fh,是,fh,无,fh,100,fh,0Q313596790CTIME,fh,Date,fh,上传时间,fh,否,fh,无,fh,32,fh,0Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,100,fh,0Q313596790USERNAME,fh,String,fh,长传者,fh,否,fh,无,fh,50,fh,0Q313596790DEPARTMENT_ID,fh,String,fh,部门ID,fh,否,fh,无,fh,100,fh,0Q313596790FILESIZE,fh,String,fh,文件大小,fh,否,fh,无,fh,10,fh,0Q313596790', '2016-05-27 20:52:01', '文件管理', 'single');
INSERT INTO `sys_createcode` VALUES ('7899e622cafc40cdb775cf3294133d7d', 'system', 'LogInImg', 'SYS_,fh,LOGINIMG', 'NAME,fh,String,fh,文件名,fh,是,fh,无,fh,30,fh,0Q313596790FILEPATH,fh,String,fh,路径,fh,是,fh,无,fh,100,fh,0Q313596790TYPE,fh,Integer,fh,状态,fh,是,fh,无,fh,2,fh,0Q313596790FORDER,fh,Integer,fh,排序,fh,是,fh,无,fh,3,fh,0Q313596790', '2017-04-10 03:13:05', '登录页面背景图片', 'single');
INSERT INTO `sys_createcode` VALUES ('91af9fe509704fa68f6bca121359e3ec', 'fhoa', 'Staff', 'OA_,fh,STAFF', 'NAME,fh,String,fh,姓名,fh,是,fh,无,fh,50,fh,0Q313596790NAME_EN,fh,String,fh,英文,fh,是,fh,无,fh,50,fh,0Q313596790BIANMA,fh,String,fh,编码,fh,是,fh,无,fh,100,fh,0Q313596790DEPARTMENT_ID,fh,String,fh,部门,fh,是,fh,无,fh,100,fh,0Q313596790FUNCTIONS,fh,String,fh,职责,fh,是,fh,无,fh,255,fh,0Q313596790TEL,fh,String,fh,电话,fh,是,fh,无,fh,20,fh,0Q313596790EMAIL,fh,String,fh,邮箱,fh,是,fh,无,fh,50,fh,0Q313596790SEX,fh,String,fh,性别,fh,是,fh,无,fh,10,fh,0Q313596790BIRTHDAY,fh,Date,fh,出生日期,fh,是,fh,无,fh,32,fh,0Q313596790NATION,fh,String,fh,民族,fh,是,fh,无,fh,10,fh,0Q313596790JOBTYPE,fh,String,fh,岗位类别,fh,是,fh,无,fh,30,fh,0Q313596790JOBJOINTIME,fh,Date,fh,参加工作时间,fh,是,fh,无,fh,32,fh,0Q313596790FADDRESS,fh,String,fh,籍贯,fh,是,fh,无,fh,100,fh,0Q313596790POLITICAL,fh,String,fh,政治面貌,fh,是,fh,无,fh,30,fh,0Q313596790PJOINTIME,fh,Date,fh,入团时间,fh,是,fh,无,fh,32,fh,0Q313596790SFID,fh,String,fh,身份证号,fh,是,fh,无,fh,20,fh,0Q313596790MARITAL,fh,String,fh,婚姻状况,fh,是,fh,无,fh,10,fh,0Q313596790DJOINTIME,fh,Date,fh,进本单位时间,fh,是,fh,无,fh,32,fh,0Q313596790POST,fh,String,fh,现岗位,fh,是,fh,无,fh,30,fh,0Q313596790POJOINTIME,fh,Date,fh,上岗时间,fh,是,fh,无,fh,32,fh,0Q313596790EDUCATION,fh,String,fh,学历,fh,是,fh,无,fh,10,fh,0Q313596790SCHOOL,fh,String,fh,毕业学校,fh,是,fh,无,fh,30,fh,0Q313596790MAJOR,fh,String,fh,专业,fh,是,fh,无,fh,30,fh,0Q313596790FTITLE,fh,String,fh,职称,fh,是,fh,无,fh,30,fh,0Q313596790CERTIFICATE,fh,String,fh,职业资格证,fh,是,fh,无,fh,30,fh,0Q313596790CONTRACTLENGTH,fh,Integer,fh,劳动合同时长,fh,是,fh,无,fh,2,fh,0Q313596790CSTARTTIME,fh,Date,fh,签订日期,fh,是,fh,无,fh,32,fh,0Q313596790CENDTIME,fh,Date,fh,终止日期,fh,是,fh,无,fh,32,fh,0Q313596790ADDRESS,fh,String,fh,现住址,fh,是,fh,无,fh,100,fh,0Q313596790USER_ID,fh,String,fh,绑定账号ID,fh,否,fh,无,fh,100,fh,0Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255,fh,0Q313596790', '2016-04-23 20:44:31', '员工管理', 'single');
INSERT INTO `sys_createcode` VALUES ('ae92803163ff44539e91711cfbe35411', 'fhoa', 'Datajur', 'OA_,fh,DATAJUR', 'DEPARTMENT_IDS,fh,String,fh,部门ID组合,fh,否,fh,无,fh,5000,fh,0Q313596790STAFF_ID,fh,String,fh,员工ID,fh,否,fh,无,fh,100,fh,0Q313596790DEPARTMENT_ID,fh,String,fh,部门ID,fh,是,fh,无,fh,100,fh,0Q313596790', '2016-04-27 03:49:39', '数据权限表', 'single');
INSERT INTO `sys_createcode` VALUES ('bf35ab8b2d064bf7928a04bba5e5a6dd', 'system', 'Fhsms', 'SYS_,fh,FHSMS', 'CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,1000Q313596790TYPE,fh,String,fh,类型,fh,否,fh,无,fh,5Q313596790TO_USERNAME,fh,String,fh,收信人,fh,是,fh,无,fh,255Q313596790FROM_USERNAME,fh,String,fh,发信人,fh,是,fh,无,fh,255Q313596790SEND_TIME,fh,String,fh,发信时间,fh,是,fh,无,fh,100Q313596790STATUS,fh,String,fh,状态,fh,否,fh,无,fh,5Q313596790SANME_ID,fh,String,fh,共同ID,fh,是,fh,无,fh,100Q313596790', '2016-03-27 21:39:45', '站内信', 'single');
INSERT INTO `sys_createcode` VALUES ('c7586f931fd44c61beccd3248774c68c', 'system', 'Department', 'SYS_,fh,DEPARTMENT', 'NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790NAME_EN,fh,String,fh,英文,fh,是,fh,无,fh,50Q313596790BIANMA,fh,String,fh,编码,fh,是,fh,无,fh,50Q313596790PARENT_ID,fh,String,fh,上级ID,fh,否,fh,无,fh,100Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790HEADMAN,fh,String,fh,负责人,fh,是,fh,无,fh,30Q313596790TEL,fh,String,fh,电话,fh,是,fh,无,fh,50Q313596790FUNCTIONS,fh,String,fh,部门职能,fh,是,fh,无,fh,255Q313596790ADDRESS,fh,String,fh,地址,fh,是,fh,无,fh,255Q313596790', '2015-12-20 01:49:25', '组织机构', 'tree');
INSERT INTO `sys_createcode` VALUES ('c937e21208914e5b8fb1202c685bbf2f', 'fhdb', 'Fhdb', 'DB_,fh,FHDB', 'USERNAME,fh,String,fh,操作用户,fh,否,fh,无,fh,50Q313596790BACKUP_TIME,fh,Date,fh,备份时间,fh,否,fh,无,fh,32Q313596790TABLENAME,fh,String,fh,表名,fh,是,fh,无,fh,50Q313596790SQLPATH,fh,String,fh,存储位置,fh,否,fh,无,fh,300Q313596790TYPE,fh,Integer,fh,类型,fh,是,fh,无,fh,1Q313596790DBSIZE,fh,String,fh,文件大小,fh,否,fh,无,fh,10Q313596790BZ,fh,String,fh,备注,fh,否,fh,无,fh,255Q313596790', '2016-03-30 13:46:54', '数据库管理', 'single');
INSERT INTO `sys_createcode` VALUES ('f148276493914b1ba78942d0124d482c', 'system', 'CodeEditor', 'SYS_,fh,CODEEDITOR', 'TYPE,fh,String,fh,类型,fh,是,fh,无,fh,30,fh,0Q313596790FTLNMAME,fh,String,fh,文件名,fh,是,fh,无,fh,30,fh,0Q313596790CTIME,fh,Date,fh,创建时间,fh,否,fh,无,fh,32,fh,0Q313596790CODECONTENT,fh,String,fh,代码,fh,是,fh,无,fh,255,fh,0Q313596790', '2017-06-11 22:35:02', '代码编辑器', 'single');
INSERT INTO `sys_createcode` VALUES ('fe239f8742194481a5b56f90cad71520', 'system', 'Fhbutton', 'SYS_,fh,FHBUTTON', 'NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790QX_NAME,fh,String,fh,权限标识,fh,是,fh,无,fh,50Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790', '2016-01-15 18:38:40', '按钮管理', 'single');
INSERT INTO `sys_createcode` VALUES ('ff6e6cdc87ba42579b033cf4925d4d70', 'dst', 'DataSource2', 'DS_,fh,DATASOURCE2', 'TITLE,fh,String,fh,标题,fh,是,fh,无,fh,100,fh,0Q313596790CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,255,fh,0Q313596790', '2016-05-23 15:51:46', '第2数据源例子', 'single');

-- ----------------------------
-- Table structure for `sys_dictionaries`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionaries`;
CREATE TABLE `sys_dictionaries` (
  `DICTIONARIES_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `ORDER_BY` int(11) NOT NULL COMMENT '排序',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TBSNAME` varchar(100) DEFAULT NULL COMMENT '排查表',
  PRIMARY KEY (`DICTIONARIES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dictionaries
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_fhbutton`
-- ----------------------------
DROP TABLE IF EXISTS `sys_fhbutton`;
CREATE TABLE `sys_fhbutton` (
  `FHBUTTON_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `QX_NAME` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHBUTTON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_fhbutton
-- ----------------------------
INSERT INTO `sys_fhbutton` VALUES ('3542adfbda73410c976e185ffe50ad06', '导出EXCEL', 'toExcel', '导出EXCEL');
INSERT INTO `sys_fhbutton` VALUES ('46992ea280ba4b72b29dedb0d4bc0106', '发邮件', 'email', '发送电子邮件');
INSERT INTO `sys_fhbutton` VALUES ('4c7f34b9eed54683957f356afcda24df', '组织机构数据权限', 'Datajur', '组织机构数据权限按钮');
INSERT INTO `sys_fhbutton` VALUES ('4efa162fce8340f0bd2dcd3b11d327ec', '导入EXCEL', 'FromExcel', '导入EXCEL到系统用户');
INSERT INTO `sys_fhbutton` VALUES ('cc51b694d5344d28a9aa13c84b7166cd', '发短信', 'sms', '发送短信');
INSERT INTO `sys_fhbutton` VALUES ('da7fd386de0b49ce809984f5919022b8', '站内信', 'FHSMS', '发送站内信');
INSERT INTO `sys_fhbutton` VALUES ('fc5e8767b4564f34a0d2ce2375fcc92e', '绑定用户', 'userBinding', '绑定用户');

-- ----------------------------
-- Table structure for `sys_fhlog`
-- ----------------------------
DROP TABLE IF EXISTS `sys_fhlog`;
CREATE TABLE `sys_fhlog` (
  `FHLOG_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `CZTIME` varchar(32) DEFAULT NULL COMMENT '操作时间',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '事件',
  PRIMARY KEY (`FHLOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_fhlog
-- ----------------------------
INSERT INTO `sys_fhlog` VALUES ('0d77021fd0104531a8913822ef66b8f5', 'admin', '2017-12-29 11:03:00', '登录系统');
INSERT INTO `sys_fhlog` VALUES ('940447dbeac14285bccea34c5e95de3e', 'admin', '2017-12-29 11:06:55', '删除系统用户：{tm=1514516809536, USER_ID=6f65d209e9564f04b2083aee2464eb69}');
INSERT INTO `sys_fhlog` VALUES ('acac9a16c72d4c6da99118f18dafe612', 'admin', '2017-12-29 11:05:50', '登录系统');
INSERT INTO `sys_fhlog` VALUES ('d0482f00605646e0850a59ee03808c41', 'lisi', '2017-12-29 11:04:20', '登录系统');
INSERT INTO `sys_fhlog` VALUES ('d6b6a97d37d84111bc6afa8f6d6c61d6', 'admin', '2017-12-29 11:04:03', '新增系统用户：lisi');
INSERT INTO `sys_fhlog` VALUES ('e70a2860a2c9438888df58f7873cf7f5', 'admin', '2017-12-29 10:59:18', '登录系统');

-- ----------------------------
-- Table structure for `sys_fhsms`
-- ----------------------------
DROP TABLE IF EXISTS `sys_fhsms`;
CREATE TABLE `sys_fhsms` (
  `FHSMS_ID` varchar(100) NOT NULL,
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `TYPE` varchar(5) DEFAULT NULL COMMENT '类型',
  `TO_USERNAME` varchar(255) DEFAULT NULL COMMENT '收信人',
  `FROM_USERNAME` varchar(255) DEFAULT NULL COMMENT '发信人',
  `SEND_TIME` varchar(100) DEFAULT NULL COMMENT '发信时间',
  `STATUS` varchar(5) DEFAULT NULL COMMENT '状态',
  `SANME_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`FHSMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_fhsms
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_loginimg`
-- ----------------------------
DROP TABLE IF EXISTS `sys_loginimg`;
CREATE TABLE `sys_loginimg` (
  `LOGINIMG_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '文件名',
  `FILEPATH` varchar(100) DEFAULT NULL COMMENT '路径',
  `TYPE` int(2) NOT NULL COMMENT '状态',
  `FORDER` int(3) NOT NULL COMMENT '排序',
  PRIMARY KEY (`LOGINIMG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_loginimg
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(60) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  `MENU_STATE` int(1) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '#', '0', '1', 'menu-icon fa fa-home blue', '2', '1');
INSERT INTO `sys_menu` VALUES ('2', '权限管理', '#', '1', '1', 'menu-icon fa fa-lock black', '1', '1');
INSERT INTO `sys_menu` VALUES ('3', '日志管理', 'fhlog/list.do', '1', '6', 'menu-icon fa fa-book blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('4', '文件管理', 'fhfile/list.do', '59', '3', 'menu-icon fa fa-folder-open purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('6', '信息管理', '#', '0', '5', 'menu-icon fa fa-credit-card green', '2', '1');
INSERT INTO `sys_menu` VALUES ('7', '图片管理', '#', '6', '1', 'menu-icon fa fa-folder-o pink', '2', '1');
INSERT INTO `sys_menu` VALUES ('8', '性能监控', 'druid/index.html', '9', '9', 'menu-icon fa fa-tachometer red', '1', '1');
INSERT INTO `sys_menu` VALUES ('9', '系统工具', '#', '0', '3', 'menu-icon fa fa-cog black', '2', '1');
INSERT INTO `sys_menu` VALUES ('10', '接口测试', 'tool/interfaceTest.do', '9', '2', 'menu-icon fa fa-exchange green', '1', '1');
INSERT INTO `sys_menu` VALUES ('11', '发送邮件', 'tool/goSendEmail.do', '9', '3', 'menu-icon fa fa-envelope-o green', '1', '1');
INSERT INTO `sys_menu` VALUES ('12', '置二维码', 'tool/goTwoDimensionCode.do', '9', '4', 'menu-icon fa fa-barcode green', '1', '1');
INSERT INTO `sys_menu` VALUES ('14', '地图工具', 'tool/map.do', '9', '6', 'menu-icon fa fa-globe black', '1', '1');
INSERT INTO `sys_menu` VALUES ('15', '微信管理', '#', '0', '4', 'menu-icon fa fa-comments purple', '2', '1');
INSERT INTO `sys_menu` VALUES ('16', '文本回复', 'textmsg/list.do', '15', '2', 'menu-icon fa fa-comment green', '2', '1');
INSERT INTO `sys_menu` VALUES ('17', '应用命令', 'command/list.do', '15', '4', 'menu-icon fa fa-comment grey', '2', '1');
INSERT INTO `sys_menu` VALUES ('18', '图文回复', 'imgmsg/list.do', '15', '3', 'menu-icon fa fa-comment pink', '2', '1');
INSERT INTO `sys_menu` VALUES ('19', '关注回复', 'textmsg/goSubscribe.do', '15', '1', 'menu-icon fa fa-comment orange', '2', '1');
INSERT INTO `sys_menu` VALUES ('20', '在线管理', 'onlinemanager/list.do', '1', '5', 'menu-icon fa fa-laptop green', '1', '1');
INSERT INTO `sys_menu` VALUES ('21', '打印测试', 'tool/printTest.do', '9', '7', 'menu-icon fa fa-hdd-o grey', '1', '1');
INSERT INTO `sys_menu` VALUES ('36', '角色(基础权限)', 'role.do', '2', '1', 'menu-icon fa fa-key orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('37', '按钮权限', 'buttonrights/list.do', '2', '2', 'menu-icon fa fa-key green', '1', '1');
INSERT INTO `sys_menu` VALUES ('38', '菜单管理', 'menu/listAllMenu.do', '1', '3', 'menu-icon fa fa-folder-open-o brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('39', '按钮管理', 'fhbutton/list.do', '1', '2', 'menu-icon fa fa-download orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('40', '用户管理', '#', '0', '2', 'menu-icon fa fa-users blue', '2', '1');
INSERT INTO `sys_menu` VALUES ('41', '系统用户', 'user/listUsers.do', '40', '1', 'menu-icon fa fa-users green', '1', '1');
INSERT INTO `sys_menu` VALUES ('42', '会员管理', 'happuser/listUsers.do', '40', '2', 'menu-icon fa fa-users orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('43', '数据字典', 'dictionaries/listAllDict.do?DICTIONARIES_ID=0', '1', '4', 'menu-icon fa fa-book purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('44', '代码生成器', '#', '9', '0', 'menu-icon fa fa-cogs brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('48', '图表报表', ' tool/fusionchartsdemo.do', '9', '5', 'menu-icon fa fa-bar-chart-o black', '1', '1');
INSERT INTO `sys_menu` VALUES ('50', '站内信', 'fhsms/list.do', '6', '3', 'menu-icon fa fa-envelope green', '1', '1');
INSERT INTO `sys_menu` VALUES ('51', '图片列表', 'pictures/list.do', '7', '1', 'menu-icon fa fa-folder-open-o green', '1', '1');
INSERT INTO `sys_menu` VALUES ('52', '图片爬虫', 'pictures/goImageCrawler.do', '7', '2', 'menu-icon fa fa-cloud-download green', '1', '1');
INSERT INTO `sys_menu` VALUES ('53', '表单构建器', 'tool/goFormbuilder.do', '9', '1', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('54', '数据库管理', '#', '0', '9', 'menu-icon fa fa-hdd-o blue', '2', '1');
INSERT INTO `sys_menu` VALUES ('55', '数据库备份', 'brdb/listAllTable.do', '54', '1', 'menu-icon fa fa-cloud-upload blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('56', '数据库还原', 'brdb/list.do', '54', '3', 'menu-icon fa fa-cloud-download blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('57', '备份定时器', 'timingbackup/list.do', '54', '2', 'menu-icon fa fa-tachometer blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('58', 'SQL编辑器', 'sqledit/view.do', '54', '4', 'menu-icon fa fa-pencil-square-o blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('59', 'OA办公', '#', '0', '6', 'menu-icon fa fa-laptop pink', '2', '1');
INSERT INTO `sys_menu` VALUES ('60', '组织机构', 'department/listAllDepartment.do?DEPARTMENT_ID=0', '59', '1', 'menu-icon fa fa-users green', '1', '1');
INSERT INTO `sys_menu` VALUES ('61', '反向生成', 'recreateCode/list.do', '44', '2', 'menu-icon fa fa-cogs blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('62', '正向生成', 'createCode/list.do', '44', '1', 'menu-icon fa fa-cogs green', '1', '1');
INSERT INTO `sys_menu` VALUES ('63', '主附结构', 'attached/list.do', '6', '2', 'menu-icon fa fa-folder-open blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('64', '员工管理', 'staff/list.do', '59', '2', 'menu-icon fa fa-users blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('65', '多数据源', 'datasource2/list.do', '6', '4', 'menu-icon fa fa-folder-open-o purple', '1', '0');
INSERT INTO `sys_menu` VALUES ('66', '下拉联动', 'linkage/view.do', '6', '5', 'menu-icon fa fa-exchange green', '1', '1');
INSERT INTO `sys_menu` VALUES ('67', '公众号管理', 'key/list.do', '15', '0', 'menu-icon fa fa-comments blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('68', '快递查询', 'tool/queryExpress.do', '9', '8', 'menu-icon fa fa-fighter-jet green', '1', '1');
INSERT INTO `sys_menu` VALUES ('69', '模版管理', '#', '44', '3', 'menu-icon fa fa-folder-open-o purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('70', '单表模版', 'codeeditor/goEdit.do?type=createCode&ftl=controllerTemplate', '69', '1', 'menu-icon fa fa-folder-open green', '1', '1');
INSERT INTO `sys_menu` VALUES ('71', '树形表模版', 'codeeditor/goEdit.do?type=createTreeCode&ftl=controllerTemplate', '69', '4', 'menu-icon fa fa-folder-open blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('72', '主表模版', 'codeeditor/goEdit.do?type=createFaCode&ftl=controllerTemplate', '69', '2', 'menu-icon fa fa-folder-open orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('73', '明细表模版', 'codeeditor/goEdit.do?type=createSoCode&ftl=controllerTemplate', '69', '3', 'menu-icon fa fa-folder-open red', '1', '1');
INSERT INTO `sys_menu` VALUES ('74', '处理类', 'codeeditor/goEdit.do?type=createCode&ftl=controllerTemplate', '70', '1', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('75', 'service层', 'codeeditor/goEdit.do?type=createCode&ftl=serviceTemplate', '70', '3', 'menu-icon fa fa-folder orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('76', 'service层manager', 'codeeditor/goEdit.do?type=createCode&ftl=managerTemplate', '70', '2', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('77', 'mapper_Mysql', 'codeeditor/goEdit2.do?type=createCode&ftl=mapperMysqlTemplate', '70', '4', 'menu-icon fa fa-folder red', '1', '1');
INSERT INTO `sys_menu` VALUES ('78', 'mapper_Oracle', 'codeeditor/goEdit2.do?type=createCode&ftl=mapperOracleTemplate', '70', '5', 'menu-icon fa fa-folder black', '1', '1');
INSERT INTO `sys_menu` VALUES ('79', 'mapper_Sqlserver', 'codeeditor/goEdit2.do?type=createCode&ftl=mapperSqlserverTemplate', '70', '6', 'menu-icon fa fa-folder grey', '1', '1');
INSERT INTO `sys_menu` VALUES ('80', 'mysql_SQL脚本', 'codeeditor/goEdit.do?type=createCode&ftl=mysql_SQL_Template', '70', '7', 'menu-icon fa fa-folder pink', '1', '1');
INSERT INTO `sys_menu` VALUES ('81', 'oracle_SQL脚本', 'codeeditor/goEdit.do?type=createCode&ftl=oracle_SQL_Template', '70', '8', 'menu-icon fa fa-folder brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('82', 'sqlserver_SQL脚本', 'codeeditor/goEdit.do?type=createCode&ftl=sqlserver_SQL_Template', '70', '9', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('83', 'jsp_list', 'codeeditor/goEdit2.do?type=createCode&ftl=jsp_list_Template', '70', '10', 'menu-icon fa fa-folder orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('84', 'jsp_edit', 'codeeditor/goEdit2.do?type=createCode&ftl=jsp_edit_Template', '70', '11', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('86', '处理类', 'codeeditor/goEdit.do?type=createFaCode&ftl=controllerTemplate', '72', '1', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('87', 'service层manager', 'codeeditor/goEdit.do?type=createFaCode&ftl=managerTemplate', '72', '2', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('88', 'service层', 'codeeditor/goEdit.do?type=createFaCode&ftl=serviceTemplate', '72', '3', 'menu-icon fa fa-folder black', '1', '1');
INSERT INTO `sys_menu` VALUES ('89', 'mapper_Mysql', 'codeeditor/goEdit2.do?type=createFaCode&ftl=mapperMysqlTemplate', '72', '4', 'menu-icon fa fa-folder pink', '1', '1');
INSERT INTO `sys_menu` VALUES ('90', 'mapper_Oracle ', 'codeeditor/goEdit2.do?type=createFaCode&ftl=mapperOracleTemplate', '72', '5', 'menu-icon fa fa-folder brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('91', 'mapper_Sqlserver', 'codeeditor/goEdit2.do?type=createFaCode&ftl=mapperSqlserverTemplate', '72', '6', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('92', 'mysql_SQL脚本', 'codeeditor/goEdit.do?type=createFaCode&ftl=mysql_SQL_Template', '72', '7', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('93', 'oracle_SQL脚本  ', 'codeeditor/goEdit.do?type=createFaCode&ftl=oracle_SQL_Template', '72', '8', 'menu-icon fa fa-folder orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('94', 'sqlserver_SQL脚本  ', 'codeeditor/goEdit.do?type=createFaCode&ftl=sqlserver_SQL_Template', '72', '9', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('95', 'jsp_list', 'codeeditor/goEdit2.do?type=createFaCode&ftl=jsp_list_Template', '72', '10', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('96', 'jsp_edit', 'codeeditor/goEdit2.do?type=createFaCode&ftl=jsp_edit_Template', '72', '11', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('97', '处理类', 'codeeditor/goEdit.do?type=createSoCode&ftl=controllerTemplate', '73', '1', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('98', 'service层manager', 'codeeditor/goEdit.do?type=createSoCode&ftl=managerTemplate', '73', '2', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('99', 'service层', 'codeeditor/goEdit.do?type=createSoCode&ftl=serviceTemplate', '73', '3', 'menu-icon fa fa-folder black', '1', '1');
INSERT INTO `sys_menu` VALUES ('100', 'mapper_Mysql', 'codeeditor/goEdit2.do?type=createSoCode&ftl=mapperMysqlTemplate', '73', '4', 'menu-icon fa fa-folder pink', '1', '1');
INSERT INTO `sys_menu` VALUES ('101', 'mapper_Oracle ', 'codeeditor/goEdit2.do?type=createSoCode&ftl=mapperOracleTemplate', '73', '5', 'menu-icon fa fa-folder brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('102', 'mapper_Sqlserver', 'codeeditor/goEdit2.do?type=createSoCode&ftl=mapperSqlserverTemplate', '73', '6', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('103', 'mysql_SQL脚本', 'codeeditor/goEdit.do?type=createSoCode&ftl=mysql_SQL_Template', '73', '7', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('104', 'oracle_SQL脚本  ', 'codeeditor/goEdit.do?type=createSoCode&ftl=oracle_SQL_Template', '73', '8', 'menu-icon fa fa-folder orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('105', 'sqlserver_SQL脚本  ', 'codeeditor/goEdit.do?type=createSoCode&ftl=sqlserver_SQL_Template', '73', '9', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('106', 'jsp_list', 'codeeditor/goEdit2.do?type=createSoCode&ftl=jsp_list_Template', '73', '10', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('107', 'jsp_edit', 'codeeditor/goEdit2.do?type=createSoCode&ftl=jsp_edit_Template', '73', '11', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('108', '处理类', 'codeeditor/goEdit.do?type=createTreeCode&ftl=controllerTemplate', '71', '1', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('109', 'service层manager', 'codeeditor/goEdit.do?type=createTreeCode&ftl=managerTemplate', '71', '2', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('110', 'service层', 'codeeditor/goEdit.do?type=createTreeCode&ftl=serviceTemplate', '71', '3', 'menu-icon fa fa-folder black', '1', '1');
INSERT INTO `sys_menu` VALUES ('111', 'mapper_Mysql', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=mapperMysqlTemplate', '71', '5', 'menu-icon fa fa-folder pink', '1', '1');
INSERT INTO `sys_menu` VALUES ('112', 'mapper_Oracle ', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=mapperOracleTemplate', '71', '6', 'menu-icon fa fa-folder brown', '1', '1');
INSERT INTO `sys_menu` VALUES ('113', 'mapper_Sqlserver', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=mapperSqlserverTemplate', '71', '7', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('114', 'mysql_SQL脚本', 'codeeditor/goEdit.do?type=createTreeCode&ftl=mysql_SQL_Template', '71', '8', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('115', 'oracle_SQL脚本  ', 'codeeditor/goEdit.do?type=createTreeCode&ftl=oracle_SQL_Template', '71', '9', 'menu-icon fa fa-folder orange', '1', '1');
INSERT INTO `sys_menu` VALUES ('116', 'sqlserver_SQL脚本  ', 'codeeditor/goEdit.do?type=createTreeCode&ftl=sqlserver_SQL_Template', '71', '10', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('117', 'jsp_list', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=jsp_list_Template', '71', '11', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('118', 'jsp_edit', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=jsp_edit_Template', '71', '12', 'menu-icon fa fa-folder blue', '1', '1');
INSERT INTO `sys_menu` VALUES ('119', '实体类', 'codeeditor/goEdit.do?type=createTreeCode&ftl=entityTemplate', '71', '4', 'menu-icon fa fa-folder green', '1', '1');
INSERT INTO `sys_menu` VALUES ('120', 'jsp_tree', 'codeeditor/goEdit2.do?type=createTreeCode&ftl=jsp_tree_Template', '71', '13', 'menu-icon fa fa-folder purple', '1', '1');
INSERT INTO `sys_menu` VALUES ('121', '问卷调查', '#', '0', '11', 'menu-icon fa fa-leaf black', '2', '1');
INSERT INTO `sys_menu` VALUES ('123', '岗位角色', 'roleTree/listAll.do?ROLE_ID=0', '2', '3', 'menu-icon fa fa-leaf black', '1', '0');
INSERT INTO `sys_menu` VALUES ('124', '后台用户', 'newuser/listUsers.do', '40', '3', 'menu-icon fa fa-leaf black', '1', '0');
INSERT INTO `sys_menu` VALUES ('127', '问卷调查', 'questionnaire/list.do', '121', '2', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('128', '问诊数据', 'manager/list.do', '121', '3', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('130', '联动数据管理', 'linkagePullData/list', '121', '5', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('131', '满意度统计', 'questionStatic/goStatissticsData.do', '121', '6', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('133', '问卷答案管理', 'qResult/listResult.do', '121', '8', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('134', '问卷导入数据管理', 'questionnaireTemp/list.do', '121', '7', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('136', '问诊数据名称配置', 'recConf/configure.do', '121', '10', 'menu-icon fa fa-leaf black', '1', '1');
INSERT INTO `sys_menu` VALUES ('137', '星级评定统计', 'questionStatic/starRat.do', '121', '11', 'menu-icon fa fa-leaf black', '1', '1');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理组', '298634995357005440647926296141621591269342', '0', '1', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('115b386ff04f4352b060dffcd2b5d1da', '中级会员', '2658455991531145831358883798259359488', '2', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('1b67fc82ce89457a8347ae53e43a347e', '初级会员', '2658455991531145831358883798259359488', '2', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('2', '会员组', '2658455991531145831358883798259359488', '0', '0', '0', '0', '1');
INSERT INTO `sys_role` VALUES ('3e7e6070dbcb4e8a96e99212623ea788', '问卷审核员', '298600435429115071520858755017754076512256', '1', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('46294b31a71c4600801724a6eb06bb26', '职位组', '', '0', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('5466347ac07044cb8d82990ec7f3a90e', '主管', '', '46294b31a71c4600801724a6eb06bb26', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('856849f422774ad390a4e564054d8cc8', '经理', '', '46294b31a71c4600801724a6eb06bb26', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('8b70a7e67f2841e7aaba8a4d92e5ff6f', '高级会员', '2658455991531145831358883798259359488', '2', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('99e7a9091d5048298cebc0b3034b2bc9', '问卷专员', '110424286521836101225631043852059965128720', '1', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888');
INSERT INTO `sys_role` VALUES ('adb8cc8ee2674a2abdc8603615d72f08', '综合管理员', '298600435429115071520877201761827786063888', '1', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888', '298600435429115071520877201761827786063888');
INSERT INTO `sys_role` VALUES ('c21cecf84048434b93383182b1d98cba', '组长', '', '46294b31a71c4600801724a6eb06bb26', '0', '0', '0', '0');
INSERT INTO `sys_role` VALUES ('d449195cd8e7491080688c58e11452eb', '总监', '', '46294b31a71c4600801724a6eb06bb26', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `sys_role_fhbutton`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_fhbutton`;
CREATE TABLE `sys_role_fhbutton` (
  `RB_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `BUTTON_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RB_ID`),
  KEY `角色表外键` (`ROLE_ID`) USING BTREE,
  KEY `fbutton` (`BUTTON_ID`) USING BTREE,
  CONSTRAINT `sys_role_fhbutton_ibfk_1` FOREIGN KEY (`BUTTON_ID`) REFERENCES `sys_fhbutton` (`FHBUTTON_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_fhbutton_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_fhbutton
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'de41b7fb99201d8334c23c014db35ecd92df81bc', 'FH', '1133671055321055258374707980945218933803269864762743594642571294', '1', '0', '2017-12-29 11:05:50', '0:0:0:0:0:0:0:1', '0', 'admin', 'default', 'QQ313596790@main.com', '001', '18788888888');

-- ----------------------------
-- Table structure for `sys_userphoto`
-- ----------------------------
DROP TABLE IF EXISTS `sys_userphoto`;
CREATE TABLE `sys_userphoto` (
  `USERPHOTO_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(30) DEFAULT NULL COMMENT '用户名',
  `PHOTO0` varchar(255) DEFAULT NULL COMMENT '原图',
  `PHOTO1` varchar(100) DEFAULT NULL COMMENT '头像1',
  `PHOTO2` varchar(100) DEFAULT NULL COMMENT '头像2',
  `PHOTO3` varchar(100) DEFAULT NULL COMMENT '头像3',
  PRIMARY KEY (`USERPHOTO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_userphoto
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_attached`
-- ----------------------------
DROP TABLE IF EXISTS `tb_attached`;
CREATE TABLE `tb_attached` (
  `ATTACHED_ID` varchar(100) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `FDESCRIBE` varchar(255) DEFAULT NULL COMMENT '描述',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '价格',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ATTACHED_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_attached
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_attachedmx`
-- ----------------------------
DROP TABLE IF EXISTS `tb_attachedmx`;
CREATE TABLE `tb_attachedmx` (
  `ATTACHEDMX_ID` varchar(100) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '创建日期',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '单价',
  `ATTACHED_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ATTACHEDMX_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_attachedmx
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_file_details`
-- ----------------------------
DROP TABLE IF EXISTS `tb_file_details`;
CREATE TABLE `tb_file_details` (
  `fileId` varchar(100) NOT NULL COMMENT '附件编号',
  `ownershipMasterId` varchar(100) DEFAULT NULL COMMENT '归属关系编号：(问卷)\r\n            如：所属问卷、其他',
  `category` varchar(20) DEFAULT NULL COMMENT '使用分类：\r\n            logo[C1]、背景[C2]、附件[C3] 等',
  `fileTitle` varchar(50) DEFAULT NULL COMMENT '文件标题',
  `fileName` varchar(100) DEFAULT NULL COMMENT '文件名称',
  `fileExtension` varchar(30) DEFAULT NULL COMMENT '文件后缀',
  `specification` varchar(100) DEFAULT NULL COMMENT '规范要求',
  `filePath` varchar(100) DEFAULT NULL COMMENT '文件路径',
  `content` longblob COMMENT '二进制文件流存储',
  `description` varchar(100) DEFAULT NULL COMMENT '描述说明(备注)',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `createUser` varchar(100) DEFAULT NULL COMMENT '创建人',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `modifyUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  `enCodePath` varchar(1000) DEFAULT NULL,
  `shortUrl` varchar(200) DEFAULT NULL COMMENT '短链接码',
  PRIMARY KEY (`fileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件附件表：\r\n项目附件详情';

-- ----------------------------
-- Records of tb_file_details
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_linkage_pull_data`
-- ----------------------------
DROP TABLE IF EXISTS `tb_linkage_pull_data`;
CREATE TABLE `tb_linkage_pull_data` (
  `linkageId` varchar(100) NOT NULL,
  `linkageName` varchar(100) DEFAULT NULL COMMENT '联动名称',
  `parentId` varchar(100) DEFAULT NULL COMMENT '父类id',
  `level` int(11) DEFAULT NULL COMMENT '联动级别',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段',
  `questionnaireId` varchar(1000) DEFAULT NULL COMMENT '问卷id',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `createUser` varchar(100) DEFAULT NULL COMMENT '创建人',
  `updateTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `updateUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`linkageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_linkage_pull_data
-- ----------------------------
INSERT INTO `tb_linkage_pull_data` VALUES ('006aa39df28c41d38c9d44da99449d21', '市场营销部', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:28', '1', '2017-09-26 15:14:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('00b1fab412504963bf2d2b862e5ba397', '仙鹤湖经营公司', '5b6691a27bca4fecb9b2393d681fa725', '4', '4', null, '2017-09-26 15:10:55', '1', '2017-09-26 15:10:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0254d606a6bb4181bf6e848857cb7bb0', '客户管理部', 'fc4bcdc7b2d04709a607f4ced59bb9ce', '4', null, null, '2017-09-26 15:37:21', '1', '2017-09-26 15:37:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('025f90a1d7324c01850ffc2983719963', '创新一期-工程部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:48', '1', '2017-09-26 15:18:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('02ee3d4e3c2e459a84f8bc7741de9a72', '医务部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:02', '1', '2017-09-26 15:04:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('030ded0d6bb044b0b86009f9f3ec9007', '特色科室_护理', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:06:42', '1', '2017-09-26 15:06:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0316cab9f3cc4ff990b497e70f68944c', '设计部', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:25', '1', '2017-09-26 15:26:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0360be7451394404a493655d06283368', '综合部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:51', '1', '2017-09-26 15:14:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0513087f31aa4c1ebd89ac9d72e1fc2b', '金融-财务部', 'bf65f1753b8b4a8c85cb3dbf811011cb', '5', null, null, '2017-09-26 15:18:55', '1', '2017-09-26 15:19:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('05893cc4005044fe80d6a22f95575701', '事业部本部', '373f39f029634ee5a60d376a47d1f1cc', '3', null, null, '2017-09-25 16:56:27', '1', '2017-09-25 16:56:37', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('05d403592def4eb9a056927ddebd3139', '总监室', 'f76b0ca19376439d96690f05ebebbabb', '3', null, null, '2017-10-18 11:16:41', '1', '2017-10-18 11:16:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('061fe16f5ee14a099169c6c4f02f43ac', '国际-综合部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:29', '1', '2017-09-26 15:19:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('064ea6579fb0479f8350018f1a8f060c', '财务部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:12:58', '1', '2017-09-26 15:13:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0838ef65f48c4ebf9bce4533cc89d2b7', '吴园养老社区筹备组', 'ce0cb88af66044f28c689863d1bc073f', '4', '5', null, '2017-09-25 17:00:19', '1', '2017-09-25 17:00:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('09091770ead142508cf208fbc2256b29', '事业部本部', '98f9cd1a69524d5d9160255b32b079b2', '3', null, null, '2017-09-26 15:20:17', '1', '2017-09-26 15:20:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('09c4c6907d22427eb452911c36df4c14', '旅游市场部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:13:25', '1', '2017-09-26 15:13:33', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0af7987a9baa4a83b4e3f819628ba5dc', '呼吸一科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:27', '1', '2017-09-26 15:31:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0b593d9bc88543b38b68b93e48f4d525', '眼科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:06:44', '1', '2017-09-26 15:06:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0be0b612e1e14eef8546b29892965e89', '粤园门诊部', '74848f35311e4105b497922c3ee271eb', '5', null, null, '2017-09-26 15:08:51', '1', '2017-09-26 15:08:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0ce298547ea64ecaa12d3f7f55d0c94c', '客服部', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:25', '1', '2017-09-26 15:12:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('0dbed649b68d474b90911b3bee05145b', '投后管理部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '2', null, '2017-09-26 15:24:00', '1', '2017-09-26 15:24:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('10088144156d4af1ad2ee0ba29813994', '北京分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:13', '1', '2017-09-26 15:11:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1078a0dd11414aa39aaf0a34cd2da92a', '北京康复医院', 'bcb987a9a28d40d2acec335b70d6354f', '4', '1', null, '2017-09-25 17:20:28', '1', '2017-09-25 17:20:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1136c4008b84477e83d0ca7ffef92803', '餐饮部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:38', '1', '2017-09-25 17:04:23', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1228c446a21641fabc6e1d5e3b89d6c2', '总经理办公室', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:12:58', '1', '2017-09-26 15:13:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('13c8be50f3c645ca91925c3a3ec69c02', '总经理室', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:25', '1', '2017-09-26 15:26:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('14f18f59b9af4a8db2ff7e366582fd3d', '事业部本部', 'c81e58b1a5e14dc0a4b57ff003945343', '3', null, null, '2017-09-26 15:09:16', '1', '2017-09-26 15:09:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('152af52ae7fc4b6a92ad694b5a21f522', '成本招采部', '09091770ead142508cf208fbc2256b29', '4', '2', null, '2017-09-26 15:20:44', '1', '2017-09-26 15:21:09', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('159a88ef85af4db39f00b8376b108346', '市场部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '2', null, '2017-09-26 15:09:36', '1', '2017-09-26 15:09:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('15f119bb756e4304abfc3a5a958ffd9a', '前期部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:25:47', '1', '2017-09-26 15:26:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('16d057bc0f1540b285dd3069b8dd0a29', '海南-投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:30', '1', '2017-09-26 15:24:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('171d3b9751144e1cad7246ac2fd6433f', '神经内科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:56', '1', '2017-09-26 15:06:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('17bb5096409a46d58db6e1d6e11492a3', '社会服务部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:53', '1', '2017-09-26 15:30:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1883ba349a9d40c2951138f2025ae643', '设计管理部', '09091770ead142508cf208fbc2256b29', '4', '3', null, '2017-09-26 15:20:44', '1', '2017-09-26 15:21:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('18e3ba4b4cfa4f25b7701f398880bf5a', 'SN1项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:23', '1', '2017-09-26 15:21:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('18f8230afbb34b8db46f96388d554dcf', '泰康同济国际医院项目部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:26:08', '1', '2017-09-26 15:26:12', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('19193d16da8c4171999fc488adb3ba9d', '成都业务发展中心', '1db93b45b8a74c9e8f0541bcb81bc491', '3', '3', null, '2017-09-26 15:24:55', '1', '2017-09-26 15:25:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1a096d60072a45c7b80b816e3a9ee683', '医疗事务管理部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:55', '1', '2017-09-26 15:08:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1a6b78ab9e904666834499738b6e6c93', '质控部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:58', '1', '2017-09-26 15:29:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1b08dcbc37ce4e678e81420395ea2e4f', '医疗规划部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '2', null, '2017-09-25 17:19:13', '1', '2017-09-25 17:19:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1cbc28b58f15448faf40048e49a4add9', '超声影像室', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:25', '1', '2017-09-26 15:34:30', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1db93b45b8a74c9e8f0541bcb81bc491', '业务发展中心', '3802a8056dac4b0e87614e22cb1c3abc', '2', '9', null, '2017-09-26 15:23:13', '1', '2017-09-26 15:24:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1e0a51e95be44ef8a19688dd94484e59', '妇科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:57', '1', '2017-09-26 15:06:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1ea74a46786e40efbf325a1c5eb40cc7', '中医科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:09', '1', '2017-09-26 15:05:33', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1f0e0f7219fa40e99fbbda14319650f6', '口腔科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:34', '1', '2017-09-26 15:33:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('1f3e7282622d46a1b2f86f73f5cc56ad', '海外投资部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '3', null, '2017-09-26 15:23:34', '1', '2017-09-26 15:23:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('20a27cf153324e148424a3ffe56d44a1', '总经理室', '09091770ead142508cf208fbc2256b29', '4', '1', null, '2017-09-26 15:20:43', '1', '2017-09-26 15:20:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2204e600f27a42f19cb871d2dd3d3900', '采购部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:33', '1', '2017-09-26 15:30:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2244e74b81fd4d34974f43d0c03af7b6', '北京不动产投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:07', '1', '2017-09-26 15:24:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2267aee5536b4280b7312b951a780398', '皮肤科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:35', '1', '2017-09-26 15:33:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('22eb97cc7ed240f3a18d8d31a177ef88', '小汤山项目部', '954f2c33ae7b44908390e2a563be11d3', '3', null, null, '2017-09-26 15:28:26', '1', '2017-09-26 15:28:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('23048e29ec084b37ba9aea780b85f026', '规划发展部', '764fbc8df6044dbb981c04d026a48303', '4', null, null, '2017-09-26 15:37:06', '1', '2017-09-26 15:37:14', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2355a1e60167445b9342194d2f01fa89', '耳鼻喉科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:33', '1', '2017-09-26 15:33:41', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('23ed78dddbcf4c5d915546fcb84da920', '总经理室', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:37', '1', '2017-09-25 17:01:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('241ce96f67f44d0183a2db4c81f987c6', '创新二期-酒店部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:18:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('24f71405ba164306a817cdd277b67578', '国际大厦物管处', 'dd187849e7364754bb76125d54828e9b', '4', null, null, '2017-09-26 15:16:54', '1', '2017-09-26 15:17:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('25268a7059ba46d8a70b5d4422ce8559', '管家部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:26', '1', '2017-09-25 17:12:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('28197437345e433ea04c26a74e193839', '经营规划部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:56', '1', '2017-09-26 15:31:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('286e403aff8f485689ee7898db30e8da', '院长办公室', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:52', '1', '2017-09-26 15:07:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2a7b48b437dc46e994aaf1275faa7656', '工程部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:39', '1', '2017-09-25 17:04:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2ad47bfc856c46a18b76a4b620c3bfc4', '投资管理部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '4', null, '2017-09-26 15:23:34', '1', '2017-09-26 15:23:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2b58d49017fd4bf99078d8736e87a2b9', '信息化管理部', 'fc4bcdc7b2d04709a607f4ced59bb9ce', '4', null, null, '2017-09-26 15:37:21', '1', '2017-09-26 15:37:30', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2d68204e81004bbfa5a2129ba7527746', '开发部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '3', null, '2017-09-26 15:09:36', '1', '2017-09-26 15:09:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2d6dc2fc27f44b8ab943518bf126c459', '行政管理部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:52', '1', '2017-09-26 15:08:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2d6ec7e3bff24123b596f833b44cb91c', '广州分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:13', '1', '2017-09-26 15:11:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2e12f6b97ed0444cad319570c74a3c04', '成都医学中心项目部', 'bb99c9055e43440e89cb04003e9a97bc', '4', null, null, '2017-09-26 15:22:48', '1', '2017-09-26 15:22:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2e73bbcac18d418ba59bf7f83fd96200', '客服部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:30:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2e9e8a9a35b34957a0353052ac46e52c', '运行保障部', '05893cc4005044fe80d6a22f95575701', '4', '9', null, '2017-09-26 13:36:58', '1', null, null);
INSERT INTO `tb_linkage_pull_data` VALUES ('2ef12ba0fce34784be42be63aeef1f63', '客服部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:09', '1', '2017-09-26 15:05:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2f4dbe8d65544c4ebb952fe77d9cf979', '综合部', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:24', '1', '2017-09-26 15:12:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2fb07d80d7844a398928cda6c434d549', '体验馆', '7a617128062c40dab3b82ec0bc007bd8', '5', null, null, '2017-09-25 17:13:41', '1', '2017-09-25 17:13:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('2fb6002a429a4275a7b7524ceffd8c8a', '市场拓展部', 'c87e5b1d8c4e4fa9ade489d1626a89f6', '5', null, null, '2017-09-25 16:59:17', '1', '2017-09-25 16:59:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('32e4d01430aa492e8c522e1e6f07d0b0', '综合部', 'b024d7f9cb964927afe4fa70efcb572e', '3', null, null, '2017-09-26 15:27:55', '1', '2017-09-26 15:28:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('33384bd96b634632822bcfb0dd24dc46', '精神科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:57', '1', '2017-09-26 15:06:33', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('33dc8205d65a4c09b2fac713809dde45', '总经理室', '0838ef65f48c4ebf9bce4533cc89d2b7', '5', null, null, '2017-09-25 17:11:45', '1', '2017-09-25 17:11:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('34f7b65b7da944daa2f61cab3e5a3c3a', '总经理办公室', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:24', '1', '2017-09-26 15:12:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3619e054b2af48ce909e0d10a12d8cba', '金融市场部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '5', null, '2017-09-26 15:23:34', '1', '2017-09-26 15:23:52', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('363c93db563f46d8a36eba64111acc73', '投资部', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:14', '1', '2017-09-26 15:25:33', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('367adf6166dc47229a25796a1a4407c7', '销售部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:55', '1', '2017-09-25 17:10:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3717ceb7addb4dfe8a55bedc5079fc19', '申园养老社区', 'ce0cb88af66044f28c689863d1bc073f', '4', '2', null, '2017-09-25 16:59:49', '1', '2017-09-25 17:00:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('373f39f029634ee5a60d376a47d1f1cc', '养老社区事业部', '3802a8056dac4b0e87614e22cb1c3abc', '2', '3', null, '2017-09-25 16:55:43', '1', '2017-09-25 16:56:23', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3802a8056dac4b0e87614e22cb1c3abc', '组织机构', null, '1', null, null, '2017-09-26 11:57:04', '1', null, null);
INSERT INTO `tb_linkage_pull_data` VALUES ('383ecc0aba2541e898766e84b776d122', '财务共享中心', '439521bebd8f4c36982dcd50e2164f3f', '3', '10', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('38f4132b5d5743f797bd0381b019a475', '办公室', '439521bebd8f4c36982dcd50e2164f3f', '3', '5', null, '2017-09-26 15:36:37', '1', '2017-09-26 15:36:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('38f7e9f4601f41af95173b2bc5b420f5', '品质管理室', '50079b5ceb014c33b8f563fcc1122f2f', '3', '2', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:15:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3a12c0d597474cf6b29c0564eb938e2b', '秩序维护部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:40', '1', '2017-09-25 17:05:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3aeb5545251b431c969c9c15c546682d', '计划财务部', '05893cc4005044fe80d6a22f95575701', '4', '8', null, '2017-09-25 16:57:50', '1', '2017-09-25 16:58:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3b39f244bc0b469bbbdfbce689905281', '院感办', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:29:52', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3c284da333134270a15c3332b1d3e238', '计划财务部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:03', '1', '2017-09-26 15:04:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3c79bd90b59f4b26946c408b78a988ed', '总经理办公室', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '1', null, '2017-09-25 17:19:12', '1', '2017-09-25 17:19:18', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3cff4f7d4dfc4daf974e2cccfffaaf27', '西南医学中心（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '4', null, '2017-09-26 14:23:50', '1', '2017-09-26 14:25:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3f3bc07705644c98b4704ed73b55d68c', '区域投资团队', '79312d7be91e4928af5746b79b84aa7a', '3', null, null, '2017-09-26 15:23:21', '1', '2017-09-26 15:23:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('3fb42a581fdf472b8953895ca751fa99', '骨科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:28', '1', '2017-09-26 15:32:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('404ad5333948463c85dc4a075a763ac4', '神经外科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:26', '1', '2017-09-26 15:31:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('42187e1345364a50ac328cdfe74ac583', '行政办公室', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '3', null, '2017-09-25 17:20:04', '1', '2017-09-25 17:20:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('439521bebd8f4c36982dcd50e2164f3f', '中后台', '3802a8056dac4b0e87614e22cb1c3abc', '2', '13', null, '2017-09-26 15:35:40', '1', '2017-09-26 15:35:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('44108e8723e14354972f6c0156595d1d', '工程园林部', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:25', '1', '2017-09-26 15:12:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('44af47431f6543e195c255db7b86ffda', '抗衰老中心', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:08', '1', '2017-09-26 15:05:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('46e71066af4f44e280008864c5a12d03', '特色科室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:56', '1', '2017-09-26 15:06:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('475fcb8158f748d78c37908ff3a6c205', '综合部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:13:25', '1', '2017-09-26 15:13:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('479882eb7f644ddb95bc9a8daf17f1a4', '康复中心', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:08', '1', '2017-09-26 15:05:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('47df8ecfb32c44cc8bf66951c2c4af68', '信息部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:33', '1', '2017-09-26 15:30:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('488338d756d6484baa38b3555115974b', '养老护理部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:53', '1', '2017-09-26 15:08:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('48f3ffcba2484881bd7900d8dbd34257', '总经理室', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:12', '1', '2017-09-26 15:11:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4a165327cf5b43e886aa75c8ad88879b', '楚园医院（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '5', null, '2017-09-26 14:25:38', '1', '2017-09-26 14:25:46', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4c49002373444747a0532e8b964ac8ea', '妇儿中心', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:29', '1', '2017-09-26 15:32:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4c69b41ca61449d79a808b69e955903e', '综合部', '0838ef65f48c4ebf9bce4533cc89d2b7', '5', null, null, '2017-09-25 17:12:07', '1', '2017-09-25 17:12:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4dc1de49e7af404bb648c3b4fc3e84be', '本部', '79312d7be91e4928af5746b79b84aa7a', '3', null, null, '2017-09-26 15:23:20', '1', '2017-09-26 15:23:26', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4e6a92e90ada4e64829d423a1eacec11', '泰康在线总部大厦项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:45', '1', '2017-09-26 15:21:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4e79d8a82edc411f88f57d1b689a67e5', '吴园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4fd7c231d1b64c28b0123d21df3c6bd2', '泰康同济国际医院（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '6', null, '2017-09-26 14:23:49', '1', '2017-09-26 14:25:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('4ffb8be5df11417bba30f51c049cdf71', '销售部', '0838ef65f48c4ebf9bce4533cc89d2b7', '5', null, null, '2017-09-25 17:12:07', '1', '2017-09-25 17:12:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('50079b5ceb014c33b8f563fcc1122f2f', '写字楼事业部', '3802a8056dac4b0e87614e22cb1c3abc', '2', '6', null, '2017-09-26 15:09:09', '1', '2017-09-26 15:15:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('51c885d5a37f4ecea576d1295be8aacd', '写字楼项目部', '98f9cd1a69524d5d9160255b32b079b2', '3', null, null, '2017-09-26 15:20:17', '1', '2017-09-26 15:20:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('53469d58594f4496a4eb991469d5f6db', '人力资源部', '05893cc4005044fe80d6a22f95575701', '4', '7', null, '2017-09-25 16:57:40', '1', '2017-09-25 16:58:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('539de206c651422688b7d9d4d733a685', '市场营销部', 'c87e5b1d8c4e4fa9ade489d1626a89f6', '5', null, null, '2017-09-26 13:37:00', '1', null, null);
INSERT INTO `tb_linkage_pull_data` VALUES ('539e7d2482dd49b3aaf42ff8fa02f316', '科教部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:29:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('54666552e96c429b99dabc1cd9210dc2', '心血管内科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:26', '1', '2017-09-26 15:31:46', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('54e9c4a201b14fdf9549f1cc227ce6ca', '国际交流部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:29:47', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('54fc3018b4df474f8fc1ba267f45ae11', '总经理室', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:54', '1', '2017-09-25 17:10:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('59ddd704200446438c4e2befef2ad994', '计划财务部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:42', '1', '2017-09-25 17:05:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5a2a6f9964e74f2cabba553b08245538', '秩序维护部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:10:52', '1', '2017-09-25 17:11:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5a6650b76982483d99a916b0f9e2439e', '总经理室', '7a617128062c40dab3b82ec0bc007bd8', '5', null, null, '2017-09-25 17:13:40', '1', '2017-09-25 17:13:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5ac950d5f56c484aad6109274ec49fb3', '创新一期-客服部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:48', '1', '2017-09-26 15:18:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5b6691a27bca4fecb9b2393d681fa725', '一线经营单位', 'c81e58b1a5e14dc0a4b57ff003945343', '3', null, null, '2017-09-26 15:09:16', '1', '2017-09-26 15:09:27', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5bcb81b0550b46af81f4d4bea42cfca8', '综合办公室', '50079b5ceb014c33b8f563fcc1122f2f', '3', '3', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:15:46', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5c4013b6a32847308a0336c305bd9c61', '九公山经营公司', '5b6691a27bca4fecb9b2393d681fa725', '4', '2', null, '2017-09-26 15:10:23', '1', '2017-09-26 15:10:39', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5c64781a3c66446baea4b649b7a64801', '餐饮部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:33', '1', '2017-09-25 17:07:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5ceaef74a8b6425eb45fea1d7c8b3c23', '秩序维护部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:35', '1', '2017-09-25 17:08:18', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('5e2e4cc61e194ddd9b651ed497b7d37a', '普外二科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:28', '1', '2017-09-26 15:32:12', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6087ff59ba0244fc96c83650785704e5', '综合办公室', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:14', '1', '2017-09-26 15:25:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('61144b1658fe469088fad3ebdc8ff6ec', '上海业务发展中心', '1db93b45b8a74c9e8f0541bcb81bc491', '3', '1', null, '2017-09-26 15:24:54', '1', '2017-09-26 15:24:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6175ef7a341a42409972b77dcd79e3d6', '项目管理部', '09091770ead142508cf208fbc2256b29', '4', '4', null, '2017-09-26 15:21:09', '1', '2017-09-26 15:21:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6196bc409f2d4a979ecb00f0ba3a0137', '计划财务部', '0838ef65f48c4ebf9bce4533cc89d2b7', '5', null, null, '2017-09-25 17:11:45', '1', '2017-09-25 17:11:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('61bcaea0de1f4143a3e5633590c06e44', '总裁室', '3802a8056dac4b0e87614e22cb1c3abc', '2', '1', null, '2017-10-17 13:02:47', '1', '2017-10-17 13:02:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('61c9c102370342e281c725f040a050f6', '医学工程部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:30:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('628fc9163c1b474c913691bbda93920f', '综合部', '7a617128062c40dab3b82ec0bc007bd8', '5', null, null, '2017-09-25 17:13:58', '1', '2017-09-25 17:14:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('633d685e34404ceab5af930791b15a5e', '胸外科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:29', '1', '2017-09-26 15:32:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6344620bad32491c97431120f2372285', '上海分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:49', '1', '2017-09-26 15:12:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('641f97fdbb234fb79407b6b618a959f4', '南京仙林鼓楼医院基建项目部', 'bb99c9055e43440e89cb04003e9a97bc', '4', null, null, '2017-09-26 15:22:48', '1', '2017-09-26 15:22:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('643072eaf09e4c4682e11eafb8a999f6', '经营管理部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '4', null, '2017-09-25 17:19:13', '1', '2017-09-25 17:19:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('655e4ff2c2ff4794af5c0c8d08ac4e1d', '儿科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:32:34', '1', '2017-09-26 15:33:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('660b153617fc4efc839c7ed9a225055e', '办公室', '05893cc4005044fe80d6a22f95575701', '4', '6', null, '2017-09-26 13:36:58', '1', null, null);
INSERT INTO `tb_linkage_pull_data` VALUES ('6624d6ba973b4a41a05e3c4fc6f9a6a8', '经营办公室', '764fbc8df6044dbb981c04d026a48303', '4', null, null, '2017-09-26 15:37:05', '1', '2017-09-26 15:37:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('66e61e125d9c491eb82f0b3d2a31204c', '市场部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:35', '1', '2017-09-25 17:08:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('68480d327dad40638163c8c0cee78b76', '项目部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '4', null, '2017-09-26 15:09:37', '1', '2017-09-26 15:10:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6866f69d79fe44e9865eaa42fa1b520b', '武汉业务发展中心', '1db93b45b8a74c9e8f0541bcb81bc491', '3', '4', null, '2017-09-26 15:24:55', '1', '2017-09-26 15:25:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('68f82fbf3c3f444faf063ca44eecb35d', '国际-泰康画廊', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:28', '1', '2017-09-26 15:19:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('695494688cbb498f853463b26b9ad177', '人力资源部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:35', '1', '2017-09-25 17:08:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6aa7c5e4a342414091c3a88df9c7824d', '设计部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:25:47', '1', '2017-09-26 15:26:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6cc00ebc799a4f6099901341566e1913', '护理部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:03', '1', '2017-09-26 15:04:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6d1d70dfb20b49878b2e83b46f7e0a3d', '社工部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:33', '1', '2017-09-25 17:07:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6d2695356202452d9515d1be0d9f7a6b', '资材供应部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:33', '1', '2017-09-26 15:30:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6dff9e7b84b347c1b4d37d9a061513f8', '人力资源部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:27', '1', '2017-09-25 17:13:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6e05d6c1e9424d009a08f2a7e7c14166', '投资部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '5', null, '2017-09-26 15:09:34', '1', '2017-09-26 15:09:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('6fbfbff9fc444db58d8514c20f17229a', '养老项目部', '98f9cd1a69524d5d9160255b32b079b2', '3', null, null, '2017-09-26 15:20:17', '1', '2017-09-26 15:20:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('70170deabf1147d2968ee47848a09407', '计划财务部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:25:46', '1', '2017-09-26 15:25:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('70a1b44ac7df4dbd8ab831c3be844a11', '市场营销部', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:25', '1', '2017-09-26 15:12:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('711f5cbf6bdd4e3fb1ad8eff1d10d229', '上海康复医院', 'bcb987a9a28d40d2acec335b70d6354f', '4', '2', null, '2017-09-25 17:20:48', '1', '2017-09-25 17:21:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('71b60d5343084b61a34562fa6c774d84', '管家部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:37', '1', '2017-09-25 17:02:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('72933cf6ca184fc4800bed250f299e25', '培训部', '439521bebd8f4c36982dcd50e2164f3f', '3', '6', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:37', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('72d13ff6010d48d5a819652ec5e330db', '社工部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:55', '1', '2017-09-25 17:10:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('72e65504e529474bbb74e361eba95f94', '环境部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:27', '1', '2017-09-25 17:13:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7388633d961e4c05941d6759f1261741', '成都分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:13', '1', '2017-09-26 15:11:30', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('739bc3a4cf6c424b9790a1abf797ba41', '普外一科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:28', '1', '2017-09-26 15:32:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7461a7b84fef4a6880376f32d74955a5', '大清谷医院（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '7', null, '2017-09-26 14:25:38', '1', '2017-09-26 14:25:52', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('74848f35311e4105b497922c3ee271eb', '粤园门诊部', 'bcb987a9a28d40d2acec335b70d6354f', '4', '3', null, '2017-09-25 17:20:49', '1', '2017-09-25 17:21:14', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('759362689ef049b1996f7a6c997f8906', '杭州项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('75cae5c511a94d15989d2f79e422a68d', '老年医学中心', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:09', '1', '2017-09-26 15:05:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('75d427ea20bd4a1d9086168f1e3f5b9e', '客服部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:51', '1', '2017-09-26 15:14:07', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('764fbc8df6044dbb981c04d026a48303', '战略发展中心', '439521bebd8f4c36982dcd50e2164f3f', '3', '1', null, '2017-09-26 15:35:52', '1', '2017-09-26 15:35:56', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('76a760a5a65541509b7825b1716604a8', '秩序维护部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:28', '1', '2017-09-25 17:13:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('77ab4727c06748eab10a21ee8422e647', '计划财务部', '9699e2ae431e4252be69209ba9ad7db2', '4', null, null, '2017-09-26 15:26:54', '1', '2017-09-26 15:26:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('79312d7be91e4928af5746b79b84aa7a', '投资中心', '3802a8056dac4b0e87614e22cb1c3abc', '2', '8', null, '2017-09-26 15:23:12', '1', '2017-09-26 15:23:18', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7a3225dcb3444d9997f5403059c92fbf', '运行保障部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '5', null, '2017-09-25 17:19:14', '1', '2017-09-25 17:19:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7a617128062c40dab3b82ec0bc007bd8', '楚园养老社区筹备组', 'ce0cb88af66044f28c689863d1bc073f', '4', '6', null, '2017-09-25 17:00:34', '1', '2017-09-25 17:00:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7ab0b537e6774c9da0427143a7e0c2f3', '自用物业项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:23', '1', '2017-09-26 15:21:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7b2269029af14fb387736cc9a50cc847', '总经理室', '9699e2ae431e4252be69209ba9ad7db2', '4', null, null, '2017-09-26 15:27:07', '1', '2017-09-26 15:27:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7b9860ae8f4d4120af4a41d233c40d02', '商业规划部', 'b024d7f9cb964927afe4fa70efcb572e', '3', null, null, '2017-09-26 15:27:55', '1', '2017-09-26 15:28:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7c58a5007e3b481998063cfe435430a6', '南京项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7cecda8655da40faa11735074d7a2413', '楚园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:14', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7d6dc750cf7d455cb9bcc7e9e48478c4', '后勤管理部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:02', '1', '2017-09-26 15:04:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7dc74b6b0a354895b45581176ee20a68', '后勤保障部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:31:13', '1', '2017-09-26 15:31:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7df407aabe484418b12e3e6973f34383', '社工部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:27', '1', '2017-09-25 17:13:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7e279ed82d824ac4abc93b7c254c9b1f', '财务部', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:28', '1', '2017-09-26 15:14:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7e44ed0b1c7848028b6b6b00573e4749', '质量和精益管理部', 'fc4bcdc7b2d04709a607f4ced59bb9ce', '4', null, null, '2017-09-26 15:37:22', '1', '2017-09-26 15:37:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7ed7c32bf34c4dccbc5c18778c1ab3db', '呼吸二科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:27', '1', '2017-09-26 15:31:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7f3c9144afed49afbcc160947be383d0', '金融-客服部', 'bf65f1753b8b4a8c85cb3dbf811011cb', '5', null, null, '2017-09-26 15:18:56', '1', '2017-09-26 15:19:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('7ff3122a01fe4772b9242aec78265093', '契约业务中心', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:48', '1', '2017-09-26 15:11:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8064c4ed19f44078ad744168ee5db6e3', '北京康复_医技科室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:03', '1', '2017-09-26 15:05:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('80869f5fc6884e5caa46b5eab975d644', '胃镜室', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:53', '1', '2017-09-26 15:35:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('80924710ff9443cbb7370fa02d41e7b6', '总经理室', '50079b5ceb014c33b8f563fcc1122f2f', '3', '1', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:15:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8257b25fabb4430bb3f6d1432037c524', '国际-安保部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:28', '1', '2017-09-26 15:19:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('825bd6910573446ea0d007849442154d', '市场营销部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:51', '1', '2017-09-26 15:14:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('827f5b17500d4f448ae81daf4d613e87', '外科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:06:42', '1', '2017-09-26 15:06:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('82c6db6d6c9e4fbda30297117be36f22', '总经理室', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:25:46', '1', '2017-09-26 15:25:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('838a33b208dc4547ad173534f09e246c', '国际-工程部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:28', '1', '2017-09-26 15:19:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('865524cd94e34f9b9869235a75c657eb', '投资部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:26:09', '1', '2017-09-26 15:26:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('865c2249d9ec4eeda2e77e918481f6a7', '销售部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:28', '1', '2017-09-25 17:13:26', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('86b24ef5cb6149a3b563bb5d4a69eb34', '泌尿一科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:28', '1', '2017-09-26 15:32:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('87572492f4cb49609f700ec31e16a717', '燕园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:52', '1', '2017-09-26 15:21:56', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8850747f97774c3b9bedd5dc782c112b', '院长办公室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:02', '1', '2017-09-26 15:04:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('88f2501e114045f793f2f47303e47a1f', '妇产科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:32:34', '1', '2017-09-26 15:33:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('89b7fa2bb8374234808d7cb01029a822', '重症医学科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:37', '1', '2017-09-26 15:34:12', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8a2d689ebb3b4946835fbbd3c30299ec', '市场部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:40', '1', '2017-09-25 17:05:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8b0b3c02240745b4a91d4068e5bcc337', '成本部', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:14', '1', '2017-09-26 15:25:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8b1236130d6d474287d41a700bdd0c6f', '国际-财务部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:28', '1', '2017-09-26 15:19:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8b95ef348974460ea41b8584792de7d6', '养老护理部', '74848f35311e4105b497922c3ee271eb', '5', null, null, '2017-09-26 15:08:52', '1', '2017-09-26 15:08:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8bf5601e34fe4e7e97f1224eafe3f718', '市场部', '0838ef65f48c4ebf9bce4533cc89d2b7', '5', null, null, '2017-09-25 17:11:46', '1', '2017-09-25 17:12:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8cb64193f70d4e91b8193576bcf3505c', '院长室', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:58', '1', '2017-09-26 15:29:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8d51deccf69f4c30b7ec694ca7f61741', '财务部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:50', '1', '2017-09-26 15:13:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8dacea81a03741949420ee4defa09ef7', '社工部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:37', '1', '2017-09-25 17:02:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8ddbe077c88c4be1a6905584f5a7585a', '药剂科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:11', '1', '2017-09-26 15:07:26', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8e02d2ea09334893b7480f7d4150550c', '总经理办公室', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '1', null, '2017-09-26 15:09:33', '1', '2017-09-26 15:09:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('8e4a6d4c50bb486b8b06dc73de6c05ad', '综合办公室', '9699e2ae431e4252be69209ba9ad7db2', '4', null, null, '2017-09-26 15:26:54', '1', '2017-09-26 15:27:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('901bae1f7d154d2aa6cf194062bc2629', '护理部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:53', '1', '2017-09-26 15:08:12', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('901f98251da84bfcb9690f9d1ac6f649', '燕园养老社区', 'ce0cb88af66044f28c689863d1bc073f', '4', '1', null, '2017-09-25 16:59:44', '1', '2017-09-25 16:59:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('902f8901574646879986033250542df2', '泌尿二科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:28', '1', '2017-09-26 15:32:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('905e984a52884b05821fc05727006f3c', '上海-投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:07', '1', '2017-09-26 15:24:14', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9066a90790074a048bc15540bc684a2e', '餐饮部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:55', '1', '2017-09-25 17:10:36', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('90be0f28692047ca8bfba3f346b6b2dd', '市场部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:27', '1', '2017-09-25 17:13:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('910889b255fc4ee0bc89cf32accfa1f5', '禅修院', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:12:59', '1', '2017-09-26 15:13:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9109eda5b04340f79e31468a9529cf72', '销售部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:39', '1', '2017-09-25 17:04:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('91dc44ba5c3a4dbaa25b8ad2d90e3d6c', '人力资源部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:41', '1', '2017-09-25 17:05:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('92c89dcc6a934c7789fcf7c0427b8162', '心功能室', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:37', '1', '2017-09-26 15:34:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('93938c80313b4e159f254cd0d76e2fa9', '创新二期-安保部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:46', '1', '2017-09-26 15:17:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('93ac18d6a11e4995bfea8e51726ca197', '综合办公室', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:47', '1', '2017-09-26 15:26:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('93c6ca3c41bc419cbf367c43c4958fd2', '运营管理部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:56', '1', '2017-09-26 15:08:47', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('93f0d41f42de47fdbe27d9285e868646', '行政办公室', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:01:41', '1', '2017-09-25 17:05:22', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('93f19ab5284c4e3cace5e7cd34c45f53', '创新一期-综合部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:18:33', '1', '2017-09-26 15:18:39', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9465f51891694593979d975492ba65cf', '病案室', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:29:00', '1', '2017-09-26 15:30:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('954f2c33ae7b44908390e2a563be11d3', '小汤山分公司', '3802a8056dac4b0e87614e22cb1c3abc', '2', '11', null, '2017-09-26 15:28:21', '1', '2017-09-26 15:28:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9699e2ae431e4252be69209ba9ad7db2', '广州业务发展中心', '1db93b45b8a74c9e8f0541bcb81bc491', '3', '2', null, '2017-09-26 15:24:55', '1', '2017-09-26 15:25:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('96e96e8fc28442d69d2f90e069b58c6f', '计划财务部', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:25', '1', '2017-09-26 15:26:37', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('97445e077e21491cafa3c1d387aaaa00', '总裁室', '61bcaea0de1f4143a3e5633590c06e44', '3', null, null, '2017-10-18 11:16:06', '1', '2017-10-18 11:16:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('981980a16f9a48d59535c5e5cfa04a6f', '王府井一号项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:23', '1', '2017-09-26 15:21:30', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('98f9cd1a69524d5d9160255b32b079b2', '开发事业部', '3802a8056dac4b0e87614e22cb1c3abc', '2', '7', null, '2017-09-26 15:09:10', '1', '2017-09-26 15:20:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9938dd0493324dbd94c4296579cbf643', 'CBD项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:23', '1', '2017-09-26 15:21:26', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('99739ce3330c402f861e243cfcb32110', '总经理室', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:06:46', '1', '2017-09-25 17:07:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('99a4838f8ab74fa882a4ff4dfed00d3b', '陵园市场部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:13:25', '1', '2017-09-26 15:13:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('99fbcb79c1704291a4de931136c7c422', '市场销售部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:56', '1', '2017-09-26 15:06:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9afc1b394be6475ca54d757cee07febf', '本部培训', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:53', '1', '2017-09-26 15:31:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9b050f27c7104945a9ffa1975295e842', '总经理室', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:13', '1', '2017-09-26 15:25:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9b7975ff9b19493a963806db8d51d6f2', '健康管理中心', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:03', '1', '2017-09-26 15:05:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9d0f3f395d984bfe9d6706fe70c40f39', '青岛项目部 ', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:54', '1', '2017-09-26 15:22:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9d1b0ad7466449dc966ccd55b1d05902', '品牌市场部', '439521bebd8f4c36982dcd50e2164f3f', '3', '7', null, '2017-09-26 15:36:37', '1', '2017-09-26 15:36:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9e4454f306ce47c98bb7b413112771b8', '创新一期-安保部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:18:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9e77be09adec45879d49fb184cb15eb3', '内分泌科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:25', '1', '2017-09-26 15:31:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9e9e69fc3f5d4740ae5514ce174fa584', '计划财务部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:36', '1', '2017-09-25 17:08:39', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('9f248f42c4f74ccbaff46170ab76fd1c', '病理科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:37', '1', '2017-09-26 15:34:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a07b1824a2d14a48bba31a8eae8d2ed8', '园区发展部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '6', null, '2017-09-25 17:19:14', '1', '2017-09-25 17:19:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a31c3300b8b34cd598cd91efa7081582', '药剂科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:26', '1', '2017-09-26 15:34:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a47a24527f3b4b79a4913ddb5c23fbd6', '合规法务部', '439521bebd8f4c36982dcd50e2164f3f', '3', '8', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a4cd208377af4d35ab1e521a5d2d57a0', '经营规划部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '6', null, '2017-09-26 15:10:14', '1', '2017-09-26 15:10:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a57fc391db3a49cfb7a8e6691cfde796', '环境部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:11:21', '1', '2017-09-25 17:11:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a58352972e684a4eb21ba09c5956d649', '竹茶园经营公司', '5b6691a27bca4fecb9b2393d681fa725', '4', '5', null, '2017-09-26 15:10:55', '1', '2017-09-26 15:11:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '蜀园养老社区筹备组', 'ce0cb88af66044f28c689863d1bc073f', '4', '4', null, '2017-09-25 17:00:19', '1', '2017-09-25 17:00:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a62c97e89fe0424d9f7aa888f6e959cb', '三亚项目部', 'b024d7f9cb964927afe4fa70efcb572e', '3', null, null, '2017-09-26 15:27:54', '1', '2017-09-26 15:27:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a6c9c9dd11234cc79cc048116bbf901c', '国际-客服部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:28', '1', '2017-09-26 15:19:49', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a76954ec56474f628cb957aac08eab4b', '金融-工程部', 'bf65f1753b8b4a8c85cb3dbf811011cb', '5', null, null, '2017-09-26 15:18:56', '1', '2017-09-26 15:19:07', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a7af4cda801045c0adf34daf174fa887', '产品技术中心', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:13', '1', '2017-09-26 15:11:26', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a7c9ed9420cd474c8ecbea5d571dafab', '消化内科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:27', '1', '2017-09-26 15:32:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('a8a30cf44ab84da89e18671720d1bf69', '深圳分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:49', '1', '2017-09-26 15:12:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('aafe68d4ff9b430481f160ff6398a1c0', '总经理办公室', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:28', '1', '2017-09-26 15:14:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ab3f61ea7198484b8e05c108446bc86b', '管家部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:54', '1', '2017-09-25 17:10:23', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('abecc32e35884241890e92824ad671ca', '创新二期-工程部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:17:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('aca3dcb83a5f44d3915d1cff70df2cc6', '销售部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:34', '1', '2017-09-25 17:08:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('acd4263a1cc048feab4d6883e27bc9fc', '采购中心', '439521bebd8f4c36982dcd50e2164f3f', '3', '2', null, '2017-09-26 15:35:52', '1', '2017-09-26 15:36:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('acf6b8589b9348c78c505e45978985f2', '体检中心', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:26', '1', '2017-09-26 15:34:47', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('acfd2f9ae4b548359712b41e5aa5cb61', '事业部本部', 'c5d8a73062a14900b587affcb48386f7', '3', null, null, '2017-09-25 17:18:04', '1', '2017-09-25 17:18:46', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ad3d9a093aee40fe9bdbbf2c09de529a', '肿瘤科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:36', '1', '2017-09-26 15:33:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ae304cfacc3b4d7cba02653a6b6871e6', '总经理室', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '1', null, '2017-09-26 15:23:33', '1', '2017-09-26 15:23:36', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ae8a3e757b6b46c7830d4b93a019db40', '资产管理部', '05893cc4005044fe80d6a22f95575701', '4', '5', null, '2017-09-25 16:57:35', '1', '2017-09-25 16:58:19', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('aeabbd2395c547f88d44181fb2c1b056', '工程园林部', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:28', '1', '2017-09-26 15:14:41', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('aeeeac3e0eee44549eeebca69fa00b0e', '计划财务部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:53', '1', '2017-09-26 15:08:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b0222338ee094d74835c5110c874a34a', '销售部', '7a617128062c40dab3b82ec0bc007bd8', '5', null, null, '2017-09-25 17:13:57', '1', '2017-09-25 17:14:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b024d7f9cb964927afe4fa70efcb572e', '海南分公司', '3802a8056dac4b0e87614e22cb1c3abc', '2', '10', null, '2017-09-26 15:23:13', '1', '2017-09-26 15:27:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b1a4c7ecce6347eab5c964f1076e3254', '客服部', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:28', '1', '2017-09-26 15:14:46', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b1a680ae2631449aa85b7bac9d9595c1', '医养股权投资部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '6', null, '2017-09-26 15:23:34', '1', '2017-09-26 15:23:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b35eb89229a247d0a0696e2f1e2e493d', '医学检验科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:26', '1', '2017-09-26 15:34:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b39d17a1b3264ac194169ea385456f91', '楚商大厦项目部', '51c885d5a37f4ecea576d1295be8aacd', '4', null, null, '2017-09-26 15:21:24', '1', '2017-09-26 15:21:43', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b3cca4b8b4044b3c997a5caf831d3e19', '申园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:52', '1', '2017-09-26 15:22:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b3ef964b615c4e448ffbde43c6130a91', '医务部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:58', '1', '2017-09-26 15:29:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b3f6d6f537eb46f99ad4e8b143ba50a5', '临床辅诊科室', 'be2d7eb65c55454c93d37192a457511e', '3', null, null, '2017-09-26 15:28:21', '1', '2017-09-26 15:39:28', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b4a6e8bd26134571b846f4bab044f70c', '工程园林部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:51', '1', '2017-09-26 15:14:03', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b5bf1cfb1a8c4c49902486ce0e794271', '综合办公室', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:26:09', '1', '2017-09-26 15:26:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b64537c162bd4449b4e9d8316a315e5b', '粤园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b6e9fd7d0d5e43579dff00c5f14ec541', '医学影像科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:51', '1', '2017-09-26 15:35:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b71781768bc94eaf93f4e04c63a0fd06', '计划财务部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:11:21', '1', '2017-09-25 17:11:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b78194c9955e49e18f605bf2782e8696', '管家部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:06:47', '1', '2017-09-25 17:07:27', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b85079ef71814a9bba22592ea3bfd909', '复兴门诊所', 'bcb987a9a28d40d2acec335b70d6354f', '4', '8', null, '2017-09-26 14:23:49', '1', '2017-09-26 14:24:19', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b95f11389d9c4974bfa9e2490fae8b7f', '项目运营部', '09091770ead142508cf208fbc2256b29', '4', '5', null, '2017-09-26 15:20:44', '1', '2017-09-26 15:21:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('b984db04cebd4ea69535fa8277e9a5ec', '人力资源部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:03', '1', '2017-09-26 15:04:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ba25578cf2ea43228bee8db43b53c8a1', '泰康保险大厦物管处', '50079b5ceb014c33b8f563fcc1122f2f', '3', '4', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:15:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ba642ecceace4abdbd2780c5fff328f0', '投资部', 'b024d7f9cb964927afe4fa70efcb572e', '3', null, null, '2017-09-26 15:27:55', '1', '2017-09-26 15:28:07', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('baa619d46fcc4ff79af51d0078070858', '行政办公室', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:11:20', '1', '2017-09-25 17:11:25', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bac6b61c6b2a419b9f149a8c31e29a16', '国际医疗城（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '9', null, '2017-09-26 14:23:50', '1', '2017-09-26 14:25:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bb99c9055e43440e89cb04003e9a97bc', '医疗项目部', '98f9cd1a69524d5d9160255b32b079b2', '3', null, null, '2017-09-26 15:20:17', '1', '2017-09-26 15:20:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bbe8d9f75d6f43b7a682733302251045', '销售管理部', 'c87e5b1d8c4e4fa9ade489d1626a89f6', '5', null, null, '2017-09-26 13:37:00', '1', null, null);
INSERT INTO `tb_linkage_pull_data` VALUES ('bbf071fe95cb4700b93b3f95942bd321', '运营管理部', '05893cc4005044fe80d6a22f95575701', '4', '4', null, '2017-09-25 16:57:38', '1', '2017-09-25 16:58:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bcb987a9a28d40d2acec335b70d6354f', '一线经营单位', 'c5d8a73062a14900b587affcb48386f7', '3', null, null, '2017-09-25 17:18:04', '1', '2017-09-25 17:18:51', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bdb26d960f6a42aaa7efea328b762b6a', '社区医务室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:08', '1', '2017-09-26 15:05:19', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('be03ecbf4ba14609aa55678e81a0aa9b', '市场部', '7a617128062c40dab3b82ec0bc007bd8', '5', null, null, '2017-09-25 17:13:40', '1', '2017-09-25 17:13:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('be2d7eb65c55454c93d37192a457511e', '泰康仙林鼓楼医院', '3802a8056dac4b0e87614e22cb1c3abc', '2', '12', null, '2017-09-26 15:28:21', '1', '2017-09-26 15:38:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bf1a833e34aa4e1e8ebbca968b4ae367', '数据中心-工程部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:18:34', '1', '2017-09-26 15:18:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bf65f1753b8b4a8c85cb3dbf811011cb', '金融大厦物管处', 'dd187849e7364754bb76125d54828e9b', '4', null, null, '2017-09-26 15:16:54', '1', '2017-09-26 15:17:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bf6c533d119e404ab21870866eb73b61', '创新二期-客服部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:18:07', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bf782cba2510470fb607d7f03487ad4f', '院长办公室', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:58', '1', '2017-09-26 15:29:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('bfa1ac8694c64709b89a744af60fe392', '吴园医院（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '10', null, '2017-09-26 14:23:50', '1', '2017-09-26 14:25:36', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c08f0adf7855404abc63fb05565442c0', '急诊医学科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:36', '1', '2017-09-26 15:33:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c094b8ae9ead4d0d9c8df7056bc6f99e', '工程部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:08:55', '1', '2017-09-25 17:10:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c1191f5cbaab448184c216975ac62040', '中医科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:36', '1', '2017-09-26 15:34:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c2d7d5e787c140449f628cbbc3b8dcd1', '养老社区报编辑部', '439521bebd8f4c36982dcd50e2164f3f', '3', '13', null, '2017-09-26 15:36:37', '1', '2017-09-26 15:36:57', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c2e1c6ec8d1c4ea997bc5052fc82b2ae', '后勤服务部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:52', '1', '2017-09-26 15:08:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c2e7d5061d3148369eeddf60dc373c29', '设计部', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:14', '1', '2017-09-26 15:25:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c34063d9644847aa85966b6c810b74f7', '口腔科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:57', '1', '2017-09-26 15:06:37', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c354e1c66c5349be93a7c4f71126c05b', '综合部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '7', null, '2017-09-26 15:09:36', '1', '2017-09-26 15:09:58', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c41bd043bd9e4777a2488befdf4784ff', '新生儿科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:32:34', '1', '2017-09-26 15:33:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c50cee0dae90453590820c854a7ddf47', '护理部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:28:59', '1', '2017-09-26 15:30:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c5d8a73062a14900b587affcb48386f7', '医疗发展事业部', '3802a8056dac4b0e87614e22cb1c3abc', '2', '4', null, '2017-09-25 17:17:54', '1', '2017-09-25 17:18:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c626348c00774e70ac476a3559113618', '计划财务部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:27', '1', '2017-09-25 17:13:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c6df9e9fe27544af88551709d9844731', '康复中心', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:53', '1', '2017-09-26 15:08:20', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c7cf21ec15c04a7a92cb1bfdfdd658f9', '三亚养老社区筹备组', 'ce0cb88af66044f28c689863d1bc073f', '4', '7', null, '2017-09-25 17:00:35', '1', '2017-09-25 17:00:52', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c819d6e46fb846fc97b3be2761a56ed0', '计划财务部', '61144b1658fe469088fad3ebdc8ff6ec', '4', null, null, '2017-09-26 15:25:14', '1', '2017-09-26 15:25:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c81e58b1a5e14dc0a4b57ff003945343', '纪念园事业部', '3802a8056dac4b0e87614e22cb1c3abc', '2', '5', null, '2017-09-26 15:09:09', '1', '2017-09-26 15:09:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c87e5b1d8c4e4fa9ade489d1626a89f6', '营销中心', '05893cc4005044fe80d6a22f95575701', '4', '3', null, '2017-09-25 16:57:54', '1', '2017-09-25 16:59:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c8d06b44325244579ae08a72a71d39fc', '总经理办公室', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:50', '1', '2017-09-26 15:13:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('c9c0a941f11f41d99c105881e68079aa', '天津分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:49', '1', '2017-09-26 15:12:14', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ca3e3c325c08431db29d8d026515ef5a', '人力资源部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:10:53', '1', '2017-09-25 17:11:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cad63256c3174488a24ad75880d46331', '人力资源部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:29:00', '1', '2017-09-26 15:30:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cb5ebe67e3a74164a38e441c5a9fe358', '杭州养老社区筹备组', 'ce0cb88af66044f28c689863d1bc073f', '4', '8', null, '2017-09-25 17:00:53', '1', '2017-09-25 17:01:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cc3c2da4ddb44b7f843a6fbb5f579e6f', '金融-综合部', 'bf65f1753b8b4a8c85cb3dbf811011cb', '5', null, null, '2017-09-26 15:18:57', '1', '2017-09-26 15:19:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cc9fe1d5705d4954af34467f3cb9b8ab', '国际-VIP服务部', '24f71405ba164306a817cdd277b67578', '5', null, null, '2017-09-26 15:19:27', '1', '2017-09-26 15:19:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cd2c99fe8254488a930f4552cc2112ca', '创新二期-综合部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:18:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cd2d9f869c494592bcea2ba2e6c94390', '健康产业教育学院', '439521bebd8f4c36982dcd50e2164f3f', '3', '14', null, '2017-09-26 15:36:37', '1', '2017-09-26 15:37:02', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ce0cb88af66044f28c689863d1bc073f', '一线经营单位', '373f39f029634ee5a60d376a47d1f1cc', '3', null, null, '2017-09-25 16:57:02', '1', '2017-09-25 16:57:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ce9076d0bd99496ea93792d1b4a4f9e2', '计划财务部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '8', null, '2017-09-26 15:09:37', '1', '2017-09-26 15:10:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cee9c6eb987642f5bf9715a01a165bbb', '市场营销部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '7', null, '2017-09-25 17:19:14', '1', '2017-09-25 17:19:50', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cef704ad096c48d694aaaa399a48b3fa', '医技部', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:53', '1', '2017-09-26 15:08:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cf3534aa1d2b4c768157725ae67b002b', '行政办公室', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:26', '1', '2017-09-25 17:12:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('cf66395518a241c7b05175fcc220c7a9', '产品策划研发部', '09091770ead142508cf208fbc2256b29', '4', '6', null, '2017-09-26 15:20:44', '1', '2017-09-26 15:20:56', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d132cd6c11bb42578a75db5389e6bd33', '武汉分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:49', '1', '2017-09-26 15:12:19', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d255868aaf244e888c135284f97f3e9d', '前期部', '09091770ead142508cf208fbc2256b29', '4', '7', null, '2017-09-26 15:20:43', '1', '2017-09-26 15:20:52', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d2dca17946484ee1a9952607a86ea37b', '人力资源部', '439521bebd8f4c36982dcd50e2164f3f', '3', '9', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d36ca3878f0140608e7402de7ebf170b', '创新二期-餐饮部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:17:47', '1', '2017-09-26 15:17:55', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d3f158050ad54d26860c15b24a5d14fa', '不动产投资部', '4dc1de49e7af404bb648c3b4fc3e84be', '4', '7', null, '2017-09-26 15:23:33', '1', '2017-09-26 15:23:40', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d412dcb912f14850ab6cc40b6cd6365e', '财务部', '5c4013b6a32847308a0336c305bd9c61', '5', null, null, '2017-09-26 15:12:25', '1', '2017-09-26 15:12:36', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d5cc8253d22c40568a30cb3cc8ebb9c7', '营销部', '14f18f59b9af4a8db2ff7e366582fd3d', '4', '9', null, '2017-09-26 15:09:37', '1', '2017-09-26 15:10:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d6126337717c4cd28c8a2daf9b8586d9', '蜀园医院（筹）', 'bcb987a9a28d40d2acec335b70d6354f', '4', '11', null, '2017-09-26 14:23:50', '1', '2017-09-26 14:25:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d6371c19576448c8af349e393cb800b2', '医疗临床科室', '711f5cbf6bdd4e3fb1ad8eff1d10d229', '5', null, null, '2017-09-26 15:07:55', '1', '2017-09-26 15:08:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d66bef91fab94647b55b6ac02b576084', '管理部门', 'be2d7eb65c55454c93d37192a457511e', '3', null, null, '2017-09-26 15:28:40', '1', '2017-09-26 15:28:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d87978e90f1e4b44b73de77c5e014b93', '手术室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:56', '1', '2017-09-26 15:06:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d8835eef58404c52ac4601234354d379', '工程部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:26', '1', '2017-09-25 17:12:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d93217f82fb34b86938086e09dc9eb4f', '稽核风控部', '439521bebd8f4c36982dcd50e2164f3f', '3', '4', null, '2017-09-26 15:36:37', '1', '2017-09-26 15:36:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('d9646086bf7449de85e22c8e081cb044', '国际交流部', 'acfd2f9ae4b548359712b41e5aa5cb61', '4', '8', null, '2017-09-25 17:19:14', '1', '2017-09-25 17:20:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('da65615c22164c87aa57979a0f300b99', '放射科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:11', '1', '2017-09-26 15:07:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('db14ff75fb4c42578437c3cf21b97766', '陵园业务中心', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:14', '1', '2017-09-26 15:11:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('db60fa54f23a4da186b9411e6e999138', '投资部', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:25', '1', '2017-09-26 15:26:45', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dc4453e035744ba4a829602724e22986', '工程部', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:34', '1', '2017-09-25 17:07:56', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dd187849e7364754bb76125d54828e9b', '物业管理中心', '50079b5ceb014c33b8f563fcc1122f2f', '3', '5', null, '2017-09-26 15:16:32', '1', '2017-09-26 15:16:53', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dd53c5cefa994d56bef4f73d8bdfd42c', '内科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:09', '1', '2017-09-26 15:05:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dd6d4150888a451c88910d42e21fbc8f', '总经理室', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:25', '1', '2017-09-25 17:12:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dd9791d2a8e641c888624d6dc66d54af', '武汉-投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:08', '1', '2017-09-26 15:24:23', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('de77d76e1fdd45208c4cde013d2cdb65', '麻醉科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:56', '1', '2017-09-26 15:06:06', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('dffe11a93ee64b54ac723d9a71689b8f', '成本部', '19193d16da8c4171999fc488adb3ba9d', '4', null, null, '2017-09-26 15:26:25', '1', '2017-09-26 15:26:32', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e0b3c5e57d9e466f8055da191cd27aba', '品牌市场部', '00b1fab412504963bf2d2b862e5ba397', '5', null, null, '2017-09-26 15:13:51', '1', '2017-09-26 15:14:12', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e172505126254af299a9a3755441b1d4', '门诊医学科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:51', '1', '2017-09-26 15:34:56', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e36516aa9f8e4c2fa0009aecc9d51144', '耳鼻喉科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:57', '1', '2017-09-26 15:06:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e393aa140254472fb91d8b1aaa5b012f', '企划部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:13:25', '1', '2017-09-26 15:13:37', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e4aca05911e64998b44fdbbd7f7580a0', '计划财务部', '50079b5ceb014c33b8f563fcc1122f2f', '3', '6', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:15:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e4e8a55a0bd5488dac0767966f38aea3', '行政办公室', '3717ceb7addb4dfe8a55bedc5079fc19', '5', null, null, '2017-09-25 17:07:36', '1', '2017-09-25 17:08:31', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e562f91c331b4892a0951d22a7ea4550', '放射科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:34:25', '1', '2017-09-26 15:34:34', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e5a4c3b5b08c437ca937b546034fab9c', '麻醉手术科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:33:36', '1', '2017-09-26 15:34:08', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e5ba959df2a34a66a70426ddaddb2727', '蜀园项目部', '6fbfbff9fc444db58d8514c20f17229a', '4', null, null, '2017-09-26 15:21:53', '1', '2017-09-26 15:22:18', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e5f3335cd02e44a696d1830bcec3a5d6', '神经内科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:25', '1', '2017-09-26 15:31:38', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e791c2bb6dc14ebb844d004cefa93562', '成都-投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:08', '1', '2017-09-26 15:24:27', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('e907926d29fd4b2082cab991d75f6307', '市场部', 'f6537945f0ad4d42b690a5ac2e751e9b', '5', null, null, '2017-09-25 17:10:51', '1', '2017-09-25 17:11:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ea038fe1461b486cad3f8e7d076157f5', '资产管理部', '50079b5ceb014c33b8f563fcc1122f2f', '3', '7', null, '2017-09-26 15:15:21', '1', '2017-09-26 15:16:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ea4cc86cfbb349d19154b2e1f356b295', '总监室', '05893cc4005044fe80d6a22f95575701', '4', '2', null, '2017-09-25 16:57:31', '1', '2017-09-25 16:58:05', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ea6c391e5a3f466d9aa8875135e8b91a', '罗浮山经营公司 ', '5b6691a27bca4fecb9b2393d681fa725', '4', '3', null, '2017-09-26 15:10:24', '1', '2017-09-26 15:10:48', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('eab23fe2bf134ec080bd4d1a9f90e297', '财务企划部', '439521bebd8f4c36982dcd50e2164f3f', '3', '11', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('eadb1208f39b47c2ae33c98d36bef31a', '数据中心-安保部', 'f9d8d24d279a455e9c09fb02745c0dee', '5', null, null, '2017-09-26 15:18:34', '1', '2017-09-26 15:18:44', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('eb7573fcec874e399c88d6e3d5516ecc', '爱佑汇', '5b6691a27bca4fecb9b2393d681fa725', '4', '1', null, '2017-09-26 15:10:23', '1', '2017-09-26 15:10:27', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ebdc1d94a7674f94910df1d619454ea5', '陵园客服部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:13:00', '1', '2017-09-26 15:13:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ecd8f7adbed2402a9e17ab2c44587ade', '透析室', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:10', '1', '2017-09-26 15:07:16', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ede7315f0aed469aa69a66928ca9fdc6', '财务会计部', '439521bebd8f4c36982dcd50e2164f3f', '3', '12', null, '2017-09-26 15:35:53', '1', '2017-09-26 15:36:15', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ee0a7c12f0f646c787e23acb20ee65d8', '营养科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:06:44', '1', '2017-09-26 15:07:04', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ee90b0c0ed564d4d83071ca8027c7068', '广州-投资部', '3f3bc07705644c98b4704ed73b55d68c', '4', null, null, '2017-09-26 15:24:07', '1', '2017-09-26 15:24:19', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('eea31e9830024d1bbd1457e1a15a52e5', '行政管理部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:02', '1', '2017-09-26 15:04:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ef078ab0dc1b4ab580aeecf11353ef20', '检验科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:12', '1', '2017-09-26 15:07:35', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('efafecdeb6fe4443b994e7790dcc9e0a', '合规法务部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:29:00', '1', '2017-09-26 15:30:24', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f1d37153d8734641a86c6c7eb3dd8ec7', '环境部', '901f98251da84bfcb9690f9d1ac6f649', '5', null, null, '2017-09-25 17:05:37', '1', '2017-09-25 17:05:41', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f3db2853b190424cb69c43d35d97d04e', '影像科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:38', '1', '2017-09-26 15:07:42', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f3e15adb19e9489ca80e7285b3d76a45', '金融-安保部', 'bf65f1753b8b4a8c85cb3dbf811011cb', '5', null, null, '2017-09-26 15:18:53', '1', '2017-09-26 15:18:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f3e577d4bcfa4adfaf2beab77a4f6aea', '消毒供应科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:35:10', '1', '2017-09-26 15:35:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f5bd3111f5d947ee957c36a82597d211', '疼痛科', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:05:09', '1', '2017-09-26 15:05:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f6537945f0ad4d42b690a5ac2e751e9b', '粤园养老社区', 'ce0cb88af66044f28c689863d1bc073f', '4', '3', null, '2017-09-25 16:59:50', '1', '2017-09-25 17:00:11', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f76b0ca19376439d96690f05ebebbabb', '总监室', '3802a8056dac4b0e87614e22cb1c3abc', '2', '2', null, '2017-10-17 13:03:04', '1', '2017-10-17 13:03:07', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f9a28d4be0f84094ad83626a87b7b1cf', '医疗养老投资团队', '9699e2ae431e4252be69209ba9ad7db2', '4', null, null, '2017-09-26 15:26:54', '1', '2017-09-26 15:27:01', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('f9d8d24d279a455e9c09fb02745c0dee', '创新中心物管处', 'dd187849e7364754bb76125d54828e9b', '4', null, null, '2017-09-26 15:16:54', '1', '2017-09-26 15:17:10', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fa96c07fea1342deab05c7b5de8dad81', '眼科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:32:35', '1', '2017-09-26 15:33:30', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('faf0dc88ffc5474eb4e909ab108f7d84', '肾内科', 'b3f6d6f537eb46f99ad4e8b143ba50a5', '4', null, null, '2017-09-26 15:31:27', '1', '2017-09-26 15:32:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fb0081413c5e4e87a45c3b816f6962a4', '成本部', '6866f69d79fe44e9865eaa42fa1b520b', '4', null, null, '2017-09-26 15:25:46', '1', '2017-09-26 15:25:54', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fc4bcdc7b2d04709a607f4ced59bb9ce', '运营中心', '439521bebd8f4c36982dcd50e2164f3f', '3', '3', null, '2017-09-26 15:35:52', '1', '2017-09-26 15:36:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fc8ba81e69bd4751b4cfb6b7ce53d801', '运营部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:04:02', '1', '2017-09-26 15:04:27', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fcb22b33233d4fc9b80c7f5497e999c0', '餐饮部', 'a5ee69c29e1f4b9c9ec9c91b1ff5c44e', '5', null, null, '2017-09-25 17:12:25', '1', '2017-09-25 17:12:39', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fd3ebf5161914df5af552476da9b245c', '财务部', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:29:00', '1', '2017-09-26 15:30:29', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fe58b4fd890242bdb1fd79f2bc23fd5e', '养老护理部', '1078a0dd11414aa39aaf0a34cd2da92a', '5', null, null, '2017-09-26 15:07:10', '1', '2017-09-26 15:07:21', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('fed4c2ac3f244c539c7e776664107dec', '广州医学中心项目部', 'bb99c9055e43440e89cb04003e9a97bc', '4', null, null, '2017-09-26 15:22:48', '1', '2017-09-26 15:23:00', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ff43f400e5094d259effdea40c87a739', '综合部', 'a58352972e684a4eb21ba09c5956d649', '5', null, null, '2017-09-26 15:14:49', '1', '2017-09-26 15:14:59', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ff452c55f91042a68429d4bdc7f689a7', '工程园林部', 'ea6c391e5a3f466d9aa8875135e8b91a', '5', null, null, '2017-09-26 15:12:59', '1', '2017-09-26 15:13:17', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ff831d08f7e14a12a66be9db7e61e183', '医保办', 'd66bef91fab94647b55b6ac02b576084', '4', null, null, '2017-09-26 15:30:32', '1', '2017-09-26 15:30:36', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ff8c6a250c6c48d0acc815adc4266221', '总经理办公室', '05893cc4005044fe80d6a22f95575701', '4', '1', null, '2017-09-25 16:57:34', '1', '2017-09-25 16:58:13', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ffa3f53bab34425db8502debf5aaa99b', '杭州分部', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:13', '1', '2017-09-26 15:11:39', '1');
INSERT INTO `tb_linkage_pull_data` VALUES ('ffb6c2044f23444db09dc7225c391852', '人力行政中心', 'eb7573fcec874e399c88d6e3d5516ecc', '5', null, null, '2017-09-26 15:11:48', '1', '2017-09-26 15:11:57', '1');

-- ----------------------------
-- Table structure for `tb_pictures`
-- ----------------------------
DROP TABLE IF EXISTS `tb_pictures`;
CREATE TABLE `tb_pictures` (
  `PICTURES_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `NAME` varchar(255) DEFAULT NULL COMMENT '文件名',
  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `MASTER_ID` varchar(255) DEFAULT NULL COMMENT '属于',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PICTURES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_pictures
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_questionnaire`
-- ----------------------------
DROP TABLE IF EXISTS `tb_questionnaire`;
CREATE TABLE `tb_questionnaire` (
  `questionnaireId` varchar(100) NOT NULL COMMENT '问卷id',
  `title` text COMMENT '问卷标题(名称)',
  `preface` text COMMENT '卷首语',
  `volumeHeader` varchar(255) DEFAULT NULL COMMENT '卷头',
  `releaseStatus` varchar(30) DEFAULT NULL COMMENT '发布状态[0、未发布. 1、回收中(已发布). 2、回收完成. 3、历史问卷]',
  `questionUrl` varchar(255) DEFAULT NULL COMMENT '问卷地址Url',
  `qrCodePath` text COMMENT '二维码图片',
  `respondentsParentId` varchar(255) DEFAULT NULL COMMENT '调查对象的父类类型id---此数据存在字典表',
  `respondents` varchar(255) DEFAULT NULL COMMENT '受访者(调查对象)',
  `description` varchar(255) DEFAULT NULL COMMENT '备注/描述',
  `startTime` varchar(100) DEFAULT NULL COMMENT '问卷的开始时间',
  `endTime` varchar(100) DEFAULT NULL COMMENT '问卷结束回答问卷的时间',
  `validState` int(11) DEFAULT NULL COMMENT '有效状态',
  `createUser` varchar(100) DEFAULT NULL COMMENT '创建人',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifyUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `logoImgId` varchar(100) DEFAULT NULL COMMENT '''logo资源名称：存储在附件资源中 附件[ID、Title、存储位置、附件格式]''',
  `backgroundImgId` varchar(100) DEFAULT NULL COMMENT '''背景图片''',
  `backMusic` varchar(100) DEFAULT NULL COMMENT '背景音乐名称',
  `backMusicSwith` bit(1) DEFAULT b'1' COMMENT '背景音乐开关1表示开启0表示关闭',
  `finishBackground` varchar(100) DEFAULT NULL COMMENT '问卷提交完成的页面选择,flowerModel鲜花模式。usualModel常规模式',
  `hospitalCode` varchar(100) DEFAULT NULL COMMENT '医院编码',
  `interfaceCode` varchar(100) DEFAULT NULL COMMENT '医院对应的接口的编码',
  `bootomType` varchar(1000) DEFAULT NULL COMMENT '星级问卷底部logo',
  `questionnaireType` varchar(100) DEFAULT NULL COMMENT '问卷类型（1表示普通问卷-common_questionnaire，2表示星级问卷---star_level_questionnaire）',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '结果表是否有效1表示有效0表示无效',
  `CREATE_USER` varchar(100) DEFAULT NULL,
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`questionnaireId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新问卷';

-- ----------------------------
-- Records of tb_questionnaire
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_questionnaire_results`
-- ----------------------------
DROP TABLE IF EXISTS `tb_questionnaire_results`;
CREATE TABLE `tb_questionnaire_results` (
  `questionResultId` varchar(100) NOT NULL DEFAULT '' COMMENT '问卷回收结果ID',
  `questionnaireId` varchar(100) DEFAULT NULL COMMENT '问卷编号',
  `questionId` varchar(100) DEFAULT NULL COMMENT '问题编号ID',
  `batch_id` varchar(100) NOT NULL,
  `types` varchar(20) DEFAULT NULL COMMENT '题型(单选、多选)',
  `score` int(11) DEFAULT NULL COMMENT '分值',
  `answerResult` text COMMENT '回答结果',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '问题备注',
  `terminalIP` varchar(100) DEFAULT NULL COMMENT '终端机IP',
  `mac` varchar(100) DEFAULT NULL COMMENT 'MAC地址',
  `createUser` varchar(100) DEFAULT NULL COMMENT '答题人',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '答题时间',
  `modifyUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `respondentCode` varchar(100) DEFAULT NULL COMMENT '调查对象',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '结果表是否有效1表示有效0表示无效',
  `column1` varchar(100) DEFAULT NULL,
  `column2` varchar(100) DEFAULT NULL,
  `column3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`questionResultId`),
  KEY `FK_Reference_7` (`questionnaireId`) USING BTREE,
  KEY `FK_Reference_8` (`questionId`) USING BTREE,
  CONSTRAINT `tb_questionnaire_results_ibfk_1` FOREIGN KEY (`questionnaireId`) REFERENCES `tb_questionnaire` (`questionnaireId`),
  CONSTRAINT `tb_questionnaire_results_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `tb_questions` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问卷回收结果; InnoDB free: 10240 kB; (`questionnaireId`) REFER `fh';

-- ----------------------------
-- Records of tb_questionnaire_results
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_questionnaire_temp`
-- ----------------------------
DROP TABLE IF EXISTS `tb_questionnaire_temp`;
CREATE TABLE `tb_questionnaire_temp` (
  `questionId` varchar(100) NOT NULL COMMENT '编号ID',
  `allBatchId` varchar(100) NOT NULL COMMENT '导入的批次号',
  `batchId` varchar(100) NOT NULL,
  `isQuestionnaire` varchar(100) NOT NULL COMMENT '字段判断是问卷还是问题：questionnaire表示问卷，question表示问题',
  `preface` text COMMENT '卷首语',
  `questionnaireId` varchar(100) DEFAULT NULL COMMENT '问卷id',
  `parentId` varchar(100) DEFAULT NULL COMMENT '所属父级ID',
  `questionCode` varchar(100) DEFAULT NULL COMMENT '问题代码',
  `title` varchar(255) DEFAULT NULL COMMENT '问题题目',
  `level` text COMMENT '问题类型(级别)',
  `classification` varchar(20) DEFAULT NULL COMMENT '问题等级:卷头、一级分类、二级分类',
  `types` varchar(20) DEFAULT NULL COMMENT '题型(单选、多选)',
  `scaleType` varchar(20) DEFAULT NULL COMMENT '量表类型',
  `scaleRange` int(11) DEFAULT NULL COMMENT '量表范围',
  `questionData` text COMMENT '数据',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段',
  `mustFlag` int(11) DEFAULT '0' COMMENT '必须填写标识',
  `description` varchar(255) DEFAULT NULL COMMENT '备注/描述',
  `createUser` varchar(100) DEFAULT NULL COMMENT '创建人',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifyUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL COMMENT '部门',
  `CREATE_USER` varchar(100) DEFAULT NULL COMMENT '创建',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '结果表是否有效1表示有效0表示无效',
  `isRight` bit(1) NOT NULL DEFAULT b'0' COMMENT '导入问卷的格式是否正确0表示正确1表示不正确',
  `whereIsError` varchar(4000) DEFAULT NULL COMMENT '错误数据在什么位置。',
  `isImport` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否导入到正式表：0表示未导入，1表示导入',
  PRIMARY KEY (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问juan';

-- ----------------------------
-- Records of tb_questionnaire_temp
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_questions`
-- ----------------------------
DROP TABLE IF EXISTS `tb_questions`;
CREATE TABLE `tb_questions` (
  `questionId` varchar(100) NOT NULL COMMENT '问题编号ID',
  `questionnaireId` varchar(100) DEFAULT NULL COMMENT '问卷id',
  `parentId` varchar(100) DEFAULT NULL COMMENT '所属父级ID',
  `questionCode` varchar(100) DEFAULT NULL COMMENT '问题代码',
  `title` text COMMENT '问题题目',
  `level` text COMMENT '问题类型(级别)',
  `classification` varchar(20) DEFAULT NULL COMMENT '问题等级:卷头、一级分类、二级分类',
  `types` varchar(20) DEFAULT NULL COMMENT '题型(单选、多选)',
  `scaleType` varchar(20) DEFAULT NULL COMMENT '量表类型',
  `scaleRange` int(11) DEFAULT NULL COMMENT '量表范围',
  `questionData` text COMMENT '数据',
  `score` int(11) DEFAULT NULL COMMENT '分值',
  `formatData` varchar(20) DEFAULT NULL COMMENT '数据格式化',
  `typeSetting` varchar(20) DEFAULT NULL COMMENT '排列方式',
  `linkageId` varchar(100) DEFAULT NULL COMMENT '联动菜单的id',
  `inquiryInformation` varchar(100) DEFAULT NULL COMMENT '问诊信息排列方式字段',
  `cutoffRule` varchar(100) DEFAULT NULL COMMENT '分割线的类型，实线（dashed）虚线（activeLine）',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段',
  `mustFlag` int(11) DEFAULT '0' COMMENT '必须填写标识',
  `isRemarks` int(11) DEFAULT '0' COMMENT '该题是否存在备注',
  `description` varchar(255) DEFAULT NULL COMMENT '备注/描述',
  `validState` int(11) DEFAULT NULL COMMENT '有效状态',
  `createUser` varchar(100) DEFAULT NULL COMMENT '创建人',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifyUser` varchar(100) DEFAULT NULL COMMENT '修改人',
  `modifyTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '结果表是否有效1表示有效0表示无效',
  `isShow` varchar(1) DEFAULT NULL,
  `questionList` longtext,
  PRIMARY KEY (`questionId`),
  KEY `FK_Reference_6` (`questionnaireId`) USING BTREE,
  CONSTRAINT `tb_questions_ibfk_1` FOREIGN KEY (`questionnaireId`) REFERENCES `tb_questionnaire` (`questionnaireId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问卷题库; InnoDB free: 10240 kB; (`questionnaireId`) REFER `fhad';

-- ----------------------------
-- Records of tb_questions
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_questions_header`
-- ----------------------------
DROP TABLE IF EXISTS `tb_questions_header`;
CREATE TABLE `tb_questions_header` (
  `header_id` varchar(100) NOT NULL DEFAULT '',
  `batch_id` varchar(100) NOT NULL,
  `questionnaireId` varchar(100) DEFAULT NULL,
  `title_name` varchar(100) DEFAULT NULL,
  `title_value` varchar(100) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL COMMENT '问题结果的备注',
  `create_user` varchar(100) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `respondentCode` varchar(100) DEFAULT NULL COMMENT '调查对象',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '结果表是否有效1表示有效0表示无效',
  `column1` varchar(100) DEFAULT NULL,
  `column2` varchar(100) DEFAULT NULL,
  `column3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`header_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_questions_header
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_section_base`
-- ----------------------------
DROP TABLE IF EXISTS `tb_section_base`;
CREATE TABLE `tb_section_base` (
  `RECORD_ID` varchar(100) NOT NULL DEFAULT '',
  `VISIT_CODE` varchar(100) DEFAULT NULL COMMENT '就诊编号',
  `HOSIPITAL_CODE` varchar(100) DEFAULT NULL COMMENT '医院ID',
  `HOSIPIATL_NAME` varchar(100) DEFAULT NULL COMMENT '医院名称',
  `VISIT_TYPE` varchar(100) DEFAULT NULL COMMENT '门诊类型(门诊或住院)',
  `SECTION_NAME` varchar(100) DEFAULT NULL COMMENT '门诊名称',
  `SECTION_CODE` varchar(100) DEFAULT NULL COMMENT '科室编号',
  `EMP_CODE` varchar(100) DEFAULT NULL COMMENT '医生编号',
  `EMP_NAME` varchar(100) DEFAULT NULL COMMENT '医生姓名',
  `DOCTORTYPE` varchar(100) DEFAULT NULL COMMENT '医生职称',
  `PATIENT_ID` varchar(100) DEFAULT NULL COMMENT '患者id',
  `PATIENT_NAME` varchar(200) DEFAULT NULL COMMENT '患者姓名',
  `SEX` varchar(20) DEFAULT NULL COMMENT '患者性别',
  `PHONE_NUMBER` varchar(50) DEFAULT NULL COMMENT '患者电话',
  `VISIT_DATE` varchar(100) DEFAULT NULL COMMENT '诊疗时间',
  `TIMES` varchar(20) DEFAULT NULL COMMENT '就诊次数',
  `EXPERIENCE_TYPE` varchar(50) DEFAULT NULL COMMENT '体检类型(团体\\个人)',
  `OUTHOSPITAL_DATE` varchar(100) DEFAULT NULL COMMENT '出院时间',
  `BED` varchar(100) DEFAULT NULL COMMENT '床位',
  `BUILDINGNUM` varchar(100) DEFAULT NULL COMMENT '楼栋号',
  `ROOTNUM` varchar(100) DEFAULT NULL COMMENT '房间号',
  `NURSE_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_section_base
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_section_configure`
-- ----------------------------
DROP TABLE IF EXISTS `tb_section_configure`;
CREATE TABLE `tb_section_configure` (
  `CONFIGURE_ID` int(100) NOT NULL AUTO_INCREMENT,
  `FIELD_NAME` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `LABEL` varchar(200) DEFAULT NULL COMMENT '标签（显示的中文名称）',
  `HOSIPITAL_ID` varchar(100) DEFAULT NULL COMMENT '医院ID',
  `INTERFACE_TYPE` varchar(50) DEFAULT NULL COMMENT '同家医院的不同接口',
  `IS_SHOW` varchar(20) DEFAULT NULL COMMENT '是否展示在页面',
  `FIELD_ORDER` varchar(100) DEFAULT NULL COMMENT '字段顺序',
  PRIMARY KEY (`CONFIGURE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_section_configure
-- ----------------------------

-- ----------------------------
-- Table structure for `weixin_command`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_command`;
CREATE TABLE `weixin_command` (
  `COMMAND_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `COMMANDCODE` varchar(255) DEFAULT NULL COMMENT '应用路径',
  `CREATETIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(1) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`COMMAND_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_command
-- ----------------------------
INSERT INTO `weixin_command` VALUES ('2636750f6978451b8330874c9be042c2', '锁定服务器', 'rundll32.exe user32.dll,LockWorkStation', '2015-05-10 21:25:06', '1', '锁定计算机');
INSERT INTO `weixin_command` VALUES ('46217c6d44354010823241ef484f7214', '打开浏览器', 'C:/Program Files/Internet Explorer/iexplore.exe', '2015-05-09 02:43:02', '1', '打开浏览器操作');
INSERT INTO `weixin_command` VALUES ('576adcecce504bf3bb34c6b4da79a177', '关闭浏览器', 'taskkill /f /im iexplore.exe', '2015-05-09 02:36:48', '2', '关闭浏览器操作');
INSERT INTO `weixin_command` VALUES ('854a157c6d99499493f4cc303674c01f', '关闭QQ', 'taskkill /f /im qq.exe', '2015-05-10 21:25:46', '1', '关闭QQ');
INSERT INTO `weixin_command` VALUES ('ab3a8c6310ca4dc8b803ecc547e55ae7', '打开QQ', 'D:/SOFT/QQ/QQ/Bin/qq.exe', '2015-05-10 21:25:25', '1', '打开QQ');

-- ----------------------------
-- Table structure for `weixin_imgmsg`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_imgmsg`;
CREATE TABLE `weixin_imgmsg` (
  `IMGMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TITLE1` varchar(255) DEFAULT NULL COMMENT '标题1',
  `DESCRIPTION1` varchar(255) DEFAULT NULL COMMENT '描述1',
  `IMGURL1` varchar(255) DEFAULT NULL COMMENT '图片地址1',
  `TOURL1` varchar(255) DEFAULT NULL COMMENT '超链接1',
  `TITLE2` varchar(255) DEFAULT NULL COMMENT '标题2',
  `DESCRIPTION2` varchar(255) DEFAULT NULL COMMENT '描述2',
  `IMGURL2` varchar(255) DEFAULT NULL COMMENT '图片地址2',
  `TOURL2` varchar(255) DEFAULT NULL COMMENT '超链接2',
  `TITLE3` varchar(255) DEFAULT NULL COMMENT '标题3',
  `DESCRIPTION3` varchar(255) DEFAULT NULL COMMENT '描述3',
  `IMGURL3` varchar(255) DEFAULT NULL COMMENT '图片地址3',
  `TOURL3` varchar(255) DEFAULT NULL COMMENT '超链接3',
  `TITLE4` varchar(255) DEFAULT NULL COMMENT '标题4',
  `DESCRIPTION4` varchar(255) DEFAULT NULL COMMENT '描述4',
  `IMGURL4` varchar(255) DEFAULT NULL COMMENT '图片地址4',
  `TOURL4` varchar(255) DEFAULT NULL COMMENT '超链接4',
  `TITLE5` varchar(255) DEFAULT NULL COMMENT '标题5',
  `DESCRIPTION5` varchar(255) DEFAULT NULL COMMENT '描述5',
  `IMGURL5` varchar(255) DEFAULT NULL COMMENT '图片地址5',
  `TOURL5` varchar(255) DEFAULT NULL COMMENT '超链接5',
  `TITLE6` varchar(255) DEFAULT NULL COMMENT '标题6',
  `DESCRIPTION6` varchar(255) DEFAULT NULL COMMENT '描述6',
  `IMGURL6` varchar(255) DEFAULT NULL COMMENT '图片地址6',
  `TOURL6` varchar(255) DEFAULT NULL COMMENT '超链接6',
  `TITLE7` varchar(255) DEFAULT NULL COMMENT '标题7',
  `DESCRIPTION7` varchar(255) DEFAULT NULL COMMENT '描述7',
  `IMGURL7` varchar(255) DEFAULT NULL COMMENT '图片地址7',
  `TOURL7` varchar(255) DEFAULT NULL COMMENT '超链接7',
  `TITLE8` varchar(255) DEFAULT NULL COMMENT '标题8',
  `DESCRIPTION8` varchar(255) DEFAULT NULL COMMENT '描述8',
  `IMGURL8` varchar(255) DEFAULT NULL COMMENT '图片地址8',
  `TOURL8` varchar(255) DEFAULT NULL COMMENT '超链接8',
  PRIMARY KEY (`IMGMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_imgmsg
-- ----------------------------
INSERT INTO `weixin_imgmsg` VALUES ('380b2cb1f4954315b0e20618f7b5bd8f', '首页', '2015-05-10 20:51:09', '1', '图文回复', '图文回复标题', '图文回复描述', 'http://a.hiphotos.baidu.com/image/h%3D360/sign=c6c7e73ebc389b5027ffe654b535e5f1/a686c9177f3e6709392bb8df3ec79f3df8dc55e3.jpg', 'www.baidu.com', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for `weixin_key`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_key`;
CREATE TABLE `weixin_key` (
  `KEY_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `APPID` varchar(100) DEFAULT NULL COMMENT 'appid',
  `APPSECRET` varchar(100) DEFAULT NULL COMMENT 'appsecret',
  `ACCESS_TOKEN` varchar(100) DEFAULT NULL COMMENT 'access_token',
  `CREATETIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `WXUSERNAME` varchar(100) DEFAULT NULL COMMENT '公众号',
  PRIMARY KEY (`KEY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_key
-- ----------------------------
INSERT INTO `weixin_key` VALUES ('58510f788aea4924b4a5438ecda5f749', 'itFteacher', '11111112222', '1111222333', '', '2017-03-29 02:31:03', 'itFteacher', 'itFteacher');

-- ----------------------------
-- Table structure for `weixin_mymenu`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_mymenu`;
CREATE TABLE `weixin_mymenu` (
  `MYMENU_ID` varchar(100) NOT NULL,
  `WXUSERNAME` varchar(100) DEFAULT NULL COMMENT '公众号',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `TITLE` varchar(30) DEFAULT NULL COMMENT '菜单名称',
  `TYPE` varchar(10) DEFAULT NULL COMMENT '类型',
  `CONTENT` varchar(100) DEFAULT NULL COMMENT '指向',
  `XID` varchar(10) DEFAULT NULL COMMENT 'XID',
  PRIMARY KEY (`MYMENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_mymenu
-- ----------------------------
INSERT INTO `weixin_mymenu` VALUES ('00ca43bbba2746429c8a6e0028a2f197', 'itFteacher', 'itFteacher', '', '', '', 'M33');
INSERT INTO `weixin_mymenu` VALUES ('02c67417e56f43a6be5356d5c5201ef7', 'itFteacher', 'itFteacher', '12121', 'view', '212121', 'M21');
INSERT INTO `weixin_mymenu` VALUES ('13e5b9a51f87430dabe2d8cc998d297c', 'itFteacher', 'itFteacher', '一级菜单', '', '', 'M1');
INSERT INTO `weixin_mymenu` VALUES ('14e68258190b45cba4d21e132508252d', 'itFteacher', 'itFteacher', '', '', '', 'M13');
INSERT INTO `weixin_mymenu` VALUES ('16230e4149134556ac5edf691d25be2a', 'itFteacher', 'itFteacher', '', '', '', 'M24');
INSERT INTO `weixin_mymenu` VALUES ('19353267c4ea43fb903b88f6401ea41a', 'itFteacher', 'itFteacher', '', '', '', 'M25');
INSERT INTO `weixin_mymenu` VALUES ('230f6447fee84bcd827de0ec73970660', 'itFteacher', 'itFteacher', '哈哈哈', '', '', 'M2');
INSERT INTO `weixin_mymenu` VALUES ('24315e33166647198dcbd31a44a1a866', 'itFteacher', 'itFteacher', '', '', '', 'M14');
INSERT INTO `weixin_mymenu` VALUES ('3daed1d236224a729860e77fe7295ea7', 'itFteacher', 'itFteacher', '', '', '', 'M32');
INSERT INTO `weixin_mymenu` VALUES ('3fbae4e173de4f36a6d721ca77b6480c', 'itFteacher', 'itFteacher', '', '', '', 'M34');
INSERT INTO `weixin_mymenu` VALUES ('4532044ae6cd4c7cb1c89e2cfdb0d812', 'itFteacher', 'itFteacher', '12121', 'click', '212121', 'M22');
INSERT INTO `weixin_mymenu` VALUES ('5fb159eb85a049ef9e0f7b56c2c8538e', 'itFteacher', 'itFteacher', '', '', '', 'M12');
INSERT INTO `weixin_mymenu` VALUES ('656c281ed7a142d6907baa6b36e93347', 'itFteacher', 'itFteacher', '', '', '', 'M23');
INSERT INTO `weixin_mymenu` VALUES ('679127c586784974a18e64a3660e0d11', 'itFteacher', 'itFteacher', '', '', '', 'M35');
INSERT INTO `weixin_mymenu` VALUES ('999a8965d4484facaaeb2768471207c5', 'itFteacher', 'itFteacher', '', '', '', 'M3');
INSERT INTO `weixin_mymenu` VALUES ('aa09cedf69e04eda9bb3a0f3b77db46c', 'itFteacher', 'itFteacher', '', '', '', 'M15');
INSERT INTO `weixin_mymenu` VALUES ('c193c0f155034d68a79c662b4046699f', 'itFteacher', 'itFteacher', '', '', '', 'M11');
INSERT INTO `weixin_mymenu` VALUES ('e940253208d84c81ae8fbec4f5f299a9', 'itFteacher', 'itFteacher', '', '', '', 'M31');

-- ----------------------------
-- Table structure for `weixin_textmsg`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_textmsg`;
CREATE TABLE `weixin_textmsg` (
  `TEXTMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '内容',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(2) DEFAULT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TEXTMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_textmsg
-- ----------------------------
INSERT INTO `weixin_textmsg` VALUES ('d4738af7aea74a6ca1a5fb25a98f9acb', '关注', '这里是关注后回复的内容', '2015-05-11 02:12:36', '1', '关注回复');

-- ----------------------------
-- Function structure for `strip_tags`
-- ----------------------------
DROP FUNCTION IF EXISTS `strip_tags`;
DELIMITER ;;
CREATE FUNCTION `strip_tags`($str text) RETURNS text   
BEGIN  
    DECLARE $start, $end INT DEFAULT 1;   
    LOOP 
	IF($str is null ) THEN RETURN $str; END IF;  
        SET $start = LOCATE("<", $str, $start);   
        IF (!$start) THEN RETURN $str; END IF;   
        SET $end = LOCATE(">", $str, $start);   
        IF (!$end) THEN SET $end = $start; END IF;   
        SET $str = INSERT($str, $start, $end - $start + 1, "");   
    END LOOP;   
END
;;
DELIMITER ;

-------------------------------------------------------
-- 2018年1月17日10:14:05             byxiaoding    未上线
-------------------------------------------------------
ALTER TABLE `tb_section_base`
MODIFY COLUMN `VISIT_DATE`  varchar(200) NULL DEFAULT NULL COMMENT '诊疗时间' AFTER `PHONE_NUMBER`;

alter table `fhadmin`.`tb_section_base` 
   change `OUTHOSPITAL_DATE` `OUTHOSPITAL_DATE` varchar(100) NULL  comment '出院时间';

ALTER TABLE `tb_questionnaire`
ADD COLUMN `allowedRepeatSwith`  bit(1) NULL DEFAULT b'1' COMMENT '是否允许重复的开关' AFTER `bootomType`;

ALTER TABLE `sys_dictionaries`
ADD COLUMN `DEPARTMENT_ID`  varchar(100) NULL AFTER `TBSNAME`,
ADD COLUMN `ISDEPARTMENT`  varchar(1) NULL AFTER `DEPARTMENT_ID`;

ALTER TABLE `sys_dictionaries`
ADD COLUMN `DEPARTMENT_PATH`  longtext NULL AFTER `ISDEPARTMENT`;

INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('6e68ddc7edc74b3d9e855d7cb77d0d48', '调查对象', 'questionnaire_respondent', 'questionnaire_respondent', 3, '0', 'questionnaire_respondent', '', '', '0', '');




INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('2383c0ecf5ee4166baf687196240c97c', '独立生活区（养老）', 'independent_living_area', 'independent_living_area', 3, '6e68ddc7edc74b3d9e855d7cb77d0d48', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('d36c0677f8824d698746d17e014f2b14', '专项调查', 'special_investigation', 'special_investigation', 4, '6e68ddc7edc74b3d9e855d7cb77d0d48', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('e69d3337cde349fc815cde2e337b355d', '写字楼', 'office_building', 'ebd6dd9b05834dd3b774dc99b05298d9', 1, '6e68ddc7edc74b3d9e855d7cb77d0d48', 'ebd6dd9b05834dd3b774dc99b05298d9', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('f9059bce14ac4f249a3f416a0a39f935', '医院', 'hosipital', 'abc6dd9b05834dd3b774dc99b05298d9', 2, '6e68ddc7edc74b3d9e855d7cb77d0d48', '', '', '', '0', '');



INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('4dd1afd520d64f19b28a66e98f47cd8e', '行政经理', 'manager', 'SL2', 2, 'e69d3337cde349fc815cde2e337b355d', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('52fff09015614c3083945c364b81ccd4', '体检', 'Physical examination', 'hospital3', 3, 'f9059bce14ac4f249a3f416a0a39f935', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('64510af48efb40f7894664add90665cf', '护理业态', 'Nursing format', 'hospital4', 4, 'f9059bce14ac4f249a3f416a0a39f935', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('7ec459148b304bd693b3faf89406d779', '住院', 'be_hospitalized', 'hospital2', 1, 'f9059bce14ac4f249a3f416a0a39f935', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('9781a39d4a414278b5ce8e1dbcfbe242', '门诊', 'men_zhen', 'hospital1', 2, 'f9059bce14ac4f249a3f416a0a39f935', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('9e5dbd151a0644dea04172073e97b3c4', '独立生活区', '  独立生活区 Independent living area', 'SL5', 1, '2383c0ecf5ee4166baf687196240c97c', '', '', '', '0', '');
INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('a3114fb2b3eb4abf9de3286a8672de6d', '普通员工', 'staff', 'SL1', 1, 'e69d3337cde349fc815cde2e337b355d', '', '', '', '0', '');




INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('7243eccb202b4a379a04213a1bd2db41', '高端客户', '高端客户', 'vip_customers', 5, '6e68ddc7edc74b3d9e855d7cb77d0d48', '', '', '', '0', '');


INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`, `DEPARTMENT_ID`, `ISDEPARTMENT`, `DEPARTMENT_PATH`) VALUES ('ac1527a74bd04478b1434d7ffb2d7cc9', '普通客户', '普通客户', 'vip_cust_001', 1, '7243eccb202b4a379a04213a1bd2db41', '', '', '', '0', '');

-------------------------------------------------------
-- 2018年1月17日10:14:05             byxiaoding    未上线             结束
-------------------------------------------------------
ALTER TABLE `tb_questionnaire`
ADD COLUMN `markedWords`  varchar(100) NULL AFTER `CREATE_USER`;



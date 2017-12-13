CREATE TABLE `t_area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` char(20) DEFAULT NULL,
  `area_orderby` int(5) DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE KEY `area_name_unique` (`area_name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8

CREATE TABLE `t_organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(20) DEFAULT NULL,
  `organization_orderby` int(5) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`organization_id`),
  UNIQUE KEY `unique_name` (`organization_name`),
  KEY `foreign_area_id` (`area_id`),
  CONSTRAINT `foreign_area_id` FOREIGN KEY (`area_id`) REFERENCES `t_area` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8

CREATE TABLE `t_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) DEFAULT NULL,
  `config_title` varchar(50) DEFAULT NULL,
  `config_value` varchar(20) DEFAULT NULL,
  `config_valuetype` varchar(20) DEFAULT NULL,
  `config_condition` varchar(100) DEFAULT NULL,
  `config_type` varchar(5) DEFAULT NULL,
  `config_orderby` int(5) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `unique_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('1','CS_TIMES','初赛考试次数','3','Integer',NULL,NULL,'3');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('5','FS_TIMES','复赛考试次数','1','Integer',NULL,NULL,'6');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('8','JIES','届数','1','String',NULL,NULL,'9');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('10','DATES_REGISTE','注册时间段',NULL,NULL,'2017-11-01 00:00:01|2017-12-19 23:59:59',NULL,'12');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('11','CS_DATES_EXAM','初赛网上考试时间段',NULL,NULL,'2017-11-10 00:00:01|2017-12-10 23:59:59',NULL,'15');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('12','CS_DATES_WRITE','初赛笔试时间段',NULL,NULL,'2017-12-20 00:00:01|2017-12-20 23:59:59',NULL,'18');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('13','FS_DATES_EXAM','复赛网上考试时间段',NULL,NULL,'2018-01-01 00:00:01|2018-01-31 23:59:59',NULL,'21');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('14','FS_DATES_WRITE','复赛笔试时间段',NULL,NULL,'2018-02-07 00:00:01|2018-02-07 23:59:59',NULL,'24');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('15','CS_DATES_QUERY','初赛成绩查询时间段',NULL,NULL,'2018-01-01 00:00:01|2018-01-31 23:59:59',NULL,'27');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('16','FS_DATES_QUERY','复赛成绩查询时间段',NULL,NULL,'2018-02-20 00:00:01|2018-03-20 23:59:59',NULL,'30');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('17','ALL_DATES_QUERY','总成绩查询时间段',NULL,NULL,'2018-02-20 00:00:01|2018-03-20 23:59:59',NULL,'33');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('19','CS_SCORES_LAST_EXAM_1','初赛网上考试最后一次成绩','60','Integer','55|59','=','36');
insert into `t_config` (`config_id`, `config_key`, `config_title`, `config_value`, `config_valuetype`, `config_condition`, `config_type`, `config_orderby`) values('20','FS_SCORES_EXAM','复赛网上考试成绩','5','Integer','55|59','+','39');





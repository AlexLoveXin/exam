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


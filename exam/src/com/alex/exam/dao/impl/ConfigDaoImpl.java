package com.alex.exam.dao.impl;

import com.alex.exam.dao.ConfigDao;
import com.alex.exam.model.Config;
/**
 * 系统配置dao实现类
 * @author 440
 *
 */
public class ConfigDaoImpl extends BaseDaoImpl<Config, Integer> implements ConfigDao {

	public ConfigDaoImpl() {
		super(Config.class);
	}

}

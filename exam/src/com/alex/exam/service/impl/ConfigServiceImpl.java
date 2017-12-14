package com.alex.exam.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alex.exam.dao.ConfigDao;
import com.alex.exam.init.Init;
import com.alex.exam.model.Config;
import com.alex.exam.service.ConfigService;
/**
 * 系统配置service实现类
 * @author 440
 *
 */
public class ConfigServiceImpl extends BaseServiceImpl<Config, Integer> implements ConfigService {
	private Logger logger = LogManager.getLogger(ConfigServiceImpl.class);
	public ConfigServiceImpl(ConfigDao dao) {
		super(dao);
	}
	@Override
	public int getMaxOrderby() {
		LinkedHashMap<String, String> order = new LinkedHashMap<String, String>();
		order.put("orderby", "desc");
		List<Config> list = dao.list(null, null, order, -1, -1);
		return list.size()==0?3:(list.get(0).getOrderby()+3);
	}
	@Override
	public void moveup(int id, String type) {
		//更新数据库
		Config config2 = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "asc");
		List<Config> configs = dao.list(" where 1=1 and orderby>? and key like ? ", new Object[] {config2.getOrderby(),"time".equals(type.trim())?"%TIMES%":("date".equals(type.trim())?"%DATES%":("score".equals(type.trim())?"%SCORES%":""))}, order, 1, 1);
		logger.debug(id+","+config2.getOrderby()+","+("time".equals(type.trim())?"%TIMES%":("date".equals(type.trim())?"%DATES%":("score".equals(type.trim())?"%SCORES%":""))));
		logger.debug("configs size=="+configs.size());
		if(configs.size()>0) {
			Config config3 = configs.get(0);
			int temp = config3.getOrderby();
			config3.setOrderby(config2.getOrderby());
			config2.setOrderby(temp);
			dao.update(config2);
			dao.update(config3);
			//更新缓存
			Init.getConfig().put(config2.getKey(), config2);
			Init.getConfig().put(config3.getKey(), config3);
		}
	}
	@Override
	public void movedown(int id, String type) {
		//更新数据库
		Config config2 = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "desc");
		List<Config> configs = dao.list(" where orderby<? and key like ? ", new Object[] {config2.getOrderby(),"time".equals(type.trim())?"%TIMES%":("date".equals(type.trim())?"%DATES%":("score".equals(type.trim())?"%SCORES%":""))}, order, 1, 1);
		if(configs.size()>0) {
			Config config3 = configs.get(0);
			int temp = config3.getOrderby();
			config3.setOrderby(config2.getOrderby());
			config2.setOrderby(temp);
			dao.update(config2);
			dao.update(config3);
			//更新缓存
			Init.getConfig().put(config2.getKey(), config2);
			Init.getConfig().put(config3.getKey(), config3);
		}
	}
}

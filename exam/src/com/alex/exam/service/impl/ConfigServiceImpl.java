package com.alex.exam.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import com.alex.exam.dao.ConfigDao;
import com.alex.exam.model.Config;
import com.alex.exam.service.ConfigService;
/**
 * 系统配置service实现类
 * @author 440
 *
 */
public class ConfigServiceImpl extends BaseServiceImpl<Config, Integer> implements ConfigService {

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
}

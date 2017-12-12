package com.alex.exam.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alex.exam.dao.AreaDao;
import com.alex.exam.model.Area;
import com.alex.exam.service.AreaService;
/**
 * 地区service实现类
 * @author Alex
 *
 */
public class AreaServiceImpl extends BaseServiceImpl<Area, Integer> implements AreaService {
	private Logger logger = LogManager.getLogger(AreaServiceImpl.class);
	public AreaServiceImpl(AreaDao dao) {
		super(dao);
	}

	@Override
	public int getMaxOrderby() {
		LinkedHashMap<String, String> order = new LinkedHashMap<String, String>();
		order.put("orderby", "desc");
		List<Area> list = dao.list(null, null, order, -1, -1);
		return list.size()==0?3:(list.get(0).getOrderby()+3);
	}

	@Override
	public void moveup(int id, String name) {
		Area area = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "asc");
		String where = " where 1=1 ";
		List<Object> params = new ArrayList<>();
		if(StringUtils.isNotBlank(name)) {
			where += " and name like ? ";
			params.add("%"+name+"%");
		}
		where += " and orderby>? ";
		params.add(area.getOrderby());
		List<Area> areas = dao.list(where, params.toArray(new Object[] {}), order, 1, 1);
		logger.debug("areas size=="+areas.size());
		if(null!=areas && areas.size()>0) {
			Area area2 = areas.get(0);
			int temp = area2.getOrderby();
			area2.setOrderby(area.getOrderby());
			area.setOrderby(temp);
			dao.update(area);
			dao.update(area2);
		}
	}

	@Override
	public void movedown(int id, String name) {
		Area area = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "desc");
		String where = " where 1=1 ";
		List<Object> params = new ArrayList<>();
		if(StringUtils.isNotBlank(name)) {
			where += " and name like ? ";
			params.add("%"+name+"%");
		}
		where += " and orderby<? ";
		params.add(area.getOrderby());
		List<Area> areas = dao.list(where, params.toArray(new Object[] {}), order, 1, 1);
		logger.debug("areas size=="+areas.size());
		if(null!=areas && areas.size()>0) {
			Area area2 = areas.get(0);
			int temp = area2.getOrderby();
			area2.setOrderby(area.getOrderby());
			area.setOrderby(temp);
			dao.update(area);
			dao.update(area2);
		}
	}

}

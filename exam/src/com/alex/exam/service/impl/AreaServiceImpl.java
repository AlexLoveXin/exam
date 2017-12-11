package com.alex.exam.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import com.alex.exam.dao.AreaDao;
import com.alex.exam.model.Area;
import com.alex.exam.service.AreaService;
/**
 * 地区service实现类
 * @author Alex
 *
 */
public class AreaServiceImpl extends BaseServiceImpl<Area, Integer> implements AreaService {

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

}

package com.alex.exam.dao.impl;

import com.alex.exam.dao.AreaDao;
import com.alex.exam.model.Area;
/**
 * 地区dao实现类
 * @author Alex
 *
 */
public class AreaDaoImpl extends BaseDaoImpl<Area, Integer> implements AreaDao {

	public AreaDaoImpl() {
		super(Area.class);
	}
	
}

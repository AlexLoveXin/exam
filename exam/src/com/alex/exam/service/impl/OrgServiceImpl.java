package com.alex.exam.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alex.exam.dao.OrgDao;
import com.alex.exam.model.Organization;
import com.alex.exam.service.OrgService;
/**
 * 学校或单位service实现类
 * @author Alex
 *
 */
public class OrgServiceImpl extends BaseServiceImpl<Organization, Integer> implements OrgService {

	private Logger logger = LogManager.getLogger(OrgServiceImpl.class);
	public OrgServiceImpl(OrgDao dao) {
		super(dao);
	}
	@Override
	public int getMaxOrderby() {
		LinkedHashMap<String, String> order = new LinkedHashMap<String, String>();
		order.put("orderby", "desc");
		List<Organization> list = dao.list(null, null, order, -1, -1);
		return list.size()==0?3:(list.get(0).getOrderby()+3);
	}

	@Override
	public void moveup(int id, String name) {
		Organization org = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "asc");
		String where = " where 1=1 ";
		List<Object> params = new ArrayList<>();
		if(StringUtils.isNotBlank(name)) {
			where += " and name like ? ";
			params.add("%"+name.trim()+"%");
		}
		where += " and orderby>? ";
		params.add(org.getOrderby());
		List<Organization> orgs = dao.list(where, params.toArray(new Object[] {}), order, 1, 1);
		logger.debug("orgs size=="+orgs.size());
		if(null!=orgs && orgs.size()>0) {
			Organization org2 = orgs.get(0);
			int temp = org2.getOrderby();
			org2.setOrderby(org.getOrderby());
			org.setOrderby(temp);
			dao.update(org);
			dao.update(org2);
		}
	}

	@Override
	public void movedown(int id, String name) {
		Organization org = dao.get(id);
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "desc");
		String where = " where 1=1 ";
		List<Object> params = new ArrayList<>();
		if(StringUtils.isNotBlank(name)) {
			where += " and name like ? ";
			params.add("%"+name.trim()+"%");
		}
		where += " and orderby<? ";
		params.add(org.getOrderby());
		List<Organization> orgs = dao.list(where, params.toArray(new Object[] {}), order, 1, 1);
		logger.debug("orgs size=="+orgs.size());
		if(null!=orgs && orgs.size()>0) {
			Organization org2 = orgs.get(0);
			int temp = org2.getOrderby();
			org2.setOrderby(org.getOrderby());
			org.setOrderby(temp);
			dao.update(org);
			dao.update(org2);
		}
	}
}

package com.alex.exam.dao.impl;

import com.alex.exam.dao.OrgDao;
import com.alex.exam.model.Organization;
/**
 * 学校或单位dao实现
 * @author Alex
 *
 */
public class OrgDaoImpl extends BaseDaoImpl<Organization, Integer> implements OrgDao {

	public OrgDaoImpl() {
		super(Organization.class);
	}

}

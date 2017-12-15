package com.alex.exam.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import com.alex.exam.dao.UserDao;
import com.alex.exam.model.User;
import com.alex.exam.service.UserService;
/**
 * 用户service实现类
 * @author 440
 *
 */
public class UserServiceImpl extends BaseServiceImpl<User, Integer> implements UserService {

	public UserServiceImpl(UserDao dao) {
		super(dao);
	}
	@Override
	public int getMaxOrderby() {
		LinkedHashMap<String, String> order = new LinkedHashMap<String, String>();
		order.put("orderby", "desc");
		List<User> list = dao.list(null, null, order, -1, -1);
		return list.size()==0?3:(list.get(0).getOrderby()+3);
	}
}

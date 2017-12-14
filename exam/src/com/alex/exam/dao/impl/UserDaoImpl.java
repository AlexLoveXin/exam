package com.alex.exam.dao.impl;

import com.alex.exam.dao.UserDao;
import com.alex.exam.model.User;
/**
 * 用户dao实现类
 * @author 440
 *
 */
public class UserDaoImpl extends BaseDaoImpl<User, Integer> implements UserDao {

	public UserDaoImpl() {
		super(User.class);
	}

}

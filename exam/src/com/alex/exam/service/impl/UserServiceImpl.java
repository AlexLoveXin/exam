package com.alex.exam.service.impl;

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

}

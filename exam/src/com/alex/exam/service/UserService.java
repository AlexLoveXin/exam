package com.alex.exam.service;

import com.alex.exam.model.User;
/**
 * 用户service接口
 * @author 440
 *
 */
public interface UserService extends BaseService<User, Integer> {
	/**
	 * 查询数据库中最大排序值，并加上3，返回给action使用
	 * @return 最大排序值+3
	 */
	int getMaxOrderby();
}

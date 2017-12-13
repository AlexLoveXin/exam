package com.alex.exam.service;

import com.alex.exam.model.Config;
/**
 * 系统配置service接口
 * @author 440
 *
 */
public interface ConfigService extends BaseService<Config, Integer> {
	/**
	 * 查询数据库中最大排序值，并加上3，返回给action使用
	 * @return 最大排序值+3
	 */
	int getMaxOrderby();
}

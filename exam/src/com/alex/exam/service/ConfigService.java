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
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和上一个数据的orderby字段交换，
	 * 如果上一个数据不存在，则无需移动
	 * @param id 主键id
	 * @param type 配置类型，time,date,score
	 */
	void moveup(int id, String type);
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和下一个数据的orderby字段交换，
	 * 如果下一个数据不存在，则无需移动
	 * @param id 主键id
	 * @param type 配置类型，time,date,score
	 * 
	 */
	void movedown(int id, String type);
}

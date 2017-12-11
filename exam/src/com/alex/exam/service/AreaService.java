package com.alex.exam.service;

import com.alex.exam.model.Area;
/**
 * 地区service接口
 * @author Alex
 *
 */
public interface AreaService extends BaseService<Area, Integer> {
	/**
	 * 查询数据库中最大排序值，并加上3，返回给action使用
	 * @return 最大排序值+3
	 */
	int getMaxOrderby();

}

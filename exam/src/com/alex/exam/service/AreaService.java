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
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和上一个数据的orderby字段交换，
	 * 如果上一个数据不存在，则无需移动，
	 * 若地区名称不为空，则查询条件需要加上地区名称
	 * @param id 主键id
	 * @param name 地区名称
	 */
	void moveup(int id, String name);
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和下一个数据的orderby字段交换，
	 * 如果下一个数据不存在，则无需移动，
	 * 若地区名称不为空，则查询条件需要加上地区名称
	 * @param id 主键id
	 * @param name 地区名称
	 * 
	 */
	void movedown(int id, String name);

}

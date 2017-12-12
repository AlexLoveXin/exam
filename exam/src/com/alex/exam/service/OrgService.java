package com.alex.exam.service;

import com.alex.exam.model.Organization;
/**
 * 学校或单位service接口
 * @author Alex
 *
 */
public interface OrgService extends BaseService<Organization, Integer> {
	/**
	 * 查询数据库中最大排序值，并加上3，返回给action使用
	 * @return 最大排序值+3
	 */
	int getMaxOrderby();
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和上一个数据的orderby字段交换，
	 * 如果上一个数据不存在，则无需移动，
	 * 若学校或单位名称不为空，则查询条件需要加上学校或单位名称
	 * @param id 主键id
	 * @param name 学校或单位名称
	 */
	void moveup(int id, String name);
	/**
	 * 在orderby字段降序排序之后，将id对应的数据和下一个数据的orderby字段交换，
	 * 如果下一个数据不存在，则无需移动，
	 * 若学校或单位名称不为空，则查询条件需要加上学校或单位名称
	 * @param id 主键id
	 * @param name 学校或单位名称
	 * 
	 */
	void movedown(int id, String name);
}

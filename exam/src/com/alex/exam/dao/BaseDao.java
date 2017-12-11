package com.alex.exam.dao;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;



/**
 * 基本dao接口
 * @author Alex
 *
 * @param <T> 泛型类型
 * @param <pk> 主键类型
 */
public interface BaseDao<T, pk extends Serializable> {
	/**
	 * 新增实体
	 * @param entity 实体
	 */
	void save(T entity);
	/**
	 * 根据id删除实体
	 * @param entityId 实体id
	 */
	void delete(pk entityId);
	/**
	 * 修改实体
	 * @param entity 实体
	 */
	void update(T entity);
	/**
	 * 根据id获取实体
	 * @param entityId 实体id
	 * @return 实体对象
	 */
	T get(pk entityId);
	/**
	 * 根据查询条件获取实体数量
	 * @param condition 查询参数，如果为null，则代表不需要查询条件 eg:where p1=? and p2=?
	 * @param params 参数值，如果为null，则代表不需要给查询参数设值
	 * @return 实体数量
	 */
	long getTotal(String condition, Object[] params);
	/**
	 * 根据查询条件、排序、分页查询实体集合
	 * @param condition 查询参数，如果为null，则代表不需要查询条件 eg:where p1=? and p2=?
	 * @param params 参数值，如果为null，则代表不需要给查询参数设值
	 * @param order 排序字段，如果为null，则代表不需要排序
	 * @param page 查询页，如果为-1，则代表不需要分页
	 * @param pageSize 每页显示数量，如果为-1，则代表不需要分页
	 * @return 实体集合
	 */
	List<T> list(String condition, Object[] params, LinkedHashMap<String, String> order, int page, int pageSize);
}

package com.alex.exam.service.impl;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

import com.alex.exam.dao.BaseDao;
import com.alex.exam.service.BaseService;
/**
 * 基本service实现类
 * @author Alex
 *
 * @param <T> 泛型类型
 * @param <pk> 主键类型
 */
public abstract class BaseServiceImpl<T, pk extends Serializable> implements BaseService<T, pk> {
	protected BaseDao<T, pk> dao;
	public BaseServiceImpl(BaseDao<T, pk> dao) {
		this.dao = dao;
	}
	@Override
	public void save(T entity) {
		dao.save(entity);
	}

	@Override
	public void delete(pk entityId) {
		dao.delete(entityId);
	}

	@Override
	public void update(T entity) {
		dao.update(entity);
	}

	@Override
	public T get(pk entityId) {
		return dao.get(entityId);
	}

	@Override
	public long getTotal(String condition, Object[] params) {
		return dao.getTotal(condition, params);
	}

	@Override
	public List<T> list(String condition, Object[] params, LinkedHashMap<String, String> order, int page,
			int pageSize) {
		return dao.list(condition, params, order, page, pageSize);
	}

}

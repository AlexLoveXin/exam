package com.alex.exam.dao.impl;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateCallback;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.alex.exam.dao.BaseDao;
/**
 * 基本dao实现类
 * @author Alex
 *
 * @param <T> 泛型类型
 * @param <pk> 主键类型
 */
public abstract class BaseDaoImpl<T, pk extends Serializable> extends HibernateDaoSupport implements BaseDao<T, pk> {
	private Logger logger = LogManager.getLogger(BaseDaoImpl.class);
	private Class<T> clazz;
	public BaseDaoImpl(Class<T> clazz) {
		logger.debug("BaseDaoImpl constuctor().");
		this.clazz = clazz;
	}
	@Override
	public void save(T entity) {
		getHibernateTemplate().save(entity);
	}

	@Override
	public void delete(pk entityId) {
		getHibernateTemplate().delete(get(entityId));
	}

	@Override
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	@Override
	public T get(pk entityId) {
		return getHibernateTemplate().get(clazz, entityId);
	}

	@Override
	public long getTotal(String condition, Object[] params) {
		return getHibernateTemplate().execute(new HibernateCallback<Long>() {

			@Override
			public Long doInHibernate(Session session) throws HibernateException {
				String hql = "select count(*) from "+clazz.getSimpleName()+" "+ (StringUtils.isNotBlank(condition)?condition:"");
				Query q = session.createQuery(hql);
				setParams(params, q);
				return (Long) q.uniqueResult();
			}
		});
	}

	@Override
	public List<T> list(String condition, Object[] params, LinkedHashMap<String, String> order, int page,
			int pageSize) {
		return getHibernateTemplate().execute(new HibernateCallback<List<T>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<T> doInHibernate(Session session) throws HibernateException {
				StringBuffer sb = new StringBuffer();
				if(null!=order && order.size()>0) {
					sb.append(" order by ");
					Set<String> keys = order.keySet();
					for(String key : keys) {
						sb.append(key).append(" ").append(order.get(key)).append(",");
					}
					sb.deleteCharAt(sb.length()-1);
				}
				String orderby = sb.toString();
				String hql = "from "+clazz.getSimpleName()+" "+(StringUtils.isNotBlank(condition)?condition:"")+orderby;
				Query q = session.createQuery(hql);
				setParams(params, q);
				if(page!=-1 && pageSize!=-1) {
					q.setMaxResults(pageSize).setFirstResult((page-1)*pageSize);
				}
				return (List<T>) q.list();
			}
		});
	}
	/**
	 * 为hql查询对象设置查询参数值
	 * @param params 参数值数组
	 * @param q hql查询对象
	 */
	private void setParams(Object[] params, Query q) {
		if(null!=params) {
			for (int i = 0; i < params.length; i++) {
				q.setParameter(i, params[i]);
			}
		}
	}
}

package com.alex.exam.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;

import com.alex.exam.exception.MyException;
import com.alex.exam.model.Area;
import com.alex.exam.service.AreaService;

public class AreaAction extends BaseAction {
	private Logger logger = LogManager.getLogger(AreaAction.class);
	private AreaService areaService;
	public void setAreaService(AreaService areaService) {
		this.areaService = areaService;
	}
	//接收查询的参数
	private String name;
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	//接收新增、修改、删除参数
	private Area area;
	public void setArea(Area area) {
		this.area = area;
	}
	public Area getArea() {
		return area;
	}
	//接收页码参数
	private int page;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	private List<Area> list;
	private long total;
	private long pages;
	public void setList(List<Area> list) {
		this.list = list;
	}
	public List<Area> getList() {
		return list;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public long getTotal() {
		return total;
	}
	public void setPages(long pages) {
		this.pages = pages;
	}
	public long getPages() {
		return pages;
	}
	public String list() throws MyException {
		try {
			if(page==0) {
				page=1;
			}
			int pageSize = PAGE_SIZE;
			String where = " where 1=1 ";
			List<Object> params = new ArrayList<Object>();
			if(StringUtils.isNotBlank(name)) {
				where += " and name like ? ";
				params.add("%"+StringUtils.trim(name)+"%");
			}
			LinkedHashMap<String, String> order = new LinkedHashMap<>();
			order.put("orderby", "desc");
			list = areaService.list(where, params.toArray(new Object[]{}), order, page, pageSize);
			total = areaService.getTotal(where, params.toArray(new Object[]{}));
			pages = total%pageSize==0?total/pageSize:(total/pageSize+1);
			logger.debug("list size=="+list.size()+"\ntotal="+total);
		} catch (Exception e) {
			logger.error("Area list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_2, e);
			throw new MyException(MyException.ERROR_CODE_2, "查询地区列表出错");
		}
		return "list";
	}
	public String add() throws MyException {
		try {
			if(null!=area && StringUtils.isNotBlank(area.getName())) {
				area.setName(StringUtils.trim(area.getName()));
				int maxOrderby = areaService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Area area2 = new Area();
				BeanUtils.copyProperties(area, area2, new String[]{"id", "orderby"});
				area2.setOrderby(maxOrderby);
				areaService.save(area2);
			}
		} catch (Exception e) {
			logger.error("Area add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_1, e);
			throw new MyException(MyException.ERROR_CODE_1, "保存地区信息出错");
		}
		return "toList";
	}
	public void checkName() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{\"exist\":");
			if(null!=area && StringUtils.isNotBlank(area.getName())) {
				if(areaService.list(" where name=? ", new Object[]{area.getName().trim()}, null, -1, -1).size()>0) {//存在
					sb.append(true);
				} else {//不存在
					sb.append(false);
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("check area name error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_3, e);
			throw new MyException(MyException.ERROR_CODE_3, "检查地区名称是否存在出错");
		}
	}
	public void get() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=area && area.getId()!=0) {
				Area area2 = areaService.get(area.getId());
				if(null!=area2) {
					sb.append("\"id\":"+area2.getId()).append(",\"name\":\""+area2.getName()+"\"").append(",\"orderby\":"+area2.getOrderby());
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("area get by id error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_4, e);
			throw new MyException(MyException.ERROR_CODE_4, "根据id获取地区信息出错");
		}
	}
	public String edit() throws MyException {
		try {
			if(null!=area && area.getId()!=0 && StringUtils.isNotBlank(area.getName().trim())) {
				Area area2 = areaService.get(area.getId());
				area2.setName(area.getName().trim());
				areaService.update(area2);
			}
		} catch (Exception e) {
			logger.error("area edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_5, e);
			throw new MyException(MyException.ERROR_CODE_5, "修改地区信息出错");
		}
		return "toList";
	}
	public String del() throws MyException {
		try {
			if(null!=area && area.getId()!=0) {
				areaService.delete(area.getId());
			}
		} catch (Exception e) {
			logger.error("area delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_6, e);
			throw new MyException(MyException.ERROR_CODE_6, "删除地区信息出错");
		}
		return "toList";
	}
	public void moveup() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=area && area.getId()!=0) {
				areaService.moveup(area.getId(), name);
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("area move up error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_7, e);
			throw new MyException(MyException.ERROR_CODE_7, "上移地区出错");
		}
	}
	public void movedown() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=area && area.getId()!=0) {
				areaService.movedown(area.getId(), name);
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("area move down error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_8, e);
			throw new MyException(MyException.ERROR_CODE_8, "下移地区出错");
		}
	}
}

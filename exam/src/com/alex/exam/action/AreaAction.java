package com.alex.exam.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;

import com.alex.exam.model.Area;
import com.alex.exam.service.AreaService;

public class AreaAction {
	private Logger logger = LogManager.getLogger("alex");
	private AreaService areaService;
	public void setAreaService(AreaService areaService) {
		this.areaService = areaService;
	}
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
	public String list() {
		try {
			if(page==0) {
				page=1;
			}
			int pageSize = 2;
			String where = " where 1=1 ";
			List<Object> params = new ArrayList<Object>();
			if(null!=area && StringUtils.isNotBlank(area.getName())) {
				where += " and name like ? ";
				params.add("%"+StringUtils.trim(area.getName())+"%");
			}
			LinkedHashMap<String, String> order = new LinkedHashMap<>();
			order.put("orderby", "desc");
			list = areaService.list(where, params.toArray(new Object[]{}), order, page, pageSize);
			total = areaService.getTotal(where, params.toArray(new Object[]{}));
			pages = total%pageSize==0?total/pageSize:(total/pageSize+1);
			logger.debug("list size=="+list.size()+"\ntotal="+total);
		} catch (Exception e) {
			logger.error("Area list error", e);
		}
		return "list";
	}
	public String add() {
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
			logger.error("Area add error", e);
		}
		return "toList";
	}
}

package com.alex.exam.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.alex.exam.exception.MyException;
import com.alex.exam.model.Area;
import com.alex.exam.service.AreaService;

public class AreaAction {
	private Logger logger = LogManager.getLogger(AreaAction.class);
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
	public String list() throws MyException {
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
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");
			ServletOutputStream out = response.getOutputStream();
			out.println(sb.toString());
		} catch (Exception e) {
			logger.error("check area name error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_3, e);
			throw new MyException(MyException.ERROR_CODE_3, "检查地区名称是否存在出错");
		}
	}
}

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
import com.alex.exam.model.Organization;
import com.alex.exam.service.AreaService;
import com.alex.exam.service.OrgService;

/**
 * 学校或单位action
 * @author Alex
 *
 */
public class OrgAction extends BaseAction {
	private Logger logger = LogManager.getLogger(OrgAction.class);
	private OrgService orgService;
	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
	}
	public OrgService getOrgService() {
		return orgService;
	}
	private AreaService areaService;
	public void setAreaService(AreaService areaService) {
		this.areaService = areaService;
	}
	public AreaService getAreaService() {
		return areaService;
	}
	//接收查询的参数
	private String name;
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	private int areaIdSearch;
	public void setAreaIdSearch(int areaIdSearch) {
		this.areaIdSearch = areaIdSearch;
	}
	public int getAreaIdSearch() {
		return areaIdSearch;
	}
	//接收新增、修改、删除参数
	private Organization org;
	public void setOrg(Organization org) {
		this.org = org;
	}
	public Organization getOrg() {
		return org;
	}
	//接收页码参数
	private int page;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	private List<Organization> list;
	private long total;
	private long pages;
	public void setList(List<Organization> list) {
		this.list = list;
	}
	public List<Organization> getList() {
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
	private List<Area> areas;
	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}
	public List<Area> getAreas() {
		return areas;
	}
	private int areaId;
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public int getAreaId() {
		return areaId;
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
			if(areaIdSearch!=0) {
				where += " and area.id=? ";
				params.add(areaIdSearch);
			}
			LinkedHashMap<String, String> order = new LinkedHashMap<>();
			order.put("orderby", "desc");
			list = orgService.list(where, params.toArray(new Object[]{}), order, page, pageSize);
			total = orgService.getTotal(where, params.toArray(new Object[]{}));
			pages = total%pageSize==0?total/pageSize:(total/pageSize+1);
			logger.debug("list size=="+list.size()+"\ntotal="+total);
			areas = areaService.list(null, null, order, -1, -1);
		} catch (Exception e) {
			logger.error("Org list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_10, e);
			throw new MyException(MyException.ERROR_CODE_10, "查询学校或单位列表出错");
		}
		return "list";
	}
	public String add() throws MyException {
		try {
			if(null!=org && StringUtils.isNotBlank(org.getName()) && areaId!=0) {
				org.setName(StringUtils.trim(org.getName()));
				int maxOrderby = orgService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Organization org2 = new Organization();
				BeanUtils.copyProperties(org, org2, new String[]{"id", "orderby"});
				org2.setOrderby(maxOrderby);
				org2.setArea(areaService.get(areaId));
				orgService.save(org2);
			}
		} catch (Exception e) {
			logger.error("Org add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_9, e);
			throw new MyException(MyException.ERROR_CODE_9, "保存学校或单位信息出错");
		}
		return "toList";
	}
	public void checkName() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{\"exist\":");
			if(null!=org && StringUtils.isNotBlank(org.getName())) {
				if(orgService.list(" where name=? ", new Object[]{org.getName().trim()}, null, -1, -1).size()>0) {//存在
					sb.append(true);
				} else {//不存在
					sb.append(false);
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("check Org name error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_11, e);
			throw new MyException(MyException.ERROR_CODE_11, "检查学校或单位名称是否存在出错");
		}
	}
	public void get() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=org && org.getId()!=0) {
				Organization org2 = orgService.get(org.getId());
				if(null!=org2) {
					sb.append("\"id\":"+org2.getId()).append(",\"name\":\""+org2.getName()+"\"").append(",\"orderby\":"+org2.getOrderby()).append(",\"areaId\":"+org2.getArea().getId());
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("Org get by id error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_12, e);
			throw new MyException(MyException.ERROR_CODE_12, "根据id获取学校或单位信息出错");
		}
	}
	public String edit() throws MyException {
		try {
			if(null!=org && org.getId()!=0 && StringUtils.isNotBlank(org.getName().trim()) && areaId!=0) {
				Organization org2 = orgService.get(org.getId());
				org2.setName(org.getName().trim());
				org2.setArea(areaService.get(areaId));
				orgService.update(org2);
			}
		} catch (Exception e) {
			logger.error("Org edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_13, e);
			throw new MyException(MyException.ERROR_CODE_13, "修改学校或单位信息出错");
		}
		return "toList";
	}
	public String del() throws MyException {
		try {
			if(null!=org && org.getId()!=0) {
				orgService.delete(org.getId());
			}
		} catch (Exception e) {
			logger.error("Org delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_14, e);
			throw new MyException(MyException.ERROR_CODE_14, "删除学校或单位信息出错");
		}
		return "toList";
	}
	public void moveup() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=org && org.getId()!=0) {
				orgService.moveup(org.getId(), name);
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("Org move up error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_15, e);
			throw new MyException(MyException.ERROR_CODE_15, "上移学校或单位出错");
		}
	}
	public void movedown() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=org && org.getId()!=0) {
				orgService.movedown(org.getId(), name);
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("Org move down error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_16, e);
			throw new MyException(MyException.ERROR_CODE_16, "下移学校或单位出错");
		}
	}
}

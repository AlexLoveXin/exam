package com.alex.exam.action;


import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;

import com.alex.exam.exception.MyException;
import com.alex.exam.init.Init;
import com.alex.exam.model.Area;
import com.alex.exam.model.Config;
import com.alex.exam.model.Organization;
import com.alex.exam.model.User;
import com.alex.exam.service.AreaService;
import com.alex.exam.service.OrgService;
import com.alex.exam.service.UserService;

/**
 * 用户action
 * @author 440
 *
 */
public class UserAction extends BaseAction {
	private Logger logger = LogManager.getLogger(UserAction.class);
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public UserService getUserService() {
		return userService;
	}
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
	private List<Organization> orgs;
	public void setOrgs(List<Organization> orgs) {
		this.orgs = orgs;
	}
	public List<Organization> getOrgs() {
		return orgs;
	}
	private List<Area> areas;
	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}
	public List<Area> getAreas() {
		return areas;
	}
	//提示信息
	private String info;
	private String ahref;
	private String acontent;
	public void setInfo(String info) {
		this.info = info;
	}
	public String getInfo() {
		return info;
	}
	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}
	public String getAcontent() {
		return acontent;
	}
	public void setAhref(String ahref) {
		this.ahref = ahref;
	}
	public String getAhref() {
		return ahref;
	}
	private User user;
	public void setUser(User user) {
		this.user = user;
	}
	public User getUser() {
		return user;
	}
	private int orgId;
	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}
	public int getOrgId() {
		return orgId;
	}
	public String frontregisteForm() throws MyException {
		//检查是否在注册开放时间段
		Config registedate = Init.getConfig().get(Init.DATES_REGISTE);
		boolean isopen = Init.checkBetweenDate(new Date(), registedate);
		if(isopen) {
			try {
				LinkedHashMap<String, String> order = new LinkedHashMap<>();
				order.put("orderby", "desc");
				orgs = orgService.list(null, null, order, -1, -1);
				areas = areaService.list(null, null, order, -1, -1);
			} catch (Exception e) {
				// TODO: handle exception
			}
			return "frontregisteForm";
		} else {
			info = "注册时间已过";
			ahref = "user/frontloginFormUser.do";
			acontent = "返回登录";
			return "info";
		}
	}
	public String frontregiste() throws MyException {
		try {
			if(null!=user && StringUtils.isNotBlank(user.getAccount()) && StringUtils.isNotBlank(user.getPassword()) && StringUtils.isNotBlank(user.getName()) && StringUtils.isNotBlank(user.getSex()) && StringUtils.isNotBlank(user.getMobile()) && orgId!=0) {
				user.setAccount(user.getAccount().trim());
				user.setUnpassword(user.getPassword().trim());
				user.setName(user.getName().trim());
				user.setSex(user.getSex().trim());
				user.setMobile(user.getMobile().trim());
				User user2 = new User();
				BeanUtils.copyProperties(user, user2, new String[] {"id","password","type","jie","orderby","registedate","org"});
				user2.setPassword(DigestUtils.md5Hex(user.getUnpassword()));
				user2.setType(EXAM_USERS);
				user2.setJie(Init.getConfig().get(Init.JIES).getValue());
				user2.setOrderby(userService.getMaxOrderby());
				user2.setRegistedate(new Date());
				user2.setOrg(orgService.get(orgId));
				userService.save(user2);
				logger.debug("user registed");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "frontloginForm";
	}
	public String frontloginForm() throws MyException {
		
		return "frontloginForm";
	}
	public String frontlogin() throws MyException {
		try {
			if(null!=user && StringUtils.isNotBlank(user.getAccount()) && StringUtils.isNotBlank(user.getPassword())) {
				if(userService.getTotal(" where account=? and password=? ", new Object[] {user.getAccount().trim(), DigestUtils.md5Hex(user.getPassword().trim())})>0L) {
					logger.debug("login success");
				} else {
					acontent = "返回登录";
					ahref = "user/frontloginFormUser.do";
					info = "账号或密码错误";
					return "info";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "frontindex";
	}
	public void checkAccount() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{\"exist\":");
			if(null!=user && StringUtils.isNotBlank(user.getAccount())) {
				if(userService.list(" where account=? ", new Object[]{user.getAccount().trim()}, null, -1, -1).size()>0) {//存在
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
	private int page;
	private String account;
	private String name;
	private String jie;
	private List<User> list;
	private long total;
	private long pages;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setJie(String jie) {
		this.jie = jie;
	}
	public String getJie() {
		return jie;
	}
	public List<User> getList() {
		return list;
	}
	public void setList(List<User> list) {
		this.list = list;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public long getPages() {
		return pages;
	}
	public void setPages(long pages) {
		this.pages = pages;
	}
	public String managelist() throws MyException {
		try {
			if(page==0) {
				page=1;
			}
			int pageSize = PAGE_SIZE;
			String where = " where type=? ";
			List<Object> params = new ArrayList<Object>();
			params.add(MANAGE_USERS);
			if(StringUtils.isNotBlank(account)) {
				where += " and account like ? ";
				params.add("%"+StringUtils.trim(account)+"%");
			}
			if(StringUtils.isNotBlank(name)) {
				where += " and name like ? ";
				params.add("%"+StringUtils.trim(name)+"%");
			}
			LinkedHashMap<String, String> order = new LinkedHashMap<>();
			order.put("orderby", "desc");
			list = userService.list(where, params.toArray(new Object[]{}), order, page, pageSize);
			total = userService.getTotal(where, params.toArray(new Object[]{}));
			pages = total%pageSize==0?total/pageSize:(total/pageSize+1);
			logger.debug("list size=="+list.size()+"\ntotal="+total);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "back_mamagelist";
	}
	public String examlist() throws MyException {
		try {
			if(page==0) {
				page=1;
			}
			int pageSize = PAGE_SIZE;
			String where = " where type=? ";
			List<Object> params = new ArrayList<Object>();
			params.add(EXAM_USERS);
			if(StringUtils.isNotBlank(account)) {
				where += " and account like ? ";
				params.add("%"+StringUtils.trim(account)+"%");
			}
			if(StringUtils.isNotBlank(name)) {
				where += " and name like ? ";
				params.add("%"+StringUtils.trim(name)+"%");
			}
			if(StringUtils.isNotBlank(jie) && Integer.parseInt(jie)!=0) {
				where += " and jie = ? ";
				params.add(StringUtils.trim(jie));
			}
			if(orgId!=0) {
				where += " and org.id = ? ";
				params.add(orgId);
			}
			LinkedHashMap<String, String> order = new LinkedHashMap<>();
			order.put("orderby", "desc");
			list = userService.list(where, params.toArray(new Object[]{}), order, page, pageSize);
			total = userService.getTotal(where, params.toArray(new Object[]{}));
			pages = total%pageSize==0?total/pageSize:(total/pageSize+1);
			logger.debug("list size=="+list.size()+"\ntotal="+total);
			orgs = orgService.list(null, null, order, -1, -1);
			areas = areaService.list(null, null, order, -1, -1);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "back_examlist";
	}
	public String userexamdel() throws MyException {
		
		return "toexamlist";
	}
}

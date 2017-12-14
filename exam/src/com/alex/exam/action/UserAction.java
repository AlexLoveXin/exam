package com.alex.exam.action;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alex.exam.exception.MyException;
import com.alex.exam.init.Init;
import com.alex.exam.model.Config;
import com.alex.exam.model.Organization;
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
	private List<Organization> orgs;
	public void setOrgs(List<Organization> orgs) {
		this.orgs = orgs;
	}
	public List<Organization> getOrgs() {
		return orgs;
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
	public String frontregisteForm() throws MyException {
		//检查是否在注册开放时间段
		Config registedate = Init.getConfig().get(Init.DATES_REGISTE);
		boolean isopen = Init.checkBetweenDate(new Date(), registedate);
		if(isopen) {
			try {
				LinkedHashMap<String, String> order = new LinkedHashMap<>();
				order.put("orderby", "desc");
				orgs = orgService.list(null, null, order, -1, -1);
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
	public String frontloginForm() throws MyException {
		
		return "frontloginForm";
	}
}

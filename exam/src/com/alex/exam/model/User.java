package com.alex.exam.model;
/**
 * 用户model
 * @author 440
 *
 */

import java.util.Date;

public class User {                                   
	private int id;                                   //主键
	private String account;                           //账号，同idcard
	private String password;                          //密码（密文）
	private String unpassword;                        //密码（明文）
	private String name;                              //姓名
	private String sex;                               //性别
	private String mobile;                            //手机号
	private String idcard;                            //身份证号
	private Date birthday;                            //生日
	private String type;                              //类型，考试人员|后台管理
	private String jie;                               //届
	private int orderby;                              //排序
	private Date registedate;                         //注册时间
	private Organization org;                         //学校或单位
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUnpassword() {
		return unpassword;
	}
	public void setUnpassword(String unpassword) {
		this.unpassword = unpassword;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getJie() {
		return jie;
	}
	public void setJie(String jie) {
		this.jie = jie;
	}
	public Organization getOrg() {
		return org;
	}
	public void setOrg(Organization org) {
		this.org = org;
	}
	public void setOrderby(int orderby) {
		this.orderby = orderby;
	}
	public int getOrderby() {
		return orderby;
	}
	public void setRegistedate(Date registedate) {
		this.registedate = registedate;
	}
	public Date getRegistedate() {
		return registedate;
	}
}

package com.alex.exam.model;
/**
 * 地区
 * @author Alex
 *
 */
public class Area {
	private int id;                        //主键
	private String name;                   //地区名
	private int orderby;                   //排序字段
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getOrderby() {
		return orderby;
	}
	public void setOrderby(int orderby) {
		this.orderby = orderby;
	}
	
}

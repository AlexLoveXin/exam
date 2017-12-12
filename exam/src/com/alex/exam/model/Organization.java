package com.alex.exam.model;
/**
 * 学校或单位
 * @author Alex
 *
 */
public class Organization {
	private int id;                    //主键
	private String name;               //名称
	private int orderby;               //排序字段
	private Area area;                 //地区，多对一
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
	public Area getArea() {
		return area;
	}
	public void setArea(Area area) {
		this.area = area;
	}
}

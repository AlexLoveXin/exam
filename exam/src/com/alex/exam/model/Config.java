package com.alex.exam.model;
/**
 * 系统配置
 * @author Alex
 *
 */
public class Config {                      
	private int id;                        //主键
	private String key;                    //键
	private String value;                  //值
	private String valuetype;              //值类型，用来转换类型
	private String condition;              //区间,时间配置：xxxx-xx-xx xx:xx:xx|xxxx-xx-xx xx:xx:xx,分数配置：10|20
	private String type;                   //用于分数配置，加分|设置分
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getValuetype() {
		return valuetype;
	}
	public void setValuetype(String valuetype) {
		this.valuetype = valuetype;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}

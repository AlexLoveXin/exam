package com.alex.exam.action;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;

import com.alex.exam.exception.MyException;
import com.alex.exam.init.Init;
import com.alex.exam.model.Config;
import com.alex.exam.service.ConfigService;

/**
 * 系统配置action
 * @author 440
 *
 */
public class ConfigAction extends BaseAction {
	private Logger logger = LogManager.getLogger(ConfigAction.class);
	private ConfigService configService;
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}
	public ConfigService getConfigService() {
		return configService;
	}
	private Config config;
	public void setConfig(Config config) {
		this.config = config;
	}
	public Config getConfig() {
		return config;
	}
	private List<Config> list;
	public void setList(List<Config> list) {
		this.list = list;
	}
	public List<Config> getList() {
		return list;
	}
	public String times() throws MyException {
		try {
			HashMap<String, Config> configs = Init.getConfig();
			list = new ArrayList<>();
			Set<String> keys = configs.keySet();
			for (String key : keys) {
				if(key.indexOf("TIMES")!=-1) {//CS_TIME,CS_EXAM_
					list.add(configs.get(key));
				}
			}
			logger.debug("list size=="+list.size());
		} catch (Exception e) {
			logger.error("Area list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_2, e);
			throw new MyException(MyException.ERROR_CODE_2, "查询地区列表出错");
		}
		return "times";
	}
	public String timeadd() throws MyException {
		try {
			if(null!=config && StringUtils.isNotBlank(config.getKey()) && StringUtils.isNotBlank(config.getValue()) && StringUtils.isNotBlank(config.getTitle())) {
				config.setKey(config.getKey().trim());
				config.setTitle(config.getTitle().trim());
				config.setValue(config.getValue().trim());
				int maxOrderby = configService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Config config2 = new Config();
				BeanUtils.copyProperties(config, config2, new String[]{"id", "valuetype", "condition", "type", "orderby"});
				config2.setOrderby(maxOrderby);
				config2.setValuetype("Integer");
				configService.save(config2);
				//将配置加到缓存中
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("Area add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_1, e);
			throw new MyException(MyException.ERROR_CODE_1, "保存地区信息出错");
		}
		return "totimes";
	}
	public void checkKey() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{\"exist\":");
			if(null!=config && StringUtils.isNotBlank(config.getKey())) {
				HashMap<String, Config> configs = Init.getConfig();
				Set<String> keys = configs.keySet();
				boolean exist = false;
				for (String key : keys) {
					if(key.equals(config.getKey())) {
						exist = true;
						break;
					}
				}
				sb.append(exist);
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
			if(null!=config && config.getId()!=0) {
				Config config2 = configService.get(config.getId());
				if(null!=config2) {
					sb.append("\"id\":"+config2.getId()).append(",\"key\":\""+config2.getKey()+"\"").append(",\"title\":"+config2.getTitle()).append(",\"value\":"+config2.getValue()).append(",\"valuetype\":"+config2.getValuetype()).append(",\"condition\":"+config2.getCondition()).append(",\"type\":"+config2.getType()).append(",\"orderby\":"+config2.getOrderby());
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("area get by id error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_4, e);
			throw new MyException(MyException.ERROR_CODE_4, "根据id获取地区信息出错");
		}
	}
	public String timeedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getValue().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle());
				config2.setValue(config.getValue());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("area edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_5, e);
			throw new MyException(MyException.ERROR_CODE_5, "修改地区信息出错");
		}
		return "totimes";
	}
	public String timedel() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey())) {
				configService.delete(config.getId());
				//在缓存中移除
				Init.getConfig().remove(config.getKey().trim());
			}
		} catch (Exception e) {
			logger.error("area delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_6, e);
			throw new MyException(MyException.ERROR_CODE_6, "删除地区信息出错");
		}
		return "totimes";
	}
	public String jieadd() throws MyException {
		try {
			if(null!=config && StringUtils.isNotBlank(config.getKey()) && StringUtils.isNotBlank(config.getValue()) && StringUtils.isNotBlank(config.getTitle())) {
				config.setKey(config.getKey().trim());
				config.setTitle(config.getTitle().trim());
				config.setValue(config.getValue().trim());
				int maxOrderby = configService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Config config2 = new Config();
				BeanUtils.copyProperties(config, config2, new String[]{"id", "valuetype", "condition", "type", "orderby"});
				config2.setOrderby(maxOrderby);
				config2.setValuetype("String");
				configService.save(config2);
				//将配置加到缓存中
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("Area add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_1, e);
			throw new MyException(MyException.ERROR_CODE_1, "保存地区信息出错");
		}
		return "todates";
	}
	public String jieedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getValue().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle());
				config2.setValue(config.getValue());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("area edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_5, e);
			throw new MyException(MyException.ERROR_CODE_5, "修改地区信息出错");
		}
		return "todates";
	}
	public String datedel() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey())) {
				configService.delete(config.getId());
				//在缓存中移除
				Init.getConfig().remove(config.getKey().trim());
			}
		} catch (Exception e) {
			logger.error("area delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_6, e);
			throw new MyException(MyException.ERROR_CODE_6, "删除地区信息出错");
		}
		return "todates";
	}
	public String dateadd() throws MyException {
		try {
			if(null!=config && StringUtils.isNotBlank(config.getKey()) && StringUtils.isNotBlank(config.getCondition()) && StringUtils.isNotBlank(config.getTitle())) {
				config.setKey(config.getKey().trim());
				config.setTitle(config.getTitle().trim());
				config.setValue(config.getCondition().trim());
				int maxOrderby = configService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Config config2 = new Config();
				BeanUtils.copyProperties(config, config2, new String[]{"id", "valuetype", "value", "type", "orderby"});
				config2.setOrderby(maxOrderby);
				configService.save(config2);
				//将配置加到缓存中
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("Area add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_1, e);
			throw new MyException(MyException.ERROR_CODE_1, "保存地区信息出错");
		}
		return "todates";
	}
	public String dateedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getCondition().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle());
				config2.setCondition(config.getCondition());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("area edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_5, e);
			throw new MyException(MyException.ERROR_CODE_5, "修改地区信息出错");
		}
		return "todates";
	}
	private List<Config> jies;
	public void setJies(List<Config> jies) {
		this.jies = jies;
	}
	public List<Config> getJies() {
		return jies;
	}
	private List<Config> dates;
	public void setDates(List<Config> dates) {
		this.dates = dates;
	}
	public List<Config> getDates() {
		return dates;
	}
	public String dates() throws MyException {
		try {
			HashMap<String, Config> configs = Init.getConfig();
			dates = new ArrayList<>();
			jies = new ArrayList<>();
			Set<String> keys = configs.keySet();
			for (String key : keys) {
				if(key.indexOf("DATES")!=-1) {
					dates.add(configs.get(key));
				} else if(key.indexOf("JIES")!=-1) {
					jies.add(configs.get(key));
				}
			}
			logger.debug("dates size=="+dates.size()+"\njies size="+jies.size());
		} catch (Exception e) {
			logger.error("Area list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_2, e);
			throw new MyException(MyException.ERROR_CODE_2, "查询地区列表出错");
		}
		return "dates";
	}
}

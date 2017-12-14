package com.alex.exam.action;


import java.util.ArrayList;
import java.util.Comparator;
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
			if(list.size()>0) {
				list.sort(new Comparator<Config>() {

					@Override
					public int compare(Config conf1, Config conf2) {
						return conf2.getOrderby()-conf1.getOrderby();
					}
				});
			}
			logger.debug("list size=="+list.size());
		} catch (Exception e) {
			logger.error("time list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_17, e);
			throw new MyException(MyException.ERROR_CODE_17, "查询考试次数出错");
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
			logger.error("time config add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_18, e);
			throw new MyException(MyException.ERROR_CODE_18, "新增考试次数配置出错");
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
			logger.error("check config key error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_19, e);
			throw new MyException(MyException.ERROR_CODE_19, "检查配置key是否存在出错");
		}
	}
	public void get() throws MyException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			if(null!=config && config.getId()!=0) {
				Config config2 = configService.get(config.getId());
				if(null!=config2) {
					sb.append("\"id\":"+config2.getId()).append(",\"key\":\""+config2.getKey()+"\"").append(",\"title\":\""+config2.getTitle()+"\"").append(",\"value\":\""+config2.getValue()+"\"").append(",\"valuetype\":\""+config2.getValuetype()+"\"").append(",\"condition\":\""+config2.getCondition()+"\"").append(",\"type\":\""+config2.getType()+"\"").append(",\"orderby\":"+config2.getOrderby());
				}
			}
			sb.append("}");
			printJson(sb.toString());
		} catch (Exception e) {
			logger.error("config get by id error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_20, e);
			throw new MyException(MyException.ERROR_CODE_20, "根据id获取配置信息出错");
		}
	}
	public String timeedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getValue().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle().trim());
				config2.setValue(config.getValue().trim());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("time config edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_21, e);
			throw new MyException(MyException.ERROR_CODE_21, "修改考试次数配置出错");
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
			logger.error("time config delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_22, e);
			throw new MyException(MyException.ERROR_CODE_22, "删除考试次数配置出错");
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
			logger.error("jie config add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_23, e);
			throw new MyException(MyException.ERROR_CODE_23, "新增届配置出错");
		}
		return "todates";
	}
	public String jieedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getValue().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle().trim());
				config2.setValue(config.getValue().trim());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("jie config edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_24, e);
			throw new MyException(MyException.ERROR_CODE_24, "修改届配置出错");
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
			logger.error("date config delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_25, e);
			throw new MyException(MyException.ERROR_CODE_25, "删除日期配置出错");
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
			logger.error("date config add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_26, e);
			throw new MyException(MyException.ERROR_CODE_26, "新增日期配置出错");
		}
		return "todates";
	}
	public String dateedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getCondition().trim())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle().trim());
				config2.setCondition(config.getCondition().trim());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("date config edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_27, e);
			throw new MyException(MyException.ERROR_CODE_27, "修改日期配置出错");
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
			if(jies.size()>0) {
				jies.sort(new Comparator<Config>() {

					@Override
					public int compare(Config config1, Config config2) {
						return config2.getOrderby()-config1.getOrderby();
					}
					
				});
			}
			if(dates.size()>0) {
				dates.sort(new Comparator<Config>() {

					@Override
					public int compare(Config config1, Config config2) {
						return config2.getOrderby()-config1.getOrderby();
					}
					
				});
			}
			logger.debug("dates size=="+dates.size()+"\njies size="+jies.size());
		} catch (Exception e) {
			logger.error("date config list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_28, e);
			throw new MyException(MyException.ERROR_CODE_28, "查询日期配置出错");
		}
		return "dates";
	}
	public String scores() throws MyException {
		try {
			HashMap<String, Config> configs = Init.getConfig();
			list = new ArrayList<>();
			Set<String> keys = configs.keySet();
			for (String key : keys) {
				if(key.indexOf("SCORES")!=-1) {
					list.add(configs.get(key));
				}
			}
			if(list.size()>0) {
				list.sort(new Comparator<Config>() {

					@Override
					public int compare(Config config1, Config config2) {
						return config2.getOrderby()-config1.getOrderby();
					}
					
				});
			}
			logger.debug("list size=="+list.size());
		} catch (Exception e) {
			logger.error("score config list error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_29, e);
			throw new MyException(MyException.ERROR_CODE_29, "查询分数配置出错");
		}
		return "scores";
	}
	public String scoreadd() throws MyException {
		try {
			if(null!=config && StringUtils.isNotBlank(config.getKey()) && StringUtils.isNotBlank(config.getCondition()) && StringUtils.isNotBlank(config.getTitle()) && StringUtils.isNotBlank(config.getType()) && StringUtils.isNotBlank(config.getValue())) {
				config.setKey(config.getKey().trim());
				config.setTitle(config.getTitle().trim());
				config.setCondition(config.getCondition().trim());
				config.setType(config.getType().trim());
				config.setValue(config.getValue().trim());
				int maxOrderby = configService.getMaxOrderby();
				logger.debug("maxOrderby=="+maxOrderby);
				Config config2 = new Config();
				BeanUtils.copyProperties(config, config2, new String[]{"id", "valuetype", "orderby"});
				config2.setOrderby(maxOrderby);
				config2.setValuetype("Integer");
				configService.save(config2);
				//将配置加到缓存中
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("score config add error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_30, e);
			throw new MyException(MyException.ERROR_CODE_30, "新增分数配置信息出错");
		}
		return "toscores";
	}
	public String scoreedit() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey().trim()) && StringUtils.isNotBlank(config.getTitle().trim()) && StringUtils.isNotBlank(config.getCondition().trim()) && StringUtils.isNotBlank(config.getType().trim()) && StringUtils.isNotBlank(config.getValue())) {
				Config config2 = configService.get(config.getId());
				config2.setTitle(config.getTitle().trim());
				config2.setCondition(config.getCondition().trim());
				config2.setType(config.getType().trim());
				config2.setValue(config.getValue().trim());
				configService.update(config2);
				//缓存中替换掉
				Init.getConfig().put(config2.getKey(), config2);
			}
		} catch (Exception e) {
			logger.error("score config edit error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_31, e);
			throw new MyException(MyException.ERROR_CODE_31, "修改分数配置信息出错");
		}
		return "toscores";
	}
	public String scoredel() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(config.getKey())) {
				configService.delete(config.getId());
				//在缓存中移除
				Init.getConfig().remove(config.getKey().trim());
			}
		} catch (Exception e) {
			logger.error("score config delete error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_32, e);
			throw new MyException(MyException.ERROR_CODE_32, "删除分数配置信息出错");
		}
		return "toscores";
	}
	//上移，下移时分辨是次数、日期、分数
	private String type;
	public void setType(String type) {
		this.type = type;
	}
	public String getType() {
		return type;
	}
	public void moveup() throws MyException {
		try {
			if(null!=config && config.getId()!=0 && StringUtils.isNotBlank(type)) {
				configService.moveup(config.getId(), type.trim());
			}
		} catch (Exception e) {
			logger.error("config moveup error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_33, e);
			throw new MyException(MyException.ERROR_CODE_33, "上移配置出错");
		}
	}
	public void movedown() throws MyException {
		try {
			configService.movedown(config.getId(), type.trim());
		} catch (Exception e) {
			logger.error("config movedown error! "+MyException.position(e)+" errorCode:"+MyException.ERROR_CODE_34, e);
			throw new MyException(MyException.ERROR_CODE_34, "下移配置出错");
		}
	}
}

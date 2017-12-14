package com.alex.exam.init;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.alex.exam.model.Config;
import com.alex.exam.service.ConfigService;

/**
 * 系统初始化加载此类，包含系统配置等
 * @author 440
 *
 */
public class Init {
	public static final String DATES_REGISTE = "DATES_REGISTE";
	private ConfigService configService;
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}
	public ConfigService getConfigService() {
		return configService;
	}
	private static HashMap<String, Config> config;//系统配置
	public static HashMap<String, Config> getConfig() {
		return config;
	}
	/**
	 * 初始化方法
	 */
	public void init() {
		config = new LinkedHashMap<>();
		LinkedHashMap<String, String> order = new LinkedHashMap<>();
		order.put("orderby", "desc");
		List<Config> configs = configService.list(null, null, order, -1, -1);
		for (Config conf : configs) {
			config.put(conf.getKey(), conf);
		}
	}
	/**
	 * 配置模块，
	 * 检查目标时间是否在时间配置的时间段内
	 * @param targetDate 需要检查的时间
	 * @param config 时间配置实例
	 * @return 返回true，在区间内，false，不在区间内
	 */
	public static boolean checkBetweenDate(Date targetDate, Config config) {
		boolean isopen = false;
		if(null!=config && StringUtils.isNotBlank(config.getCondition())) {
			String[] dates = config.getCondition().trim().split("\\|");
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date start = sdf.parse(dates[0]);
				Date end = sdf.parse(dates[1]);
				if(start.before(new Date()) && end.after(new Date())) {
					isopen = true;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return isopen;
	}
}

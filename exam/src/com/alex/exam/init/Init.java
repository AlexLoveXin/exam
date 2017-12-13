package com.alex.exam.init;
/**
 * 系统初始化加载此类，包含系统配置等
 * @author 440
 *
 */

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.alex.exam.model.Config;
import com.alex.exam.service.ConfigService;

public class Init {
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
}

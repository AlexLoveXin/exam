package com.alex.exam.action;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
/**
 * 基本action
 * @author 440
 *
 */
public abstract class BaseAction {
	public static final int PAGE_SIZE = 10;
	/**
	 * 获取HttpServletResponse
	 * @return
	 */
	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}
	/**
	 * 输出json字符串
	 * @param jsonString json字符串
	 * @throws Exception
	 */
	public void printJson(String jsonString) throws Exception {
		HttpServletResponse response = getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();//writer可以发送中文，stream无法发送中文
		out.println(jsonString);
	}
}

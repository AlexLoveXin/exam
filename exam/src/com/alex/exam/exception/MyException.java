package com.alex.exam.exception;
/**
 * 自定义错误类
 * @author 440
 *
 */
public class MyException extends Exception {
	
	private static final long serialVersionUID = 4350971111012050425L;
	public static final String ERROR_CODE_1 = "1";
	public static final String ERROR_CODE_2 = "2";
	public static final String ERROR_CODE_3 = "3";
	public static final String ERROR_CODE_4 = "4";
	public static final String ERROR_CODE_5 = "5";
	public static final String ERROR_CODE_6 = "6";
	public static final String ERROR_CODE_7 = "7";
	public static final String ERROR_CODE_8 = "8";
	public static final String ERROR_CODE_9 = "9";
	public static final String ERROR_CODE_10 = "10";
	public static final String ERROR_CODE_11 = "11";
	public static final String ERROR_CODE_12 = "12";
	public static final String ERROR_CODE_13 = "13";
	public static final String ERROR_CODE_14 = "14";
	public static final String ERROR_CODE_15 = "15";
	public static final String ERROR_CODE_16 = "16";
	private String errorCode;                    //自定义错误代码
	private String errorMsg;                     //自定义错误信息
	public MyException(String errorCode, String errorMsg) {
		this.errorCode = errorCode;
		this.errorMsg = errorMsg;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	/**
	 * 异常发生的位置
	 * @param e 异常
	 * @return
	 */
	public static String position(Exception e) {
		StackTraceElement[] eles = e.getStackTrace();
		StackTraceElement ele = null;
		for(StackTraceElement element : eles) {
			if(element.getClassName().indexOf("com.alex.exam.action.")!=-1) {
				ele = element;
				break;
			}
		}
		if(null!=ele) {
			return "position=="+ele.getClassName()+" "+ele.getMethodName()+" "+ele.getLineNumber();
		}
		return "";
	}
	
}

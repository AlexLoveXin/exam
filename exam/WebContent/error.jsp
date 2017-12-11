<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isErrorPage="true"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=edge"><!-- 优先以ie的edge模式打开页面 -->
<meta name="viewport" content="width=device-width,initial-scale=1"><!-- 适配移动端 -->
<meta name="renderer" content="webkit"><!-- 刷新优先以google模式显示页面 -->
<title>考试平台-错误页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
<div class="jumbotron">
    <div class="container">
        <p class="text-danger" style="font-size: 63px;"><span class="glyphicon glyphicon-remove-sign"></span>真糟糕，出现错误！</p>
        <p>错误代码：<s:property value="exception.errorCode"/></p>
        <p>错误发生时间：<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) %></p>
        <p>错误信息：<s:property value="exception.errorMsg"/></p>
        <p><button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';">返回首页</button></p>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.js"></script>
</body>
</html>
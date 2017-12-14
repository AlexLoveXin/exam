<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=edge"><!-- 优先以ie的edge模式打开页面 -->
<meta name="viewport" content="width=device-width,initial-scale=1"><!-- 适配移动端 -->
<meta name="renderer" content="webkit"><!-- 刷新优先以google模式显示页面 -->
<title>考试平台-注册</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/front_login.css">
</head>
<body>
<div class="container">
	<form class="form-signin" method="post" action="#"><!-- ${pageContext.request.contextPath }/user/frontregisteUser.do -->
    <h2 class="form-signin-heading">考试平台注册</h2>
    <div class="form-group">
	    <label for="userregisteaccount" class="sr-only">账号</label>
	    <input type="text" id="userregisteaccount" class="form-control" placeholder="账号" name="user.account" required autofocus>
    </div>
    <div class="form-group">
	    <label for="userregistepassword" class="sr-only">密码</label>
	    <input type="password" id="userregistepassword" class="form-control" placeholder="密码" name="user.password" required>
    </div>
    <div class="form-group">
	    <label for="userregistename" class="sr-only">姓名</label>
	    <input type="text" id="userregistename" class="form-control" placeholder="姓名" name="user.name" required>
    </div>
    <div class="form-group">
    	<label class="radio-inline">
    		<input type="radio" id="userregistesexmale" name="user.sex" required>&nbsp;男
    	</label>
    	<label class="radio-inline">
    		<input type="radio" id="userregistesexfemale" name="user.sex" required>&nbsp;女
    	</label>
    </div>
    <div class="form-group">
	    <label for="userregistemobile" class="sr-only">手机号</label>
	    <input type="text" id="userregistemobile" class="form-control" placeholder="手机号" name="user.mobile" required>
    </div>
    <div class="form-group">
	    <label for="userregisteidcard" class="sr-only">身份证号</label>
	    <input type="text" id="userregisteidcard" class="form-control" placeholder="身份证号" name="user.idcard">
    </div>
    <div class="form-group">
	    <label for="userregistebirthday" class="sr-only">出生日期</label>
	    <input type="date" id="userregistebirthday" class="form-control" placeholder="出生日期" name="user.birthday">
    </div>
    <div class="form-group">
	    <label for="userregisteorg" class="sr-only">学校或单位</label>
	    <select class="form-control" name="orgId" id="userregisteorg" required>
	    	<option value="0">--请选择学校或单位--</option>
	    	<c:forEach items="${orgs }" var="org">
	    	<option value="${org.id }">${org.name }</option>
	    	</c:forEach>
	    </select>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">注册<span class="sr-only">注册</span></button>
    <button class="btn btn-lg btn-primary btn-block" type="button" onclick="window.location.href='${pageContext.request.contextPath}/user/frontloginFormUser.do';">返回登录<span class="sr-only">返回登录</span></button>
    </form>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
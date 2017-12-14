<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=edge"><!-- 优先以ie的edge模式打开页面 -->
<meta name="viewport" content="width=device-width,initial-scale=1"><!-- 适配移动端 -->
<meta name="renderer" content="webkit"><!-- 刷新优先以google模式显示页面 -->
<title>考试平台-登录</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/front_login.css">
</head>
<body>
<div class="container">
	<form class="form-signin" method="post" action="${pageContext.request.contextPath }/user/frontloginUser.do">
    <h2 class="form-signin-heading">考试平台登录</h2>
    <div class="form-group">
	    <label for="userloginaccount" class="sr-only">账号</label>
	    <input type="text" id="userloginaccount" class="form-control" placeholder="账号" name="user.account" required autofocus>
    </div>
    <div class="form-group">
	    <label for="userloginpassword" class="sr-only">密码</label>
	    <input type="password" id="userloginpassword" class="form-control" placeholder="密码" name="user.password" required>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">登录<span class="sr-only">登录</span></button>
    <p>没有账号，请<a href="${pageContext.request.contextPath }/user/frontregisteFormUser.do">注册<span class="sr-only">注册</span></a></p>
    </form>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
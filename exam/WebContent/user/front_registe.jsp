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
	<form class="form" id="userregisteform" style="max-width: 330px;padding: 15px;margin: 0 auto;" method="post" action="${pageContext.request.contextPath }/user/frontregisteUser.do">
    <h2 class="form-signin-heading">考试平台注册</h2>
    <div class="form-group has-feedback" id="userregisteaccountFormGroup">
	    <label for="userregisteaccount" class="sr-only">账号</label>
	    <input type="text" id="userregisteaccount" class="form-control" placeholder="账号" name="user.account" required autofocus>
	    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
    </div>
    <div class="form-group has-feedback">
	    <label for="userregistepassword" class="sr-only">密码</label>
	    <input type="password" id="userregistepassword" class="form-control" placeholder="密码" name="user.password" required>
	    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
    </div>
    <div class="form-group has-feedback">
	    <label for="userregistename" class="sr-only">姓名</label>
	    <input type="text" id="userregistename" class="form-control" placeholder="姓名" name="user.name" required>
	    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
    </div>
    <div class="form-group">
    	<label class="radio-inline">
    		<input type="radio" id="userregistesexmale" name="user.sex" value="男" required>&nbsp;男
    	</label>
    	<label class="radio-inline">
    		<input type="radio" id="userregistesexfemale" name="user.sex" value="女" required>&nbsp;女
    	</label>
    </div>
    <div class="form-group has-feedback">
	    <label for="userregistemobile" class="sr-only">手机号</label>
	    <input type="text" id="userregistemobile" class="form-control" placeholder="手机号" name="user.mobile" required>
	    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
    </div>
    <div class="form-group">
	    <label for="userregisteidcard" class="sr-only">身份证号</label>
	    <input type="text" id="userregisteidcard" class="form-control" placeholder="身份证号" name="user.idcard">
    </div>
    <div class="form-group">
	    <label for="userregistebirthday" class="">出生日期</label>
	    <input type="date" id="userregistebirthday" class="form-control" placeholder="出生日期" name="user.birthday">
    </div>
    <div class="form-group" id="userregisteorgFormGroup">
	    <label for="userregisteorg" class="sr-only">学校或单位</label>
	    <select class="form-control" name="orgId" id="userregisteorg">
	    	<option value="0">--请选择学校或单位--</option>
	    	<c:forEach items="${areas }" var="area">
	    	<optgroup label="${area.name }">
	    		<c:forEach items="${orgs }" var="org">
	    		<c:if test="${area.id==org.area.id }">
		    	<option value="${org.id }">${org.name }</option>
		    	</c:if>
		    	</c:forEach>
	    	</optgroup>
	    	</c:forEach>
	    </select>
    </div>
    <button class="btn btn-primary btn-block disabled" type="button" id="userregistebtn">注册<span class="sr-only">注册</span></button>
    <button class="btn btn-primary btn-block" type="button" onclick="window.location.href='${pageContext.request.contextPath}/user/frontloginFormUser.do';">返回登录<span class="sr-only">返回登录</span></button>
    </form>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
	var exist = true;
	var orgselect = false;
	var accountisnull = true;
	
	function registe() {
		if($('#userregisteorg').val()=='0') {
			$('#userregisteorgFormGroup').addClass('has-error');
			return;
		}
		if($.trim($('#userregisteaccount').val())!='') {
			$.post('${pageContext.request.contextPath}/user/checkAccountUser.do',{"user.account":$.trim($('#userregisteaccount').val())},function(result){
				if(result.indexOf('<html')==-1) {
					var r = eval('('+result+')');
					if(r.exist) {
						$('#userregisteaccountFormGroup').addClass('has-error');
						return;
					} else {
						$('#userregisteform').submit();
					}
				} else {
					return;
				}
			});
		}
	}
	$(function(){
		$('#userregisteorg').on('change', function(){
			if($('#userregisteorg').val()=='0') {
				orgselect = false;
				$('#userregisteorgFormGroup').addClass('has-error');
			} else {
				orgselect = true;
				$('#userregisteorgFormGroup').removeClass('has-error');
			}
			if(!exist && orgselect && !accountisnull) {
				$('#userregistebtn').removeClass('disabled');
				$('#userregistebtn').attr('type','submit');
			} else {
				$('#userregistebtn').addClass('disabled');
				$('#userregistebtn').attr('type','button');
			}
		});
		$('#userregisteaccount').on('keydown', function(){
			$('#userregisteaccountFormGroup').removeClass('has-error');
		});
		$('#userregisteaccount').on('blur', function(){
			console.info($('#userregisteaccount').val());
			if($.trim($('#userregisteaccount').val())!='') {
				accountisnull = false;
				console.info($('#userregisteaccount').val());
				$.post('${pageContext.request.contextPath}/user/checkAccountUser.do',{"user.account":$.trim($('#userregisteaccount').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						exist = r.exist;
					} else {
						exist = true;
					}
					if(!exist && orgselect && !accountisnull) {
						$('#userregistebtn').removeClass('disabled');
						$('#userregistebtn').attr('type','submit');
					} else {
						$('#userregistebtn').addClass('disabled');
						$('#userregistebtn').attr('type','button');
					}
				});
			} else {
				accountisnull = true;
			}
		});
	});
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
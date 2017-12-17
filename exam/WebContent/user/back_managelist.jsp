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
<title>管理平台-用户管理-管理用户</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/manage.css">
</head>
<body>
<form id="userinitpasswordform" action="${pageContext.request.contextPath }/user/usermanageinitpasswordUser.do" method="post">
	<input type="hidden" name="user.id" id="userinitpasswordid">
</form>
<div class="modal fade in" id="userdelconfirm" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">删除确认<span class="sr-only">删除确认</span></h4>
            </div>
            <div class="modal-body">
                <p>确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="否">否</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="userdel();">是</button>
            </div>
        </div>
    </div>
</div>
<!-- 删除数据form -->
<form id="userdelform" action="${pageContext.request.contextPath }/user/usermanagedelUser.do" method="post">
	<input type="hidden" name="user.id" id="userdelid">
</form>
<!-- 删除确认弹出框 -->
<div class="modal fade in" id="userdelconfirm" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">删除确认<span class="sr-only">删除确认</span></h4>
            </div>
            <div class="modal-body">
                <p>确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="否">否</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="userdel();">是</button>
            </div>
        </div>
    </div>
</div>
<!-- 提示框 -->
<div id="popover" class="popover" role="tooltip" aria-labelledby="提示">
    <div class="arrow"></div>
    <h3 class="popover-title">
        <button id="closepopover" type="button" class="close" aria-label="关闭提示">&times;</button>
        <span class="popovertitle"></span>
    </h3>
    <div class="popover-content"></div>
</div>
<!-- 修改modal -->
<div class="modal fade" id="usereditmodal" role="dialog" tabindex="-1" aria-labelledby="修改窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改用户<span class="sr-only">修改用户</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="usereditform" method="post" action="${pageContext.request.contextPath }/user/manageusereditUser.do">
                    <div class="form-group" id="usereditaccountFormGroup">
					    <label for="usereditaccount" class="control-label col-md-2 col-sm-2">账号</label>
					    <div class="col-md-10 col-sm-10">
						    <input type="text" id="usereditaccount" class="form-control" placeholder="账号" name="user.account" readonly="readonly">
						    <input type="hidden" name="user.id" id="usereditid">
	                        <input type="hidden" name="page" value="${page }">
	                        <input type="hidden" name="name" value="${name }">
	                        <input type="hidden" name="account" value="${account }">
                        </div>
				    </div>
				    <div class="form-group has-feedback">
					    <label for="usereditname" class="control-label col-md-2 col-sm-2">姓名</label>
					    <div class="col-md-10 col-sm-10">
						    <input type="text" id="usereditname" class="form-control" placeholder="姓名" name="user.name" autofocus required>
						    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
				    	</div>
				    </div>
				    <div class="form-group has-feedback">
					    <label for="usereditmobile" class="control-label col-md-2 col-sm-2">手机号</label>
					    <div class="col-md-10 col-sm-10">
						    <input type="text" id="usereditmobile" class="form-control" placeholder="手机号" name="user.mobile" required>
						    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
				    	</div>
				    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="usereditbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 顶部导航 -->
<%@ include file="../common/nav_back.jsp" %>
<div class="container-fluid">
    <div class="row">
    	<!-- 左侧导航 -->
    	<%@ include file="../common/left_back.jsp" %>
    	<!-- 内容部分 -->
    	<div class="col-md-10 col-md-offset-2 col-sm-10 col-sm-offset-2 main">
            <h3 class="page-header">管理用户<span class="sr-only">管理用户</span></h3>
            <form class="form-inline" id="usersearchform" method="post" action="${pageContext.request.contextPath }/user/managelistUser.do">
                <div class="form-group">
                    <label class="sr-only" for="userAccount">账号</label>
                    <input type="text" class="form-control" name="account" placeholder="账号" id="userAccount" value="${account }">
                </div>
                <div class="form-group">
                    <label class="sr-only" for="userName">姓名</label>
                    <input type="text" class="form-control" name="name" placeholder="姓名" id="userName" value="${name }">
                </div>
                <button type="button" class="btn btn-default" id="usersearchbtn">搜索<span class="sr-only">搜索</span></button>
            </form>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>#<span class="sr-only">序号</span></th><th>账号<span class="sr-only">账号</span></th><th>姓名<span class="sr-only">姓名</span></th><th>手机号<span class="sr-only">手机号</span></th><th>操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${vstatus.count }</td>
                    		<td>${obj.account }</td>
                    		<td>${obj.name }</td>
                    		<td>${obj.mobile }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="userdelconfirm('${obj.id}');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="useredit('${obj.id}');">修改<span class="sr-only">修改</span></button>
                    			<button type="button" class="btn btn-xs btn-default" onclick="userinitpasswordconfirm('${obj.id}');">初始化密码<span class="sr-only">初始化密码</span></button>
                    		</td>
                    	</tr>
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <ul class="pagination">
            	<c:if test="${page==1 }">
            	<li class="disabled"><a href="javascript:void(0);">首页<span class="sr-only">首页</span></a></li>
            	<li class="disabled"><a href="javascript:void(0);">前页<span class="sr-only">前页</span></a></li>
            	</c:if>
            	<c:if test="${page!=1 }">
            	<li><a href="javascript:toPage('1');">首页<span class="sr-only">首页</span></a></li>
            	<li><a href="javascript:toPage('${page-1}');">前页<span class="sr-only">前页</span></a></li>
            	</c:if>
                <c:forEach begin="1" end="${pages }" var="p">
                <c:if test="${page==p }">
            	<li class="disabled"><a href="javascript:void(0);">${p }<span class="sr-only">${p }</span></a></li>
            	</c:if>
            	<c:if test="${page!=p }">
            	<li><a href="javascript:toPage('${p}');">${p }<span class="sr-only">${p }</span></a></li>
            	</c:if>
                </c:forEach>
                <c:if test="${page==pages||pages==0 }">
            	<li class="disabled"><a href="javascript:void(0);">后页<span class="sr-only">后页</span></a></li>
                <li class="disabled"><a href="javascript:void(0);">尾页<span class="sr-only">尾页</span></a></li>
            	</c:if>
            	<c:if test="${page!=pages&&pages!=0 }">
            	<li><a href="javascript:toPage('${page+1}');">后页<span class="sr-only">后页</span></a></li>
                <li><a href="javascript:toPage('${pages}');">尾页<span class="sr-only">尾页</span></a></li>
            	</c:if>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(function(){
		//查询按钮点击事件
		$('#usersearchbtn').on('click', function(){
			$('#usersearchform').submit();
		});
		//修改窗口保存按钮点击事件
		$('#usereditbtn').on('click', function(){
			$('#usereditform').submit();
		});
	});
	//提示
	function tips(title, msg) {
		$('#popover .popovertitle').html(title);
        $('#popover .popover-content').html(msg);
        $('#popover').show();
        setTimeout(function () {
        	$('#popover').hide();
        }, 5000);
        $('#closepopover').on('click', function() {
        	$('#popover').hide();
        });
	}
	//修改
	function useredit(id) {
		$.post('${pageContext.request.contextPath}/user/getUser.do',{"user.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#usereditid').val(r.id);
				$('#usereditaccount').val(r.account);
				$('#usereditname').val(r.name);
				$('#usereditmobile').val(r.mobile);
				$('#usereditmodal').modal('show');
			} else {
				tips('错误', '根据id获取信息出错');
			}
		});
	}
	//删除
	function userdelconfirm(id) {
		$('#userdelconfirm').modal('show');
		$('#userdelid').val(id);
	}
	function userdel() {
		$('#userdelform').submit();
	}
	//初始化密码
	function userinitpasswordconfirm(id) {
		$('#userinitpasswordconfirm').modal('show');
		$('#userinitpasswordid').val(id);
	}
	function userinitpassword() {
		$('#userinitpasswordform').submit();
	}
	//页码跳转
	function toPage(page) {
		window.location.href='${pageContext.request.contextPath}/user/managelistUser.do?page='+page+'&account='+$.trim($('#userAccount').val())+'&name='+$.trim($('#userName').val());
	}
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
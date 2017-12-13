<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=edge"><!-- 优先以ie的edge模式打开页面 -->
<meta name="viewport" content="width=device-width,initial-scale=1"><!-- 适配移动端 -->
<meta name="renderer" content="webkit"><!-- 刷新优先以google模式显示页面 -->
<title>考试平台-系统配置-时间配置</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/exam.css">
</head>
<body>
<!-- 删除数据form -->
<form id="jiedelform" action="${pageContext.request.contextPath }/config/datedelConfig.do" method="post">
	<input type="hidden" name="config.id" id="jiedelid">
	<input type="hidden" name="config.key" id="jiedelkey">
</form>
<!-- 删除确认弹出框 -->
<div class="modal fade in" id="jiedelmodal" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="jiedel();">是</button>
            </div>
        </div>
    </div>
</div>
<form id="datedelform" action="${pageContext.request.contextPath }/config/datedelConfig.do" method="post">
	<input type="hidden" name="config.id" id="datedelid">
	<input type="hidden" name="config.key" id="datedelkey">
</form>
<div class="modal fade in" id="datedelmodal" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="datedel();">是</button>
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
<!-- 届数修改modal -->
<div class="modal fade" id="jieeditmodal" role="dialog" tabindex="-1" aria-labelledby="修改窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改届数<span class="sr-only">修改届数</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="jieeditform" method="post" action="${pageContext.request.contextPath }/config/jieeditConfig.do">
                    <div class="form-group" id="jieeditkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieeditkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="jieeditkey" readonly="readonly">
                            <input type="hidden" name="config.id" id="jieeditid">
                        </div>
                    </div>
                    <div class="form-group" id="jieedittitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieedittitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="jieedittitle">
                        </div>
                    </div>
                    <div class="form-group" id="jieeditvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieeditvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="jieeditvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="jieeditbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="dateeditmodal" role="dialog" tabindex="-1" aria-labelledby="修改窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改日期<span class="sr-only">修改日期</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="dateeditform" method="post" action="${pageContext.request.contextPath }/config/dateeditConfig.do">
                    <div class="form-group" id="dateeditkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateeditkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="dateeditkey" readonly="readonly">
                            <input type="hidden" name="config.id" id="dateeditid">
                        </div>
                    </div>
                    <div class="form-group" id="dateedittitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateedittitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="dateedittitle">
                        </div>
                    </div>
                    <div class="form-group" id="dateeditconditionFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateeditcondition">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.condition" placeholder="值" id="dateeditcondition">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="dateeditbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 届数新增modal -->
<div class="modal fade" id="jieaddmodal" role="dialog" tabindex="-1" aria-labelledby="新增窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增届数<span class="sr-only">新增届数</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="jieaddform" method="post" action="${pageContext.request.contextPath }/config/jieaddConfig.do">
                    <div class="form-group" id="jieaddkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieaddkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="jieaddkey">
                        </div>
                    </div>
                    <div class="form-group" id="jieaddtitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieaddtitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="jieaddtitle">
                        </div>
                    </div>
                    <div class="form-group" id="jieaddvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="jieaddvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="jieaddvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="jieaddbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="dateaddmodal" role="dialog" tabindex="-1" aria-labelledby="新增窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增日期<span class="sr-only">新增日期</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="dateaddform" method="post" action="${pageContext.request.contextPath }/config/dateaddConfig.do">
                    <div class="form-group" id="dateaddkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateaddkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="dateaddkey">
                        </div>
                    </div>
                    <div class="form-group" id="dateaddtitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateaddtitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="dateaddtitle">
                        </div>
                    </div>
                    <div class="form-group" id="dateaddconditionFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="dateaddcondition">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.condition" placeholder="值" id="dateaddcondition">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="dateaddbtn">保存</button>
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
            <h3 class="page-header">届数<span class="sr-only">届数</span></h3>
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#jieaddmodal">新增<span class="sr-only">新增</span></button>
            <br><br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>名称<span class="sr-only">名称</span></th><th>届<span class="sr-only">届</span></th><th>操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${jies }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${obj.title }</td>
                    		<td>${obj.value }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="jiedelconfirm('${obj.id}','${obj.key }');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="jieedit('${obj.id}');">修改<span class="sr-only">修改</span></button>
                    		</td>
                    	</tr>
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <h3 class="page-header">日期配置<span class="sr-only">日期配置</span></h3>
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#dateaddmodal">新增<span class="sr-only">新增</span></button>
            <br><br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>名称<span class="sr-only">名称</span></th><th>开始日期<span class="sr-only">开始日期</span></th><th>结束日期<span class="sr-only">结束日期</span></th><th>操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${dates }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${obj.title }</td>
                    		<td>${fn:substring(obj.condition,0,fn:indexOf(obj.condition,"|")) }</td>
                    		<td>${fn:substring(obj.condition,fn:indexOf(obj.condition,"|")+1,fn:length(obj.condition)) }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="datedelconfirm('${obj.id}','${obj.key }');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="dateedit('${obj.id}');">修改<span class="sr-only">修改</span></button>
                    		</td>
                    	</tr>
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(function(){
		//新增窗口保存按钮点击事件
		$('#jieaddbtn').on('click', function(){
			if($.trim($('#jieaddvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#jieaddvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#jieaddvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#jieaddvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#jieaddtitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#jieaddtitleFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#jieaddkey').val())!=''){//不为空
				//检查是否在数据库中存在
				$.post('${pageContext.request.contextPath}/config/checkKeyConfig.do',{"config.key":$.trim($('#jieaddkey').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
							tips('提示', '键'+$.trim($('#jieaddkey').val())+'在系统中已存在');
					        //输入框加上错误样式
					        $('#jieaddkeyFormGroup').addClass('has-error');
					        return;
						} else {
							$('#jieaddkey').val($.trim($('#jieaddkey').val()));
							$('#jieaddvalue').val($.trim($('#jieaddvalue').val()));
							$('#jieaddtitle').val($.trim($('#jieaddtitle').val()));
							$('#jieaddform').submit();
							$('#jieaddmodal').modal('hide');
						}
					} else {
						tips('错误', '检查键是否存在出错');
						return;
					}
				});
			} else {//为空
				//弹出提示
				tips('提示', '键为必填项');
		        //输入框加上错误样式
		        $('#jieaddkeyFormGroup').addClass('has-error');
				return;
			}
		});
		//新增窗口输入框一旦有输入，移除错误样式
		$('#jieaddkey').on('keydown', function(){
			$('#jieaddkeyFormGroup').removeClass('has-error');
		});
		$('#jieaddvalue').on('keydown', function(){
			$('#jieaddvalueFormGroup').removeClass('has-error');
		});
		$('#jieaddtitle').on('keydown', function(){
			$('#jieaddtitleFormGroup').removeClass('has-error');
		});
		//新增窗口保存按钮点击事件
		$('#dateaddbtn').on('click', function(){
			if($.trim($('#dateaddcondition').val())=='') {
				tips('错误', '值为必填项');
				$('#dateaddconditionFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#dateaddtitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#dateaddtitleFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#dateaddkey').val())!=''){//不为空
				//检查是否在数据库中存在
				$.post('${pageContext.request.contextPath}/config/checkKeyConfig.do',{"config.key":$.trim($('#dateaddkey').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
							tips('提示', '键'+$.trim($('#dateaddkey').val())+'在系统中已存在');
					        //输入框加上错误样式
					        $('#dateaddkeyFormGroup').addClass('has-error');
					        return;
						}
					} else {
						tips('错误', '检查键是否存在出错');
						return;
					}
				});
			} else {//为空
				//弹出提示
				tips('提示', '键为必填项');
		        //输入框加上错误样式
		        $('#dateaddkeyFormGroup').addClass('has-error');
				return;
			}
			$('#dateaddkey').val($.trim($('#dateaddkey').val()));
			$('#dateaddcondition').val($.trim($('#dateaddcondition').val()));
			$('#dateaddtitle').val($.trim($('#dateaddtitle').val()));
			$('#dateaddform').submit();
			$('#dateaddmodal').modal('hide');
		});
		//新增窗口输入框一旦有输入，移除错误样式
		$('#dateaddkey').on('keydown', function(){
			$('#dateaddkeyFormGroup').removeClass('has-error');
		});
		$('#dateaddcondition').on('keydown', function(){
			$('#dateaddconditionFormGroup').removeClass('has-error');
		});
		$('#dateaddtitle').on('keydown', function(){
			$('#dateaddtitleFormGroup').removeClass('has-error');
		});
		//修改窗口保存按钮点击事件
		$('#jieeditbtn').on('click', function(){
			if($.trim($('#jieeditvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#jieeditvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#jieeditvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#jieeditvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#jieedittitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#jieedittitleFormGroup').addClass('has-error');
				return;
			}
			$('#jieeditvalue').val($.trim($('#jieeditvalue').val()));
			$('#jieedittitle').val($.trim($('#jieedittitle').val()));
			$('#jieeditform').submit();
			$('#jieeditmodal').modal('hide');
		});
		//修改窗口地区输入框一旦有输入，移除错误样式
		$('#jieedittitle').on('keydown', function(){
			$('#jieedittitleFormGroup').removeClass('has-error');
		});
		$('#jieeditvalue').on('keydown', function(){
			$('#jieeditvalueFormGroup').removeClass('has-error');
		});
		$('#dateeditbtn').on('click', function(){
			if($.trim($('#dateeditcondition').val())=='') {
				tips('错误', '值为必填项');
				$('#dateeditconditionFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#dateedittitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#dateedittitleFormGroup').addClass('has-error');
				return;
			}
			$('#dateeditkey').val($.trim($('#dateeditkey').val()));
			$('#dateeditcondition').val($.trim($('#dateeditcondition').val()));
			$('#dateedittitle').val($.trim($('#dateedittitle').val()));
			$('#dateeditform').submit();
			$('#dateeditmodal').modal('hide');
		});
		$('#dateedittitle').on('keydown', function(){
			$('#dateedittitleFormGroup').removeClass('has-error');
		});
		$('#dateeditvalue').on('keydown', function(){
			$('#dateeditvalueFormGroup').removeClass('has-error');
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
	function jieedit(id) {
		$.post('${pageContext.request.contextPath}/config/getConfig.do',{"config.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#jieeditkey').val(r.key);
				$('#jieeditid').val(r.id);
				$('#jieeditvalue').val(r.value);
				$('#jieedittitle').val(r.title);
				$('#jieeditmodal').modal('show');
			} else {
				tips('错误', '根据id获取信息出错');
			}
		});
	}
	//修改
	function dateedit(id) {
		$.post('${pageContext.request.contextPath}/config/getConfig.do',{"config.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#dateeditkey').val(r.key);
				$('#dateeditid').val(r.id);
				$('#dateeditcondition').val(r.condition);
				$('#dateedittitle').val(r.title);
				$('#dateeditmodal').modal('show');
			} else {
				tips('错误', '根据id获取信息出错');
			}
		});
	}
	//删除
	function jiedelconfirm(id,key) {
		$('#jiedelmodal').modal('show');
		$('#jiedelid').val(id);
		$('#jiedelkey').val(key);
	}
	function jiedel() {
		$('#jiedelform').submit();
	}
	function datedelconfirm(id,key) {
		$('#datedelmodal').modal('show');
		$('#datedelid').val(id);
		$('#datedelkey').val(key);
	}
	function datedel() {
		$('#datedelform').submit();
	}
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
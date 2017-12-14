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
<title>考试平台-系统配置-考试次数</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/exam.css">
</head>
<body>
<!-- 删除数据form -->
<form id="scoredelform" action="${pageContext.request.contextPath }/config/scoredelConfig.do" method="post">
	<input type="hidden" name="config.id" id="scoredelid">
	<input type="hidden" name="config.key" id="scoredelkey">
</form>
<!-- 删除确认弹出框 -->
<div class="modal fade in" id="scoredelmodal" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="scoredel();">是</button>
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
<!-- 考试次数添加modal窗口 -->
<div class="modal fade" id="scoreaddmodal" role="dialog" tabindex="-1" aria-labelledby="新增窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增分数配置<span class="sr-only">新增分数配置</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="scoreaddform" method="post" action="${pageContext.request.contextPath }/config/scoreaddConfig.do">
                    <div class="form-group" id="scoreaddkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreaddkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="scoreaddkey">
                        </div>
                    </div>
                    <div class="form-group" id="scoreaddtitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreaddtitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="scoreaddtitle">
                        </div>
                    </div>
                    <div class="form-group" id="scoreaddconditionFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreaddcondition">分数区间</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.condition" placeholder="分数区间" id="scoreaddcondition">
                        </div>
                    </div>
                    <div class="form-group" id="scoreaddtypeFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreaddtype">调整类型</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.type" placeholder="调整类型" id="scoreaddtype">
                        </div>
                    </div>
                    <div class="form-group" id="scoreaddvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreaddvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="scoreaddvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="scoreaddbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改modal -->
<div class="modal fade" id="scoreeditmodal" role="dialog" tabindex="-1" aria-labelledby="修改窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改分数配置<span class="sr-only">修改分数配置</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="scoreeditform" method="post" action="${pageContext.request.contextPath }/config/scoreeditConfig.do">
                    <div class="form-group" id="configKeyFormGroupEdit">
                        <label class="control-label col-md-2 col-sm-2" for="scoreeditkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="scoreeditkey" readonly="readonly">
                            <input type="hidden" name="config.id" id="scoreeditid">
                        </div>
                    </div>
                    <div class="form-group" id="scoreedittitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreedittitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="scoreedittitle">
                        </div>
                    </div>
                    <div class="form-group" id="scoreeditconditionFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreeditcondition">分数区间</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.condition" placeholder="分数区间" id="scoreeditcondition">
                        </div>
                    </div>
                    <div class="form-group" id="scoreedittypeFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreedittype">调整类型</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.type" placeholder="调整类型" id="scoreedittype">
                        </div>
                    </div>
                    <div class="form-group" id="scoreeditvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="scoreeditvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="scoreeditvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="scoreeditbtn">保存</button>
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
            <h3 class="page-header">分数配置<span class="sr-only">分数配置</span></h3>
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#scoreaddmodal">新增<span class="sr-only">新增</span></button>
            <br>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>名称<span class="sr-only">名称</span></th><th>分数区间<span class="sr-only">分数区间</span></th><th>分值<span class="sr-only">分值</span></th><th>操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${obj.title }</td>
                    		<td>${fn:replace(obj.condition, '|', '-') }</td>
                    		<td>${obj.type }${obj.value }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="scoremoveup('${obj.id}');">上移<span class="sr-only">上移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="scoremovedown('${obj.id}');">下移<span class="sr-only">下移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="scoredelconfirm('${obj.id}','${obj.key }');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="scoreedit('${obj.id}');">修改<span class="sr-only">修改</span></button>
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
		$('#scoreaddbtn').on('click', function(){
			if($.trim($('#scoreaddvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#scoreaddvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#scoreaddvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#scoreaddvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreaddtitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#scoreaddtitleFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreaddtype').val())=='') {
				tips('错误', '调整类型为必填项');
				$('#scoreaddtypeFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreaddcondition').val())=='') {
				tips('错误', '分数区间为必填项');
				$('#scoreaddconditionFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreaddkey').val())!=''){//不为空
				//检查是否在数据库中存在
				$.post('${pageContext.request.contextPath}/config/checkKeyConfig.do',{"config.key":$.trim($('#scoreaddkey').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
							tips('提示', '键'+$.trim($('#scoreaddkey').val())+'在系统中已存在');
					        //输入框加上错误样式
					        $('#scoreaddkeyFormGroup').addClass('has-error');
					        return;
						} else {
							$('#scoreaddkey').val($.trim($('#scoreaddkey').val()));
							$('#scoreaddvalue').val($.trim($('#scoreaddvalue').val()));
							$('#scoreaddtitle').val($.trim($('#scoreaddtitle').val()));
							$('#scoreaddtype').val($.trim($('#scoreaddtype').val()));
							$('#scoreaddcondition').val($.trim($('#scoreaddcondition').val()));
							$('#scoreaddform').submit();
							$('#scoreaddmodal').modal('hide');
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
		        $('#scoreaddkeyFormGroup').addClass('has-error');
				return;
			}
		});
		//新增窗口输入框一旦有输入，移除错误样式
		$('#scoreaddkey').on('keydown', function(){
			$('#scoreaddkeyFormGroup').removeClass('has-error');
		});
		$('#scoreaddvalue').on('keydown', function(){
			$('#scoreaddvalueFormGroup').removeClass('has-error');
		});
		$('#scoreaddtitle').on('keydown', function(){
			$('#scoreaddtitleFormGroup').removeClass('has-error');
		});
		$('#scoreaddtype').on('keydown', function(){
			$('#scoreaddtypeFormGroup').removeClass('has-error');
		});
		$('#scoreaddcondition').on('keydown', function(){
			$('#scoreaddconditionFormGroup').removeClass('has-error');
		});
		//修改窗口保存按钮点击事件
		$('#scoreeditbtn').on('click', function(){
			if($.trim($('#scoreeditvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#scoreeditvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#scoreeditvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#scoreeditvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreedittitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#scoreedittitleFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreedittype').val())=='') {
				tips('错误', '调整类型为必填项');
				$('#scoreedittypeFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#scoreeditcondition').val())=='') {
				tips('错误', '分数区间为必填项');
				$('#scoreeditconditionFormGroup').addClass('has-error');
				return;
			}
			$('#scoreeditvalue').val($.trim($('#scoreeditvalue').val()));
			$('#scoreedittitle').val($.trim($('#scoreedittitle').val()));
			$('#scoreedittype').val($.trim($('#scoreedittype').val()));
			$('#scoreeditcondition').val($.trim($('#scoreeditcondition').val()));
			$('#scoreeditform').submit();
			$('#scoreeditmodal').modal('hide');
		});
		//修改窗口地区输入框一旦有输入，移除错误样式
		$('#scoreedittitle').on('keydown', function(){
			$('#scoreedittitleFormGroup').removeClass('has-error');
		});
		$('#scoreeditvalue').on('keydown', function(){
			$('#scoreeditvalueFormGroup').removeClass('has-error');
		});
		$('#scoreedittype').on('keydown', function(){
			$('#scoreedittypeFormGroup').removeClass('has-error');
		});
		$('#scoreeditcondition').on('keydown', function(){
			$('#scoreeditconditionFormGroup').removeClass('has-error');
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
	function scoreedit(id) {
		$.post('${pageContext.request.contextPath}/config/getConfig.do',{"config.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#scoreeditkey').val(r.key);
				$('#scoreeditid').val(r.id);
				$('#scoreeditvalue').val(r.value);
				$('#scoreedittitle').val(r.title);
				$('#scoreedittype').val(r.type);
				$('#scoreeditcondition').val(r.condition);
				$('#scoreeditmodal').modal('show');
			} else {
				tips('错误', '根据id获取信息出错');
			}
		});
	}
	//删除
	function scoredelconfirm(id,key) {
		$('#scoredelmodal').modal('show');
		$('#scoredelid').val(id);
		$('#scoredelkey').val(key);
	}
	function scoredel() {
		$('#scoredelform').submit();
	}
	//上移
	function scoremoveup(id) {
		$.post('${pageContext.request.contextPath}/config/moveupConfig.do',{"type":"score","config.id":id}, function(result) {
			window.location.href="${pageContext.request.contextPath}/config/scoresConfig.do";
		});
	}
	//下移
	function scoremovedown(id) {
		$.post('${pageContext.request.contextPath}/config/movedownConfig.do',{"type":"score","config.id":id}, function(result) {
			window.location.href="${pageContext.request.contextPath}/config/scoresConfig.do";
		});
	}
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
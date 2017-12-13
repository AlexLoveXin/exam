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
<form id="timedelform" action="${pageContext.request.contextPath }/config/timedelConfig.do" method="post">
	<input type="hidden" name="config.id" id="timedelid">
	<input type="hidden" name="config.key" id="timedelkey">
</form>
<!-- 删除确认弹出框 -->
<div class="modal fade in" id="timedelmodal" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="timedel();">是</button>
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
<div class="modal fade" id="timeaddmodal" role="dialog" tabindex="-1" aria-labelledby="新增窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增考试次数<span class="sr-only">新增考试次数</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="timeaddform" method="post" action="${pageContext.request.contextPath }/config/timeaddConfig.do">
                    <div class="form-group" id="timeaddkeyFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="timeaddkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="timeaddkey">
                        </div>
                    </div>
                    <div class="form-group" id="timeaddtitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="timeaddtitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="timeaddtitle">
                        </div>
                    </div>
                    <div class="form-group" id="timeaddvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="timeaddvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="timeaddvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="timeaddbtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改modal -->
<div class="modal fade" id="timeeditmodal" role="dialog" tabindex="-1" aria-labelledby="修改窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改考试次数<span class="sr-only">修改考试次数</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="timeeditform" method="post" action="${pageContext.request.contextPath }/config/timeeditConfig.do">
                    <div class="form-group" id="configKeyFormGroupEdit">
                        <label class="control-label col-md-2 col-sm-2" for="timeeditkey">键</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.key" placeholder="键" id="timeeditkey" readonly="readonly">
                            <input type="hidden" name="config.id" id="timeeditid">
                        </div>
                    </div>
                    <div class="form-group" id="timeedittitleFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="timeedittitle">描述</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.title" placeholder="描述" id="timeedittitle">
                        </div>
                    </div>
                    <div class="form-group" id="timeeditvalueFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="timeeditvalue">值</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="config.value" placeholder="值" id="timeeditvalue">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="timeeditbtn">保存</button>
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
            <h3 class="page-header">考试次数<span class="sr-only">考试次数</span></h3>
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#timeaddmodal">新增<span class="sr-only">新增</span></button>
            <br>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>名称<span class="sr-only">名称</span></th><th>次数<span class="sr-only">次数</span></th><th>操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${obj.title }</td>
                    		<td>${obj.value }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="timedelconfirm('${obj.id}','${obj.key }');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="timeedit('${obj.id}');">修改<span class="sr-only">修改</span></button>
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
		$('#timeaddbtn').on('click', function(){
			if($.trim($('#timeaddvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#timeaddvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#timeaddvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#timeaddvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#timeaddtitle').val())=='') {
				tips('错误', '值为必填项');
				$('#timeaddtitleFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#timeaddkey').val())!=''){//不为空
				//检查是否在数据库中存在
				$.post('${pageContext.request.contextPath}/config/checkKeyConfig.do',{"config.key":$.trim($('#timeaddkey').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
							tips('提示', '键'+$.trim($('#timeaddkey').val())+'在系统中已存在');
					        //输入框加上错误样式
					        $('#timeaddkeyFormGroup').addClass('has-error');
					        return;
						} else {
							$('#timeaddkey').val($.trim($('#timeaddkey').val()));
							$('#timeaddvalue').val($.trim($('#timeaddvalue').val()));
							$('#timeaddtitle').val($.trim($('#timeaddtitle').val()));
							$('#timeaddform').submit();
							$('#timeaddmodal').modal('hide');
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
		        $('#timeaddkeyFormGroup').addClass('has-error');
				return;
			}
		});
		//新增窗口输入框一旦有输入，移除错误样式
		$('#timeaddkey').on('keydown', function(){
			$('#timeaddkeyFormGroup').removeClass('has-error');
		});
		$('#timeaddvalue').on('keydown', function(){
			$('#timeaddvalueFormGroup').removeClass('has-error');
		});
		$('#timeaddtitle').on('keydown', function(){
			$('#timeaddtitleFormGroup').removeClass('has-error');
		});
		//修改窗口保存按钮点击事件
		$('#timeeditbtn').on('click', function(){
			if($.trim($('#timeeditvalue').val())=='') {
				tips('错误', '值为必填项');
				$('#timeeditvalueFormGroup').addClass('has-error');
				return;
			}
			if(isNaN(parseInt($.trim($('#timeeditvalue').val())))) {
				tips('错误', '值必须填写数字');
				$('#timeeditvalueFormGroup').addClass('has-error');
				return;
			}
			if($.trim($('#timeedittitle').val())=='') {
				tips('错误', '描述为必填项');
				$('#timeedittitleFormGroup').addClass('has-error');
				return;
			}
			$('#timeeditvalue').val($.trim($('#timeeditvalue').val()));
			$('#timeedittitle').val($.trim($('#timeedittitle').val()));
			$('#timeeditform').submit();
			$('#timeeditmodal').modal('hide');
		});
		//修改窗口地区输入框一旦有输入，移除错误样式
		$('#timeedittitle').on('keydown', function(){
			$('#timeedittitleFormGroup').removeClass('has-error');
		});
		$('#timeeditvalue').on('keydown', function(){
			$('#timeeditvalueFormGroup').removeClass('has-error');
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
	function timeedit(id) {
		$.post('${pageContext.request.contextPath}/config/getConfig.do',{"config.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#timeeditkey').val(r.key);
				$('#timeeditid').val(r.id);
				$('#timeeditvalue').val(r.value);
				$('#timeedittitle').val(r.title);
				$('#timeeditmodal').modal('show');
			} else {
				tips('错误', '根据id获取信息出错');
			}
		});
	}
	//删除
	function timedelconfirm(id,key) {
		$('#timedelmodal').modal('show');
		$('#timedelid').val(id);
		$('#timedelkey').val(key);
	}
	function timedel() {
		$('#timedelform').submit();
	}
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
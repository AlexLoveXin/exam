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
<title>考试平台-学校或单位管理</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/exam.css">
</head>
<body>
<!-- 删除数据form -->
<form id="delform" action="${pageContext.request.contextPath }/org/delOrg.do" method="post">
	<input type="hidden" name="org.id" id="delid">
</form>
<!-- 删除确认弹出框 -->
<div class="modal fade in" id="confirm" role="dialog" tabindex="-1" aria-labelledby="删除确认窗口">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="是" onclick="del();">是</button>
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
<!-- 学校或单位添加modal窗口 -->
<div class="modal fade" id="addorg" role="dialog" tabindex="-1" aria-labelledby="新增学校或单位窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增学校或单位<span class="sr-only">新增学校或单位</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addform" method="post" action="${pageContext.request.contextPath }/org/addOrg.do">
                    <div class="form-group" id="orgNameFormGroupAdd">
                        <label class="control-label col-md-3 col-sm-3" for="orgNameAdd">学校或单位名称</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="org.name" placeholder="学校或单位名称" id="orgNameAdd">
                        </div>
                    </div>
                    <div class="form-group" id="areaNameFormGroupAdd">
                        <label class="control-label col-md-3 col-sm-3" for="areaIdAdd">地区名称</label>
                        <div class="col-md-9">
                            <select id="areaIdAdd" class="form-control" name="areaId">
                            	<option value="0">--请选择--</option>
                            	<c:forEach items="${areas }" var="obj">
                            	<option value="${obj.id }">${obj.name }</option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="savebtn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 学校或单位修改modal -->
<div class="modal fade" id="editorg" role="dialog" tabindex="-1" aria-labelledby="修改学校或单位窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">修改学校或单位<span class="sr-only">修改学校或单位</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="editform" method="post" action="${pageContext.request.contextPath }/org/editOrg.do">
                    <div class="form-group" id="orgNameFormGroupEdit">
                        <label class="control-label col-md-3 col-sm-3" for="orgNameEdit">学校或单位名称</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="org.name" placeholder="学校或单位名称" id="orgNameEdit">
                            <input type="hidden" name="org.id" id="orgIdEdit">
                            <input type="hidden" name="page" value="${page }">
                            <input type="hidden" name="name" value="${name }">
                            <input type="hidden" name="areaIdSearch" value="${areaIdSearch }">
                        </div>
                    </div>
                    <div class="form-group" id="areaNameFormGroupEdit">
                        <label class="control-label col-md-3 col-sm-3" for="areaIdEdit">地区名称</label>
                        <div class="col-md-9">
                            <select id="areaIdEdit" class="form-control" name="areaId">
                            	<option value="0">--请选择--</option>
                            	<c:forEach items="${areas }" var="obj">
                            	<option value="${obj.id }">${obj.name }</option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" aria-label="保存" id="editbtn">保存</button>
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
            <h3 class="page-header">学校或单位<span class="sr-only">学校或单位</span></h3>
            <form class="form-inline" id="searchform" method="post" action="${pageContext.request.contextPath }/org/listOrg.do">
                <div class="form-group">
                    <label class="sr-only" for="orgName">学校或单位名称</label>
                    <input type="text" class="form-control" name="name" placeholder="学校或单位名称" id="orgName" value="${name }">
                </div>
                <div class="form-group">
                    <label class="sr-only" for="areaIdSearch">地区</label>
                    <select id="areaIdSearch" class="form-control" name="areaIdSearch">
                    	<option value="0">--请选择--</option>
                    	<c:forEach items="${areas }" var="obj">
                    	<option value="${obj.id }">${obj.name }</option>
                    	</c:forEach>
                    </select>
                </div>
                <button type="button" class="btn btn-default" id="searchbtn">搜索<span class="sr-only">搜索</span></button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addorg">新增<span class="sr-only">新增</span></button>
            </form>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>#<span class="sr-only">序号</span></th><th>学校或单位名称<span class="sr-only">学校或单位名称</span></th><th>顺序<span class="sr-only">顺序</span></th><th>地区<span class="sr-only">地区</span></th><th width="20%">操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${vstatus.count }</td>
                    		<td>${obj.name }</td>
                    		<td>${obj.orderby }</td>
                    		<td>${obj.area.name }</td>
                    		<td>
                    			<button type="button" class="btn btn-xs btn-default" onclick="moveup('${obj.id}');">上移<span class="sr-only">上移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="movedown('${obj.id}');">下移<span class="sr-only">下移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="delconfirm('${obj.id}');">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default" onclick="edit('${obj.id}');">修改<span class="sr-only">修改</span></button>
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
		//新增窗口保存按钮点击事件
		$('#savebtn').on('click', function(){
			if($('#areaIdAdd').val()==0) {
				//弹出提示
				tips('提示', '地区为必选项');
		        //地区选择加上错误样式
		        $('#areaNameFormGroupAdd').addClass('has-error');
				return;
			}
			if($.trim($('#orgNameAdd').val())!=''){//学校或单位名称不为空
				//检查学校或单位名称是否在数据库中存在
				$.post('${pageContext.request.contextPath}/org/checkNameOrg.do',{"org.name":$.trim($('#orgNameAdd').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
							tips('提示', '学校或单位名称'+$.trim($('#orgNameAdd').val())+'在系统中已存在');
					        //学校或单位名称输入框加上错误样式
					        $('#orgNameFormGroupAdd').addClass('has-error');
						} else {
							$('#orgNameAdd').val($.trim($('#orgNameAdd').val()));
							$('#addform').submit();
							$('#addorg').modal('hide');
						}
					} else {
						tips('错误', '检查学校或单位名称是否存在出错');
					}
				});
			} else {//学校或单位名称为空
				//弹出提示
				tips('提示', '学校或单位名称为必填项');
		        //学校或单位名称输入框加上错误样式
		        $('#orgNameFormGroupAdd').addClass('has-error');
				return;
			}
		});
		//新增窗口地区选择如果有改变，移除错误样式
		$('#areaIdAdd').on('change', function(){
			$('#areaNameFormGroupAdd').removeClass('has-error');
		});
		//新增窗口学校或单位名称输入框一旦有输入，移除错误样式
		$('#orgNameAdd').on('keydown', function(){
			$('#orgNameFormGroupAdd').removeClass('has-error');
		});
		//查询按钮点击事件
		$('#searchbtn').on('click', function(){
			$('#searchform').submit();
		});
		//修改窗口保存按钮点击事件
		$('#editbtn').on('click', function(){
			if($('#areaIdEdit').val()==0) {
				//弹出提示
				tips('提示', '地区为必选项');
		        //地区选择加上错误样式
		        $('#areaNameFormGroupAdd').addClass('has-error');
				return;
			}
			if($.trim($('#orgNameEdit').val())!=''){//地区名称不为空
				//检查学校或单位名称是否在数据库中存在
				$.post('${pageContext.request.contextPath}/org/checkNameOrg.do',{"org.name":$.trim($('#orgNameEdit').val())},function(result){
					if(result.indexOf('<html')==-1) {
						var r = eval('('+result+')');
						if(r.exist) {
							//弹出提示
					        tips('提示', '学校或单位名称'+$.trim($('#orgNameEdit').val())+'在系统中已存在');
					        //学校或单位名称输入框加上错误样式
					        $('#orgNameFormGroupEdit').addClass('has-error');
						} else {
							$('#orgNameEdit').val($.trim($('#orgNameEdit').val()));
							$('#editform').submit();
							$('#editorg').modal('hide');
						}
					} else {
						tips('错误', '检查学校或单位名称是否存在出错');
					}
				});
			} else {//学校或单位名称为空
				//弹出提示
		        tips('提示', '地区名称为必填项');
		        //学校或单位名称输入框加上错误样式
		        $('#orgNameFormGroupEdit').addClass('has-error');
				return;
			}
		});
		//修改窗口地区选择如果有改变，移除错误样式
		$('#areaIdAdd').on('change', function(){
			$('#areaNameFormGroupAdd').removeClass('has-error');
		});
		//修改窗口学校或单位输入框一旦有输入，移除错误样式
		$('#orgNameEdit').on('keydown', function(){
			$('#orgNameFormGroupEdit').removeClass('has-error');
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
	function edit(id) {
		$.post('${pageContext.request.contextPath}/org/getOrg.do',{"org.id":id},function(result){
			if(result.indexOf('<html')==-1) {
				var r = eval('('+result+')');
				$('#orgNameEdit').val(r.name);
				$('#orgIdEdit').val(r.id);
				//地区选择定位
				var options = $('#areaIdEdit option');
				for(var i=0;i<options.length;i++) {
					if(options[i].value==r.areaId) {
						$(options[i]).attr('selected','selected');
						break;
					}
				}
				$('#editorg').modal('show');
			} else {
				tips('错误', '根据id获取学校或单位信息出错');
			}
		});
	}
	//地区选择定位
	function positionArea(selectId, idvalue) {
		var options = $('#'+selectId+' option');
		for(var i=0;i<options.length;i++) {
			if(options[i].value==idvalue) {
				$(options[i]).attr('selected','selected');
				break;
			}
		}
	}
	positionArea('areaIdSearch','${areaIdSearch}');
	//删除
	function delconfirm(id) {
		$('#confirm').modal('show');
		$('#delid').val(id);
	}
	function del() {
		$('#delform').submit();
	}
	//页码跳转
	function toPage(page) {
		window.location.href='${pageContext.request.contextPath}/org/listOrg.do?page='+page+'&name='+$.trim($('#orgName').val())+"&areaIdSearch="+$.trim($('#areaIdSearch').val());
	}
	//上移
	function moveup(id) {
		$.post('${pageContext.request.contextPath}/org/moveupOrg.do',{"org.id":id,"name":$.trim($('#orgName').val())},function(result){
			if(result.indexOf('<html')==-1) {
				toPage('${page}');
			} else {
				tips('错误', '上移学校或单位出错');
			}
		});
	}
	//下移
	function movedown(id) {
		$.post('${pageContext.request.contextPath}/org/movedownOrg.do',{"org.id":id,"name":$.trim($('#orgName').val())},function(result){
			if(result.indexOf('<html')==-1) {
				toPage('${page}');
			} else {
				tips('错误', '下移学校或单位出错');
			}
		});
	}
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
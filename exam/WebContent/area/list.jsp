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
<title>考试平台-地区管理</title>
<link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/exam.css">
</head>
<body>
<div id="popover" class="popover" role="tooltip" aria-labelledby="提示">
    <div class="arrow"></div>
    <h3 class="popover-title">
        <button id="closepopover" type="button" class="close" aria-label="关闭提示">&times;</button>
        <span class="popovertitle"></span>
    </h3>
    <div class="popover-content"></div>
</div>
<!-- 地区添加modal窗口 -->
<div class="modal fade" id="addarea" role="dialog" tabindex="-1" aria-labelledby="新增地区窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增地区<span class="sr-only">新增地区</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addform" method="post" action="${pageContext.request.contextPath }/area/addArea.do">
                    <div class="form-group" id="areaNameFormGroup">
                        <label class="control-label col-md-2 col-sm-2" for="areaNameAdd">地区名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="area.name" placeholder="地区名称" id="areaNameAdd">
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
<!-- 顶部导航 -->
<%@ include file="../common/nav_back.jsp" %>
<div class="container-fluid">
    <div class="row">
    	<!-- 左侧导航 -->
    	<%@ include file="../common/left_back.jsp" %>
    	<!-- 内容部分 -->
    	<div class="col-md-10 col-md-offset-2 col-sm-10 col-sm-offset-2 main">
            <h3 class="page-header">地区<span class="sr-only">地区</span></h3>
            <form class="form-inline">
                <div class="form-group">
                    <label class="sr-only" for="areaName">地区名称</label>
                    <input type="text" class="form-control" name="area.name" placeholder="地区名称" id="areaName">
                </div>
                <button type="button" class="btn btn-default">搜索<span class="sr-only">搜索</span></button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addarea">新增<span class="sr-only">新增</span></button>
            </form>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    	<tr><th>#<span class="sr-only">序号</span></th><th>地区名称<span class="sr-only">地区名称</span></th><th>顺序<span class="sr-only">顺序</span></th><th width="20%">操作选项<span class="sr-only">操作选项</span></th></tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="obj" varStatus="vstatus">
                    	<tr>
                    		<td>${vstatus.count }</td>
                    		<td>${obj.name }</td>
                    		<td>${obj.orderby }</td>
                    		<td width="30%">
                    			<button type="button" class="btn btn-xs btn-default">上移<span class="sr-only">上移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default">下移<span class="sr-only">下移</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default">删除<span class="sr-only">删除</span></button>&nbsp;
                    			<button type="button" class="btn btn-xs btn-default">修改<span class="sr-only">修改</span></button>
                    		</td>
                    	</tr>
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <ul class="pagination">
                <li><a href="#">首页<span class="sr-only">首页</span></a></li>
                <li class="disabled"><a href="${pageContext.request.contextPath }/area/listArea.do?page=${page-1}">前页<span class="sr-only">前页</span></a></li>
                <c:forEach begin="1" end="${pages }" var="p">
                <li><a href="${pageContext.request.contextPath }/area/listArea.do?page=${p}">${p }<span class="sr-only">${p }</span></a></li>
                </c:forEach>
                <li><a href="#">后页<span class="sr-only">后页</span></a></li>
                <li><a href="#">尾页<span class="sr-only">尾页</span></a></li>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="../bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(function(){
		//保存按钮点击事件
		$('#savebtn').on('click', function(){
			if($.trim($('#areaNameAdd').val())!=''){//地区名称不为空
				$('#areaNameAdd').val($.trim($('#areaNameAdd').val()));
				$('#addform').submit();
				$('#addarea').modal('hide');
			} else {//地区名称为空
				//弹出提示
				$('#popover .popovertitle').html('提示');
		        $('#popover .popover-content').html('地区名称为必填项');
		        $('#popover').show();
		        setTimeout(function () {
		        	$('#popover').hide();
		        }, 5000);
		        $('#closepopover').on('click', function() {
		        	$('#popover').hide();
		        });
		        //地区名称输入框加上错误样式
		        $('#areaNameFormGroup').addClass('has-error');
				return;
			}
		});
		//地区输入框一旦有输入，移除错误样式
		$('#areaNameAdd').on('keydown', function(){
			$('#areaNameFormGroup').removeClass('has-error');
		});
	});
</script>
<script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>
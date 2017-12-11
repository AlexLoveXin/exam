<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=edge"><!-- 优先以ie的edge模式打开页面 -->
<meta name="viewport" content="width=device-width,initial-scale=1"><!-- 适配移动端 -->
<meta name="renderer" content="webkit"><!-- 刷新优先以google模式显示页面 -->
<title>考试平台-后台管理</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="css/exam.css">
</head>
<body>
<div class="modal fade" id="addarea" role="dialog" tabindex="-1" aria-labelledby="新增地区窗口">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭">&times;</button>
                <h4 class="modal-title">新增地区<span class="sr-only">新增地区</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2" for="areaNameAdd">地区名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" placeholder="地区名称" id="areaNameAdd">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="关闭">关闭</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="保存">保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="common/nav_back.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="common/left_back.jsp" %>
        <div class="col-md-10 col-md-offset-2 col-sm-10 col-sm-offset-2 main">
            <h3 class="page-header">地区</h3>
            <form class="form-inline">
                <div class="form-group">
                    <label class="sr-only" for="areaName">地区名称</label>
                    <input type="text" class="form-control" name="name" placeholder="地区名称" id="areaName">
                </div>
                <button type="button" class="btn btn-default">搜索</button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addarea">新增</button>
            </form>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr><th>#</th><th>ss</th><th>操作</th></tr>
                    </thead>
                    <tbody>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td width="30%"><button type="button" class="btn btn-xs btn-default">上移</button>&nbsp;<button type="button" class="btn btn-xs btn-default">下移</button>&nbsp;<button type="button" class="btn btn-xs btn-default">删除</button>&nbsp;<button type="button" class="btn btn-xs btn-default">修改</button></td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    <tr><td>#</td><td>地区</td><td>操作</td></tr>
                    </tbody>
                </table>
            </div>
            <ul class="pagination">
                <li><a href="#">首页</a></li>
                <li class="disabled"><a href="#">前页</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">后页</a></li>
                <li><a href="#">尾页</a></li>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="bootstrap/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
</body>
</html>
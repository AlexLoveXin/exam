<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
		<div class="col-md-2 col-sm-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="javascript:void(0);" style="text-align: center;cursor: text;">系统配置<span class="sr-only">系统配置</span></a></li>
                <li><a href="${pageContext.request.contextPath }/config/datesConfig.do">时间配置<span class="sr-only">时间配置</span></a></li>
                <li><a href="${pageContext.request.contextPath }/config/scoresConfig.do">分数调整配置<span class="sr-only">分数调整配置</span></a></li>
                <li><a href="${pageContext.request.contextPath }/config/timesConfig.do">考试次数<span class="sr-only">考试次数</span></a></li>
            </ul>
            <ul class="nav nav-sidebar">
                <li><a href="${pageContext.request.contextPath }/area/listArea.do">地区管理<span class="sr-only">地区管理</span></a></li>
            </ul>
            <ul class="nav nav-sidebar">
                <li><a href="${pageContext.request.contextPath }/org/listOrg.do">学校或单位<span class="sr-only">学校或单位</span></a></li>
            </ul>
        </div>
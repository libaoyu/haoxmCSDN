<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String baseP = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"+"zj/url?c=";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
	window.jQuery
			|| document
					.write("<script src='../static/js/jquery-1.9.1.min.js'>\x3C/script>");
</script>
<script src="../static/js/jquery.tips.js"></script>
		<link href="../static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="../static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<script type="text/javascript">
	$(top.hangge());
</script>
<style type="text/css">
		 #preview, .img, img
		 {
			 width:100px;
			 height:100px;
		 }
		 #preview
		 {
			border:1px solid #000;
		 }
		 
</style>
</head>
<body>
	<div style="text-align: center;background-color: white;width: 100%;height: 100%;" id="zhongxin">
	<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:16%;text-align: right;padding-top: 13px;">名称：</td>
				<td style="width:75%;text-align: right;padding-top: 13px;">${data.linkageName}</td>
			</tr>
			<c:if test="${!empty  data.parentName }">
				<tr>
					<td style="width:16%;text-align: right;padding-top: 13px;">父类名称：</td>
					<td style="width:75%;text-align: right;padding-top: 13px;">${data.parentName}</td>
				</tr>
			</c:if>
			<tr>
				<td style="width:16%;text-align: right;padding-top: 13px;">创建时间：</td>
				<td style="width:75%;text-align: right;padding-top: 13px;">${data.createTime}</td>
			</tr>
			<tr>
				<td style="width:16%;text-align: right;padding-top: 13px;">修改时间：</td>
				<td style="width:75%;text-align: right;padding-top: 13px;">${data.updateTime}</td>
			</tr>
			
			<!-- <tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
				</td>
			</tr> -->
	</table>
		
		
	</div>
</body>
<script type="text/javascript">
	function showByShort(url){
		window.open(url);
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	//保存
	function save(){
			if($("#PAGENAME").val()==""){
			$("#PAGENAME").tips({
				side:3,
	            msg:'请输入问卷名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAGENAME").focus();
			return false;
		}
		if($("#PAGESTATUS").val()==""){
			$("#PAGESTATUS").tips({
				side:3,
	            msg:'请输入问卷状态',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAGESTATUS").focus();
			return false;
		}
		if($("#PAGEADDRESS").val()==""){
			$("#PAGEADDRESS").tips({
				side:3,
	            msg:'请输入问卷访问地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAGEADDRESS").focus();
			return false;
		}
		if($("#PAGEDATA").val()==""){
			$("#PAGEDATA").tips({
				side:3,
	            msg:'请输入备用字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAGEDATA").focus();
			return false;
		}
		if($("#PAGEDATAS").val()==""){
			$("#PAGEDATAS").tips({
				side:3,
	            msg:'请输入备用字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAGEDATAS").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="questionpage/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="QUESTIONPAGE_ID" id="QUESTIONPAGE_ID" value="${pd.QUESTIONPAGE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">问卷名称:</td>
				<td><input type="text" name="PAGENAME" id="PAGENAME" value="${pd.PAGENAME}" maxlength="32" placeholder="这里输入问卷名称" title="问卷名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">问卷状态:</td>
				<td>
					<select name="PAGESTATUS" id="PAGESTATUS" placeholder="请设置问卷状态" style="width: 120px;line-height:26px">
							<option value="0">未发布</option>
							<option value="1">调查中</option>
							<option value="-1">已完成</option>
					</select>
				</td>
			</tr>
			<input type="text" name="SECONDCODE" id="SECONDCODE" value="${pd.SECONDCODE}" style="display:none"/>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">问卷网址:</td>
				<td><input type="text" name="PAGEADDRESS" id="PAGEADDRESS" value="${pd.PAGEADDRESS}" placeholder="这里输入问卷访问地址" title="问卷访问地址"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">调查对象:</td>
				<td>
					<select name="PAGEDATAS" id="PAGEDATAS" placeholder="请选择调查对象" style="width: 120px;line-height:26px">
							<option value="0">普通员工</option>
							<option value="1">行政经理</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">备用字段:</td>
				<td><input type="text" name="PAGEDATA" id="PAGEDATA" value="${pd.PAGEDATA}" maxlength="32" placeholder="这里输入备用字段" title="备用字段"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/index/top.jsp"%>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
	<!-- 树形下拉框end -->
	
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="questionnaire/saveTransfer.do" name="userForm" id="userForm" method="post">
									
									<input type="hidden" name="questionnaireId" id="questionnaireId" value="${pd.questionnaireId }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">部门:</td>
											<td>
												<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID"/>
												<div class="selectTree" id="selectTree"></div>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">员工:</td>
											<td>
												<select name="USER_ID" id="userSelect"  style="width:90%;line-height:26px">
													<option value="">请选择</option>
												</select>
											</td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
												<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
											</td>
										</tr>
									</table>
									</div>
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
								</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
	$(top.hangge());
	function save(){
		
		if($("#DEPARTMENT_ID").val() == ''){
			$("#selectTree").tips({
				side:3,
	            msg:'请选择问卷',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#selectTree").focus();
			return false;
			
		}
		if($("#userSelect").val() == ''){
			$("#userSelect").tips({
				side:3,
	            msg:'请选择员工',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#userSelect").focus();
			return false;
		}
		$("#userForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	//下拉树
	var defaultNodes = {"treeNodes":${zTreeNodes}};
	function initComplete(){
		//绑定change事件
		$("#selectTree").bind("change",function(){
			if(!$(this).attr("relValue")){
		      //  top.Dialog.alert("没有选择节点");
		    }else{
				//alert("选中节点文本："+$(this).attr("relText")+"<br/>选中节点值："+$(this).attr("relValue"));
				$("#DEPARTMENT_ID").val($(this).attr("relValue"));
				$("#DEPARTMENT_NAME").val($(this).attr("relText"));
				findUser($(this).attr("relValue"));
		    }
		});
		//赋给data属性
		$("#selectTree").data("data",defaultNodes);  
		$("#selectTree").render();
		$("#selectTree2_input").val("${null==pd.DEPARTMENT_NAME?'请选择':pd.DEPARTMENT_NAME}");
	}
	//查询部门下员工
	function findUser(DEPARTMENT_ID){
		$.ajax({
			url:"questionnaire/findDepartmentUser",
			type:"post",
			data:{DEPARTMENT_ID:DEPARTMENT_ID},
			success: function(data){
				var html ="<option value=''>请选择</option>";
				$.each(data,function(i,val){
					html += "<option value='"+val.USER_ID+"'>"+val.USERNAME+"</option>"
				});
				$("#userSelect").empty();
				$("#userSelect").append(html);
			}
		});
	}
</script>
</html>
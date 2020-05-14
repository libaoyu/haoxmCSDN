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
		<title>ADD</title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 下拉复选框 begin -->
		<link rel="stylesheet" type="text/css" href="static/question/css/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/style.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/jquery-ui.css" />
		
		<script type="text/javascript" src="static/question/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="static/question/js/jquery.multiselect.js"></script> 
		<!-- 下拉复选框 end -->
		
		<!-- 富文本编辑器 -->
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript">

	$(function() {
		$("#MySelectBox").multiselect({
			noneSelectedText: "请选择", 
			checkAllText: "全选", 
			uncheckAllText: '全不选', 
			selectedList: 10, 
		});
	 	var ids = "${questionnaire.respondents}".split(',');   
        if (ids != null) {            
            $('#MySelectBox').val(ids);
            $('#MySelectBox').multiselect("refresh");           
        } 
	});
	function changeLeve(){
		//显示选择项文本
		var array_of_checked_values = $("#MySelectBox").multiselect("getChecked").map(function(){
				return this.value; 
			}).get();
		$("#respondents").val(array_of_checked_values);
	}
	function changeGetQuestionnaireType(obj){
		if(obj.value!='' && obj.value!='请选择'){
			$("#respondentsStr").css('display','');
			appendMySelectedBoxByAjax(obj.value);
		}else{
			$("#respondentsStr").css('display','none');
		}
		
	}
	function appendMySelectedBoxByAjax(id){
		var url = "<%=basePath%>questionnaire/getRespondentsForParentIdByAjax.do?parentId="+id;
		
		$('#MySelectBox').empty();
		$('#MySelectBox').multiselect('refresh');
		$.ajax({
			type: "POST",
			url: url,
	    	//data: {questionnaireId:questionnaireId,levels:levels,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				var jsonObj1=eval(data.respondents);
				//alert(jsonObj1);
				//更新调查对象下拉复选
				for(var i=0; i<jsonObj1.length; i++){
					opt = $('<option />', {  
                        value: jsonObj1[i].key,  
                        text: jsonObj1[i].value  
                    }); 
					opt.appendTo($('#MySelectBox')); 
				}
				var ids = "${question.level}".split(',');      
		        if (ids != null) {            
		            $('#MySelectBox').val(ids);
		            $('#MySelectBox').multiselect("refresh");           
		        }
				$('#MySelectBox').multiselect('refresh');
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				$('#parentId').empty();
				$('#MySelectBox').empty();
				$('#MySelectBox').multiselect('refresh');
				alert('数据获取异常');    
			}
		});
	}
	
</script>
</head>
<body>
	<form action="questionnaire/copyQuestion.do" name="Form" id="Form" method="post" >
		<input type="hidden" name="questionnaireId" id="questionnaireId" value="${questionnaire.questionnaireId}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">问卷题目:</td>
				<td style="width:70%;" colspan="3">
				<input name="title" style="width:88%" id="title" value="${questionnaire.title}" type="text" disabled="disabled">
				</td>
			</tr>
			<tr style="height: 58px; ">
				<td style="width:20%;text-align: right;padding-top: 13px;">调查对象类型:</td>
				<td style="width:70%;" colspan="3">
					<select name="respondentsParentId" id="respondentsParentId"  style="width:90%;line-height:26px" onchange="changeGetQuestionnaireType(this);">
						<option value="">请选择</option>
						<c:forEach items="${getQuestionnaireType}" var="item">
							<option value="${item.key}" <c:if test="${questionnaire.respondentsParentId==item.key}"> selected=true</c:if> >${item.value }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr id="respondentsStr" style="height: 58px;<c:if test="${questionnaire.respondents == null }">display:none;</c:if>">
				<td style="width:20%;text-align: right;padding-top: 13px;">调查对象:</td>
				<td style="width:70%;" colspan="3">
					<input type="hidden" name="respondents" id="respondents" value="${questionnaire.respondents}"/>
					<select id="MySelectBox" multiple="multiple" data-placeholder="请选择调查对象" style="width:70%;line-height:26px" onchange="changeLeve();">
							<c:forEach items="${respondentsForListByParentId}" var="item">
								<option value="${item.key}" >${item.value }</option>
							</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">是否使用原短链接:</td>
				<td style="width:70%;" colspan="3">
					<select name="isNewUrl" style="width:90%;line-height:26px">
						<option value="0" >不使用</option>
						<option value="1" >使用</option>
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
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
		<!-- 引入 -->
		<script src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script type="text/javascript">
		$(top.hangge());
		
		function save(){
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		</script>
</body>
</html>
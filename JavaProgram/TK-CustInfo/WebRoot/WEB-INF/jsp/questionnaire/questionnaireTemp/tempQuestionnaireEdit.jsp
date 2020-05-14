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
		
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
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
	 	var ids = "${pd.level}".split(',');        
        if (ids != null) {            
            $('#MySelectBox').val(ids);
            $('#MySelectBox').multiselect("refresh");           
        }
	      
	});
	
	//替换图片
	function changeImg(file,imgPathId){
		 var prevDiv = document.getElementById('preview');
		 if (file.files && file.files[0])
		 {
			 var reader = new FileReader();
			 reader.onload = function(evt){
			 	//prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
			 	$('#'+imgPathId).attr('src',evt.target.result);
			 }  
			 reader.readAsDataURL(file.files[0]);
		 }else  
		 {
			 $('#'+imgPathId).attr("style","filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src='" + file.value + "'");
			 //prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
		 }
		//document.getElementById(imgId).click();
	}
	//保存
	function save(){
		var value=title.getContent();
		//alert(value);
		if(value==""){
			$("#title").tips({
				side:3,
	            msg:'请输入问卷标题名称',
	            bg:'#AE81FF',
	            time:2
	        });
			title.focus();
			return false;
		}else{
			$('#title1').val(value);
		}
		$('#preface1').val(preface.getContent());
		/**
		if($("#preface").val()==""){
			$("#preface").tips({
				side:3,
	            msg:'请输入卷首语',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#preface").focus();
			return false;
		}*/
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	function changeLeve(){
		//显示选择项文本
		var array_of_checked_values = $("#MySelectBox").multiselect("getChecked").map(function(){
				return this.value; 
			}).get();
		$("#respondents").val(array_of_checked_values);
		//显示数量
		/**
		var ids=[];
		$("#MySelectBox :checked").each(function(i,item){
			ids.push($(item).attr("value"));
		});	
		$("#respondents").val(ids.join(","));*/
	}
	function deletePicture(ids,type){
		var id=$('#'+ids).val();
		if(id!=null && id !=''){
			var questionnaireId="${pd.questionnaireId}";
			if(questionnaireId!=null&&questionnaireId!=''){
				var result =window.confirm("是否确认删除图片？");
				if(result) {
					var url = "<%=basePath%>questionnaire/deletePicture.do?questionnaireId="+questionnaireId+"&type="+type+"&fileId="+id;
					$.get(url,function(data){
						if(data=='success'){
							$('#'+type).attr("src","");
							$('#'+ids).val('');
						}
						
					});
				}
			}
		}else{
			var obj=null;
			if(type=='logoImgPath'){
				obj = document.getElementById('logoImgFile') ; 
			}else if(type=='backgroundImgPath'){
				obj = document.getElementById('backgroundImgFile') ; 
			}
			obj.outerHTML=obj.outerHTML; 
			$('#'+type).attr("src","");
		}
	}
	function changeGetQuestionnaireType(obj){
		//alert(obj.value);
		
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
	<form action="questionnaireTemp/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="questionnaireId" id="questionnaireId" value="${pd.questionId}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">问卷题目:</td>
				<td style="width:70%;" colspan="3">
				<%-- <input style="width:90%" type="text" name="title" id="title" value="${pd.title}" maxlength="32" placeholder="这里输入问卷名称" title="问卷名称"/> --%>
				<script id="title"  type="text/plain" style="width: 100%; height: 70px;">${pd.title}</script>
				<input name="title" id="title1" value="" type="hidden">
				</td>
				
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">卷首语:</td>
				<td style="width:70%;" colspan="3">
				<%-- <textarea id="preface" name="preface" rows="3" cols="50" placeholder="问卷序言"  title="问卷序言" style="width: 90%;"></textarea> --%>
				<input id="preface1" name="preface" value="" type="hidden">
				<script id="preface"  type="text/plain" style="width: 100%; height: 100px;">${pd.preface}</script>
				</td>
			</tr>
			
			<tr  style="height: 58px; ">
				<td style="width:20%;text-align: right;padding-top: 13px;">调查对象类型:</td>
				<td style="width:70%;" colspan="3">
					<select name="respondentsParentId" id="respondentsParentId"  style="width:90%;line-height:26px" onchange="changeGetQuestionnaireType(this);">
						<option value="">请选择</option>
						<c:forEach items="${getQuestionnaireType}" var="item">
							<option value="${item.key}" <c:if test="${pd.respondentsParentId==item.key}"> selected=true</c:if> >${item.value }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr id="respondentsStr" style="height: 58px;<c:if test="${pd.level == null }">display:none;</c:if>">
				<td style="width:20%;text-align: right;padding-top: 13px;">调查对象:</td>
				<td style="width:70%;" colspan="3">
					<input type="hidden" name="respondents" id="respondents" value="${pd.level }"/>
					<select id="MySelectBox" multiple="multiple" data-placeholder="请选择调查对象" style="width:70%;line-height:26px" onchange="changeLeve();">
							<c:forEach items="${staffLevels}" var="item">
								<option value="${item.key}" >${item.value }</option>
							</c:forEach>
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
		var title = UE.getEditor('title', {
		    toolbars: [
["undo","redo","link","unlink","bold","italic","underline","fontborder","strikethrough","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","indent","removeformat","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize"]
		           ],
		           autoHeightEnabled: true,
		           autoFloatEnabled: true,
		           wordCountMsg:false,
		           elementPathEnabled:false
		       });
		var preface = UE.getEditor('preface',{
		    toolbars: [
["undo","redo","link","unlink","bold","italic","underline","fontborder","strikethrough","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","indent","removeformat","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize"]
		           ],
		           autoHeightEnabled: true,
		           autoFloatEnabled: true
		       });
		
		$(top.hangge());
		</script>
</body>
</html>
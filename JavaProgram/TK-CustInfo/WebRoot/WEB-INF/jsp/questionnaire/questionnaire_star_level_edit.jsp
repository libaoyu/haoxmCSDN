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
	 	var ids = "${pd.respondents}".split(',');  
        if (ids != null) {            
            $('#MySelectBox').val(ids);
            $('#MySelectBox').multiselect("refresh");           
        } 
      //日期框
		$('.date-picker').datepicker(); 
      if("${hospitalCodeStr}" !=null && "${hospitalCodeStr}" !=''){
    	  $('#hospitalCode').change();
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
		$('#markedWords1').val(markedWords.getContent());
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
		var startTime=$("#startTime").val();
		if(startTime==""){
			$("#startTime").tips({
				side:3,
	            msg:'请输入问卷开始时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#startTime").focus();
			return false;
		}
		/* var endTime=$("#endTime").val();
		if(endTime==""){
			$("#endTime").tips({
				side:3,
	            msg:'请输入问卷结束时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#endTime").focus();
			return false;
		} */
		
		if($("#respondentsParentId").val()==""){
			$("#respondentsParentId").tips({
				side:3,
	            msg:'请选择问卷调查对象类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#respondentsParentId").focus();
			return false;
		}
		if($("#releaseStatus").val()==""){
			$("#releaseStatus").tips({
				side:3,
	            msg:'请选择问卷状态',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#releaseStatus").focus();
			return false;
		}
		if($("#questionUrl").val()==""){
			$("#questionUrl").tips({
				side:3,
	            msg:'请输入问卷访问地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#questionUrl").focus();
			return false;
		}
		if($("#interfaceCode").val()==""){
			$("#interfaceCode").tips({
				side:3,
	            msg:'请选择医院接口类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#interfaceCode").focus();
			return false;
		}
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
	function changeHospitalCode(obj){
		var hospitalCode=obj.value;
		$("#interfaceCodeStr").css("display","");
		getHospitalCodeByType(hospitalCode);
	}
	function getHospitalCodeByType(arrList){
		var url="<%=basePath%>questionnaire/changeHospitalCode.do?data="+arrList;
		$.ajax({
			type: "POST",
			url: url,
			dataType:'json',
			cache: false,
			success: function(data){
				var html=""
				var dataStr=eval(data.respondents);
				var  interfaceCode="${pd.interfaceCode}";
				for(var i=0;i<dataStr.length;i++){
					if(interfaceCode==dataStr[i].key){
						html+="<option selected='true' value="+dataStr[i].key+">"	+dataStr[i].value+"</option>";		
					}else{
						html+="<option value="+dataStr[i].key+">"	+dataStr[i].value+"</option>";		
					}
					
				}
				$("#interfaceCode").html(html);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				$("#interfaceCode").html('');
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
	<form action="questionnaire/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="questionnaireId" id="questionnaireId" value="${pd.questionnaireId}"/>
		<input type="hidden" name="questionnaireType" id="questionnaireType" value="${pd.questionnaireType}"/>
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
			<tr  style="height: 58px;">
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
			<tr id="respondentsStr"  style='height: 58px;<c:if test="${pd.respondents == null }">display:none;</c:if>' >
				<td style="width:20%;text-align: right;padding-top: 13px;">调查对象:</td>
				<td style="width:70%;" colspan="3">
					<input type="hidden" name="respondents" id="respondents" value="${pd.respondents }"/>
					<select id="MySelectBox" multiple="multiple" data-placeholder="请选择调查对象" style="width:70%;line-height:26px" onchange="changeLeve();">
						<c:forEach items="${respondentsForListByParentId}" var="item">
								<option value="${item.key}" >${item.value }</option>
							</c:forEach>
					</select>
				</td>
			</tr>
			<c:if test="${!empty hospitalCodeStr }">
				<tr>
					<td style="width:20%;text-align: right;padding-top: 13px;">医院选择:</td>
					<td style="width:70%;" colspan="3">
						<select name="hospitalCode" id="hospitalCode" placeholder="请选择"  style="width:90%;line-height:26px" onchange="changeHospitalCode(this);">
								<c:forEach items="${getHosName}" var="item">
								<c:if test="${item.key eq pd.hospitalCode}">
									<option value="${item.key}" selected="selected">${item.value }</option>
								</c:if>
								<c:if test="${item.key ne pd.hospitalCode}">
									<option value="${item.key}" >${item.value }</option>
								</c:if>
								</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			
			<tr style="" id="interfaceCodeStr">
				<td style="width:20%;text-align: right;padding-top: 13px;">医院接口选择:</td>
				<td style="width:70%;" colspan="3">
					<c:if test="${empty hospitalCodeStr }">
						<input  name="hospitalCode" value="${hospitalCode }" type="hidden"/>
					</c:if>
					<select name="interfaceCode" id="interfaceCode" placeholder="请选择" style="width:90%;line-height:26px">
							<c:forEach items="${getInterName}" var="item">
								<c:if test="${item.key eq pd.interfaceCode}">
									<option value="${item.key}" selected="selected">${item.value }</option>
								</c:if>
								<c:if test="${item.key ne pd.interfaceCode}">
									<option value="${item.key}" >${item.value }</option>
								</c:if>
							</c:forEach> 
					</select>
				</td>
			</tr>
			
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">发布状态:</td>
				<td style="width:70%;" colspan="3">
					<select name="releaseStatus" id="releaseStatus" placeholder="请设置问卷状态" style="width:90%;line-height:26px">
							<c:forEach items="${releaseStatusList}" var="item">
							<c:if test="${item.key eq pd.releaseStatus}">
								<option value="${item.key}" selected="selected">${item.value }</option>
							</c:if>
							<c:if test="${item.key ne pd.releaseStatus}">
								<option value="${item.key}" >${item.value }</option>
							</c:if>
							</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">问卷网址:</td>
				<td style="width:70%" colspan="3"><input style="width:90%" type="text" name="questionUrl" id="questionUrl" <c:if test="${pd.questionUrl !=null && pd.questionUrl!=''}">value="${pd.questionUrl}"</c:if> <c:if test="${pd.questionUrl ==null || pd.questionUrl ==''}">value="<%=basePath %>qResult/getList"</c:if>  placeholder="这里输入问卷访问地址" title="问卷访问地址"/></td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">开始时间:</td>
				<td style="width:30%;"><input class="span10 date-picker" name="startTime" id="startTime" value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
				<td style="width:10%;text-align: right;padding-top: 13px;">结束时间:</td>
				<td style="width:30%;"><input class="span10 date-picker" name="endTime" id="endTime" value="${pd.endTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">LOGO:<br/><font style="color: red;">背景透明(格式PNG)</font><br/><font style="color: red;">高x宽(203*40)</font></td>
				<td style="width:70%;" colspan="3">
					 <div id="preview">
					 	<img alt="logo" name="logoImgPath" id="logoImgPath" style="width: 100px;height: 100px;" src="<%=basePath %>${pd.logoImgPath }"/>
					 	<input type="hidden" id="logoImgId" name="logoImgId" value="${pd.logoImgId }"/>
					 </div>
					 <input type="file" id="logoImgFile" style=" font-size: 15px;width:200px" name="logoImgFile" onchange="changeImg(this,'logoImgPath')" size="20"/>
					<a style="height: 30px;width: 30px;padding: 3px;padding-left: 5px;" class=" btn-small btn-danger" onclick="deletePicture('logoImgId','logoImgPath');" title="删除图片" ><i class='icon-trash'></i></a>
				</td>
			</tr>
			
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">背景音乐</td>
				<td style="width:70%;" colspan="3">
					<select name="backMusic" id="backMusic" style="width:90%;line-height:26px">
						<option value="">请选择</option>
						<option value="../static/videoLog/mp3/LUDLOWS.mp3" <c:if test="${pd.backMusic =='../static/videoLog/mp3/LUDLOWS.mp3' }">selected=true</c:if> >LUDLOWS</option>
						<option value="../static/videoLog/mp3/video_20171016.mp3" <c:if test="${pd.backMusic =='../static/videoLog/mp3/video_20171016.mp3' }">selected=true</c:if>>新版司歌《泰康永远》</option>
						<option value="../static/videoLog/mp3/woainitaikang.mp3" <c:if test="${pd.backMusic =='../static/videoLog/mp3/woainitaikang.mp3' }">selected=true</c:if>> 暖场：我爱你泰康</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">是否允许问卷多次提交</td>
				<td style="width:70%;" colspan="3">
					是<input type="radio" value="1" name="allowedRepeatSwith" <c:if test="${pd.allowedRepeatSwith  }">checked=true</c:if> id="allowedRepeatSwith"></br>
					否<input type="radio" value="0" name="allowedRepeatSwith" <c:if test="${!pd.allowedRepeatSwith  }">checked=true</c:if> id="allowedRepeatSwith"></br>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">背景音乐开关</td>
				<td style="width:70%;" colspan="3">
					<!-- <select name="backMusicSwith" id="backMusicSwith" style="width:90%;line-height:26px">
						
					</select> -->
					开<input type="radio" value="1" name="backMusicSwith" <c:if test="${pd.backMusicSwith  }">checked=true</c:if> id="backMusicSwith"></br>
					关<input type="radio" value="0" name="backMusicSwith" <c:if test="${!pd.backMusicSwith  }">checked=true</c:if> id="backMusicSwith"></br>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">背景选择</td>
				<td style="width:70%;" colspan="3">
					<select name="finishBackground" id="finishBackground" style="width:90%;line-height:26px">
						<option value="">请选择</option>
						<option value="usualModel" <c:if test="${pd.finishBackground =='usualModel' }">selected=true</c:if>>常规模式</option>
						<option value="flowerModel"  <c:if test="${pd.finishBackground =='flowerModel' }">selected=true</c:if>>鲜花模式</option>
						<option value="markedWords"  <c:if test="${pd.finishBackground =='markedWords' }">selected=true</c:if>>自定义提示语</option>
						<option value="by_bo_ansult_success"  <c:if test="${pd.finishBackground =='by_bo_ansult_success' }">selected=true</c:if>>拜博口腔</option>
						
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">问卷底部状态选择</td>
				<td style="width:70%;" colspan="3">
					<select name="bootomType" id="bootomType" style="width:90%;line-height:26px">
						<option value="">请选择</option>
						<option value="xianlin_bootom.jsp" <c:if test="${pd.bootomType =='xianlin_bootom.jsp' }">selected=true</c:if>>仙林模式</option>
						<option value="yanyuankangfuyiyuan_bootom.jsp" <c:if test="${pd.bootomType =='yanyuankangfuyiyuan_bootom.jsp' }">selected=true</c:if>>康复医院模式</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">问卷状态:</td>
				<td style="width:70%;" colspan="3">
					<select name="validState" id="validState" style="width:90%;line-height:26px">
						<c:forEach items="${status}" var="item">
							<c:if test="${item.key eq pd.validState}">
								<option value="${item.key}" selected="selected">${item.value }</option>
							</c:if>
							<c:if test="${item.key ne pd.validState}">
								<option value="${item.key}" >${item.value }</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">备注描述:</td>
				<td style="width:70%;" colspan="3">
					<textarea name="description" id="description" rows="3" cols="10" title="备注描述" style="width:90%">${pd.description}</textarea>
				</td>
			</tr>
			<tr>
				<td style="width:20%;text-align: right;padding-top: 13px;">提示语:</td>
				<td style="width:70%;" colspan="3">
					<script id="markedWords"  type="text/plain" style="width: 100%; height: 70px;">${pd.markedWords}</script>
					<input name="markedWords" id="markedWords1" value="" type="hidden">
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
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script src="static/js/jquery.tips.js"></script>
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
		var markedWords = UE.getEditor('markedWords', {
		    toolbars: [
["undo","redo","link","unlink","bold","italic","underline","fontborder","strikethrough","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","indent","removeformat","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize"]
		           ],
		           autoHeightEnabled: true,
		           autoFloatEnabled: true,
		           wordCountMsg:false,
		           elementPathEnabled:false
		       });
		$(top.hangge());
		</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<link href="../static/question/css/bootstrap.css" rel="stylesheet">
<title></title>
<link rel="stylesheet" href="../static/question/custom_template_questionnaire/custom_template_questionnaire.css">
<script type="text/javascript" src="../static/jedate/jedate.min.js"></script>
<script type="text/javascript">

	function addCookieForValue(obj){
		$.cookie(obj.name,obj.value,{expires:7});
	}
	function addCookieForValueFor(obj,values){
		$.cookie(obj.name,values,{expires:7});
	}
	function setCookie(id,value){
		$.cookie(id,value,{expires:7});
	}
	//为单选框赋值，并且存在cookie
	function setRadio(param,obj){
		var qValue = obj.value;
		//为单选框当前对象添加cookie
		addCookieForValueFor(obj,qValue);
		//为单选框对应的 隐藏域添加cookie
		//setCookie(param,qValue);
	}
	//为复选框赋值，且将数据存在cookie
	function setCheckbox(param,obj){
		var values='';
		var index=0;
		var checkboxs=$('input[name='+param+']');
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked==true){
				if(index==0){
					values='%'+checkboxs[i].value;
				}else{
					values=values+'%'+checkboxs[i].value;
				}
				index++;
				
			}
		}
		//alert(values);
		addCookieForValueFor(obj,values);
	}
	//为下拉框赋值给隐藏域，且将值存cookie
	function setSelect(param ,obj){
		setCookie(param,obj.value);
	}
	
	</script>
<script type="text/javascript">
	function addValueForCookie(){
		//取得当前的cookie
	    var cookieStr=document.cookie;
		//alert(cookieStr);
		//cookie 存在多个时已分号隔开
      	if(cookieStr.indexOf(';')>-1){
    		var cookieArr=cookieStr.split(';');
    	  	for(var i=0;i<cookieArr.length;i++){
    		  //获取每个cookie
    		  var nameValue=cookieArr[i];
    		  //获取每个cookie的键值
    		  var nameValueArr=nameValue.split('=');
    		  addValueForLoad(nameValueArr);
    	  }
      }else{
    	  var nameValueArr=cookieStr.split('=');
    	  addValueForLoad(nameValueArr);
      }
	     document.styleSheets[0].insertRule('.wrapper::before{background:url(<%=basePath%>${questionnaireData.backgroundImgPath})}',0);
	 <%--  //   document.styleSheets[0].addRule('.wrapper::before{background:url(<%=basePath%>${questionnaireData.backgroundImgPath})}',0) ; --%>
	 
	 window.onscroll = function(){
	        var top=document.body.scrollTop;
	      //  console.log(top);
	        if(top>200){
	            $('#angle_up').css('display','none');
	        }else{
	            $('#angle_up').css('display','block');
	        }
	    }
	
	} 
	
	
	//公用去cookie的方法。
	function addValueForLoad(nameValueArr) {
		//
		var name = nameValueArr[0];
		var value = decodeURIComponent(nameValueArr[1]);
		//alert(value);
		if (name.indexOf('-id') > -1) {
			name = name.replace(/(^\s*)|(\s*$)/g, '');
			$('#' + name).html(value + "分");
		}
		//根据name获取到input
	//	alert(name+"---------"+value);
		//判断名字包含_checkId   则为下拉框
		if(name.indexOf('_checkId') > -1){
			var selects = $('select[id=' + name + ']');
			// alert(selects.length);
			if (selects.length != 0) {
				selects[0].value = value;
			}
		//否则    为     单选框，复选框  单行文本
		}else{
			var inputs = $('input[name=' + name + ']');
		//	alert(inputs.length);
			//表示单行文本    或者文本域 
			if(inputs.length ==0){
				var textAreas = $('textarea[name=' + name + ']');
				if (textAreas.length != 0) {
					textAreas[0].value = value;
				}
			}else if(inputs.length==1){
				inputs[0].value = value;
			//表示    单选框     复选框 
			}else {
				//说明多个值。只有复选框
				if (value.indexOf('%') > -1) {
					var checkboxs = $('input[name=' + name + ']');
					var checkboxValues = value.split('%');
					for (var j = 0; j < checkboxs.length; j++) {
						for (var k = 0; k < checkboxValues.length; k++) {
							if (checkboxs[j].value == checkboxValues[k]) {
								checkboxs[j].checked = true;
								break;
							}
						}
					}
					/* if (inputs.length != 0) {
						inputs[0].value = value;
					} */
					return;
				}else{
					//长度为多个时，肯定为单选框或者复选框
					for (var j = 0; j < inputs.length; j++) {
						if (inputs[j].value == value) {
							inputs[j].checked = true;
							//break;
						}
					}
				}
			}
		}
	}
	//评分题选择事件
	function choseNumFor(questionId, type) {
		var obj = document.getElementsByName(questionId);
		for (var i = 0; i < obj.length; i++) {
			obj[i].setAttribute("onclick", "toChoseNumFor('" + questionId
					+ "',this,'" + type + "')");
		}
	}
	//评分题评值
	function toChoseNumFor(question, obj, type) {
		var qValue = obj.value;
		$("#" + question + "-id").html(qValue + "分");
		$("#" + question + "_" + type).val(qValue);
		//为评分题。。。添加cookie
		addCookieForValue(obj);
		//为评分题的隐藏域添加cookie
		$.cookie(question + "-id", qValue, 7, '/');
		$.cookie(question + "_" + type, qValue, 7, '/');
	}
	function saveDataForList() {
		$('[id^=mustFlag_]') .each( function(index, elementObj) {
			var id = $(elementObj).attr("id");
			var questionsId = id.split('_')[1];
			var inputs = $('[name^=' + questionsId + '_]');
			var startLen = inputs.length;
			//文本域
			if(inputs.length==0){
				//文本域
				var textAreas = $('textarea[name^=' + questionsId + ']');
				if(textAreas.length>0){
					for(var i=0;i<textAreas.length;i++){
						if(textAreas.value==''){
							$(elementObj) .attr( "style", "display:block");
							$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").addClass('border');
							return false;
						}else{
							$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").removeClass('border');
							$(elementObj) .attr( "style", "display:none;");
						}
					}
				}
				//下拉框
				var selects=$("select[name^="+questionsId+"]");
				if(selects.length>0){
					for(var i=0;i<selects.length;i++){
						if(selects[i].value==''){
							$(elementObj) .attr( "style", "display:block");
							$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").addClass('border');
							return false;
						}else{
							$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").removeClass('border');
							$(elementObj) .attr( "style", "display:none;");
						}
					}
				}
				
			//input 框
			}else if(inputs.length==1){
				//alert(questionsId);
				$('[name^=' + questionsId + '_]') .each( function(index, elementInput) {
					var entity = inputs[startLen - 1 - index];
					if ($(entity).val() == '') {
						$(elementObj) .attr( "style", "display:block");
						$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").addClass('border');
						return false;
					}else{
						$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").removeClass('border');
						$(elementObj) .attr( "style", "display:none;");
					}
				});
			//单选题    复选题 
			}else{
				var isChecked=false;
				$('[name^=' + questionsId + '_]') .each( function(index, elementInput) {
					if(!isChecked && elementInput.checked){
						isChecked=true;
					}
				});
				//alert(isChecked);
				if(!isChecked){
					$(elementObj).attr( "style", "display:block");
					$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").addClass('border');
				}else{
					$("#"+questionsId.replace(/(^\s*)|(\s*$)/g, "")+"frame").removeClass('border');
					$(elementObj).attr( "style", "display:none;");
				}
			}
		});
		var isRight = true;
		var locationId="";
		$('[id^=mustFlag_]').each(function(index, elementObj) {
			var style =$(elementObj).css('display');
			//alert(style);
			if (style == 'block') {
				if(locationId==''){
					locationId=$(elementObj).attr("id");
				}
				isRight = false;
			}
		});
		//alert(locationId);
		if (!isRight) {
			//alert("必填没填！");
			var questionsId=locationId.split("_")[1];
			var inputs = $('[name^=' + questionsId + '_]');
			var startLen = inputs.length;
			$('[name^=' + questionsId + '_]') .each( function(index, elementInput) {	
				var entity = inputs[startLen - 1 - index];
				var ua = navigator.userAgent.toLowerCase();	
				if (/iphone|ipad|ipod/.test(ua)) {
					var id=$(entity)[0].id;
					$("#maodian").attr("href","#"+id);			//跳转到指定id的锚点
					$("#click").click();
				} else{
					$(entity).focus();
				}
				if (entity != document.activeElement) {
					var all = $('[name^='+ questionsId+ ']');
					var allLen = $('[name^='+ questionsId+ ']').length;
				    $('[name^='+ questionsId+ ']').each( function( index, elementInput) { 
							var allEntity = all[allLen - 1 - index];
							var ua = navigator.userAgent.toLowerCase();	
							//alert(name);
							if (/iphone|ipad|ipod/.test(ua)) {
							    //alert("iphone");	
								var id=allEntity.id;
								$("#maodian").attr("href","#"+id);			//跳转到指定id的锚点
								$("#click").click();
							} else{
							    //alert("android");
								$(allEntity).focus();
							}
							return false;
					});
				}
				//exist = false;
			else{
				
			}
		});
			return false;
		}
		//alert("提交。。。。。");
		$('#mask').show();
		$('#loading').show();
		$('.survey_main').bind( "touchmove", function (e) {
			   e.preventDefault();
			});

		$("body,.c").height($(window).height()).css({
			  "overflow-y": "hidden"
			});
		$('#questionForm').attr('action','saveQuestionsForList');
		$('#questionForm').submit();
	}
	function addCookieForT7(elem,id){
		//alert(elem);
		//alert(id);
		setCookie(id,elem);
	}
	function clickRadioForA(id){
		//alert(id);
		$("#"+id).click();
	}
	 /* 单选题隐藏一部分题型 */
	 function hiddenSomeQuestions(obj){
		 var id=obj.id;
		 var questionsId=id.split("_");
		 //获取所有问题的列表
		 var questionList=$("#hidden_all_by_"+questionsId[0]+"_input").val();
		 var dataList=eval(questionList);
		 var thisValue=obj.value;
		 var arrList="";
		 for(var i=0;i<dataList.length;i++){
			// alert(dataList[i].name);
			 var questionsIdList=dataList[i].value.split(",");
			 for(var j=0;j<questionsIdList.length;j++){
				if(thisValue==dataList[i].name){
					$("#"+questionsIdList[j]+"_div_hidden").css("display","");
				 }else{
					 $("#"+questionsIdList[j]+"_div_hidden").css("display","none");
						// alert(questionsIdList[j]+"_div_hidden");
						 $('[name^='+ questionsIdList[j]+ ']').each( function( index, elementInput) { 
							$(elementInput).disabled=true;
						});
				 } 
			 }
		 }
		 var qValue = obj.value;
		 addCookieForValueFor(obj,qValue);
	 }
	 function showImgByAjax(){
		 $('[id^=img_show_]').each(function(index, elementObj) {
				var value =$(elementObj).attr("value");
				alert(value);
			});
	 }
</script>
<style type="text/css">
	/*滑动操作提示*/
	.backImg{
		width: 70px;height: 127px;position: fixed;background-image: url('../static/images/gensture.png');
	background-position: 100% 100%;background-size:cover;bottom: -30px;left: 53%;transform:translateX(-35px);opacity:0;
	
	animation:bounce 2.5s infinite 0s;
	}
	@keyframes bounce{
		0%{
			bottom:-30px;
			opacity:1;
		}
		100%{
			bottom:30px;
			opacity:0;
		}
	}
</style>
</head>
<body >
	<div class="backImg" style="" id="angle_up"></div>
	<div id="backgroundPic" class="main_wrapper wrapper"
		style="">
		<div class="logo"
			style="background-repeat: no-repeat;background-image:url('<%=basePath%>${questionnaireData.logoImgPath}');"></div>
		<div class="survey_title" id="main_Title">
			<div class="inner">
				<div class="title_content">
					${ questionnaireData.title}
				</div>
			</div>
		</div>
		<div class="survey_main">
			<div class="main_content" style='display: '>
				<div class="main_border">
					<div class="mian_inner_content">
						<!--设置字体大小-->
						<div class="font_size">
							<label>字体:</label> <input type="radio" name="fontS" value="大">
							<span>大</span> <input type="radio" name="fontS" value="中">
							<span>中</span> <input type="radio" name="fontS" value="小" checked="checked">
							<span>小</span>
						</div>
						<hr class="f1 user_hr2">
						<!--navbar-->
						<div style="margin: 3% 3%; line-height: 1.5; text-align: justify">
							${questionnaireData.preface }
						</div>
						<!--navbar end-->
						<!--section-->
						<!-- <div class="hr_div">
							<hr class="f1 user_hr1">
							<p class="f1 user_p1">填写个人信息</p>
							<hr class="f1 user_hr1">
							<div class="c1"></div>
						</div> -->
<form action="#" method="post" name="Form"
	id="questionForm" >
	<input name="batchId" type="hidden" value="${batch }" /> 
	<input name="questionnaireId" type="hidden" value="${questionnaireId }" />
	<input name="level" type="hidden" value="${pd.level }" />
    <input name="column1" type="hidden" value="" />
	<!--main-->
	<div class="main">
		<c:forEach items="${ varList}" var="entity" varStatus="countEntity">
			<c:if test="${entity.types=='T10' }">
					<c:if test="${entity.cutoffRule=='activeLine' }">
	   					 <c:if test="${empty entity.title }">
	   					 	 <div class="lineAcive" style="margin-top: 10px;"  id="${entity.questionId }_div_hidden"></div>
	   					 </c:if>
	   					 <c:if test="${!empty entity.title }">
	   					 	 <div class="lineOne" style="margin-top: 10px;"  id="${entity.questionId }_div_hidden">
	    					    <p class="lineAcive" style="float:left;width:30%;"></p>
	    					    ${entity.title }
	    					    <p class="lineAcive" style="float:right;width:30%;"></p>
	    					 </div>
	   					 </c:if>
	 				</c:if>
				 	<c:if test="${entity.cutoffRule=='dashed' }">
				 		 <c:if test="${empty entity.title }">
				 			 <div class="lineX" style="margin-top: 10px;" id="${entity.questionId }_div_hidden"> </div>
	   					  </c:if>
	   					 <c:if test="${!empty entity.title }">
	    					 <div class="lineOne" style="margin-top: 10px;"  id="${entity.questionId }_div_hidden">
	    					    <p class="lineX" style="float:left;width:30%;"></p>
	    					    ${entity.title }
	    					    <p class="lineX" style="float:right;width:30%;"></p>
	    					 </div>
	    				 </c:if>	
				 	</c:if>
			</c:if>
			<c:if test="${entity.types=='T15' }">
				<!-- 提示题 -->
				<div>
					${entity.title }
				</div>
			</c:if>
			<c:if test="${entity.classification=='L0' }">
					<div id="${entity.questionId }frame" class="user_div01">
					<c:if test="${entity.types !='T10'  and entity.types !='T15'}">
						<c:if test="${entity.types=='T1' || entity.types=='T2' }">
							<span class="user_span03 f1" id="span_${entity.questionId }">
								${entity.title } </span>
						</c:if>
						<c:if test="${entity.types!='T1' and entity.types !='T2' }">
							<span class="user_span01 f1" id="span_${entity.questionId }">
								${entity.title } </span>
						</c:if>
					</c:if>
						<c:if test="${ entity.types=='T0'}">
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}" type="radio" value="0"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" id="${entity.questionId}_checkId0"/>
								<a onclick="clickRadioForA('${entity.questionId}_checkId0');"> <span
								class="sp_ma">不适用</span></a>
							</label>
						
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}" type="radio" value="1"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" id="${entity.questionId}_checkId1"/>
								<a onclick="clickRadioForA('${entity.questionId}_checkId1');"> <span
								class="sp_ma">1分</span></a>
							</label>
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}" type="radio" value="2"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" id="${entity.questionId}_checkId2"/> 
								<a onclick="clickRadioForA('${entity.questionId}_checkId2');"><span
								class="sp_ma">2分</span></a>
							</label>
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}" type="radio" value="3"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" id="${entity.questionId}_checkId3" />
								<a onclick="clickRadioForA('${entity.questionId}_checkId3');"><span
								class="sp_ma">3分</span></a>
							</label>
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}" id="${entity.questionId}_checkId4" type="radio" value="4"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" />
								<a onclick="clickRadioForA('${entity.questionId}_checkId4');"> <span
								class="sp_ma">4分</span></a>
							</label>
							<label class="f1"> <input class="user_in03 f1"
								name="${entity.questionId}_${entity.types}"  id="${entity.questionId}_checkId5" type="radio" value="5"
								onclick="setRadio('${entity.questionId }_${entity.types }',this)" /> 
								<a onclick="clickRadioForA('${entity.questionId}_checkId5');"> <span class="sp_ma">5分</span></a>
							</label>
							<c:if test="${entity.mustFlag==1 }">
								<div class="c1">
									<a class="hide_p_l" id="mustFlag_${entity.questionId}"
										style="display: none">这道题必须回答哦。</a>
								</div>
							</c:if>
							<c:if test="${entity.mustFlag ==1}">
								<span style="color: red">*</span>
							</c:if>
					</div>
				</c:if>
				<c:if test="${entity.types=='T1' }">
						<c:if test="${ empty entity.typeSetting || entity.typeSetting=='ST8'}">
					<div >
						<c:forEach items="${entity.questionDataMap }" var="childEntity" varStatus="st">
							<label > <input class="user_in02 f1"
								onclick="setRadio('${entity.questionId}_checkId${st.index+1}',this)"
								name="${entity.questionId }_${entity.types }" type="radio"
								value="${childEntity.key }" id="${entity.questionId}_checkId${st.index+1}" >
								<a onclick="clickRadioForA('${entity.questionId}_checkId${st.index+1}');"> <span
								class="user_span02 f1">${childEntity.value }</span></a>
							</label>
						</c:forEach>
					</div>
						<c:if test="${entity.mustFlag ==1}">
							<span style="color: red;">*</span>
						</c:if>
						<c:if test="${entity.mustFlag==1 }">
							<div class="c1">
								<a class="hide_p_l" id="mustFlag_${entity.questionId}"
									style="display: none">这道题必须回答哦。</a>
							</div>
						</c:if>
					</c:if>
					
						<c:if test="${ entity.typeSetting=='ST9'}">
						<c:if test="${entity.mustFlag ==1}">
									<span style="color: red;vertical-align: middle;" >*</span>
								</c:if>
						<div >
							<table class="table-bordered" style="width: 62%;" >
							<c:forEach items="${entity.questionDataMap }" var="myMap" varStatus="st">
								<tr class="user_tr" >
									<td style="width:10%;text-align:left;"><label class="f1"><input class="user_in02 f1"
											onclick="setRadio('${entity.questionId }_checkId${st.index+1}',this)"
											name="${entity.questionId }_${entity.types }" type="radio"
											value="${myMap.key }" id="${entity.questionId}_${entity.types }"> 
										</label></td>
									<td><label class="f1"> 
										<a onclick="clickRadioForA('${entity.questionId}_checkId${st.index+1}');">
										<span class="sp_ma"><c:out value="${myMap.value}" /></span>
										</a>
									</label>
									</td>
								</tr>
							</c:forEach>
							</table>
								<c:if test="${entity.mustFlag==1 }">
									<div class="c1">
										<a class="hide_p_l" id="mustFlag_${entity.questionId}"
											style="display: none">这道题必须回答哦。</a>
									</div>
								</c:if>
							</div>
						</c:if>
					</div>
					</c:if>
					<c:if test="${entity.types=='T2' }">
						<table class="table-bordered" style="width: 62%;">
							<c:if test="${ empty entity.typeSetting || entity.typeSetting=='ST8'}">
							<c:if test="${entity.mustFlag ==1}">
								<span style="color: red;vertical-align: middle;" >*</span>
							</c:if>
								 <c:forEach items="${entity.questionDataMap }" var="childEntity" varStatus="stt">
									<label> <input class="user_in02 f1" id="${entity.questionId}_checkId${stt.index}"
										onclick="setCheckbox('${entity.questionId }_${entity.types }',this)"
										name="${entity.questionId }_${entity.types }" type="checkbox"
										value="${childEntity.key }">
										<a onclick="clickRadioForA('${entity.questionId}_checkId${stt.index}');">
										 <span class="user_span02 f1">${childEntity.value }</span>
										</a>
									</label>
								</c:forEach>
							</c:if>
							<c:if test="${ entity.typeSetting=='ST9'}">
							<c:if test="${entity.mustFlag ==1}">
								<span style="color: red;vertical-align: middle;" >*</span>
							</c:if>
								<c:forEach items="${entity.questionDataMap }" var="myMap" varStatus="myMapCount">
									<tr class="user_tr" >
											<td style="width:10%;text-align:left;"><label class="f1"> <input class="user_in03 f1"
													name="${entity.questionId }_${entity.types }" type="checkbox"
													value='${myMap.key}'    id="${entity.questionId}_checkId${myMapCount.index}"
													onclick="setCheckbox('${entity.questionId }_${entity.types }',this)">
												</label></td>
											<td><label class="f1"> 
												<a onclick="clickRadioForA('${entity.questionId}_checkId${myMapCount.index}');">
													<span class="sp_ma"><c:out value="${myMap.value}" /></span>
												</a>
											</label></td>
									</tr>
								</c:forEach>
							</c:if>
							</table>
						<c:if test="${entity.mustFlag==1 }">
							<div class="c1">
								<a class="hide_p_l" id="mustFlag_${entity.questionId}"
									style="display: none">这道题必须回答哦。</a>
							</div>
						</c:if>
					</div>
					</c:if>
						<c:if test="${entity.types=='T3' }">
							<select class="user_in01" name="${entity.questionId }_${entity.types }"
								placeholder="请选择"  id="${entity.questionId}_checkId"
								onchange="setSelect('${entity.questionId}_checkId',this);">
								<c:forEach items="${entity.questionDataMap }" var="childEntity">
									<option value="${childEntity.key }">${childEntity.value }</option>
								</c:forEach>
							</select>
							<c:if test="${entity.mustFlag ==1}">
								<span style="color: red">*</span>
							</c:if>
							<c:if test="${entity.mustFlag==1 }">
								<div class="c1">
									<a class="hide_p_l" id="mustFlag_${entity.questionId}"
										style="display: none">这道题必须回答哦。</a>
								</div>
							</c:if>
					</div>
					</c:if>
					<c:if test="${entity.types=='T5' }">
						<input class="user_in01" id="${entity.questionId }_${entity.types }"
							name="${entity.questionId }_${entity.types }" type="text"
							onchange="addCookieForValue(this);">
						<c:if test="${entity.mustFlag ==1}">
							<span style="color: red">*</span>
						</c:if>
						<c:if test="${entity.mustFlag==1 }">
							<div class="c1">
								<a class="hide_p_l" id="mustFlag_${entity.questionId}"
									style="display: none">这道题必须回答哦。</a>
							</div>
						</c:if>
						</div>
				</c:if>
				<c:if test="${entity.types=='T6' }">
					<textarea class="user_in01" name="${entity.questionId }_${entity.types }"
						id="${entity.questionId }_${entity.types }" type="text"
						onchange="addCookieForValue(this)"></textarea>
					<c:if test="${entity.mustFlag ==1}">
						<span style="color: red">*</span>
					</c:if>
					<c:if test="${entity.mustFlag==1 }">
						<div class="c1">
							<a class="hide_p_l" id="mustFlag_${entity.questionId}"
								style="display: none">这道题必须回答哦。</a>
						</div>
					</c:if>
			</div>
			</c:if>
			<c:if test="${ entity.types=='T7'}">
				<%-- <input class="span10 date-picker" name="${entity.questionId }_title" id="${entity.questionId }_title" 
					onchange="addCookieForValue(this);" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="日期"/> --%>
				<c:if test="${ entity.formatData=='ST6'}">
					<input  class="user_in01" name="${entity.questionId}_${entity.types }" id="${entity.questionId}_${entity.types }" type="text" placeholder="请选择" onclick="jeDate({dateCell:'#${entity.questionId}_${entity.types }',isTime:false,format:'YYYY-MM-DD', choosefun:function(elem, val, date) {addCookieForT7(elem,'${entity.questionId}_${entity.types }');}})" readonly/>
				</c:if>
				<c:if test="${ entity.formatData=='ST7'}">
					<input  class="user_in01" name="${entity.questionId}_${entity.types }" id="${entity.questionId}_${entity.types }" type="text" placeholder="请选择" onclick="jeDate({dateCell:'#${entity.questionId}_${entity.types }',isTime:true,format:'YYYY-MM-DD  hh:mm:ss', choosefun:function(elem, val, date) {addCookieForT7(elem,'${entity.questionId}_${entity.types }');}})" readonly/>
				</c:if>
				<c:if test="${entity.mustFlag ==1}">
					<span style="color: red">*</span>
				</c:if>
				<c:if test="${entity.mustFlag==1 }">
						<div class="c1">
							<a class="hide_p_l" id="mustFlag_${entity.questionId}"
								style="display: none">这道题必须回答哦。</a>
						</div>
				</c:if>
				</div>
			</c:if>
			<c:if test="${ entity.types=='T8'}">
						<!-- 联动题判断 -->
					<td>
						<input name="${entity.questionId }_${entity.types }"
									id="${entity.questionId }_${entity.types }" type="hidden">
						 <div class="cell-left" id="div_list_linkageId_${entity.questionId }" style="display: none;">${entity.linkageName }</div>
		                    <input type="text" style="min-height:0;padding:7px 4px;font-size:14px;" id="list_linkage_${entity.questionId }" name="list_linkage_${entity.questionId }" value="" class="user_in01" readonly id="J_Address" placeholder="请选择${entity.linkageName }">
					</td>
					<c:if test="${entity.mustFlag ==1}">
							<span style="color: red">*</span>
					</c:if>
					<c:if test="${entity.mustFlag==1 }">
						<div class="c1">
							<a class="hide_p_l" id="mustFlag_${entity.questionId}"
								style="display: none">这道题必须回答哦。</a>
						</div>
					</c:if>
					</div>
				</c:if>
				
				<c:if test="${entity.isRemarks==1 }">
				</br>
						<input  class="user_in01" style="width: 100%;"
							name="isRemarks_header_${entity.questionId}"
							id="isRemarks_header_${entity.questionId}"
							onchange="addCookieForValue(this);" type="text"> </input>
				</c:if>
				
			</c:if>
					
			<c:if test="${entity.classification =='L1'}">
				<div class="containerTitle">
					<b class="ti_b1"> <p>${entity.questionCode}.</p>${entity.title } <c:if
							test="${(!empty entity.SUBQUESTIONS) && (entity.SUBQUESTIONS.size()==1 )}">
							<c:if test="${empty entity.SUBQUESTIONS[0].title   }">
								<c:if test="${entity.SUBQUESTIONS[0].mustFlag==1 }">
									<span style="color: red">*</span>
								</c:if>
							</c:if>
						</c:if>
					</b>
				</div>
				<c:forEach items="${entity.SUBQUESTIONS }" var="childEntity" varStatus="st">
					<div id="${childEntity.questionId }frame"   <c:if test="${childEntity.mustFlag==1 }"> class="container" </c:if>  <c:if test="${childEntity.mustFlag!=1 }"> class="containerTitle" </c:if>>
						<a name="${childEntity.questionId }" style="float: left;"></a>
						<c:if test="${childEntity.types=='T10' }">
							<c:if test="${childEntity.cutoffRule=='activeLine' }">
			   					 <c:if test="${empty childEntity.title }">
			   					 	 <div class="lineAcive" style="margin-top: 10px;"  id="${childEntity.questionId }_div_hidden"></div>
			   					 </c:if>
			   					 <c:if test="${!empty childEntity.title }">
			   					 	 <div class="lineOne" style="margin-top: 10px;"  id="${childEntity.questionId }_div_hidden">
			    					    <p class="lineAcive" style="float:left;width:30%;"></p>
			    					    ${childEntity.title }
			    					    <p class="lineAcive" style="float:right;width:30%;"></p>
			    					 </div>
			   					 </c:if>
			 				</c:if>
						 	<c:if test="${childEntity.cutoffRule=='dashed' }">
						 		 <c:if test="${empty childEntity.title }">
						 			 <div class="lineX" style="margin-top: 10px;" id="${childEntity.questionId }_div_hidden"> </div>
			   					  </c:if>
			   					 <c:if test="${!empty childEntity.title }">
			    					 <div class="lineOne" style="margin-top: 10px;"  id="${childEntity.questionId }_div_hidden">
			    					    <p class="lineX" style="float:left;width:30%;"></p>
			    					    ${childEntity.title }
			    					    <p class="lineX" style="float:right;width:30%;"></p>
			    					 </div>
			    				 </c:if>	
						 	</c:if>
						</c:if>
						<c:if test="${childEntity.types=='T15' }">
							<!-- 提示题 -->
							<div>
								${childEntity.title }
							</div>
						</c:if>
						<c:if test="${!empty childEntity.title   and childEntity.types !='T15' and  childEntity.types !='T10'}">
							<div class="ti_p1" style="float: left;" >
								<p>${entity.questionCode}${st.index+1 }.</p>${childEntity.title }
								<c:if test="${childEntity.mustFlag==1 }">
									<span style="color: red">*</span>
								</c:if>
							</div>
						</c:if>
						<table class="table-bordered">
							<tbody>
								<tr class="user_tr">
									<c:if test="${   childEntity.types=='T0'}">
										<%-- <input name="${childEntity.questionId }_${childEntity.types }"
											id="${childEntity.questionId }_${childEntity.types }"type="hidden"
											> --%>
										<td><label class="f1"  > <input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="0"
											onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)"	 id="${childEntity.questionId}_checkId0"/>
												<a onclick="clickRadioForA('${childEntity.questionId}_checkId0');"><span class="sp_ma">不适用</span></a>
										</label></td>
										<td><label class="f1" > <input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="1"
												onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)" id="${childEntity.questionId}_checkId1"/>
											<a  onclick="clickRadioForA('${childEntity.questionId}_checkId1');">	<span class="sp_ma">1分</span></a>
										</label></td>	
										<td><label class="f1" > <input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="2"
											onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)"	 id="${childEntity.questionId}_checkId2"/>
												<a  onclick="clickRadioForA('${childEntity.questionId}_checkId2');"><span class="sp_ma">2分</span></a>
										</label></td>	
										<td><label class="f1"  > <input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="3"
											onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)"	 id="${childEntity.questionId}_checkId3"/>
												<a onclick="clickRadioForA('${childEntity.questionId}_checkId3');"><span class="sp_ma">3分</span></a>
										</label></td>
										<td><label class="f1" > <input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="4"
												onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)" id="${childEntity.questionId}_checkId4"/>
											<a onclick="clickRadioForA('${childEntity.questionId}_checkId4');">		<span class="sp_ma">4分</span></a>
										</label></td>
										<td><label class="f1" ><input
												class="user_in03 f1" name="${childEntity.questionId}_${childEntity.types }"
												type="radio" value="5"
												onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this)"  id="${childEntity.questionId}_checkId5"/>
											<a onclick="clickRadioForA('${childEntity.questionId}_checkId5');">	<span class="sp_ma">5分</span></a>
										</label></td>
									</c:if>
									<c:if test="${ childEntity.types=='T1' }">
										<c:if test="${ empty childEntity.typeSetting || childEntity.typeSetting=='ST8'}">
											<%-- <input name="${childEntity.questionId }_${childEntity.types }"
												id="${childEntity.questionId }_${childEntity.types }"
												type="hidden"> --%>
											<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="stt">
												<td><label class="f1"> <input
														class="user_in03 f1" name="${childEntity.questionId }_${childEntity.types }"
														type="radio" value='${myMap.key}' id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_checkId${stt.index+1}',this)">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
														<span class="sp_ma">${myMap.value}</span>
														</a>
												</label></td>
											</c:forEach>
										</c:if>
									</c:if>
										<!-- 联动题型判断 -->
									<c:if test="${ childEntity.types=='T8'}">
										<input name="${childEntity.questionId }_${childEntity.types }"
														id="${childEntity.questionId }_${childEntity.types }" type="hidden">
										<td style="padding: 2px 4px;">
											 <div class="cell-left" id="div_list_linkageId_${childEntity.questionId }" style="display: none;">${childEntity.linkageName }</div>
							                <div class="cell-right cell-arrow">
							                    <input style="min-height:0;padding:7px 4px;font-size:14px;" type="text" id="list_linkage_${childEntity.questionId }" name="list_linkage_${childEntity.questionId }" value="" class="cell-input" readonly id="J_Address" placeholder="请选择${childEntity.linkageName }">
							                </div>
										</td>
									</c:if>
									<c:if test="${ childEntity.types=='T3'}">
										<%-- <input name="${childEntity.questionId }_${childEntity.types }"
											id="${childEntity.questionId }_${childEntity.types }"
											type="hidden"> --%>
										<td><select name="${childEntity.questionId }_${childEntity.types }" class="user_in01" style="width: 100%;margin-left:-5px;"
											  id="${childEntity.questionId}_checkId"
											onchange="setSelect('${childEntity.questionId}_checkId',this);">
												<c:forEach items="${childEntity.questionDataMap }" var="myMap">
													<option value="${myMap.key}">${myMap.value}</option>
												</c:forEach>
										</select></td>
									</c:if>
									<c:if test="${ childEntity.types=='T4'}">
										<%-- <input name="${childEntity.questionId }_${childEntity.types }"
											id="${childEntity.questionId }_${childEntity.types }"
											type="hidden"> --%>
										<c:if test="${childEntity.scaleType=='ST1'}">
											<td><label > <span class="sp_ma">非常不满意&nbsp;</span>
											</label> </td>
											<c:forEach end="${childEntity.scaleRange }" begin="1"
													var="myMap" varStatus="stt">
													<td><label class="f1"> <input class="user_in03 f1"
														name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap}"   id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');"><span class="sp_ma">${myMap}&nbsp;</span>
														</a>
													</label></td>
												</c:forEach>
												<td> <label > <span class="sp_ma">非常满意</span>
											</label></td>
										</c:if>
										<c:if test="${childEntity.scaleType=='ST2' }">
											<td><label > 
												<span class="sp_ma">非常不认同&nbsp;</span>
												</label>
											</td> 
											<c:forEach end="${childEntity.scaleRange }" begin="1" var="myMap" varStatus="stt">
													<td><label class="f1"> <input class="user_in03 f1"
														name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap}"    id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
															<span class="sp_ma">${myMap}&nbsp;</span>
														</a>
													</label></td>
												</c:forEach> <td><label class="f1"> <span class="sp_ma">非常认同</span>
											</label></td>
										</c:if>
										<c:if test="${childEntity.scaleType=='ST3' }">
											<td><label class="f1"> <span class="sp_ma">非常不重要&nbsp;</span>
											</label></td> <c:forEach end="${childEntity.scaleRange }" begin="1" var="myMap" varStatus="stt">
													<td><label class="f1"> <input class="user_in03 f1"
														name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap}"	 id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
															<span class="sp_ma">${myMap}&nbsp;</span>
															</a>
													</label></td>
												</c:forEach> <td><label class="f1"> <span class="sp_ma">非常重要</span>
											</label></td>
										</c:if>
										<c:if test="${childEntity.scaleType=='ST4' }">
											<td><label class="f1"> <span class="sp_ma">非常不愿意&nbsp;</span>
											</label></td> <c:forEach end="${childEntity.scaleRange }" begin="1"
													var="myMap" varStatus="stt">
												<td>	<label class="f1"> <input class="user_in03 f1"
														name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap}"	 id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
															<span class="sp_ma">${myMap}&nbsp;</span>
														</a>
													</label></td>
												</c:forEach><td> <label class="f1"> <span class="sp_ma">非常愿意</span>
											</label></td>
										</c:if>
										<c:if test="${childEntity.scaleType=='ST5' }">
											<td><label class="f1"> <span class="sp_ma">非常不符合&nbsp;</span>
											</label></td> <c:forEach end="${childEntity.scaleRange }" begin="1"
													var="myMap" varStatus="">
												<td>	<label class="f1"> <input class="user_in03 f1"
														name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap}"	 id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
														<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
															<span class="sp_ma">${myMap}&nbsp;</span>
															</a>
													</label></td>
												</c:forEach> <td><label class="f1"> <span class="sp_ma">非常符合</span>
											</label></td>
										</c:if>
										<c:if test="${childEntity.scaleType=='ST0' }">
											<div data-toggle="modal" data-target="#id_${childEntity.questionId}" onclick="choseNumFor('${childEntity.questionId}','${childEntity.types }');"
												class="user_div02">
												<p class="f1" id="${childEntity.questionId}-id"  
													name="${childEntity.questionId}">请选择</p>
													<input name="${childEntity.questionId }_${childEntity.types }"
											id="${childEntity.questionId }_${childEntity.types }"
											type="hidden">
												<p class="f2">
													<span style="font-weight: normal"
														class="glyphicon glyphicon-chevron-right"></span>
												</p>
												<div class="c1"></div>
											</div>
											<div id="id_${childEntity.questionId}" class="modal fade"
												style="display: none;">
												<!--最底层的半透明遮罩-->
												<div style="width: 80%; margin: 50% auto"
													class="modal-dialog">
													<!--用于设定宽高、定位-->
													<div class="modal-content">
														<!--背景、边框、倒角-->
														<div
															style="border-bottom: 1px solid transparent; margin-bottom: -5%"
															class="modal-header">
															<!--<button data-dismiss="modal" class="close" type="button">&times;</button>-->
															<h4 style="color: #333;" class="modal-title text-center">请选择</h4>
														</div>
														<div class="modal-body">
															<div
																style="width: 50%; border-right: 1px dashed #ccc; padding-left: 10%"
																class="f1">
																<c:forEach end="${childEntity.scaleRange }" begin="2"
																	step="2" var="myMap">
																	<label style="display: block; padding: 5px;"> <input
																		class="user_in03" name="${childEntity.questionId}"
																		type="radio" value="${myMap}"> <span>${myMap}</span>
																	</label>
																</c:forEach>
															</div>
															<div style="width: 50%; padding-left: 10%" class="f1">
																<c:forEach end="${childEntity.scaleRange }" begin="1"
																	step="2" var="myMap">
																	<label style="display: block; padding: 5px;"> <input
																		class="user_in03" name="${childEntity.questionId}"
																		type="radio" value="${myMap }"> <span>${myMap }</span>
																	</label>
																</c:forEach>
															</div>
															<div class="c1"></div>
														</div>
														<div
															style="border-top: 1px solid transparent; text-align: center; margin-top: -10%"
															class="modal-footer">
															<button data-dismiss="modal" class="ensure" type="button">确定</button>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</c:if>
								</tr>
							</tbody>
						</table>
						<c:if test="${ childEntity.types=='T1'}">
							<c:if test="${ childEntity.typeSetting=='ST9'}">
								<table class="table-bordered">
								<%-- <input type="hidden"
										name="${childEntity.questionId }_${childEntity.types }"
										id="${childEntity.questionId }_${childEntity.types }"> --%>
								<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="stt">
									<tr class="user_tr" >
										<td style="width:10%;text-align:left;"><label class="f1">
											 <input class="user_in03 f1" name="${childEntity.questionId }_${childEntity.types }" type="radio"
														value="${myMap.key}"   id="${childEntity.questionId}_checkId${stt.index+1}"
														onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
											</label></td>
										<td><label class="f1"> 
												<a onclick="clickRadioForA('${childEntity.questionId}_checkId${stt.index+1}');">
													<span class="sp_ma"><c:out value="${myMap.value}" /></span>
													</a>
										</label></td>
									</tr>
								</c:forEach>
								</table>
							</c:if>
						</c:if>
						<c:if test="${ childEntity.types=='T2'}">
							<table class="table-bordered">
							<%-- <input type="hidden" name="${childEntity.questionId }_${childEntity.types }" id="${childEntity.questionId }_${childEntity.types }"> --%>
							<c:if test="${ empty childEntity.typeSetting || childEntity.typeSetting=='ST8'}">
								<tr class="user_tr" >
									<%-- <input type="hidden"
										name="${childEntity.questionId }_${childEntity.types }"
										id="${childEntity.questionId }_${childEntity.types }"> --%>
									<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="myMapCount">
										<td style="width:16.66%;text-align:left;"><label class="f1"> 
										<input class="user_in03 f1" name="${childEntity.questionId }_${childEntity.types }" type="checkbox"
												value='${myMap.key}'    id="${childEntity.questionId}_checkId${myMapCount.index}"
												onclick="setCheckbox('${childEntity.questionId}_${childEntity.types }',this)">
											</label></td>
										</c:forEach>
								</tr>
								<tr class="user_tr">
									<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="myMapCount">
										<td><label class="f1"> 
										<a onclick="clickRadioForA('${childEntity.questionId}_checkId${myMapCount.index}');">
												<span class="sp_ma"><c:out value="${myMap.value}" /></span>
											</a>	
											</label></td>
										</c:forEach>
								</tr>
							</c:if>
							<c:if test="${ childEntity.typeSetting=='ST9'}">
								<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="myMapCount">
									<tr class="user_tr" >
											<td style="width:10%;text-align:left;"><label class="f1"> <input class="user_in03 f1"
													name="${childEntity.questionId }_${childEntity.types }" type="checkbox"
													value='${myMap.key}'    id="${childEntity.questionId}_checkId${myMapCount.index}"
													onclick="setCheckbox('${childEntity.questionId}_${childEntity.types }',this)">
												</label></td>
											<td><label class="f1"> 
												<a onclick="clickRadioForA('${childEntity.questionId}_checkId${myMapCount.index}');">
												<span class="sp_ma"><c:out value="${myMap.value}" /></span>
												</a>	
											</label></td>
									</tr>
								</c:forEach>
							</c:if>
							</table>
						</c:if>
						
						<c:if test="${ childEntity.types=='T6'}">
							<textarea name="${childEntity.questionId}_${childEntity.types }"
								id="${childEntity.questionId}_${childEntity.types }"
								onchange="addCookieForValue(this);" rows="6" cols="30"
								class="user_text01"></textarea>
						</c:if>
						<c:if test="${ childEntity.types=='T5'}">
							<input class="user_in01" style="width: 100%;"
								name="${childEntity.questionId}_${childEntity.types }"
								id="${childEntity.questionId}_${childEntity.types }"
								onchange="addCookieForValue(this);" type="text">
						</c:if>
						
						<c:if test="${ childEntity.types=='T7'}">
							<%-- <input class="span10 date-picker" name="${entity.questionId }_title" id="${entity.questionId }_title" 
								onchange="addCookieForValue(this);" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="日期"/> --%>
							<c:if test="${ childEntity.formatData=='ST6'}">
								<input  class="user_in01" name="${childEntity.questionId}_${childEntity.types }" id="${childEntity.questionId}_${childEntity.types }" type="text" placeholder="请选择" onclick="jeDate({dateCell:'#${childEntity.questionId}_${childEntity.types }',isTime:true,format:'YYYY-MM-DD', choosefun:function(elem, val, date) {addCookieForT7(elem,'${childEntity.questionId}_${childEntity.types }');}})" readonly/>
							
							</c:if>	
							<c:if test="${ childEntity.formatData=='ST7'}">
								<input  class="user_in01" name="${childEntity.questionId}_${childEntity.types }" id="${childEntity.questionId}_${childEntity.types }" type="text" placeholder="请选择" onclick="jeDate({dateCell:'#${childEntity.questionId}_${childEntity.types }',isTime:true,format:'YYYY-MM-DD hh:mm:ss', choosefun:function(elem, val, date){addCookieForT7(elem,'${childEntity.questionId}_${childEntity.types }');}})" readonly/>
							</c:if>	
						</c:if>
						<c:if test="${childEntity.mustFlag==1 }">
							<div class="c1">
								<a class="hide_p" id="mustFlag_${childEntity.questionId}"
									style="display: none">这道题必须回答哦。</a>
							</div>
						</c:if>
						<c:if test="${childEntity.isRemarks==1 }">
							<div class="c1">
								<input class="user_in01" style="width: 100%;"
									name="isRemarks_body_${childEntity.questionId}"
									id="isRemarks_body_${childEntity.questionId}"
									onchange="addCookieForValue(this);" type="text">
							</div> 
						</c:if>
						<c:if test="${childEntity.types=='T14' }">
							<!-- 图片福选题   题型             判断            开始 -->
							<table class="table-bordered">
								<tr class="user_tr" >
									<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="stt">
											<td style="width:10%;text-align:left;"><label class="f1">
												<!-- 图片div -->
												<div>
													<c:forEach items="${fileData }" var="fileId">
														<c:if test="${ fileId.key== myMap.img }">
															<div 
																style="background-repeat: no-repeat;background-image:url('<%=basePath%>${fileId.value }');"></div>
																<img alt="" src="<%=basePath%>${fileId.value }" style="width: 100px;height: 100px;">
														</c:if>
													</c:forEach>
													
												</div>
												<!-- 复选框  div -->
												<div>
													<%--  <input class="user_in03 f1" name="${childEntity.questionId }_${childEntity.types }" type="radio"
															value="${myMap.key}"   id="${childEntity.questionId}_checkId${stt.index+1}"
															onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);"> --%>
													 <input class="user_in02 f1" id="${childEntity.questionId}_checkId${stt.index}"
														onclick="setCheckbox('${childEntity.questionId }_${childEntity.types }',this)"
														name="${childEntity.questionId }_${childEntity.types }" type="checkbox"
														value="${myMap.key }">
												</div>
												</label>
											</td>
										
									</c:forEach>
								</tr>
							</table>
							<!-- 图片福选题   题型             判断            结束 -->
						</c:if>
						<c:if test="${childEntity.types=='T13' }">
							<!-- 图片福选题   题型             判断            开始 -->
							<table class="table-bordered">
								<tr class="user_tr" >
									<c:forEach items="${childEntity.questionDataMap }" var="myMap" varStatus="stt">
											<td style="width:10%;text-align:left;"><label class="f1">
												<!-- 图片div -->
												<div>
													<c:forEach items="${fileData }" var="fileId">
														<c:if test="${ fileId.key== myMap.img }">
															<div 
																style="background-repeat: no-repeat;background-image:url('<%=basePath%>${fileId.value }');"></div>
																<img alt="" src="<%=basePath%>${fileId.value }" style="width: 100px;height: 100px;">
														</c:if>
													</c:forEach>
													
												</div>
												<!-- 复选框  div -->
												<div>
													 <input class="user_in03 f1" name="${childEntity.questionId }_${childEntity.types }" type="radio"
															value="${myMap.key}"   id="${childEntity.questionId}_checkId${stt.index+1}"
															onclick="setRadio('${childEntity.questionId}_${childEntity.types }',this);">
													<%--  <input class="user_in02 f1" id="${childEntity.questionId}_checkId${stt.index}"
														onclick="setCheckbox('${childEntity.questionId }_${childEntity.types }',this)"
														name="${childEntity.questionId }_${childEntity.types }" type="checkbox"
														value="${myMap.key }"> --%>
												</div>
												</label>
											</td>
										
									</c:forEach>
								</tr>
							</table>
							<!-- 图片福选题   题型             判断            结束 -->
						</c:if>
					</div>
				</c:forEach>
			</c:if>
		</c:forEach>
	</div>
	</form>
	<c:if test="${!empty varList }">
		<a href="javascript:void(0)" onclick="saveDataForList()" class="sub_a">提交答卷</a>
	</c:if>
	<c:if test="${empty varList }">
		<button class="btn btn_lose" id="close" onclick="save()">确定</button>  
	</c:if>
	<a id="maodian" class="hide_p"
		href="#"
		style="display: none"><span id="click">转到锚点</span></a>
	</div>
	</div>
	<div class="border_corner"></div>
	</div>
	</div>
		</div>
	<div class="g_footer has_background">
		<div class="g_content">
			<p>
			<span>泰康之家
					版权所有 京ICP备15000213号</span><br>
				Copyright Taikang Community. <br>All Rights Reserved 
			</p>
		</div>
	</div>
	<c:if test="${data.backMusicSwith }">
		<audio loop src="${data.backMusic }" id="media" autoplay="autoplay" preload=""></audio>
	</c:if>
	
	</div>
	<div id="mask">
			<div id="loading" class="loading">提交中请稍后...</div> 
	</div>
	<!-- <script src="../static/js/jquery-1.7.2.js"></script> -->
	<script src="../static/question/js/jquery.min.js"></script>
	<script src="../static/question/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../static/js/jquery.cookie.js"></script>
	<script src="../static/question/js/queryPage.js"></script>
	
	<!-- 联动下拉框引用            开始 -->
	
	<script src="../static/question/js/citys.js"></script>
	<script src="../static/question/js/ydui.flexible.js"></script>
	<script src="../static/question/js/ydui.js"></script>
	<link href="../static/question/css/demo.css" rel="stylesheet"/>
	<link href="../static/question/css/ydui.css" rel="stylesheet"/>
	<!-- 联动下拉框引用            结束 -->
</body>
<script type="text/javascript">

//--创建页面监听，等待微信端页面加载完毕 触发音频播放
 /* var backMusicSwith="${data.backMusicSwith }";
	if(backMusicSwith==true){  */
		
		document.addEventListener('DOMContentLoaded', function () {
			   function audioAutoPlay() {
			    	try{
			    		 var audio = document.getElementById('media');
			             audio.play();
				         document.addEventListener("WeixinJSBridgeReady", function () {
				             audio.play();
				         }, false);
			    	}catch(err){
			    		console.log(err);
			    	}
			    }
			    audioAutoPlay(); 
			});   	
	/* }  */

/* 联动 */

$(document).ready(function(){
			//alert("1111");
			 /* 初始化页面联动题                            -----------------开始----------------- */
			  $('[id^=list_linkage_]') .each(function(index, elementObj) {
				 var id = $(elementObj).attr("id");
				 var questionsIdForRealId='';//真正的id
				 var questionsId = id.split('list_linkage_')[1];//
				 if(id.indexOf("_title")>-1){
					 questionsIdForRealId= id.split('list_linkage_')[1].split('_title')[0];
				 }else{
					 questionsIdForRealId=questionsId;
				 }
				 $.ajax({
						type: 'post',
						url : '../qResult/findLinkageByParentIdForLinkage.do',
						data: {questionId:questionsIdForRealId},
						//dataType:'json',
						cache: false,
						success: function(data){
							var citys = eval(data);	
							//alert(data)
							if (typeof define === "function") {
								define(citys);
							} else {
								window.YDUI_CITYS = citys;
							}
							 var $target = $('#'+id);
								//var $targetH = $('#'+id);
								//alert("div_list_linkageId_"+questionsId);
							$target.citySelect({
								types:2,
								div_list_linkageId_id:"div_list_linkageId_"+questionsId
							});
							$target.on('click', function (event) {
								event.stopPropagation();
								$target.citySelect('open');
							});
							$target.on('done.ydui.cityselect', function (ret) {
								var returnStr = ret.provance+" ";
								if(ret.city !='' && ret.city !='全部'){
									returnStr+=ret.city + ' '
								}
								if(ret.area !='' && ret.area !='全部'){
									returnStr+=ret.area + ' '
								}
								if(ret.levelfour !='' && ret.levelfour !='全部'){
									returnStr+=ret.levelfour + ' '
								}
								$("#"+questionsId+"_T8").val(returnStr);
								setCookie(questionsId+"_T8",returnStr);
								//setCookie(id,returnStr);
								if(ret.levelfour !='' && ret.levelfour !='全部'){
									$(this).val(ret.levelfour);
									setCookie("list_linkage_"+questionsId,ret.levelfour);
									return;
								}
								if(ret.area !='' && ret.area !='全部'){
									$(this).val(ret.area);
									setCookie("list_linkage_"+questionsId,ret.area);
									return;
								}
								if(ret.city !='' && ret.city !='全部'){
									$(this).val(ret.city);
									setCookie("list_linkage_"+questionsId,ret.city);
									return;
								}
								if(ret.provance !='' && ret.provance !='全部'){
									$(this).val(ret.provance);
									setCookie("list_linkage_"+questionsId,ret.provance);
									return;
								}
							});
						}
					});
				
			 }); 
			 /* 初始化页面联动题                            -----------------结束----------------- */
			  addValueForCookie();
			  checkedCookie();
		});
function save(){
	try{
		WeixinJSBridge.call('closeWindow');
	}catch(err){
		//alert("出错了！");
		window.close();
		
	}
}
//是否允许重复答题提交
function checkedCookie(){
	var cookieVlaueForCheck="${cookieVlaueForCheck}";
	var cookieVlaue=$.cookie(""+cookieVlaueForCheck+""); 
	if(typeof(cookieVlaue) !=  'undefined' && cookieVlaue!='' && cookieVlaueForCheck!=''){
		//alert($("#batchId").val());
		$("#batchId").val('');
		//alert($("#batchId").val());
		window.location.href="../qResult/skipExitToJsp";
	}
}
</script>
</html>
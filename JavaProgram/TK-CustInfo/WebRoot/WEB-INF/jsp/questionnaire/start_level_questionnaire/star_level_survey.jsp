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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/question/css/font-awesome.css"/>
    <link rel="stylesheet" href="../static/question/css/expressEva.css"/>	
	<link rel="stylesheet" href="../static/question/css/common.css" />
	<link rel="stylesheet" href="../static/question/css/app.css" />
	<link rel="stylesheet" href="../static/question/css/range.css" />
	<script src="../static/question/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../static/question/js/jquery.range.js" type="text/javascript" charset="utf-8"></script>
	    
    <style type="text/css">
	#ex1Slider .slider-selection {
		background: #BABABA;
	}
</style>
    <title>问卷</title>
</head>

<body >
<form method="post" action="#" name="questionForm" id="questionForm">
	<input type="hidden" name="code" id="code" value="${visitCode }"/>
	<input  type="hidden" name="hosipitalCode" id="hosipitalCode" value="${hospitalCode }"/>
	<input name="batchId" type="hidden" value="${batch }" />
	<input name="questionnaireId" type="hidden" value="${questionnaireId }" />
	<input name="level" type="hidden" value="${pd.level }" /> 
    <div >
        <div class="ex_top">
            <img src="<%=basePath%>${questionnaireData.logoImgPath}" alt="">
        </div>
       <c:forEach items="${ varList}" var="entity" varStatus="stt">
       		<c:if test="${entity.types=='T10' and stt.index == 0}">
       			<c:if test="${entity.cutoffRule=='activeLine' }">
   					 <c:if test="${empty entity.title }">
   					 	 <div class="lineAcive" style="margin-bottom:45px;" id="${entity.questionId }_div_hidden"></div>
   					 </c:if>
   					 <c:if test="${!empty entity.title }">
   					 	 <div class="lineOne" style="margin-bottom:90px;" id="${entity.questionId }_div_hidden">
    					    <p class="lineAcive" style="float:left;width:30%;"></p>
    					    ${entity.title }
    					    <p class="lineAcive" style="float:right;width:30%;"></p>
    					 </div>
   					 </c:if>
 				</c:if>
			 	<c:if test="${entity.cutoffRule=='dashed' }">
			 		 <c:if test="${empty entity.title }">
			 			 <div class="lineX" id="${entity.questionId }_div_hidden"> </div>
   					  </c:if>
   					 <c:if test="${!empty entity.title }">
    					 <div class="lineOne" style="margin-bottom:90px;" id="${entity.questionId }_div_hidden">
    					    <p class="lineX" style="float:left;width:30%;"></p>
    					    ${entity.title }
    					    <p class="lineX" style="float:right;width:30%;"></p>
    					 </div>
    				 </c:if>	
			 	</c:if>
       		</c:if>
       </c:forEach>
        
        <div class="contentAll">
       		<c:forEach items="${ varList}" var="entity" varStatus="stt">
       			<c:if test="${entity.classification=='L0' }">
       				<c:if test="${entity.types=='T12' }">
      				<!-- 医生问诊信息  -->
      					<c:if test="${entity.inquiryInformation=='ArrLeft'}">
      						<div class="doctorInfor" id="${entity.questionId }_div_hidden">
	      						<span class="titleC" style="width:100%;">
									<b class="titleLine" style="float: left;"></b>
									${entity.title }
								</span>
								<div class="contentWrap">
									<div class="doctorInforContent clc">
										<span class="doctorImg" >
											<img src="../static/img/doctorImg.jpg" alt="" />
										</span>
										<div class="doctorRightInfor">
											 <c:forEach var="map" items="${mapInfo}">
									            <p>${map.key}:${map.value}</p>
									        </c:forEach>
										</div>
									</div>
								</div>
							</div>
      					</c:if>
      					<c:if test="${entity.inquiryInformation=='ArrTop'}">
      					<div id="${entity.questionId }_div_hidden">
      						 <div class="doctor_logo">
			                    <span class="ex_name">${pds.empName}<br>(<c:if test="${pds.doctorType == null or pds.doctorType ==''}">医师</c:if>${pds.doctorType})</span>
			                </div>
			                <div class="doctor_profile">
			                    <div class="doctor_text">
			                        <c:forEach var="map" items="${mapInfo}">
							            <p>${map.key}:${map.value}</p>
							        </c:forEach>
			                    </div>
			                </div>
      					</div>
      					</c:if>
      				</c:if>
      				<c:if test="${entity.types=='T10' and stt.index != 0}">
      					<c:if test="${entity.cutoffRule=='activeLine' }">
	       					 <c:if test="${empty entity.title }">
	       					 	 <div class="lineAcive" style="margin-bottom:45px;" id="${entity.questionId }_div_hidden"></div>
	       					 </c:if>
	       					 <c:if test="${!empty entity.title }">
	       					 	 <div class="lineOne" style="margin-bottom:45px;" id="${entity.questionId }_div_hidden">
		       					    <p class="lineAcive" style="float:left;width:30%;"></p>
		       					    ${entity.title }
		       					    <p class="lineAcive" style="float:right;width:30%;"></p>
		       					 </div>
	       					 </c:if>
      					</c:if>
   					 	<c:if test="${entity.cutoffRule=='dashed' }">
   					 		 <c:if test="${empty entity.title }">
   					 			 <div class="lineX" id="${entity.questionId }_div_hidden"> </div>
	       					  </c:if>
	       					 <c:if test="${!empty entity.title }">
		       					 <div class="lineOne" id="${entity.questionId }_div_hidden">
		       					    <p class="lineX" style="float:left;width:30%;"></p>
		       					    ${entity.title }
		       					    <p class="lineX" style="float:right;width:30%;"></p>
		       					 </div>
		       				 </c:if>	
   					 	</c:if>
       				</c:if>
       				<c:if test="${entity.types=='T11' }">
       					<!-- 意向 -->
  					 	<div class="doctorCommend clc" style="width: 100%;overflow: hidden;" id="${entity.questionId }_div_hidden">
							<span class="titleC" style="width: 100%;">
								<b class="titleLine fl" ></b>
								${entity.title }
							</span>
							<div>
							    <p class="satisfy"><span>非常不满意</span><span>非常满意</span></p>
								<p class="range" style="margin-top:10px;">
									<input type="hidden" id="range_${entity.questionId }_${entity.types}_${entity.scaleRange}" name="${entity.questionId }_${entity.types}" class="range-slider" value="${entity.scaleRange}"/>  
								</p>
							</div>
						</div>
       				</c:if>
      				<c:if test="${entity.types=='T9' }">
      				<!-- 星级评定题型  -->
	      				<div class="docotorEvaluate" id="${entity.questionId }_div_hidden">
	      					<span class="titleC" style="width: 100%;">
								<b class="titleLine"  style="float: left;"></b>
								${entity.title }
							</span>
							<div class="contentWrap">
								<div class="evaluateContent clc" style="margin-left:12px;">
									<div class="serviceAttitude">
										<p class="two fl" >
											<input type="hidden" name="${entity.questionId }_${entity.types}" id="${entity.questionId }_${entity.types}">
										  	<i class="fa fa-star-o" onclick="clickStarFor(this);" id="${entity.questionId }_${entity.types}_1"  style="width:42px;" data-star="1"></i>
							                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${entity.questionId }_${entity.types}_2" style="width: 42px;" data-star="2"></i>
							                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${entity.questionId }_${entity.types}_3" style="width: 42px;" data-star="3"></i>
							                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${entity.questionId }_${entity.types}_4" style="width: 42px;" data-star="4"></i>
							                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${entity.questionId }_${entity.types}_5" style="width: 42px;" data-star="5"></i>
										</p>
										<p class="evaluate fl" id="${entity.questionId }_${entity.types}_evaluate">【服务评价】</p>
									</div>
								</div>
							</div>	
						</div>	      				
      				</c:if>
      				<c:if test="${entity.types=='T6'}">
      					<div class="ex_text" id="${entity.questionId }_div_hidden">
							<span class="titleC" style="width:100%;">
								<b class="titleLine fl" ></b>
								${entity.title }
							</span>
							<div class="contentWrap">
								<textarea rows="5"  name="${entity.questionId}_${entity.types }"  placeholder="" style="background-color:white;"></textarea>
							</div>
						</div>
      				</c:if>
      				<c:if test="${entity.types=='T1'}">
      					<c:if test="${empty entity.isShow}">
	      					<div class="ex_text" id="${entity.questionId }_div_hidden">
								<span class="titleC" style="width:100%;">
									<b class="titleLine fl" ></b>
									${entity.title }
								</span>
	      						<div class="contentWrap user_tr" style="display:flex;">
      								<c:forEach items="${entity.questionDataMap }" var="childEntity" varStatus="st">
      								  <p style="flex:1;border:solid 1px #ccc;padding:5px 5px;" >
										<label > <input 
											name="${entity.questionId }_${entity.types }" type="radio"
											value="${childEntity.key }" id="${entity.questionId}_checkId${st.index+1}" >
											<a onclick="clickRadioForA('${entity.questionId}_checkId${st.index+1}');" style="color:black;"> <span
											class="user_span02 f1">${childEntity.value }</span></a>
										</label>
									</p>
									</c:forEach>
	      						</div>
	      					</div>
      					</c:if>
      					<c:if test="${!empty entity.isShow}">
      						<div class="ex_text" id="${entity.questionId }_div_hidden">
								<span class="titleC" style="width:100%;">
									<b class="titleLine fl" ></b>
									${entity.title }
								</span>
	      						<div class="contentWrap user_tr"  style="display:flex;">
	      							<input id="hidden_all_by_${entity.questionId }_input" value='${entity.questionList }' type="hidden">
	      							<c:forEach items="${entity.questionDataMap }" var="childEntity" varStatus="st">
	      							 <p style="flex:1;border:solid 1px #ccc;padding:5px 5px;" >
										<label > <input 
											onclick='hiddenSomeQuestions(this)'
											name="${entity.questionId }_${entity.types }" type="radio" 
											value="${childEntity.key }" id="${entity.questionId}_checkId${st.index+1}" >
											<a onclick="clickRadioForA('${entity.questionId}_checkId${st.index+1}');" style="color:black;"> <span
											class="" style="color: black;">${childEntity.value }</span></a>
										</label>
										</p>
									</c:forEach>
	      						</div>
      						</div>
      					</c:if>
      				</c:if>
       			</c:if>
      			<c:if test="${entity.classification =='L1' }">
      				<div class="docotorEvaluate" id="${entity.questionId }_div_hidden">
      					<span class="titleC" style="width: 100%;">
							<b class="titleLine"  style="float: left;"></b>
							${entity.title }
						</span>
		      			<c:forEach items="${entity.SUBQUESTIONS }" var="childEntity" varStatus="st">
		      				<c:if test="${childEntity.types=='T9'}">
		      					<!-- 星级评定题型  -->
								<c:if test="${childEntity.typeSetting=='ST8' }">
									<div class="contentWrap" id="${childEntity.questionId }_div_hidden">
			      						<div class="evaluateContent clc <c:if test="${st.index==0 }">evaluateContentTop</c:if>">
											<div class="technicalLevel">
												<span class="fl" style="">${childEntity.title }</span>
												<p class="two fl" style="margin-left:14px">
													<input type="hidden" value="0" name="${childEntity.questionId }_${childEntity.types}" id="${childEntity.questionId }_${childEntity.types}">
												  	<i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_1"  style="width: 25px;" data-star="1"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_2" style="width: 25px;" data-star="2"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_3" style="width: 25px;" data-star="3"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_4" style="width: 25px;" data-star="4"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_5" style="width: 25px;" data-star="5"></i>
												</p>
												<p class="evaluate" id="${childEntity.questionId }_${childEntity.types}_evaluate">【服务评价】</p>
											</div>
										</div>
									</div>
		      					</c:if>
								<c:if test="${childEntity.typeSetting=='ST9' }">
									<div class="evaluateContent clc <c:if test="${st.index==0 }">evaluateContentTop</c:if>" id="${childEntity.questionId }_div_hidden">
										<div class="contentWrap" style="height:auto">
										<table>
											<tr style="width: 100%;">
												<td style="width: 100%;padding:10px 0" >
													<p class="one fl" >${childEntity.title }</p>
												</td>
											</tr>
											<tr style="width: 100%;"> 
												<td style="width: 100%;">
													<p class="two fl" >
													<input type="hidden" value="0" name="${childEntity.questionId }_${childEntity.types}" id="${childEntity.questionId }_${childEntity.types}">
												  	<i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_1"  style="width: 42px;" data-star="1"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_2" style="width:42px;" data-star="2"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_3" style="width: 42px;" data-star="3"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_4" style="width: 42px;" data-star="4"></i>
									                <i class="fa fa-star-o" onclick="clickStarFor(this);" id="${childEntity.questionId }_${childEntity.types}_5" style="width: 42px;" data-star="5"></i>
													</p>
													<p class="evaluate fl" id="${childEntity.questionId }_${childEntity.types}_evaluate">【服务评价】</p>
												</td>
											</tr>
										</table>
										</div>
									</div>
								</c:if>
		      				</c:if>
		      				<c:if test="${childEntity.types=='T12' }">
		      					<!-- 医生问诊信息  -->
		      					<c:if test="${childEntity.inquiryInformation=='ArrLeft'}">
		      						<div class="doctorInfor" id="${childEntity.questionId }_div_hidden">
			      						<span class="titleC" style="margin-left: 5px;width:100%;">
											<b class="titleLine" style="float: left;"></b>
											${childEntity.title }
										</span>
										<div class="doctorInforContent clc">
											<span class="doctorImg" >
												<img src="../static/img/doctorImg.jpg" alt="" />
											</span>
											<div class="doctorRightInfor">
												 <c:forEach var="map" items="${mapInfo}">
										            <p>${map.key}:${map.value}</p>
										        </c:forEach>
											</div>
										</div>
									</div>
		      					</c:if>
		      					<c:if test="${childEntity.inquiryInformation=='ArrTop'}">
		      					<div id="${childEntity.questionId }_div_hidden">
		      						<div class="doctor_logo" >
					                    <span class="ex_name" >${pds.EMP_NAME}<br>(<c:if test="${pds.DOCTORTYPE == null or pds.DOCTORTYPE ==''}">医师</c:if>${pds.DOCTORTYPE})</span>
					                </div>
					                <div class="doctor_profile">
					                    <div class="doctor_text">
					                        <c:forEach var="map" items="${mapInfo}">
									            <p>${map.key}:${map.value}</p>
									        </c:forEach>
					                    </div>
					                </div>
		      					</div>
		      					</c:if>
		      				</c:if>
		      				<c:if test="${childEntity.types=='T10' }">
			      				<c:if test="${childEntity.cutoffRule=='activeLine' }">
			      					<c:if test="${empty childEntity.title }">
			      						 <div class="lineAcive" style="margin-bottom:45px;" id="${childEntity.questionId }_div_hidden">
				       					 </div>
				       				</c:if>
				       				<c:if test="${!empty childEntity.title }">
				       					 <div class="lineOne" style="margin-bottom:45px;" id="${childEntity.questionId }_div_hidden">
				       					    <p class="lineAcive" style="float:left;width:30%"></p>
				       					    ${childEntity.title }
				       					    <p class="lineAcive" style="float:right;width:30%"></p>
				       					 </div>
				       				</c:if>
			      				</c:if>
		   					 	<c:if test="${childEntity.cutoffRule=='dashed' }">
			   					 	<c:if test="${empty childEntity.title }">
		   					 			 <div class="lineX" style="margin-bottom:45px;" id="${childEntity.questionId }_div_hidden"> </div>
			       					</c:if>
			       					<c:if test="${!empty childEntity.title }">
				       					 <div class="lineOne" style="margin-bottom:45px;" id="${childEntity.questionId }_div_hidden">
				       					    <p class="lineX" style="float:left;width:30%"></p>
				       					    ${childEntity.title }
				       					    <p class="lineX" style="float:right;width:30%"></p>
				       					 </div>
			       					 </c:if>
		       					</c:if>
		       				</c:if>
		       				<c:if test="${childEntity.types=='T11' }">
		       					<!-- 意向 -->
		  					 	<div class="doctorCommend clc" id="${childEntity.questionId }_div_hidden">
									<span class="one fl spanStyle"  >
										${childEntity.title }
									</span>
									<div>
							   			<p class="satisfy"><span>非常不满意</span><span>非常满意</span></p>
										<p class="range" style="margin-top:45px;">
											<input type="hidden" id="range_${childEntity.questionId }_${childEntity.types}_${childEntity.scaleRange}" name="${childEntity.questionId }_${childEntity.types}" class="range-slider" value="${childEntity.scaleRange}"/>  
										</p>
									</div>
								</div>
		       				</c:if>
		       				
		      				<c:if test="${childEntity.types=='T6'}">
		      					<div class="ex_text" id="${childEntity.questionId }_div_hidden">
									<span  style="width:100%;"  class="spanStyle">
										${childEntity.title }
									</span>
									<div class="contentWrap">
										<textarea rows="5" cols="40"  name="${childEntity.questionId}_${childEntity.types }"  placeholder="" style="background-color:white;"></textarea>
									</div>
								</div>
		      				</c:if>
		      				<c:if test="${childEntity.types=='T1'}">
      					<c:if test="${empty childEntity.isShow}">
	      					<div class="ex_text" id="${childEntity.questionId }_div_hidden">
								<span class="titleC" style="width:100%;">
									<b class="titleLine fl" ></b>
									${childEntity.title }
								</span>
	      						<div class="contentWrap" style="display:flex;">
      								<c:forEach items="${childEntity.questionDataMap }" var="childEntity1" varStatus="st">
      								<p style="flex:1;border:solid 1px #ccc;padding:5px 5px;">
										<label > <input
											name="${childEntity.questionId }_${childEntity.types }" type="radio"
											value="${childEntity1.key }" id="${childEntity.questionId}_checkId${st.index+1}" >
											<a onclick="clickRadioForA('${childEntity.questionId}_checkId${st.index+1}');" style="color:black;"> <span
											class="user_span02 f1">${childEntity1.value }</span></a>
										</label>
										</p>
									</c:forEach>
	      						</div>
	      					</div>
      					</c:if>
      					<c:if test="${!empty childEntity.isShow}">
      						<div class="ex_text" id="${childEntity.questionId }_div_hidden">
								<span class="titleC" style="width:100%;">
									<b class="titleLine fl" ></b>
									${childEntity.title }
								</span>
	      						<div class="contentWrap" style="display:flex;">
	      							<input id="${childEntity.questionId }_input" value='${childEntity.questionList }' type="hidden">
	      							<c:forEach items="${childEntity.questionDataMap }" var="childEntity1" varStatus="st">
	      							<p style="flex:1;border:solid 1px #ccc;padding:5px 5px;">
										<label > <input  
											onclick='hiddenSomeQuestions(this)'
											name="${childEntity.questionId }_${childEntity.types }" type="radio" 
											value="${childEntity1.key }" id="${childEntity.questionId}_checkId${st.index+1}" >
											<a onclick="clickRadioForA('${childEntity.questionId}_checkId${st.index+1}');" style="color:black;"> <span
											class="" style="color: black;">${childEntity1.value }</span></a>
										</label>
										</p>
									</c:forEach>
	      						</div>
      						</div>
      					</c:if>
      				</c:if>
	     				</c:forEach>
     					
     				</div>	    
      			</c:if>	
   			</c:forEach>
   			<c:if test="${!empty varList }">
   				<button href="javascript:void(0)" style=" color: #fff; text-decoration: none;" onclick="save();" class="submitBtn">匿名提交</button>
   			</c:if>
        </div>
       <div id="mask">
			<div  class="loading" style="display:none;">提交中请稍后...</div> 
	</div>
    </div>
    <c:if test="${questionnaireData.backMusicSwith }">
		<audio loop src="${questionnaireData.backMusic }" id="media" autoplay="autoplay" preload=""></audio>
	</c:if>
</form>
</body>
	<c:if test="${questionnaireData.bootomType == 'xianlin_bootom.jsp' }">
		 <%@ include file="xianlin_bootom.jsp"%> 
	</c:if>
	<c:if test="${questionnaireData.bootomType == 'yanyuankangfuyiyuan_bootom.jsp' }">
		 <%@ include file="yanyuankangfuyiyuan_bootom.jsp"%> 
	</c:if>
	
	
<script>
	var score = [ "很不满意", "不满意", "一般", "满意", "非常满意" ];
	function clickStarFor(obj){
		//alert(obj.id);	
		var id=obj.id;
		var selectedArr=id.split("_");//获取选中的值
		var hiddenInputId=selectedArr[0]+"_"+selectedArr[1];
		$("#"+hiddenInputId).val(selectedArr[2]);
		$("#"+hiddenInputId+"_evaluate").html("【"+score[selectedArr[2]-1]+"】");
		//将选中的之前的星星全变成亮色
		for(var i= 1; i<=selectedArr[2];i++){
			$("#"+hiddenInputId+"_"+i).addClass('active');
			$("#"+hiddenInputId+"_"+i).addClass('fa-star');//fa-star-o
			$("#"+hiddenInputId+"_"+i).removeClass('fa-star-o');
		}
		for(var i= 5; i>selectedArr[2];i--){
			$("#"+hiddenInputId+"_"+i).removeClass('active');
			$("#"+hiddenInputId+"_"+i).addClass('fa-star-o');//fa-star-o
			$("#"+hiddenInputId+"_"+i).removeClass('fa-star');
		}
	}
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
	 
	 /* 滑动框js */
	$(function(){
		/* $('.range-slider').jRange({
			from: 0,
			to: 5,
			step: 1,
			scale: [0,1,2,3,4,5],
			format: '%s',
			width: 300,
			showLabels: true,
			snap: true
		}); */
		$('[id^=range_]') .each(function(index, elementObj) {
			//定义一个接收变动取值范围范围的数组	
			var scaleRangeArr=[];
			var scaleRangeStr="";
			//定义一个接收最大值的数值
			var scaleRange="";
			var id = $(elementObj).attr("id");
			scaleRange=id.split("_")[3];
			for(var i=0;i<=scaleRange;i++){
				/* if(i==0){
					scaleRangeStr=i;
				}else{
					scaleRangeStr=scaleRangeStr+","+i;
				} */
				scaleRangeArr[i]=i;
			}
			/* scaleRangeArr=scaleRangeStr.split(","); */
			 $("#"+id).jRange({
					from: 0,
					to: scaleRange,
					step: 1,
					scale: scaleRangeArr,
					format: '%s',
					width: 300,
					showLabels: true,
					snap: true
				}); 
		});
		$('[id^=hidden_all_by_]').each(function(index, elementObj) {
			var value = $(elementObj).attr("value");
			 var dataList=eval(value);
			 var arrList="";
			 for(var i=0;i<dataList.length;i++){
				// alert(dataList[i].name);
				 var questionsIdList=dataList[i].value.split(",");
				 for(var j=0;j<questionsIdList.length;j++){
						 $("#"+questionsIdList[j]+"_div_hidden").css("display","none");
							// alert(questionsIdList[j]+"_div_hidden");
							 $('[name^='+ questionsIdList[j]+ ']').each( function( index, elementInput) { 
								$(elementInput).disabled=true;
							});
				 }
			 } 
		});
	});
	 function save(){
		 var code=$("#code").val();
		 if(code==""){
			 alert("缺少参数不能提交！");
			 return ;
		 }
		//$('#mask').show();
		$('#mask').show();
		
		
		$('#questionForm').attr('action','saveQuestionsForList');
		$('#questionForm').submit();
	 }
	 function clickRadioForA(id){
			$("#"+id).click();
			//alert(id);
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
	 }
</script>

</html>
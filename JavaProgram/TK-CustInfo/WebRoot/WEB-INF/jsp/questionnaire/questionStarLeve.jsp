<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%> 
	<script type="text/javascript" src="static/stat/js/echarts.common.min.js"></script>
	<!-- 树形下拉框start -->
	<script type="text/javascript" src="plugins/selectZtree/selectTree.js"></script>
	<script type="text/javascript" src="plugins/selectZtree/framework.js"></script>
	<link rel="stylesheet" type="text/css" href="plugins/selectZtree/import_fh.css"/>
	<script type="text/javascript" src="plugins/selectZtree/ztree/ztree.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/selectZtree/ztree/ztree.css"></link>
	<link type="text/css" rel="stylesheet" href="static/stat/css/style.css">
	<!-- 树形下拉框end -->
	
	<script type="text/javascript">
	//饼图初始化
	function btInit(myChart,id,legData,serData,title){
		//基于准备好的dom，初始化echarts实例
		//var myChart = echarts.init(document.getElementById('btcharts-'+id));
		//myChart.showLoading();
		//指定图表的配置项和数据
		option = {
			//title : {
		   //     text: title+'分数分布图',
		    //    x:'center'
		   // },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{b}:{c}人"
		    },
		    legend: {
		    	orient: 'vertical',
		        //left: 'right',
		        right:'5%',
		        top:'middle',
		        align:'left',
		        data: []
		    },
		    series: [{
		        type: 'pie',
		        radius : '60%',
		       	center:['40%','50%'],
		        label:{
	                normal:{
	                    position:'outside',//outside、inside
	                    formatter:'{b}:{c}人({d}%)',
	                    textStyle : {
	                        fontWeight : 'normal',
	                        fontSize : 10,
	                        color:'#031F03'
	                        }
	                }
	            },
		        data: []
		    }],
		    color: ['#FF0000','#FFA500','#FFFF00','#33CC33','#2AA5F8','#FF00FF']
		};
		option.legend.data = legData;
		option.series[0].data = serData;
		myChart.clear();
		myChart.setOption(option);
		//myChart.dispose();
		//myChart.hideLoading();
	}
	//折线图初始化
	function zxInit(id,xData,yData,averAge,avgerStr){
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('zxcharts-'+id));
		myChart.on('click', function (param) {
		    getZxToBt(id,param.name);
		});
		option = {
				//title: {
			    //    text: title+'分数分布图',
			    //    x:'center'
			   // },
			    tooltip: {
			        trigger: 'axis'
			    },
			    grid:{
			    	right:'20%'
			      },
			    legend: {
			        data:[
			              '平均分',
			        {
			            name:avgerStr,
			            icon:'line'
			            
			        }],
			        top:'middle',
			        orient:'vertical',
			        align:'left',
			        selectedMode:false,
			        x: 'right'
			    },
			    toolbox: {
			        show: true,
			        feature: {
			            dataZoom: {
			                yAxisIndex: 'none'
			            },
			            dataView: {readOnly: false},
			            magicType: {type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        }
			    },
			    xAxis:  {
			        type: 'category',
			        name:"时间",
			        boundaryGap: false,
			        axisLabel:{ //x轴倾斜度
			            interval:0,
			            rotate:-20
			        },
			        data: []
			    },
			    yAxis: {
			        type: 'value',
			        name:"分数",
			        max:5,
			        //axisLabel: {
			        //    formatter: '{value}分'
			        //}
			    },
			    series: [
			             {
			            	 name:'平均分',
			                 type:'line',
			                 symbolSize:'10',//折点大小
			                 symbol:'circle',//折点实心
			                 data:[],
			                 itemStyle : {  
			                     normal : {  
			                         label:{
			                           show:true  
			                         },
			                         color:'#0000CD',
			                         lineStyle:{  
			                             color:'#0000CD'  //折线颜色
			                         }  
			                     }  
			                 },
			                 markLine: {
			                	 silent:true,
			                	 symbolSize:'0',
			                     lineStyle:{
			                       normal:{
			                           color:'#FF0000',
			                           type:'solid'
			                       }  
			                     },
			                     data: [
										//averAge
			                         /* {type: 'average', name: '平均值'} */
			                         /* {name: '平均值', yAxis: averAge} */
			                     ]
			                 }
			             },
			             {
			            	 name:avgerStr,
			            	 type:'line',
			            	 itemStyle : {  
			                     normal : {
			                         color:'#FF0000'
			                     }  
			                 }
			             }
			         ]
			};
		option.xAxis.data = xData;
		option.series[0].data = yData;
		//console.log(averAge);
		option.series[0].markLine.data = averAge;
		myChart.clear();
		myChart.setOption(option);
	}
	//折点点击事件
	function getZxToBt(questionId,time){
		var myChart = echarts.getInstanceByDom(document.getElementById('btcharts-'+questionId));
		myChart.showLoading();
		var isFinance = $("input[name='isFinance']:checked").val();
		var zxStartTime = $("#zxStartTime").val();
		var zxEndTime = $("#zxEndTime").val();
		var HOSIPITAL_CODE = $("#hosipitalCode").val();
		var SECTION_CODE = $("#sectionCode").val();
		var EMP_CODE = $("#empCode").val();
		
		$.ajax({
			url:"questionStatic/findBtData.do",
			type:"POST",
			data:{isFinance:isFinance,
				zxStartTime:zxStartTime,
				zxEndTime:zxEndTime,
				questionId:questionId,
				btEndTime:time,
				HOSIPITAL_CODE:HOSIPITAL_CODE,
				SECTION_CODE:SECTION_CODE,
				EMP_CODE:EMP_CODE
				},
			success:function(data){
				$("#"+data.questionId).html("平均分："+data.bfb);
				btInit(myChart,data.questionId,data.btData,data.bt,$("#title-"+data.questionId).html());
				myChart.hideLoading();
			}
			
		});
	}
	function search(){
		if(validationData() !=false){
			top.jzts();
			//$("#Form").submit();
			submit();
		}
	};
	function submit(currentPage,showCount){
		var param = $("#Form").serialize();
		if(typeof(currentPage)!="undefined"){
			param+="&currentPage="+currentPage
		}
		if(typeof(showCount)!="undefined"){
			param+="&showCount="+showCount
		}
		goLoacation("goTop");
		$.ajax({
			url:"questionStatic/starRatJson.do",
			type:"POST",
			data:param,
			success:function(data){
				$("#divMsg").empty();
				$("#pageStr").empty();
				var html = "";
				var pageHtml = "";
				var ret = eval('('+data+')');  
				if(ret.QX.cha == 0){ 
					html += "<div style='text-align:center'>您无权查看</div>";
				}else{
					if(ret.questionList!=null && ret.questionList.length>0){
						$.each(ret.questionList,function(i,item){
							html+="<div class='circle_box clear'  id='div-"+item.questionId+"'>";
								html+="<div class='circle_box_l'>"
									html+="<h2 class='circle_box_title'>";
									html+="<span>"+item.title+"分数分布图</span>";
									html+="<strong id='"+item.questionId+"'>平均分："+item.bfb+"</strong>";
									html+="</h2>";
								html+="<div id='btcharts-"+item.questionId+"'style='height:320px;'></div>";
							html+="</div>";
								html+="<div class='circle_box_r'>";
									html+="<h2 class='circle_box_title'>";
									html+="<span>"+item.title+"评分数</span>";
									if(ret.isFinance == 1){
										html+="<strong>时间段："+data.notFinanceDay+"天</strong>";
									}
									html+="</h2>";
									html+="<div id='zxcharts-"+item.questionId+"' style='height:320px;'></div>";
								html+="</div>";
							html+="</div>";
						});
						//分页
						pageHtml = ret.page.pageStr;
					}else{
						html+="<div style='text-align:center'>没有相关数据</div>";
					}
				}
				$("#divMsg").append(html);
				$("#pageStr").append(pageHtml);
				for(var i=0;i<ret.questionList.length;i++){
					var id=ret.questionList[i].questionId;
					var legData = ret.questionList[i].btData;
					var serData = ret.questionList[i].bt;
					var xData = ret.questionList[i].xData;
					var yData = ret.questionList[i].yData;
					var averAgeRes = ret.questionList[i].averAgeRes;
					var avgerStr = ret.questionList[i].avgerStr;
					$("#div-"+id).css("width",$("#div-"+id).width());
					var myChart = echarts.init(document.getElementById('btcharts-'+id));
					btInit(myChart,id,legData,serData);
					if(avgerStr!=''){
						averAgeRes =[{name: '平均值', yAxis: averAgeRes}];
					}else{
						averAgeRes=[];
					}
					zxInit(id,xData,yData,averAgeRes,avgerStr);
				};
				top.hangge();
			}
		});
	}
	
	function goLoacation(id){
		 $('html,body').animate({
	           scrollTop: $("#"+id).offset().top
	     }, 100);
	}
	
	
	function seach(goPage,showCount){
		submit(goPage,showCount);
	}
	
	//数据校验
	function validationData(){
		if($("#DEPARTMENT_IDQ").val() ==''){
			$("#selectTree").tips({
				side:3,
	            msg:'请选择园区',
	            bg:'#AE81FF',
	            time:2
	            
	        });
			$("#selectTree").focus();
			return false;
		}
		/* if($("#hosipitalCode").val() ==''){
			$("#hosipitalCode").tips({
				side:3,
	            msg:'请选择医院',
	            bg:'#AE81FF',
	            time:2
	            
	        });
			$("#hosipitalCode").focus();
			return false;
		} */
		var a = $("input[name='isFinance']:checked").val();
		if(a == undefined){
			$("#dytjzq").tips({
				side:3,
	            msg:'请选择单月统计周期',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#dytjzq").focus();
			return false;
		}
		if(a == 1){
			if($("#zxStartTime").val() == ''){
				$("#zxStartTime").tips({
					side:3,
		            msg:'请选择开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#zxStartTime").focus();
				return false;
			}
			if($("#zxEndTime").val() == ''){
				$("#zxEndTime").tips({
					side:3,
		            msg:'请选择结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#zxEndTime").focus();
				return false;
			}
		}
	}
	
	</script>
</head>
<body style="min-width:1022px" id="goTop">
	<form class="clear" action="questionStatic/starRat.do?id=z31" method="post" name="Form" id="Form" style="padding:15px">
	<table style="width:100%;min-width:1022px" class="questionStarLTb">
				<tr>
					<td style="width: 110px;background:#f6f6f6;font-weight:700;font-size:14px;text-align:right"> 
					 	<span id="yuanqu">选择园区</span>
				 	</td>
 					<td class="inputTD">
 						<input type="hidden" name="DEPARTMENT_IDQ" id="DEPARTMENT_IDQ" value="${pd.DEPARTMENT_IDQ}"/>
 						<input type="hidden" name="DEPARTMENT_NAME" id="DEPARTMENT_NAME" value="${pd.DEPARTMENT_NAME}"/>
						<div class="selectTree" id="selectTree"></div>
						
						<select class="chzn-select" name="HOSIPITAL_CODE" id="hosipitalCode" onchange="findSectionCode()" data-placeholder="全部医院" style="vertical-align:top;width: 250px">
							<option value="">全部医院</option>
					  	</select>
						<select class="chzn-select" name="SECTION_CODE" id="sectionCode" onchange="findDoctorCode()" data-placeholder="全部科室" style="vertical-align:top;width: 250px">
							<option value="">全部科室</option>
					  	</select>
						<select class="chzn-select" name="EMP_CODE" id="empCode" data-placeholder="全部医生" style="vertical-align:top;width: 250px">
							<option value="">全部医生</option>
					  	</select>
					</td>
					<td style="background:#f6f6f6;font-weight:700;font-size:14px;text-align:right">
						调查问卷
					</td>
					<td class="tdr">
						<select name="questionnaireId" id="questionnaireId" style="float:left;height:25px">
							<option value="">全部</option>
							<c:forEach items="${questionnaireList}" var="item">
								<c:choose>
									<c:when test="${item.questionnaireId eq pd.questionnaireId}">
										<option value="${item.questionnaireId }" selected="selected">${item.title }</option>
									</c:when>
									<c:otherwise>
										<option value="${item.questionnaireId }">${item.title }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					  	</select>
					  	<button style="float:left;height:25px" class="btn btn-mini btn-light" type="button" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button>
					</td>
					
				</tr>
				<tr>
					<td style="background:#f6f6f6;font-weight:700;font-size:14px;text-align:right"><p id="dytjzq">单月统计周期</p></td>
					<td class="tdr">
						<input type="radio" style="position: relative;top:-6px;" name="isFinance" value="0" <c:if test="${pd.isFinance==0 || isFinance==null}">checked="checked"</c:if> onclick=""/> 财务月
						
						<input class="span10 date-picker" name="btEndTime" id="btEndTime"  value="${pd.btEndTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;margin-left:4px;margin-right:12px;height:20px" placeholder="开始日期"/>
						
						<input type="radio" style="position: relative;top:-6px;" name="isFinance" value="1" <c:if test="${pd.isFinance==1}">checked="checked"</c:if> onclick=""/>     
						非财务月
						<input class="span10 date-picker" name="zxStartTime" id="zxStartTime" value="${pd.zxStartTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;margin-left:4px;margin-right:0px;height:20x" placeholder="开始日期"/>
						<input class="span10 date-picker" name="zxEndTime" id="zxEndTime" value="${pd.zxEndTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;margin-right:0px;height:20px" placeholder="结束日期"/>
						
					</td>
					 	
					<td style="background:#f6f6f6;font-weight:700;font-size:14px;text-align:right">
					趋势图统计刻度
					</td>
					<td class="tdr">
					<select name="kd" style="width:80px;position: relative;top:-3px" onchange="search()">
						<c:forEach items="${kdList}" var="item">
							<c:choose>
									<c:when test="${item eq pd.kd}">
										<option value="${item }" selected="selected">${item }</option>
									</c:when>
									<c:otherwise>
										<option value="${item }">${item }</option>
									</c:otherwise>
								</c:choose>
						</c:forEach>
					</select>
					</td>
				</tr>
			</table>
	</form>
	<c:if test="${QX.cha==1}">
				<c:choose>
					<c:when test="${not empty questionList}">
						<c:forEach items="${questionList}" var="item" varStatus="vs">
					    	<div class="circle_box clear"  id="div-${item.questionId}">
								<div class="circle_box_l">
									<h2 class="circle_box_title">
										<span>${item.title}分数分布图</span>
										<strong id="${item.questionId}">平均分：${item.bfb}</strong>
									</h2>
									<div id="btcharts-${item.questionId}"style="height:320px;">
										
									</div>
								</div>
								<div class="circle_box_r">
									<h2 class="circle_box_title">
										<span>${item.title}评分数</span>
										<c:if test="${pd.isFinance==1 }">
										<strong>时间段：${notFinanceDay}天</strong>
										</c:if>
									</h2>
									<div id="zxcharts-${item.questionId}" style="height:320px;">
										
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<!-- <div style="text-align:center">没有相关数据</div> -->
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${QX.cha == 0 }">
				<div style="text-align:center">您无权查看</div>
			</c:if>
	<!-- 返回顶部  -->
	<div id="divMsg"></div>
	<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;padding-right:20px" id="pageStr"></div>
	
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
		<i class="icon-double-angle-up icon-only"></i>
	</a>
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<script type="text/javascript">
	/* $(document).ready(
			function(){
				var pdList='${questionStr}';
				if(pdList.length>0){
					pdList = eval('(' + pdList + ')');
					//var i = ${vs.index};
					for(var i=0;i<pdList.length;i++){
						var id=pdList[i].questionId;
						var legData = pdList[i].btData;
						var serData = pdList[i].bt;
						var xData = pdList[i].xData;
						var yData = pdList[i].yData;
						//$("#div-"+id).css("display","block");
						$("#div-"+id).css("width",$("#div-"+id).width());
						var myChart = echarts.init(document.getElementById('btcharts-'+id));
						btInit(myChart,id,legData,serData);
						zxInit(id,xData,yData);	
					};
				}
				top.hangge();
			}
	); */
		//检索
			$(function() {
			top.hangge();
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('#zxStartTime').datepicker();
			$('#zxEndTime').datepicker();
			$('#btEndTime').datepicker({
				  language: "zh-CN",
		          todayHighlight: true,
		          format: 'yyyy-mm',
		          autoclose: true,
		          startView: 'months',
		          maxViewMode:'years',
		          minViewMode:'months'
				
			});
			
		});
		//查找该部门下字典配置医院
		function findDictionHosipatl(id){
			$.ajax({
				url:"questionStatic/findDictionHosipatl.do",
				type:"post",
				data:{DEPARTMENT_ID:id},
				success:function(data){
					var html = "<option value=''>全部医院</option>"
						$.each(data,function(i,value){
							html += "<option value='"+value.BIANMA+"'>"+value.NAME+"</option>";
						});
					$("#hosipitalCode").empty();
					$("#hosipitalCode").append(html);
					$("#hosipitalCode").trigger("liszt:updated");
		            $("#hosipitalCode").chosen(); 
				}
			});
		}
		//查找科室下拉
		function findSectionCode(){
			var HOSIPITAL_CODE = $("#hosipitalCode").val();
			$.ajax({
				url:"questionStatic/findSectionCodeName.do",
				type:"post",
				data:{HOSIPITAL_CODE:HOSIPITAL_CODE},
				async:false,
				success:function(data){
					$("#sectionCode").empty();
					var html = "<option value=''>全部科室</option>";
					$.each(data,function(i,value){
						html += "<option value='"+value.SECTION_CODE+"'>"+value.SECTION_NAME+"</option>";
					});
					$("#sectionCode").append(html);
					$("#sectionCode").trigger("liszt:updated");
		            $("#sectionCode").chosen(); 
				}
				
			});
		}
		//查找医生下拉
		function findDoctorCode(){
			var HOSIPITAL_CODE = $("#hosipitalCode").val();
			var SECTION_CODE = $("#sectionCode").val();
			$.ajax({
				url:"questionStatic/findDoctorCodeName.do",
				type:"post",
				data:{
					HOSIPITAL_CODE:HOSIPITAL_CODE,
					SECTION_CODE:SECTION_CODE
				},
				async:false,
				success:function(data){
					$("#empCode").empty();
					var html = "<option value=''>全部医生</option>";
					$.each(data,function(i,value){
						html += "<option value='"+value.EMP_CODE+"'>"+value.EMP_NAME+"</option>";
					});
					$("#empCode").append(html);
					$("#empCode").trigger("liszt:updated");
		            $("#empCode").chosen(); 
				}
			});
		}
		
		function findQuestionList(DEPARTMENT_ID){
			$.ajax({
				url:"questionStatic/findQuestionList.do",
				type:"post",
				data:{DEPARTMENT_ID:DEPARTMENT_ID
					},
				async:false,
				success:function(data){
					var html = "<option value=''>全部</option>"
						$.each(data.questionnaireList,function(i,value){
							html += "<option value='"+value.questionnaireId+"'>"+value.title+"</option>";
						});
					$("#questionnaireId").empty();
					$("#questionnaireId").append(html);
				}
			});
			
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
					$("#DEPARTMENT_IDQ").val($(this).attr("relValue"));
					$("#DEPARTMENT_NAME").val($(this).attr("relText"));
					findQuestionList($(this).attr("relValue"));
					findDictionHosipatl($(this).attr("relValue"));
			    }
			});
			//赋给data属性
			$("#selectTree").data("data",defaultNodes);  
			$("#selectTree").render();
			$("#selectTree2_input").val("${null==pd.DEPARTMENT_NAME?'请选择':pd.DEPARTMENT_NAME}");
		}
		
		
		
	</script>
	
	
</body>

</html>


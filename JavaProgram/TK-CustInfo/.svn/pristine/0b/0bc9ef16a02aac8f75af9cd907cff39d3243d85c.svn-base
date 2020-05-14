<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%> 
	<script type="text/javascript" src="static/js/echarts.js"></script>
	<style>
		
	</style>
	<link rel="stylesheet" href="static/css/font-awesome.css">
    <style>
    	td{
			white-space: nowrap;
		  }
        * {
            margin: 0;
            padding: 0;
        }
        ul {
            list-style: none;
        }
        .hd {
            height: 61px;
        }
        .hd span {
            float: left;
            background-color: #fff;
            line-height: 35px;
            text-align: center;
            cursor: pointer;
            color: #333;
            border: 1px solid #ddd;
            font-size: 20px;
            padding: 0px 15px;
            
        }
        .hd span:first-child{
        	border-right: none;
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
        }
        .hd span:last-child{
        	border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        .hd span.current {
            background-color: #58a6e7; 
            border: 1px solid #2b8ee1;
            color: #fff;
        }
        .bd li {
            height: 255px;
            display: none;  /*设置隐藏*/
            text-align: left;
            background: lightblue;
        }
        .bd li.current {
            display: block; /*显示*/
        }
        .fa{
            margin-right: 10px;
        }
    </style>
	<script type="text/javascript">
	$(top.hangge());
	//饼图初始化
	function btInit(id,legData,serData){
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('highcharts-'+id));
		//指定图表的配置项和数据
		option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{b}:{c}人"
		    },
		    legend: {
		    	orient: 'vertical',
		        left: 'right',
		        data: legData
		    },
		    series: [{
		        //name: '销量',
		        type: 'pie',
		        radius : '70%',
		        center:['40%','60%'],
		        itemStyle:{
		        	normal:{
		        		//color: '#FF0000',
		        		label: {
	                        show: true,
	                        formatter: '{b}:{d} %'
	                    },
	                    labelLine: {
	                        show: true
	                    }
		        	}
		        	
		        },
		        data: serData
		    }]
		};
		myChart.clear();
		myChart.setOption(option);
	}
	//柱状图初始化
	function ztInit(id,xData,yData){
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('highcharts-'+id));
		option = {
			    color: ['#3398DB'],
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis : [{
			            type : 'category',
			            data : xData,
			            axisTick: {
			                alignWithLabel: true
			            }
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name:'人数',
			            type:'bar',
			            barWidth: '10%',
			            itemStyle:{
			            	normal:{
			            		label:{
			            			show:true,
			            			position:'top',
			            			formatter: '{c}'
			            		}
			            	}
			            },
			            data:yData
			        }
			    ]
			};
		myChart.clear();
		myChart.setOption(option);
	}
	</script>	
	
	</head>
<body>
		
<div class="container-fluid" id="main-container">
<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="questionStatic/chartList.do?id=z30" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td style="vertical-align:top;"> 
					  	<select name="questionnaireId" id="questionnaireId" data-placeholder="请选择" style="vertical-align:top;width: 220px;">
							<c:forEach items="${pageList}" var="entity">
								<option value="${entity.questionnaireId }"  <c:if test="${pd.questionnaireId== entity.questionnaireId }">selected=true</c:if>>${entity.title }</option>
							</c:forEach>
					  	</select>
					</td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search()"  title="检索" style="margin-left:10px;padding:2px 5px;box-sizing:border-box;border:1px solid #ccc;"><i id="nav-search-icon" class="icon-search"></i></button></td>
				</tr>
			</table>
			<!-- 检索  -->
			
			<c:forEach items="${pdList }" var="item" varStatus="vs">
				<c:if test="${item.classification=='L0'}">${vs.index+1}.${item.title }</c:if>
				<c:if test="${item.classification=='L2'}">${vs.index+1}.${item.questionCode}${item.sort}${item.title}</c:if>
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td>选项</td>
							<td>人数</td>
							<td>百分比</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${item.resultList }" var="res">
						<tr>
						<td>${res.opt}</td>
						<td>
						<c:if test="${res.sum==null}">0</c:if>
						<c:if test="${res.sum!=null}">${res.sum}</c:if>
						</td>
						<td>
						<c:choose>
							<c:when test="${res.opt=='有效填写量'}"></c:when>
							<c:when test="${res.bfb==null}">0</c:when>
							<c:when test="${res.bfb!=null}">${res.bfb}</c:when>
						</c:choose>
						</td>
						</tr>
						</c:forEach>
				    </tbody>
			    </table>
				<div id="div-${vs.index}" style="display:none">
				    <div class="hd">
				        <span  id="area-${vs.index }" onclick="bingTu('${vs.index}')"><i class="fa fa-bar-chart"></i>饼状图</span>
				        <span  id="bar-${vs.index }"onclick="zhuTu('${vs.index}')"><i class="fa fa-pie-chart"></i>柱状图</span>
				    </div>
				    <div id="highcharts-${vs.index}" style="height:300px"></div>
			    </div>
			</c:forEach>
				
			<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
		</form>
	</div>
  </div>
	
</div>
</div>
	<!-- 返回顶部  -->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
		<i class="icon-double-angle-up icon-only"></i>
	</a>
	
	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<!-- 引入 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
	<script type="text/javascript">
		
		function search(){
			$("#Form").submit();
		}
		//页面初始化图形
		$(document).ready(function(){
			//页面数据
			var pdList =${pdListJson};
			if(pdList !=''){
				for(var i =0;i<pdList.length;i++){
					var id = i;
					var legData = pdList[i].btData;
					var serData = pdList[i].bt;
					if(pdList[i].isChart && "T5" != pdList[i].types && "T6" != pdList[i].types){
						$("#div-"+id).css("display","block");
						btInit(id,legData,serData);
					}
				}
			}
		}); 
		//切换柱状图
		function zhuTu(id){
			
			$('#bar-'+id).toggleClass('current',function(){
				 $('#area-'+id).toggleClass('current');
			}); 
			var pdList =${pdListJson};
			var xData = pdList[id].xData;
			var yData = pdList[id].yData;
			ztInit(id, xData, yData);
		}
		//切换饼图
		function bingTu(id){
			 
			 $('#area-'+id).toggleClass('current',function(){
				 $('#bar-'+id).toggleClass('current'); 
			 }); 
			var pdList =${pdListJson};
			var legData = pdList[id].btData;
			var serData = pdList[id].bt;
			btInit(id,legData,serData); 
		}
		
	         
	</script>	
	</body>
</html>
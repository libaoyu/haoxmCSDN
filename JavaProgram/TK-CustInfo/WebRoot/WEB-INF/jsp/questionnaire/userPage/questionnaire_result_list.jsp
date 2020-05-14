<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@  taglib  uri="http://java.sun.com/jsp/jstl/functions"   prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<head>
	<script type="text/css" src="static/css/font-awesome.min.css"></script>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
	<style>
		td{
			white-space: nowrap;
		}
		.refresh{
			display:inline-block;
			width:30px;
			height:28px;
			background:#e7e7e7;
			font-size:16px;
			color:#82b3e0;
			text-align:center;
			line-height:29px;
		}
		.refresh:hover{
			cursor:pointer;
			background:#ccc;
		}
	</style>
	
	
	</head>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="qResult/listResult.do" method="post" name="Form" id="Form">
			<input type="hidden" value="" name="listBatchId"  id="listBatchId"/>
			<input type="hidden" value="" name="isExportAll" id="isExportAll"/>
			<table style="width: 100%;">
				<tr>
					<td style="width: 11%;">
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="title"  value="${pd.title }" placeholder="按内容查询" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;width: 20%"> 
					 	<select class="chzn-select" name="questionnaireId" id="questionnaireId" data-placeholder="请选择" style="vertical-align:top;width: 25%;" onchange="changeLevel();">
							<c:forEach items="${listQuestionnaire }" var="entity">
								<option value="${entity.questionnaireId }"  <c:if test="${pd. questionnaireId== entity.questionnaireId }">selected=true</c:if>>${entity.title }</option>
							</c:forEach>
					  	</select>
					</td>
					<td style="vertical-align:top;width: 16%;">
					<%-- <input name="level" id="level" value="${pd.level}" > --%>
					  	<select  id="MySelectBox"  name="level"  >
					  		<option value="">请选择</option>
							<c:forEach items="${levelMap }" var="entity">
								<option value="${entity.key }"  <c:if test="${pd.level==entity.key }">selected=true</c:if>  >${entity.value }</option>
							</c:forEach>
					  	</select>
					</td>
					<td style="width: 7%;"><input class="span10 date-picker" name="startTime" id="startTime" value="${pd.startTime }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td style="width: 7%;"><input class="span10 date-picker" name="endTime" id="endTime" value="${pd.endTime }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
					
					<td style="vertical-align:top;width: 2%;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					
					<td style="vertical-align:top;width: 2%;">
						<span title="重置" 
						class=" refresh icon icon-undo" onclick="clearAll();"></span>
					</td>

					<c:if test="${!empty titleList  }">
						<c:if test="${QX.toExcel == 1}">
						<td style="vertical-align:top;width: 2%;"><a class="btn btn-mini btn-light"  onclick="toExcel();"  title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
						</c:if>
					</c:if>
					<td style="text-align: right;">	
					 <c:if test="${QX.del==1}">
						<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
					 </c:if>
					</td>
				</tr>
			</table>
			<div style="overflow-x:scroll; overflow-y:scroll;width: 100%;height: 100%;">
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" name='ids' /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<c:choose>
							<c:when test="${!empty titleList  }">
								<c:forEach items="${ titleList}" var="title" varStatus="vs">
											<th class="center">${title.value}</th>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach items="${defaultColumnName }" var="entity">
									<th class="center">${entity }</th>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<th class="center">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					
					
					
					<c:when test="${ !empty listData}">
						<c:if test="${QX.cha==1 }">
						<c:forEach items="${listData}" var="data" varStatus="vsData">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${data[0] }" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vsData.index+1}</td>
								<c:forEach items="${data }" var="entity" varStatus="vs" begin="1">
										<td class='center'>${entity}</td>
								</c:forEach>
								<td>
								<c:if test="${QX.del != 1 }">
									<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
								</c:if>
								<c:if test="${QX.del==1}">
									<a style="cursor:pointer;" title="删除" onclick="del('${data[0]}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a>
								</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >暂无数据</td>
						</tr>
					</c:otherwise>
					
				</c:choose>
				</tbody>
			</table>
		</div>	
			<table style="width:100%;">
				<tr>
					
					<td>	
					 <c:if test="${QX.del==1}">
					 	<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
					 </c:if>
					</td>
					
					<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript"  src="static/js/jquery-1.9.1.min.js" ></script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<!-- 下拉复选框用到的                        开始            -->
		
	<!-- 	 <link rel="stylesheet" type="text/css" href="static/question/css/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/style.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/jquery-ui.css" />
		
		<script type="text/javascript" src="static/question/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="static/question/js/jquery.multiselect.js"></script>  -->
		<!--  结束 -->
		<script type="text/javascript">
		$(top.hangge());
		//检索
		var questionnaireId = $("#questionnaireId").val();
		function search(){
			top.jzts();
			if(questionnaireId == ""){
				alert("请先选择具体问卷!");
			}
			//alert($('#level').val());
			$("#Form").submit();
		}
		</script>
		<script type="text/javascript">
		$(function() {
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			/*  $("#MySelectBox").multiselect({
				 noneSelectedText: "请选择", 
				checkAllText: "全选", 
				uncheckAllText: "全不选", 
				selectedList: 10, 
			 });
			 var ids = "${pd.level}".split(',');        
		        if (ids != null) {            
		            $('#MySelectBox').val(ids);
		            $('#MySelectBox').multiselect("refresh");           
		        } */
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			//日期框
			$('.date-picker').datepicker();
			changeLevel();
		});
		//导出excel
		function toExcel(){
			//alert($('#level').val());
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++) {
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			var confirmExport='';
			var isExportAll='all';
			if(str!=''){
				confirmExport=confirm("是否导出选中的数据？点击是导出选中的数据，点击否导出全部数据。");
				if(confirmExport){
					isExportAll='no';
					$('#listBatchId').val(str);
					$('#isExportAll').val(isExportAll);
				}
				
			}
			$('#Form').attr("action",'<%=basePath%>qResult/exportExcel.do');
			$('#Form').submit();
			$('#listBatchId').val('');
			$('#isExportAll').val('');
			$('#Form').attr("action","qResult/listResult.do");
		}
	/* 	function changeLeve(){
			var array_of_checked_values = $("select").multiselect("getChecked").map(function(){
				return this.value; 
				}).get();
			$("#level").val(array_of_checked_values);
			//alert($('#level').val());
		} */
		function clearAll(){
			//title--questionnaireId--MySelectBox--startTime--endTime
			$('#nav-search-input').val('');
			$('#MySelectBox').val('');
			$('#startTime').val('');
			$('#endTime').val('');
		}
		function changeLevel(){
			var Id=$('#questionnaireId option:selected') .val();//选中的值
			var url = "<%=basePath%>qResult/findStaffLevel.do?questionnaireId="+Id+"&tm="+new Date().getTime();
			$.ajax({
				type: "POST",
				url: url,
				cache: false,
				contenttype :"application/x-www-form-urlencoded;charset=utf-8", 
				scriptChartset:"utf-8",
				success: function(data){
					//var listQuestionnaire=data.list;
					//alert(listQuestionnaire);
					$('#MySelectBox').html('');
					var option="<option value=''>请选择</option>";
					var selectedTrue="${pd.level}";
					 $.each(data.list, function(i, list){
						 if(selectedTrue==list.key){
							 option+="<option value='"+list.key+"'  selected=true >"+list.value+"</option>";
						 }else{
							 option+="<option value='"+list.key+"'   >"+list.value+"</option>";
						 }
					 });
						
					$('#MySelectBox').html(option);
				}
			});
		}

		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>qResult/delete.do?batchId="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data=='exist'){
							alert("此问题仍在使用不能删除！如果想删除，请先删除该问题的下属或者结果！");
							nextPage(${page.currentPage});
						}else if(data=='success'){
							alert("删除成功！");
							nextPage(${page.currentPage});
						}else{
							alert("未知错误！请联系管理员！");
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>qResult/delete.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								//dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									if(data.indexOf("|")>-1){
										if(data.split("|")[0]=='notAll '){
											alert("批量删除不成功的条数为："+data.split("|")[1]+"条，这些数据仍在使用！如果想删除，请先删除使用该问卷的数据！");
										}
									} else if(data=='success'){
										alert("删除成功！");
									}else {
										alert("未知错误！请联系管理员！");
									}
									nextPage(${page.currentPage});
								}
							});
						}
					}
				}
			});
		}
		</script>
		
	</body>
</html>


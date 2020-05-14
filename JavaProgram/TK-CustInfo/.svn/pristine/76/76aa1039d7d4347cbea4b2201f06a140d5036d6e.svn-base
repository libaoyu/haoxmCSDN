<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	</head>
	<style>
			.btnm{
				background-color:#438eb9;color:#fff;border:none;padding:5px 20px;
				font-size:16px;
			}
			.btnm:hover{
				background-color:#3f6f8b;
			} 
			.header-text{
				display:inline-block;font-size:20px;line-height:30px;
			}
			.batchInfo{
				font-size:16px;
				font-family: sans-serif;
			}
			.file{
				/* border:1px solid #ccc; */
			}
	</style>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
			<!-- 检索  -->
			<form action="questionnaireTemp/list" method="post" name="Form" id="Form" >
		  	 <table>
				 <tr>
					<td>
						<select class="chzn-select"  data-placeholder="请选择" style="vertical-align:top;width: 20%" id="allBatchId1" name="allBatchId1" style="width: 180px;" onchange="changeAllBatchId();">
							<option value="">请选择</option>
							<c:if test="${!empty listData }">
								<c:forEach items="${listData }" var="entity">
									<c:if test="${pd.allBatchId1== entity.allBatchId}">
										<option value="${entity.allBatchId }" selected="selected">${entity.allBatchId }</option>
									</c:if>
									<c:if test="${pd.allBatchId1 != entity.allBatchId}">
										<option value="${entity.allBatchId }" >${entity.allBatchId }</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select>
					</td>
					<td>
						<select  id="questionId" name="questionId" style="display: none;">
							
						</select>
					</td>
					<td style="vertical-align:top;"><button  class="btnm" onclick="search();"  title="检索">点击查询</button></td>
				</tr> 
			</table> 
			</form>
			<form action="questionnaireTemp/importExcle" method="post" name="Form1" id="Form1" enctype="multipart/form-data" style="margin-top:20px;">
			  	 <table>
					<tr class="batchInfo">
						<td>批次号:<input style="margin:0 10px;" type="text" name="allBatchId" id="allBatchId" value="${ allBatchId}"/></td>
						<c:if test="${QX.FromExcel == 1 }">
							<td>
								<input id="file" type="file" value="" name="file" class="file">
								<a  onclick="importExcle();"  title="导入"class="btnm">导入模板</a>
							</td>
						</c:if>
						<td style="vertical-align:top;"><a class="btn btn-small btn-success"  href="model/questionnaire/questionnaire_model.xlsx">下载模板</a></td>
					</tr>
				</table> 
			 </form> 
		   <div style="border:1px solid #ccc;padding:20px;">	
				   <div>
				   			<div class="header-text">问卷基本信息</div>
				   			<c:if test="${ !empty data.questionId}">
				   				<div style="display:inline-block;float:right; margin-bottom:15px">
				   					<c:if test="${QX.edit == 1 }">
				   						<button  class="btnm" onclick="updateTemp('${data.questionId}');">修改基本信息</button>
				   					</c:if>
				   					<c:if test="${QX.del == 1 }">
				   						<button  class="btnm" onclick="deleteAllTempByQuestionnaireId('${data.questionId}');">删除此问卷</button>
				   					</c:if>
				   			</div>
				   			
				   			</c:if>
				   			
				   </div>
			
			
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tbody>
					<tr>
						<th class="center" style="width:25%" >标题</th>
						<th class="center" style="width:70%;font-weight: normal;" colspan="3">${data.title }</th>
					</tr>
					<tr>
						<th class="center" style="width:20%">卷首语</th>
						<th class="center" style="width:80%;font-weight: normal;" colspan="3">${data.preface }</th>
					</tr>
					<tr>
						<th class="center" style="width:20%">问卷是否导入业务表</th>
						<th class="center" style="width:10%;font-weight: normal;">
								<c:if test="${data.isImport}">
									是
								</c:if>
								<c:if test="${!data.isImport}">
									否
								</c:if>
						</th>
						<th class="center" style="width:20%">问卷调查对象</th>
						<th class="center" style="width:50%;font-weight: normal;">
							<c:forEach items="${questionnaireLevel }" var="item">
								<c:if test="${fn:contains(data.level , item.key)}">
									${item.value }
								</c:if>
							</c:forEach>
						</th>
					</tr>
				</tbody>
			</table>
			<!-- 检索  -->		
			<p style="font-size:20px;">问卷问题信息</p>
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<!-- <th class="center">题目编号</th> -->
						<th class="center">问题</th>
						<th class="center">题型</th>
						<!-- <th class="center">选项</th> -->
						<th class="center">调查对象</th>
						<!-- <th class="center">是否必填</th> -->
						<th class="center">是否校验通过</th>
						<th class="center">错误</th>
						<th class="center">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty listPage}">
						<c:forEach items="${listPage}" var="var" varStatus="vs">
							<tr <c:if test="${var.isRight == 1 }"></c:if>>
								<td class='center' style="width: 3%;">
									<label><input type='checkbox' name='ids' value="${var.questionId}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 5%;">${vs.index+1}</td>
								<td class="" style="width: 30%;">
									<c:if test="${empty var.questionCode}">
										${var.title}
									</c:if>
									<c:if test="${!empty var.questionCode}">
										${var.questionCode}.${var.title}
									</c:if>
								</td>
								<td class="center" style="width: 5%;">
									<c:forEach items="${questionType }" var="item">
										<c:if test="${var.types eq item.key}">
											${item.value }
										</c:if>
									</c:forEach>
								</td>
								<%-- <td class="center" style="width: 8%;">${var.questionCode}</td> --%>
								<td class="center" style="width: 8%;">
									<c:forEach items="${staffLvevl }" var="item">
										<c:if test="${fn:contains(var.level , item.key)}">
											${item.value }
										</c:if>
									</c:forEach>
									
								</td>
							<%-- 	<td class="center" style="width: 7%;">${var.questionCode}</td> --%>
								<td class="center" style="width: 5%;">
										<c:if test="${var.isRight==0 }">
											是
										</c:if>
										<c:if test="${var.isRight !=0 }">
											<font color="red" id="error_${ var.questionId}">否</font>
										</c:if>
								</td>
								<td class="center" style="width: 20%;"><font color="red">${var.whereIsError }</font></td>
								
								<td class="center" style="width: 5%;">
									<div>
										<div class="inline position-relative">
										<a data-toggle="dropdown" style="text-decoration: none;cursor:pointer"><i class="icon-cog icon-only"></i></a>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
												<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.questionId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<li><a style="cursor:pointer;" title="删除" onclick="del('${var.questionId}','${var.isQuestionnaire }');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
											</c:if>
										</ul>
										</div>
									</div>
								</td>
							</tr>
							<c:if test="${not empty var.childTemp}">
								<c:forEach items="${var.childTemp}" var="child" varStatus="vss">
									<tr style="border: solid 1px #f00" <c:if test="${child.isRight == 1 }"></c:if>>
										<td class='center' style="width: 3%;">
											<label><input type='checkbox' name='ids' value="${child.questionId}" /><span class="lbl"></span></label>
										</td>
										<td></td>
										<td class="" style="width: 60px;">
											<img src='static/images/joinbottom.gif' style='vertical-align: middle;'/>
											${var.questionCode}${child.sort}.${child.title}
										</td>
										<td class="center" style="width: 60px;">
											<c:forEach items="${questionType }" var="item">
												<c:if test="${child.types eq item.key}">
													${item.value }
												</c:if>
											</c:forEach>
										</td>
										<%-- <td class="center" style="width: 60px;">${child.questionCode}</td> --%>
										<td class="center" style="width: 60px;">
											<c:forEach items="${staffLvevl }" var="item" >
												<c:if test="${fn:contains(child.level, item.key)}">
													${item.value }
												</c:if>
											</c:forEach>
										</td>
										<%-- <td class="center" style="width: 60px;">
											<c:if test="${child.mustFlag==0}">
												是
											</c:if>	
											<c:if test="${child.mustFlag!=0}">
												否
											</c:if>	
										</td> --%>
										<td class="center" style="">
											<c:if test="${child.isRight==0 }">
												是
											</c:if>
											<c:if test="${child.isRight !=0 }">
												<font color="red" id="error_${ child.questionId}">否</font>
											</c:if>
										</td>
										<td class="center" style="width: 60px;"><font color="red" >${child.whereIsError}</font></td>
										<td class="center" style="width: 60px;">
											<div>
												<div class="inline position-relative">
												<a data-toggle="dropdown" style="text-decoration: none;cursor:pointer"><i class="icon-cog icon-only"></i></a>
												<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
													<c:if test="${QX.edit == 1 }">
														<li><a style="cursor:pointer;" title="编辑" onclick="edit('${child.questionId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<li><a style="cursor:pointer;" title="删除" onclick="del('${child.questionId}','${child.isQuestionnaire }');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
													</c:if>
												</ul>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
								<td colspan="100" class="center" >没有相关数据</td>
							</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		 </div> 
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<c:if test="${not empty listPage}">
						<c:if test="${QX.del == 1 }">
							<a class="btn btn-small btn-success" onclick="makeAll('确定要删除选中的数据吗?');">批量删除</a>
						</c:if>
						<c:if test="${ listPage[0].isImport!=1}">
							<a class="btn btn-small btn-success"  onclick="exportQuestionnaire('${pd.questionId}');">导入业务表</a>
						</c:if>
						<c:if test="${ listPage[0].isImport == 1}">
							<a class="btn btn-small btn-success"  onclick="deleteQuestionnaireByTemp('${pd.questionId}');">撤销导入</a>
						</c:if>
					</c:if>
					<!-- <a class="btn btn-small btn-success" onclick="importExcle();">导入</a> -->
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		<form action="questionnaireTemp/list.do" method="post" name="questionnaireForm" id="questionnaireForm">
			<input type="text" style="display: none;" name="allBatchId1" id="allBatchId1" value="${pd.allBatchId1}"/>
			<input type="text" style="display: none;" name="allBatchId" id="allBatchId" value="${pd.allBatchId}"/>
			<input type="text" style="display: none;" name="questionId" id="questionId" value="${pd.questionId}"/>
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
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		$(top.hangge());
		//检索
		function search(){
			//alert($("#questionId").val());
			top.jzts();
			$("#Form").submit();
		}
		//删除
		function del(Id,type){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>questionnaireTemp/deleteOne.do?questionId="+Id+"&type="+type+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data==0){
							alert("存在下属问题不能删除，请先删除下属问题！");
						}else if(data==1){
							alert("删除成功！");
						}else{
							alert("程序异常！请联系管理员！");
						}
						nextPage(${page.currentPage});
					});
				}
			});
		}
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>questionnaireTemp/goEdit.do?questionId='+Id;
			 diag.Width = 850;
			 diag.Height = 655;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		</script>
		<script type="text/javascript">
		$(function() {
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
			});
			changeAllBatchId();
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			 $("#file").change(function () {
			        var filepath = $("input[name='file']").val();
			        var extStart = filepath.lastIndexOf(".");
			        var ext = filepath.substring(extStart, filepath.length).toUpperCase();
			        if (ext != ".XLSX" && ext != ".XLS" ) {
			          alert("图片限于xlsx,xls格式");
			          $("#file").after($("#file").clone().val(""));    
			          $("#file").remove(); 
			          return false;
			        }
			 });
		});
		//批量操作
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
							//top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>questionnaireTemp/delAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								//dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									if(data.indexOf("|")>-1){
										if(data.split("|")[0]=='notAll '){
											alert("批量删除不成功的条数为："+data.split("|")[1]+"条，这些数据仍在使用！如果想删除，请先删除使用该问题的数据！");
										}
									} else if(data=='all'){
										alert("删除成功！");
									}else{
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
		function importExcle(){
			window.location.href='<%=basePath%>questionnaireTemp/toImportExcle.do';
		}
		function importExcle(){
			
			var allBatchId=$("#allBatchId").val();
			var files = $('input[name="file"]').prop('files');//获取到文件列表
		 	
			if(allBatchId==''){
				alert("请填写导入的批次号！");
				return false;
			}else if(files.length==0){
				alert("请选择导入的模板！！！！！！！！");
				return false;
			}else{
				top.jzts();
				$("#Form1").submit();
			}
			//questionnaireTemp/importExcle
		//	$("#Form").action("questionnaireTemp/importExcle.do");
			
			//$("#Form").action("questionnaireTemp/list.do");
		}
		function changeAllBatchId(){
			var allBatchId= $('#allBatchId1 option:selected').val();
			//alert(allBatchId);
			if(allBatchId ==''){
				$("#questionId") .attr( "style", "display:none;");
				return;
			}
			$("#questionId") .attr( "style", "display:block;");
			$.ajax({
				type: "POST",
				url: '<%=basePath%>questionnaireTemp/getTempByAllBatchId.do?allBatchId='+allBatchId,
		    	data: {allBatchId:allBatchId},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					$("#questionId").html('');
					var questionId="${pd.questionId}";
					var list=eval(data);
					for(var i=0;i<list.length;i++){
						if(questionId !=null && questionId !='' && questionId==list[i].questionId){
							$("#questionId").append("<option selected=true value='"+list[i].questionId+"'>"+list[i].title+"</option>");
						}else{
							$("#questionId").append("<option value='"+list[i].questionId+"'>"+list[i].title+"</option>");
						}
						
					}
				}
			});
		}
		function exportQuestionnaire(id){
			bootbox.confirm("确定导入业务表？", function(result) {
				if(result){
					var countError=0;
					$.ajax({
						type: "POST",
						url: '<%=basePath%>questionnaireTemp/findCountTempByQuestionnaireId.do?questionId='+id,
						cache: false,
						success: function(data){
							if(data=='error'){
								alert("程序异常！请联系管理员！");
							}else{
								countError=parseInt(data);
								if(countError!=0){
									alert(""+countError+"条数据未通过校验，不能导入到业务表，请修改未通过校验的数据！");
									return;
								}else{
									$.ajax({
										type: "POST",
										url: '<%=basePath%>questionnaireTemp/exportQuestionnaire.do?questionId='+id,
								    	//data: {allBatchId:allBatchId},
										//dataType:'json',
										//beforeSend: validateData,
										cache: false,
										success: function(data){
											if(data=='success'){
												alert("导入成功！");
											}else if(data=='fail'){
												alert("所要导入的问卷不存在！请刷新！");
											}else{
												alert("程序异常！请联系管理员！");
											}
											nextPage(${page.currentPage});
										}
									});
								}
							}
						}
					});
					
					
				}
			});
		}
		function deleteQuestionnaireByTemp(id){
			bootbox.confirm("撤销导入业务表？", function(result) {
				if(result){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>questionnaireTemp/deleteQuestionnaireByTemp.do?questionId='+id,
				    	//data: {allBatchId:allBatchId},
						//dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if(data=='success'){
								alert("撤销成功！");
							}else if(data=='fail'){
								alert("所要撤销的问卷不存在！请刷新！");
							}else{
								alert("程序异常！请联系管理员！");
							}
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		function updateTemp(id){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>questionnaireTemp/goUpdateTemp.do?questionId='+id;
			 diag.Width = 850;
			 diag.Height = 655;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		function deleteAllTempByQuestionnaireId(id){
			bootbox.confirm("是否删除该问卷？", function(result) {
				if(result){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>questionnaireTemp/deleteAllTempByQuestionnaireId.do?questionId='+id,
				    	//data: {allBatchId:allBatchId},
						//dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if(data=='success'){
								alert("删除成功！");
							}else if(data=='fail'){
								alert("所要删除的问卷不存在！请刷新！");
							}else{
								alert("程序异常！请联系管理员！");
							}
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		</script>
		
	</body>
</html>


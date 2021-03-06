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
	<script type="text/css" src="static/css/font-awesome.min.css"></script>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%>
	<style>
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
			<form action="recConf/configure.do?id=z136" method="post" name="Form" id="Form">
			<table>
				<tr>
					<c:if test="${!empty hospitalCodeStr }">
						<td width="10%;">请选择医院名称：</td>
						<td >
							<select class="chosen-select form-control" name="hosipitalId"  onchange="changeHospitalCode(this)"  id="hosipitalId" style="vertical-align:top;width:98%;" >
							　 <c:forEach items="${getHosName}" var="mymap" >
								<c:if test="${mymap.key eq hosipitalId}">
									<option value="${mymap.key}" selected="true">${mymap.value }</option>
								</c:if>
								<c:if test="${mymap.key ne hosipitalId}">
									<option value="${mymap.key}" >${mymap.value }</option>
								</c:if>
							　 </c:forEach>
							</select>
						</td>
					</c:if>
					<td width="10%;">请选择接口名称：</td>
					<td  >
						<c:if test="${empty hospitalCodeStr }">
							<input  name="hosipitalId" value="${pd.hosipitalId }" type="hidden"/>
						</c:if>
						<select class="chosen-select form-control" name="interType" id="select" data-placeholder="请选择接口名称" style="vertical-align:top;width:98%;" >
						　 <c:forEach items="${interMap}" var="mymap" >
								<c:if test="${mymap.key eq interType}">
									<option value="${mymap.key}" selected="selected">${mymap.value }</option>
								</c:if>
								<c:if test="${mymap.key ne interType}">
									<option value="${mymap.key}" >${mymap.value }</option>
								</c:if>
						　 </c:forEach>
						</select>
					</td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
				</tr>
			</table>
			
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">字段名称</th>
						<th class="center">显示名称</th>
						<th class="center">所属医院</th>
						<th class="center">是否显示在页面</th>
						<th class="center">排序</th>
						<th class="center">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.CONFIGURE_ID}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td class="center" style="width: 250px;">${var.FIELD_NAME}</td>
								<td class="center" style="width: 60px;">${var.LABEL}</td>
								<td class="center"style="width: 60px;">${var.HOSIPITAL_NAME}</td>
								<td class="center" style="width: 60px;">
								<c:if test="${var.IS_SHOW == 1 }">是</c:if>
								<c:if test="${var.IS_SHOW == 2 }">否</c:if>
								</td>
								<td style="width: 60px;" class="center">
									<c:if test="${var.FIELD_ORDER > 1 }">
										<a href="javascript:goUpOrder('${var.CONFIGURE_ID}','${var.HOSIPITAL_ID}','${var.FIELD_ORDER-1}');" title="上移"><i class="icon-arrow-up"></i></a>
									</c:if>
									&nbsp;
									<c:if test="${var.FIELD_ORDER < csize }">
										<a href="javascript:goDownOrder('${var.CONFIGURE_ID}','${var.HOSIPITAL_ID}','${var.FIELD_ORDER}');" title="下移"><i class="icon-arrow-down"></i></a>
									</c:if>
								</td>
								<td style="width: 60px;" class="center">
									<c:if test="${QX.edit == 1 }">
									<a href="javascript:goEdit('${var.CONFIGURE_ID}');" title="编辑内容"><i class="icon-edit"></i></a>
									</c:if>
									&nbsp;
									<c:if test="${QX.del == 1 }">
										<c:if test="${var.IS_SHOW == 1 }">
											<a style="cursor:pointer;" title="不在页面显示" onclick="updateSta('${var.CONFIGURE_ID}','${var.IS_SHOW}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a>
										</c:if>
										<c:if test="${var.IS_SHOW == 2 }">
											<a style="cursor:pointer;" title="在页面显示" onclick="updateSta('${var.CONFIGURE_ID}','${var.IS_SHOW}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-ok"></i></span> </a>
										</c:if>
									</c:if>
									<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
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
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>				
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
						<a class="btn btn-small btn-success" onclick="add(${csize+1});">新增</a>
					</c:if>
					<%-- <c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
					</c:if> --%>
					<!-- <a class="btn btn-small btn-success" onclick="importExcle();">导入</a> -->
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
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
			
			//将选中的值存入cookie
			function setCookie(name,value){
				var Days = 30;
				var exp = new Date();
				exp.setTime(exp.getTime()+Days*24*60*60*1000);
				document.cookie = name+"="+escape(value)+";expirse="+exp.toGMTString();
			}
			
			// 从cookie中取值
			function getCookie(name){
				var arr,reg = new RegExp("(^|)"+name+"=([^;]*)(;|$)");
				if(arr=document.cookie.match(reg))			
					return unescape(arr[2]);
				else
					return null;
			}
			$(function(){
				/* var interType = getCookie("interType");
				$(".form-control").val(interType); */
			})
			//检索
			function search(){
				top.jzts();
				$("#Form").submit();
			}
			
			//新增
			function add(id){
				 //var interType = getCookie("interType");
				 var interType="${interType}";//$("#interType").val();
				 var hosipitalId="${hosipitalId}";//$("#hosipitalId").val();
				 top.jzts();
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="新增";
				 diag.URL = '<%=basePath%>recConf/goAdd.do?fieldOrder='+id+'&interType='+interType+'&hosipitalId='+hosipitalId;
				 diag.Width = 350;
				 diag.Height = 360;
				 diag.CancelEvent = function(){ //关闭事件
					 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
						 if('${page.currentPage}' == '0'){
							 top.jzts();
							 setTimeout("self.location=self.location",100);
						 }else{
							 nextPage(${page.currentPage});
						 }
					}
					diag.close();
				 };
				 diag.show();
			}
			
			// 上移排序
			function goUpOrder(cid,hid,oid){
				$.ajax({
					url:'<%=basePath%>recConf/goUpOrder.do',
					type:"post",
					data:{'configId':cid,'hosipitalId':hid,'fieldId':oid},
					async:false,
					success:function(data){
						if(data=="success"){
							top.jzts();
							$("#Form").submit();
						}else{
							alert("修改顺序失败！");
						}
					}
				});
			}
			
			// 下移排序
			function goDownOrder(cid,hid,oid){
				$.ajax({
					url:'<%=basePath%>recConf/goDownOrder.do',
					type:"post",
					data:{'configId':cid,'hosipitalId':hid,'fieldId':oid},
					async:false,
					success:function(data){
						if(data=="success"){
							top.jzts();
							$("#Form").submit();
						}else{
							alert("修改顺序失败！");
						}
					}
				});
			}
			
			// 编辑
			function goEdit(cid){
				 top.jzts();
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="编辑";
				 diag.URL = '<%=basePath%>recConf/goEdit.do?configId='+cid;
				 diag.Width = 270;
				 diag.Height = 300;
				 diag.CancelEvent = function(){ //关闭事件
					 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
						 if('${page.currentPage}' == '0'){
							 top.jzts();
							 setTimeout("self.location=self.location",100);
						 }else{
							 nextPage(${page.currentPage});
						 }
					}
					diag.close();
				 };
				 diag.show();
			}
			
			// 置为不在页面显示
			function updateSta(cid,isShow){
				$.ajax({
					url:'<%=basePath%>recConf/updateStatus.do',
					type:"post",
					data:{'configId':cid,'isShow':isShow},
					async:false,
					success:function(data){
						if(data=="success"){
							top.jzts();
							$("#Form").submit();
						}else{
							alert("修改状态失败！");
						}
					}
				});
			}
			function changeHospitalCode(obj){
				var hospitalCode=obj.value;
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
						var  interfaceCode="${pd.interType}";
						for(var i=0;i<dataStr.length;i++){
							if(interfaceCode==dataStr[i].key){
								html+="<option selected='true' value="+dataStr[i].key+">"	+dataStr[i].value+"</option>";		
							}else{
								html+="<option value="+dataStr[i].key+">"	+dataStr[i].value+"</option>";		
							}
						}
						$("#select").html(html);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown){
						$("#select").html('');
						alert('数据获取异常');    
					}
				});
			}
			$(function() {
		      if("${hospitalCodeStr}" !=null && "${hospitalCodeStr}" !=''){
		    	  $('#hosipitalId').change();
		      }
			});
		</script>
	</body>
</html>


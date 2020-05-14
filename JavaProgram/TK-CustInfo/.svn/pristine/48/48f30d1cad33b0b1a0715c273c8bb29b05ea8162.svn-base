<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<!-- <link rel="stylesheet" href="../static/ztree/css/demo.css" type="text/css"> -->
	<link rel="stylesheet" href="../static/ztree/css/zTreeStyle.css" type="text/css">
			<script type="text/javascript" src="../static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="../static/ztree/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="../static/ztree/js/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="../static/ztree/js/jquery.ztree.exedit.js"></script>
	<SCRIPT type="text/javascript">
		var setting = {
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeDrag: beforeDrag,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onNodeCreated: zTreeOnNodeCreated,
				onRename: zTreeOnRename,
				beforeClick: function(treeId, treeNode) {
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					if (treeNode.isParent) {
						/* zTree.expandNode(treeNode);
						return false; */
						demoIframe.attr("src","../"+"linkagePullData/lookDetailForLinkageId?linkageId="+treeNode.id );
						return true;
					} else {
						demoIframe.attr("src","../"+"linkagePullData/lookDetailForLinkageId?linkageId="+treeNode.id );
						return true;
					}
				}
			},
			check: {
				enable: true,
				chkStyle: "checkbox",
				chkboxType: { "Y": "ps", "N": "ps" }
			}
		};
		
		var zNodes =${strData};
		var log, className = "dark";
		function beforeEditName(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			setTimeout(function() {
				if (confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？")) {
					setTimeout(function() {
						zTree.editName(treeNode);
					}, 0);
				}
			}, 0);
			return false;
		}
		function beforeRemove(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
		}
		function onRemove(e, treeId, treeNode) {
			showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			//alert(treeNode.id);
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>linkagePullData/deleteLinkagePullData.do?tm='+new Date().getTime(),
			    	data: {linkageId:treeNode.id},
					//dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						//alert(data);
					}
				});
		}
		function beforeRename(treeId, treeNode, newName, isCancel) {
			className = (className === "dark" ? "":"dark");
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
			if (newName.length == 0) {
				setTimeout(function() {
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					zTree.cancelEditName();
					alert("节点名称不能为空.");
				}, 0);
				return false;
			}
			return true;
		}
		function showRemoveBtn(treeId, treeNode) {
			//获取节点所配置的noRemoveBtn属性值
			return true;
		}
		function showRenameBtn(treeId, treeNode) {
			//获取节点所配置的noEditBtn属性值
			return true;
		}
		function showLog(str) {
			if (!log) log = $("#log");
			log.append("<li class='"+className+"'>"+str+"</li>");
			if(log.children("li").length > 8) {
				log.get(0).removeChild(log.children("li")[0]);
			}
		}
		function getTime() {
			var now= new Date(),
			h=now.getHours(),
			m=now.getMinutes(),
			s=now.getSeconds(),
			ms=now.getMilliseconds();
			return (h+":"+m+":"+s+ " " +ms);
		}

		var newCount = 1;
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"new node" + (newCount++)});
				return false;
			});
		};
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};
		function selectAll() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#selectAll").bind("click", selectAll);
			$("#addParent").bind("click", {isParent:true}, addParent);
			$("#addLeaf").bind("click", {isParent:false}, add);
			$("#edit").bind("click", edit);
			$("#remove").bind("click", remove);
			$("#clearChildren").bind("click", clearChildren);
			demoIframe = $("#testIframe");
			demoIframe.bind("load", loadReady);
		});
		function loadReady() {
			var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
			htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
			maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
			h = demoIframe.height() >= maxH ? minH:maxH ;
			if (h < 530) h = 530;
			demoIframe.height(h);
		}
		var newCount = 1;
		function add(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			isParent = e.data.isParent,
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (treeNode) {
				treeNode = zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)});
			} else {
				treeNode = zTree.addNodes(null, {id:(100 + newCount), pId:0, isParent:isParent, name:"new node" + (newCount++)});
			}
			if (treeNode) {
				zTree.editName(treeNode[0]);
			} else {
				alert("叶子节点被锁定，无法增加子节点");
			}
		};
		function addParent(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			isParent = e.data.isParent,
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			treeNode = zTree.addNodes(null, {id:(100 + newCount), pId:0, isParent:isParent, name:"new node" + (newCount++)});
			if (treeNode) {
				zTree.editName(treeNode[0]);
			} else {
				alert("叶子节点被锁定，无法增加子节点");
			}
		};
		//清空子节点的方法。相当于批量删除
		function clearChildren(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0 || !nodes[0].isParent) {
				alert("请先选择一个父节点");
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>linkagePullData/deleteAllLinkagePullData.do?tm='+new Date().getTime(),
			    	data: {linkageId:treeNode.id},
					//dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						//alert(data);
						if(data=="success"){
							zTree.removeChildNodes(treeNode);
						}else{
							alert("删除失败！请联系管理员");
							return;
						}
					}
				});
			
		};
		function edit() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				alert("请先选择一个节点");
				return;
			}
			zTree.editName(treeNode);
		};
		function remove(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				alert("请先选择一个节点");
				return;
			}
			var callbackFlag = $("#callbackTrigger").attr("checked");
			zTree.removeNode(treeNode, callbackFlag);
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>linkagePullData/deleteLinkagePullData.do?tm='+new Date().getTime(),
			    	data: {linkageId:treeNode.id},
					//dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						//alert(data);
					}
				});
		};
		function beforeDrag(treeId, treeNodes) {
			return false;
		}
		$(top.hangge());
		//添加之后的回调函数
		function zTreeOnNodeCreated(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
		    if(newCount !=1 ){
		    	var name= treeNode.name;
			    var parentId=treeNode.pId;
			    var isParent=treeNode.isParent;
			   // alert(name+"-----"+parentId+"======="+isParent);
			    $.ajax({
					type: "POST",
					url: '<%=basePath%>linkagePullData/saveLinkagePullData.do?tm='+new Date().getTime(),
			    	data: {parentId:parentId,name:name,isParent:isParent},
					//dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						//alert(data);
						if(data=="fail"){
							alert("添加失败！请联系管理员！");
							return;
						}else{
							treeNode.id=data;
							//alert(treeNode.id+"------"+data);
						}
					}
				});
		    }
		}
		//用于捕获节点编辑名称结束之后的事件回调函数。
		function zTreeOnRename(event, treeId, treeNode, isCancel) {
			//alert(treeNode.tId + ", " + treeNode.name);
			//updateLinkagePullData
			var linkageId=treeNode.id;
			var name= treeNode.name;
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>linkagePullData/updateLinkagePullData.do?tm='+new Date().getTime(),
			    	data: {linkageId:linkageId,linkageName:name},
					//dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						//alert(data);
					}
				});
		}
		var demoIframe;
	</SCRIPT>
	<style type="text/css">
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
body {
	background-color: white;
	margin:0; padding:0;
	text-align: center;
	}
	div, p, table, th, td {
		list-style:none;
		margin:0; padding:0;
		color:#333; font-size:12px;
		font-family:dotum, Verdana, Arial, Helvetica, AppleGothic, sans-serif;
	}
	#testIframe {margin-left: 10px;}
	a {color:#3C6E31;text-decoration: underline;}
	a:hover {background-color:#3C6E31;color:white;}
	a{
	margin: 0;padding: 0;border: 0;outline: 0;font-weight: inherit;font-style: inherit;font-size: 100%;font-family: inherit;vertical-align: baseline;}
	</style>
</HEAD>
<BODY>
			
		<TABLE border=0 height=600px align=left>
			<TR>
				<TD width=260px align=left valign=top style="BORDER-RIGHT: #999999 1px dashed">
					<div valign=top>
						[ <a id="addParent" href="#" title="增加父节点" onclick="return false;">增加父节点</a> ]
						[ <a id="addLeaf" href="#" title="增加叶子节点" onclick="return false;">增加叶子节点</a> ]
						[ <a id="edit" href="#" title="编辑名称" onclick="return false;">编辑名称</a> ]<br/>
						[ <a id="remove" href="#" title="删除节点" onclick="return false;">删除节点</a> ]
						[ <a id="clearChildren" href="#" title="清空子节点" onclick="return false;">清空子节点</a> ]<br/>
					</div>
					<div>
						<ul id="treeDemo" class="ztree" style="width:260px; overflow:auto;"></ul>
					</div>
				</TD>
				<TD align=left valign=top>
					<div>
					<!-- 	<IFRAME ID="testIframe" Name="testIframe" FRAMEBORDER=0 SCROLLING=auto width=100%   SRC="linkagePullData/list">
						</IFRAME> -->
						<iFRAME ID="testIframe" Name="testIframe" FRAMEBORDER=0 SCROLLING=auto width=740px   SRC="" >
						</iFRAME> 
					</div>
					
				</TD>
			 </TR>
		</TABLE>
		
</BODY>
</HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=750,maximum-scale=1.0,user-scalable=0">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no,email=no" name="format-detection">
    <meta content="" name="description"/>
    <meta content="" name="keywords"/>
    <title></title>
    <!-- Bootstrap -->
    <link href="../static/weixin/css/bootstrap.css" rel="stylesheet">
    <link href="../static/weixin/css/order_style.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="../static/weixin/js/html5shiv.min.js"></script>
    <script src="../static/weixin/js/respond.min.js"></script>
    <![endif]-->
</head>
<body onload="clearCookie();">
<div class="main">
    <div class="div_bg01">
        <img class="bg_img" src="../static/weixin/img/bg02.jpg"/>
    </div>
    <div class="lose_div01">
    	<c:if test="${questionnaireData == null }">
		    	<p class="lose_p1">该问卷  已过期或者被删除！</p>
    	</c:if>
    	<c:if test="${questionnaireData !=null }">
    		<c:if test="${validState==0 }">
    			<p class="lose_p1">该问卷无效</p>
    		</c:if>
    		<c:if test="${validState!=0 }">
	    		<p class="lose_p1">该问卷处于
	    			<c:forEach var="item" items="${ releaserStatusMap}">
	    				<c:if test="${data.releaseStatus eq item.key}">
							${item.value }
						</c:if>
	    			</c:forEach>
	    			状态！
	    		</p>
    		</c:if>
    	</c:if>
        <p class="lose_p1">感谢参与！</p>
    </div>
    <div class="lose_data">
	    <div style="margin-top:10%" class="container" >
	        <button class="btn btn_lose" id="close" onclick="save()">确定</button>  
	    </div>
    </div>
    <div class="foot_data">www.taikangzhijia.com</div>
</div>
<script src="../static/weixin/js/jquery-1.11.3.js"></script>
<script src="../static/weixin/js/bootstrap.js"></script>
<script src="../static/weixin/js/order.js"></script>
<script>
function save(){
WeixinJSBridge.call('closeWindow');
}
//清楚上个页面的cookie
function clearCookie(){
	var keys = document.cookie.match(/[^ =;]+(?=\=)/g);  
    if(keys) {  
        for(var i = keys.length; i--;)  
            document.cookie = keys[i] + '=0;expires=' + new Date(0).toUTCString()  
    }  
}
</script>
</body>
</html>
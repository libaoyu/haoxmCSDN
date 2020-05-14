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
<body>
<div class="main">
    <div class="div_bg01">
        <img class="bg_img" src="../static/weixin/img/bg02.jpg"/>
    </div>
    <div class="lose_div01">
       <!--  <p class="lose_p1">非常抱歉！</p> -->

        <p class="lose_p3">此问卷已提交一次！</p>
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
<script>
function save(){
	try{
		WeixinJSBridge.call('closeWindow');
	}catch(err){
		//alert("出错了！");
		window.close();
		
	}
}
</script>
</body>
</html>
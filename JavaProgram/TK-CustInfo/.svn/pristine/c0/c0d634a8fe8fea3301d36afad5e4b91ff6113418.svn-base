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
    <style>
    	body {
   	 		background: url(../static/weixin/img/bg01.jpg) no-repeat;
    		width: 100%;
   	 		background-color: #55B339;
		}
    </style>
</head>
<body>
<div class="main">
    <!-- <div class="div_bg01">
        <img class="bg_img" src="../static/weixin/img/bg01.jpg"/>
    </div> -->
    <img class="logo_img" src="../static/weixin/img/logo.png">
	<form action="<%=basePath %>weixin/userInfo.do" method="POST" name="form" id="form" >
    <div style="margin-top: 10%" class="container-fluid">
        <div class="in_data">
            <input class="date_write01" id="idCard" type="text" name="idCard" placeholder="输入您的身份证/员工编号/护照"/>
            <img class="date_img" src="../static/weixin/img/id.png"/>
        </div>
        <div class="in_data">
            <input class="date_write01" id="name" type="text" name="name" placeholder="请输入您的姓名"/>
            <img class="date_img" src="../static/weixin/img/name.png"/>
        </div>
        <div class="in_data">
            <input class="date_write01" id="phone" type="text" name="phone"  placeholder="请输入您的手机号码"/>
            <img class="date_img" src="../static/weixin/img/phone.png"/>
            <input type="text" style="display:none" name="openId" value="<%=request.getParameter("openId") %>"/>
        </div>
        <a onclick="submit()" style="background: #0C9344" class="btn btn_order">立即预约</a>
    </div>
    </form>
    <div class="foot_data">www.taikangzhijia.com</div>
</div>
<script src="../static/weixin/js/jquery-1.11.3.js"></script>
<script src="../static/weixin/js/bootstrap.js"></script>
<script src="../static/weixin/js/order.js"></script>
<script>
	function submit(){
		var idCard = $("#idCard").val();
		var name = $("#name").val();
		var phone = $("#phone").val();
		
		var testPhone = /^0?1[3|4|5|8][0-9]\d{8}$/;
		 var testId = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/ ;
		if(testId.test(idCard) === false){
			alert("身份证格式有误");
			return
		} 
		if(testPhone.test(phone) === false){
			alert("手机号格式有误");
			return
		}
		if(idCard === null || idCard == ''){
			alert("证件号不能为空");
			return
		}
		if(name === null || name == ''){
			alert("姓名不能为空");
			return
		}
		$("#form").submit();
	}
</script>
</body>
</html>
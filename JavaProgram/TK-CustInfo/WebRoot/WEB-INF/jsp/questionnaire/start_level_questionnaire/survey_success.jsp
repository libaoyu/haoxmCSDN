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
    <link rel="stylesheet" href="../static/css/font-awesome.css">
    <link rel="stylesheet" href="../static/css/expressEva.css">
    <title>服务评价</title>
    <style>
        .success_header {
            height: 60px;
            background: #eee;
            line-height: 60px;
            text-align: center;
            font-size: 20px;
        }
        .success_logo{
            
            height: 70px;
            text-align: center;
            margin: 50px auto;
        }
        .success_logo span{
            display: block; 
            margin-top: 20px;
        }
        .already_sub{
        	height: 70px;
            text-align: center;
            margin: 50px auto;
        }
    </style>
</head>

<body>
    <div class="container">

        <div class="success_header">
            泰康仙林鼓楼医院
        </div>
        <c:if test="${isAdd == 2 }">
        <div class="success_logo">
            <img src="../static/images/evaSuccess_logo.png" alt="">
            <span>感谢您的评价！</span>
        </div>
        </c:if>
		<c:if test="${isAdd == 1 }">
			<div class="already_sub">
		          	此问卷已评价过！
		    </div>
	    </c:if>
	    <c:if test="${isAdd == 3 }">
			<div class="already_sub">
		          	获取问诊数据失败！
		    </div>
	    </c:if>
    </div>
     <div class="lose_data">
        <ul class="">
            <li>
                <p class="lose_p2">提交成功</p>
            </li>
        </ul>
	    <div style="margin-top:10%" class="container" >
	        <button class="btn btn_lose" id="close" onclick="save()">确定</button>  
	    </div>
    </div>
</body>
<script src="../static/js/jquery-1.11.3.js"></script>
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

</html>
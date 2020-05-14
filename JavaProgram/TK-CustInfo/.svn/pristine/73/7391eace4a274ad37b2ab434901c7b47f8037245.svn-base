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
    <meta name="viewport" content="width=750">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no,email=no" name="format-detection">
    <meta content="" name="description"/>
    <meta content="" name="keywords"/>
    <link href="../static/question/css/order_style.css" rel="stylesheet">
    <link href="../static/question/css/bootstrap.css" rel="stylesheet">
    <style>
        /*        body {
                    background: url(../img/bg02.png) no-repeat;
                    width: 100%;
                    background-color: #55B339;
                }*/
        body {
            background: url(../static/img/bg02.png) no-repeat;
            width: 100%;
            background-color: #55B339;
            background-size: 100% 100%;
            background-position: center;
            background-attachment: fixed;
        }
        
         body:before {
            content: ' ';
            position: fixed;
            z-index: -1;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: url(../static/img/bg02.png) center 0 no-repeat;
            background-size: cover;
        }
    </style>
</head>
<body onload="clearCookie();">
<div class="main">
    <div class="container-fluid">
        <div>
        	<!-- 
            <img id="audio_btn" class="rotate description_img04" src="../static/img/m01.png">
             -->
        </div>
        <div style="position: relative;margin-top: 30%;">
            <div class="th_div">
               ${data.markedWords }
            </div>
        </div>
        <button class="tan_btn2"  onclick="save()">确定</button>
    </div>
    <div class="foot_data font_color">www.taikangzhijia.com</div>
</div>

<script src="../static/weixin/js/jquery-1.11.3.js"></script>
<script src="../static/weixin/js/bootstrap.js"></script>
   <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
   	<script type="text/javascript" src="../static/js/jquery.cookie.js"></script>
<script>
	/*
    var x = document.getElementById("media");
    $(function () {
        $("#audio_btn").click(function () {
            $(this).toggleClass("rotate"); //控制音乐图标 自转或暂停

            //控制背景音乐 播放或暂停
            if ($(this).hasClass("rotate")) {
                x.play();
                
            } else {
                x.pause();
            }
        */
            //--创建触摸监听，当浏览器打开页面时，触摸屏幕触发事件，进行音频播放
           /*  document.addEventListener('touchstart', function () {
                function audioAutoPlay() {
                    var audio = document.getElementById('media');
                        if (audio.paused) {
                        	audio.play();
            			}
                }
                audioAutoPlay();
            }); */
         /*   
        })
    });*/
  //--创建页面监听，等待微信端页面加载完毕 触发音频播放
  /*
    document.addEventListener('DOMContentLoaded', function () {
        function audioAutoPlay() {
            var audio = document.getElementById('media');
                audio.play();
            document.addEventListener("WeixinJSBridgeReady", function () {
                audio.play();
            }, false);
        }
        audioAutoPlay();
    }); */
    /* function isWeiXin(){ 
    	var ua = window.navigator.userAgent.toLowerCase(); 
    	if(ua.match(/MicroMessenger/i) == 'micromessenger'){ 
    	return true; 
    	}else{ 
    	return false; 
    	} 
    	}  */
    function save(){
    	//alert(isWeiXin());
    	try{
    		WeixinJSBridge.call('closeWindow');
    	}catch(err){
    		//alert("出错了！");
    		window.location.href="about:blank";
    		window.close();
    	}
    	
   	}
    	//清楚上个页面的cookie
    	function clearCookie(){
    		var keys = document.cookie.match(/[^ =;]+(?=\=)/g);  
    	    if(keys) {  
    	        for(var i = keys.length; i--;)  
    	            document.cookie = keys[i] + '=0;expires=' + new Date(0).toUTCString()  
    	    } 
    	    var cookieVlaue="${cookieVlaue}";
    	    $.cookie(cookieVlaue,cookieVlaue,{expires:7});
    	}

   
</script>
</body>
</html>
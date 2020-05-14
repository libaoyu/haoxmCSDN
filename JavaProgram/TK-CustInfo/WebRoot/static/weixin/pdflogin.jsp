<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
	<title>体检结果</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../static/weixin/css/pdfbootstrap.css" rel="stylesheet">
    <style>
        a:focus { outline: none;text-decoration: none;}
        .navigation {
            width: 100%;
            height: 50px;
            line-height: 50px;
            margin: 0 auto;
            background: #73B42C;
            font-weight: 500;
            text-align: center;
        }
        .logo_p1 {
            color: #fff;
            font-size: 1.87rem;
            display: inline-block;
            font-weight: bold;
        }
        .main {
            padding-top: 5.4rem;
        }
        .enroll_a1 {
            height: 40px;
            line-height: 40px;
            color: #73B42C !important;
            text-align: center;
            border: 1px solid #73B42C;
            display: inline-block;
            font-size: 1.5rem;
            z-index: 111;
            border-radius: 5px;
        }
        .login_a1 {
            background: #73B42C;
            /* height: 40px; */
            line-height: 4rem;
            display: inline-block;
            width: 100%;
            color: #fff !important;
            font-size: 1.87rem;
            border-radius: 5px;
            border: 0;
            margin-top: 0.5rem;
        }
        /*模态框*/
        .abolish {
            border: 1px solid #e5e5e5;
            border-radius: 6px;
            color: #999;
            background: #fff;
            padding: 3% 13%;
        }
        .ensure {
            border: 1px solid #e5e5e5;
            border-radius: 6px;
            color: #999;
            background: #fff;
            padding: 3% 13%;
            /* margin-right: 5%; */
        }
    </style>
</head>
<body>
<div class="navbar navbar-fixed-top">
    <div class="container-fluid">
        <div class="navigation container">
            <p class="logo_p1">泰康人寿</p>
        </div>
    </div>
</div>
<div class="main" style="margin-top:15px">
    <div class="container">
        <form action="<%=basePath %>weixin/VerifyCode" method="POST" name="form" id="FORM" >
        <div class="form-group">
            <input id="phone" name="phone" style="height: 40px;font-size: 1.2em" type="text" class="form-control" placeholder="请输入手机号">
        </div>
        <input id="code" name="code" style="width: 63%;display: inline-block;height:40px;font-size: 1em;margin-bottom: 15px" type="text" class="form-control" placeholder="请输入手机号验证码">
        <a id="getCode" href="javascript:void(0)" style="width: 33%;margin-left:2.5% " class="enroll_a1">获取验证码</a>
        <a  data-toggle="modal" id="showError"  data-target="#id_number" href="javascript:void(0)" style="width: 33%;margin-left:2.5%;display:none" class="enroll_a1">获取验证码</a>
        <div class="c1"></div>
        <!--<p class="enroll_p1">注册即视为同意<span class="enroll_span01">《使用条款和协议》</span></p>-->
        <a class="login_a1 text-center" href="#"onclick="dateUp()">提交信息</a>
        </form>
    </div>
</div>
<!--填写模态框-->
<div id="id_number" class="modal fade"> <!--最底层的半透明遮罩-->
    <div style="width: 80%;margin:50% auto" class="modal-dialog"> <!--用于设定宽高、定位-->
        <div class="modal-content"> <!--背景、边框、倒角-->
            <div style="border-bottom: 1px solid transparent;margin-bottom: -5%" class="modal-header">
                <!--<button data-dismiss="modal" class="close" type="button">&times;</button>-->
                <h4 style="color: #333;" class="modal-title text-center">提示信息</h4>
            </div>
            <div class="modal-body">

                <!--<form action="">-->
                    <div class="form-group text-center">
                        <!--<label for="uname">用户名：</label>-->
                        <!--<input class="form-control" placeholder="请输入18位身份证号码">-->
                        <p style="color: #999;">此手机号没有体检信息</p>
                    </div>
                <!--</form>-->
            </div>
            <div style="border-top: 1px solid transparent;text-align: center;margin-top: -10%" class="modal-footer">
                <!--<button data-dismiss="modal" class="abolish" type="button">取消</button>-->
                <button data-dismiss="modal" class="ensure" type="button">确定</button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="../static/weixin/js/jquery-1.11.3.js"></script>
<script src="../static/weixin/js/bootstrap.js"></script>
<script>
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone","SymbianOS", "Windows Phone", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    if(window.screen.width>=768){
         flag = true;
    }
    return flag;
}

var testPhone = /^0?1[3|4|5|8][0-9]\d{8}$/;
var phone;
	$("#phone").blur(function (){
		phone = $("#phone").val();
		if(testPhone.test(phone) === false){
			alert("手机号格式有误");
			return
		}
		$.ajax({ 
			url: "<%=basePath%>/weixin/pdfCheckInfo?phone="+phone,
			type: "POST",
			dataType:'json',
			cache: false,
			success: function(data){
		    if(data.result != "success"){
		    	$("#showError").click();
		    }else{
		    	$("#getCode").attr("onclick","sendCode(this)");
		    }
		}});
	})
	var clock = '';
 	var nums = 60;
 	var btn;
 	function sendCode(thisBtn){ 
 		$.ajax({ 
			url: "<%=basePath%>/weixin/sendCode?phone="+phone,
			type: "POST",
			dataType:'json',
			cache: false,
			success: function(data){
		    if(data.result != "success"){
		    	alert("发送失败！");
		    }
		}});
 		btn = thisBtn;
 		btn.disabled = true; //将按钮置为不可点击
 		btn.value = nums+'秒';
 		clock = setInterval(doLoop, 1000); //一秒执行一次
 		}
 	function doLoop(){
 		nums--;
 		if(nums > 0){
 			 btn.text = nums+'秒';
 			}else{
  		clearInterval(clock); //清除js定时器
  		btn.disabled = false;
  		btn.text = '点击发送验证码';
 		nums = 10; //重置时间
 		}
 	}
 	function dateUp(){
 		$("#FORM").submit();
 	}
 		<%-- var code = $("#code").val();
 		$.ajax({ 
			url: "<%=basePath%>/weixin/VerifyCode",
			type: "POST",
			data: {phone:phone,code:code},
			dataType:'json',
			cache: false,
			success: function(data){
		    if(data.result != "success"){
		    	alert("发送失败！");
		    }
		}}); --%>
</script>
</html>
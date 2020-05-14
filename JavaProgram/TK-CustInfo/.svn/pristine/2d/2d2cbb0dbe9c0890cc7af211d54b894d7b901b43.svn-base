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
</head>

<body>
<form method="post" action="submission.do" name="Form" id="Form">
	<input type="hidden" name="recordId" value="${pd.RECORD_ID}">
	<input type="hidden" name="strIndex" value="${pd.STR_INDEX}">
	<input type="hidden" name="level" id="level" value="5">
    <div class="container">
        <div class="ex_top">
            <img src="../static/images/tkxllogo.jpg" alt="">
        </div>
        <div class="title">
            <div class="linet"></div>
            <span class="ex_top_title">服务评价</span>
        </div>

        <div class="ex_main">
            <div class="doctor_info">
                <div class="doctor_logo">
                    <span class="ex_name">${pd.EMP_NAME}<br>(<c:if test="${pd.DOCTORTYPE == null or pd.DOCTORTYPE ==''}">医师</c:if>${pd.DOCTORTYPE})</span>
                </div>
                <div class="doctor_profile">
                    <div class="doctor_text">
                        <p>科室名称：${pd.SECTION_NAME}</p>
                        <p>就诊类型：${pd.VISIT_TYPE}</p>
                        <p>患者姓名：${pd.PATIENT_NAME}</p>
                        <c:if test="${pd.VISIT_TYPE == '住院' }">
	                        <p>出院时间：${pd.VISIT_DATE}</p>
                        </c:if>
                        <c:if test="${pd.VISIT_TYPE == '门诊' }">
	                        <p>就诊时间：${pd.VISIT_DATE}</p>
	                        <p>就诊次数：${pd.TIMES}</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="ex_evaluation"><i class="line">——</i>请对医师进行评价<i class="line">——</i></div>
            <div class="ex_star">
                <i class="fa fa-star" data-star="1"></i>
                <i class="fa fa-star" data-star="2"></i>
                <i class="fa fa-star" data-star="3"></i>
                <i class="fa fa-star" data-star="4"></i>
                <i class="fa fa-star" data-star="5"></i>
            </div>
            <div class="star_infoc" >
                【您对本次服务满意吗】
            </div>
            <div class="star_info" style="display:none">
                【非常满意】
            </div>
            <div class="ex_solgan" id="three" style="display: none">
           		<c:forEach items="${pd.commonEval}" var="item">
					<span id="${item.key}" onclick="choose('${item.key}')">${item.value }</span>
				</c:forEach>
            </div>
            <div class="ex_solgan" id="four" style="display: none">
           		<c:forEach items="${pd.commonEvals}" var="item">
					<span id="${item.key}" onclick="choose('${item.key}')">${item.value }</span>
				</c:forEach>
            </div>
            <input type="hidden" name="commonEval" id="commonEval">
            <div class="comstyle" style="display:none">
            	<div class="ex_text">
	                <textarea name="evaluate" value="${pd.evaluate}" cols="83" rows="4"  placeholder="其他想说的(请留言)"></textarea>
	            </div>
	            <a href="#" onclick="sub();" class="ex_enbutton">匿名提交</a>
            </div>
            
            <div class="footer clearfix">
                <div class="footer_logo">
                	<h3 class="concat">欢迎联系我们</h3>
                    <span><i class="phone"></i>4000195522</span>
                    <span><i class="http"></i>www.xlglyy.com</span>
                    
                </div>
                <a class="QRCode">
                    <img src="../static/images/ewm.png" alt="">
                    <span class="xlwx">泰康仙林鼓楼医院<br>官方微信</span>
                </a>
            </div>
        </div>
    </div>
</form>
</body>
<script src="../static/js/jquery-1.11.3.js"></script>
<script>
	var score = [ "很不满意", "不满意", "一般", "满意", "非常满意" ];
	var num = 0, exStar = $('.ex_star'), lis = exStar.find('i'), starInfo = $('.star_info');
	var lightOn = function(num) {
		lis.each(function(index) {
			if (index < num) {
				$(this).addClass('active');
				var value = '【' + score[index] + '】';
				$('.star_infoc').css('display','none');
				$('.star_info').css('display','block');
				$('.star_info').html(value);
			} else {
				$(this).removeClass('active');
			}
		});
	}
	lightOn(num);
	 lis.on('click', function() {
		lightOn($(this).index() + 1);
	}).on('click', function() {
		$('.comstyle').css('display','block');
		// 改变星级之前的等级
		var level_before = $("#level").val();
		$("#level").val($(this).index() + 1);
		num = $(this).index() + 1;
		if (level_before<=3 && num>3) {
			$("#three").hide();
			$("#four").show();
			$("#commonEval").val("");
			str = '';
			$("#four span").removeClass('choose');
		} else if (level_before > 3 && num <= 3) {
			$("#three").show();
			$("#four").hide();
			$("#commonEval").val("");
			str = '';
			$("#three span").removeClass('choose');
		} else if (level_before > 3 && num > 3) {
			$("#three").hide();
			$("#four").show();
		} else if (level_before <= 3 && num <= 3) {
			$("#three").show();
			$("#four").hide();
		}
	});
	 exStar.on('mouseout', function() {
		lightOn(num);
	}) 
	
	var basePath = "<%=basePath%>"; 
	function sub() {
		var level = $("#level").val();
		// 去掉最后一个逗号
		var str = $("#commonEval").val();
		str = (str.substring(str.length - 1) == ',') ? str.substring(0,
				str.length - 1) : str;
		$("#commonEval").val(str);
		if (level == "") {
			alert("请选择星级！");
		} else {
			$("#Form").submit();
		}
	}

	var str = "";
	function choose(key) {
		$('#' + key).toggleClass('choosee');

		if (-1 != str.indexOf(key)) {
			// 第二次点击 则是取消掉该选项
			$('#' + key).removeClass('choosee');
			str = str.replace(key + ",", "");
		} else {
			// 添加选中样式
			$('#' + key).addClass('choosee');
			str += key + ",";
		}
		$("#commonEval").val(str);
	}
</script>

</html>
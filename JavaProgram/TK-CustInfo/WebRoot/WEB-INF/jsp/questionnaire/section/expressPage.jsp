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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/font-awesome.css">
    <link rel="stylesheet" href="../static/css/expressEva.css">
    <title>服务评价</title>
    <style>
       
    </style>
</head>
<body>
<c:if test="${status == 1 }">
	<form action="submission.do" method="post" name="Form" id="Form">
		<input type="hidden" name="recordId" value="${pd.RECORD_ID}">
		<input type="hidden" name="strIndex" value="${pd.STR_INDEX}">
		<input type="hidden" name="level" id="level">
	    <div class="container">
	        <div class="ex_top">
	            <div class="ex_top_title"><i class="fa fa-bars fa-2x icon"></i>感谢使用*****</div>
	        </div>
	        <div class="ex_main">
	            <div class="ex_noinfo">
	            	<div>科室名称:${pd.SECTION_NAME}</div>
	            	<div>类型:${pd.VISIT_TYPE}</div>
	                <div>患者姓名:${pd.PATIENT_NAME}</div>
	                <div>诊疗时间:${pd.VISIT_DATE}</div>
	                <div>就诊次数:${pd.TIMES}</div>
	                <div>患者电话:${pd.PHONE_NUMBER}</div>
	            </div>
	            <div>
	                <div class="ex_logo"></div>
	                <span class="ex_name">${pd.EMP_NAME}</span>
	            </div>
	            <div class="ex_evaluation"><i class="line">——</i>请对医生的服务进行评价<i class="line">——</i></div>
	            <div class="ex_star">
	                <i class="fa fa-star" data-star="1"></i>
	                <i class="fa fa-star" data-star="2"></i>
	                <i class="fa fa-star" data-star="3"></i>
	                <i class="fa fa-star" data-star="4"></i>
	                <i class="fa fa-star" data-star="5"></i>
	            </div>
	            <div class="star_info">
	                【非常满意】
	            </div>
	            <div class="ex_solgan" id="3" style="display: block">
	            	<c:forEach items="${pd.commonEval}" var="item">
						<span id="${item.key}" onclick="choose('${item.key}')">${item.value }</span>
					</c:forEach>
					<input type="hidden" name="commonEval" id="commonEval">
	            </div>
	            <div class="ex_text"> 
	                <textarea name="evaluate" value="${pd.evaluate}" cols="83" rows="4" placeholder="总体不错，继续加油!"></textarea>
	            </div>
	            <a href="#" onclick="sub();" class="ex_enbutton">确认</a>
	        </div>
	    </div>
    </form>
</c:if>
<c:if test="${status == 2 }">
	获取问诊数据失败！
</c:if>
</body>
<script src="../static/js/jquery-1.11.3.js"></script>
<script>
    var score = ["很不满意", "不满意", "一般", "满意", "非常满意"];
    var num=0,
        exStar = $('.ex_star'),
        lis = exStar.find('i'),
        starInfo = $('.star_info');
    var lightOn = function(num){
         lis.each(function(index){
            if (index < num) {
                $(this).addClass('active');
                var value = '【'+ score[index] + '】';
                $('.star_info').html(value);
            } else {
                $(this).removeClass('active');
            }
        });
    }
    lightOn(num);
    lis.on('mouseover',function(){
        lightOn($(this).index()+1);
    }).on('click',function(){
    	$("#level").val($(this).index()+1);
        num = $(this).index()+1;
    });
    exStar.on('mouseout',function(){
        lightOn(num);
    })
    
    function sub(){
    	var level = $("#level").val();
    	// 去掉最后一个逗号
    	var str = $("#commonEval").val();
    	str=(str.substring(str.length-1)==',')?str.substring(0,str.length-1):str;
    	$("#commonEval").val(str);
    	
    	if(level==""){
    		alert("请选择星级！");
    	}else{
    		$("#Form").submit();
    	}
    	
    }
    
    var str = "";
    function choose(key){
    	if(-1!=str.indexOf(key)){
    		$('#'+key).removeClass('choose');
    		// 第二次点击 则是取消掉该选项
    		str = str.replace(key+",","");
    	}else{
    		// 添加选中样式
    		$('#'+key).addClass('choose');
    		str+=key+",";
    	}
    	$("#commonEval").val(str);
    }
   
</script>

</html> 
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/font-awesome.css">
    <link rel="stylesheet" href="../static/css/expressEva.css">
    <title>服务评价</title>
    <style>
       
    </style>
</head>
<body>
    <div class="container">
        <div class="ex_top">
            <div class="ex_top_title"><i class="fa fa-bars fa-2x icon"></i>感谢使用****</div>
        </div>
        <div class="ex_main">
            <div class="ex_noinfo">
                <div>科室名称:${detail.SECTION_NAME}</div>
            	<div>类型:${detail.VISIT_TYPE}</div>
                <div>患者姓名:${detail.PATIENT_NAME}</div>
                <div>诊疗时间:${detail.VISIT_DATE}</div>
                <div>就诊次数:${detail.TIMES}</div>
                <div>患者电话:${detail.PHONE_NUMBER}</div>
            </div>
            <div>
                <div class="ex_logo"></div>
                <span class="ex_name">${detail.EMP_NAME}</span>
            </div>
            <div class="ex_evaluation"><i class="line">——</i>请对小哥的服务进行评价<i class="line">——</i></div>
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
            <p class="resultText">${detail.EVALUATE}</p>
            <a href="#" class="ex_enbutton">确认</a>
            
        </div>
    </div>
</body>
<script src="../static/js/jquery-1.11.3.js"></script>
<script>
	 
    var score = ["很不满意", "不满意", "一般", "满意", "非常满意"];
    var exStar = $('.ex_star'),
        lis = exStar.find('i'),
        starInfo = $('.star_info');
	$(function(){
		var num = ${detail.LEVEL};
		lis.each(function(index){
            if (index < num) {
                $(this).addClass('active');
                var value = '【'+ score[index] + '】';
                $('.star_info').html(value);
            } else {
                $(this).removeClass('active');
            }
        });
	});
    /* var lightOn = function(num){
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
        num = $(this).index()+1;
    });
    exStar.on('mouseout',function(){
        lightOn(num);
    }) */
   
</script>

</html> 
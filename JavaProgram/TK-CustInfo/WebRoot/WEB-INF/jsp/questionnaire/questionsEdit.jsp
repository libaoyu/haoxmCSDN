<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="static/question/css/question.css" type="text/css"></link>
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<!-- 下拉复选框 begin -->
		<link rel="stylesheet" type="text/css" href="static/question/css/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/style.css" />
		<link rel="stylesheet" type="text/css" href="static/question/css/jquery-ui.css" />
		<script type="text/javascript" src="static/question/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="static/question/js/jquery.multiselect.js"></script> 
		<!-- 下拉复选框 end -->
		
		
		<!-- 富文本编辑器 -->
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
<style type="text/css">
		 #preview, .img, img
		 {
			 width:50px;
			 height:50px;
		 }
		 #preview
		 {
			border:1px solid #000;
			
		 }
		 .imgPreview{
		 	display:none;
		 	margin-left: 80px;
		 	margin-top: -10px;
		 	margin-bottom: 20px;
		 	
		 }
</style>		
<style type="text/css">
		 #preview, .img, img
		 {
			 width:50px;
			 height:50px;
		 }
		 #preview
		 {
			border:1px solid #000;
			
		 }
		 .imgPreview{
		 	display:none;
		 	margin-left: 80px;
		 	margin-top: -10px;
		 	margin-bottom: 20px;
		 	
		 }
</style>		
	<script type="text/javascript">
	$(function() {
		$("#MySelectBox").multiselect({
			noneSelectedText: "请选择", 
			checkAllText: "全选", 
			uncheckAllText: '全不选', 
			selectedList: 10, 
		});
		$("#MySelectBox1_0").multiselect({
			noneSelectedText: "请选择", 
			checkAllText: "全选", 
			uncheckAllText: '全不选', 
			selectedList: 10, 
		});
		$("#MySelectBox1_1").multiselect({
			noneSelectedText: "请选择", 
			checkAllText: "全选", 
			uncheckAllText: '全不选', 
			selectedList: 10, 
		});
	 	var ids = "${question.level}".split(',');        
        if (ids != null) {            
            $('#MySelectBox').val(ids);
            $('#MySelectBox').multiselect("refresh");           
        }
        $("input[id^='questionData_code_id_']").on('input',function(e){  
        	   $(this).nextAll("input").val($(this).val()); 
        }); 
        var questions = '${question.questionList}';
        if(questions!=null){
        	$("#questionsListVal").val(questions);
        }
	});
	//替换图片
	function changeImg(file,imgPathId){
		 var prevDiv = document.getElementById('preview');
		 if (file.files && file.files[0])
		 {
			 var reader = new FileReader();
			 reader.onload = function(evt){
			 	//prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
			 	$('#'+imgPathId).attr('src',evt.target.result);
			 }  
			 reader.readAsDataURL(file.files[0]);
		 }else  
		 {
			 $('#'+imgPathId).attr("style","filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src='" + file.value + "'");
		 }
	}
	//单一删除图片
	function deletePicture(ids,type){
		var id=$('#'+ids).val();
		if(id!=null && id !=''){
			var result =window.confirm("是否确认删除图片？");
			if(result) {
				var url = "<%=basePath%>questions/deletePicture.do?fileId="+id;
				$.get(url,function(data){
					if(data=='success'){
						$('#'+type).attr("src","");
						$('#'+ids).val('');
						updateFileIdList(id);
					}
					
				});
			}
		}else{
			var obj= document.getElementById(type) ; 
			obj.outerHTML=obj.outerHTML; 
			$('#'+type).attr("src","");
		}
	}
	//此节点+后台删除图片
	function deleteImg(fileId){
		if(fileId!=null && fileId!=''){
			var result =window.confirm("是否确认删除图片？");
			if(result) {
				var url = "<%=basePath%>questions/deletePicture.do?fileId="+fileId;
				$.get(url,function(data){
					updateFileIdList(fileId);
				});
			}
		}
	}
	//更新img json串
	function updateFileIdList(id){
		var questionData = $("#questionData").val();
		if(questionData!=null && questionData !=''){
			var json = JSON.parse(questionData);
			for(var i=0;i<json.length;i++){
				if(json[i].img == id){
					json.splice(i,1);
				}
			}
			$("#questionData").val(JSON.stringify(json));
		}
	}
	
	//组装隐藏数据下拉
	function showData(){
		var isshow = $("#isShow").val();
		$("#questionsListVal").val("");
		if(isshow ==1){
			var items = $("input[name='questionData_code']");
			var q = [];
			for(var i=0;i<items.length;i++){
				var n = $(items[i]).val();
				var val = $("#questionsList_"+i).val();
				var key = {"name":n,"value":val};
				q.push(key);
			}
			var questionListVal=JSON.stringify(q);
			$("#questionsListVal").val(questionListVal);
		}
		
	}
	
	
	//级别变更
	function changeLeve(obj){
		//显示选择项文本
		var array_of_checked_values = $("#MySelectBox").multiselect("getChecked").map(function(){
				return this.value; 
			}).get();
		$("#level").val(array_of_checked_values);
		oneLevelChangeByQuestionnaire($("#questionnaireId").val(),$(obj).val());
		
	}
	//字母编码
	function disabled_questionCode(isBoolean){
		if(isBoolean){
			$('#questionCode').attr('disabled','disabled');
		}else{
			$('#questionCode').removeAttr("disabled"); 
		}
	}
	//卷头时
	//量表：量表类型、范围、所属一级(上级)
	function disabled_option_content(id,isBoolean){
		if(isBoolean){
			//alert($('#option_content').children().length);
			$('#'+id).find("label").each(function (index,elementObj){
				//alert($(elementObj).html());
				$(elementObj).children().each(function (index1,elementObj1){
					$(elementObj1).attr('disabled','disabled');
				});
			});
			$('#'+id).css('display','none');
		}else{
			
			$('#'+id).find("label").each(function (index,elementObj){
				//alert($(elementObj).html());
				$(elementObj).children().each(function (index1,elementObj1){
					$(elementObj1).removeAttr("disabled");
				});
			});
			$('#'+id).css('display','block');
		}
	}
	
	//高级自定义项
	//量表：量表类型、范围、所属一级(上级)
	function disabled_userDefinedItems(isBoolean){
		if(isBoolean){
			$('#userDefinedItems').find("input").each(function (index,elementObj){
				$(elementObj).attr('disabled','disabled');
			});
		}else{
			$('#userDefinedItems').find("input").each(function (index,elementObj){
				$(elementObj).removeAttr("disabled");
			});
		}
	}
	//题型、排序、是否必填
	function disabled_option_header(isBoolean){
		//alert($('#option_header').find("select").html());
		if(isBoolean){
			$('#types').attr('disabled','disabled');
			$('#types').css('display','none');
			$('#option_header').find("label").each(function (index,elementObj){
				//alert($(elementObj).html());
				$(elementObj).children().each(function (index1,elementObj1){
					$(elementObj1).attr('disabled','disabled');
				});
			});
			$('#sort').removeAttr("disabled");
		}else{
			$('#types').removeAttr("disabled");
			$('#types').css('display','inline-block');
			$('#option_header').find("label").each(function (index,elementObj){
				//alert($(elementObj).html());
				$(elementObj).children().each(function (index1,elementObj1){
					$(elementObj1).removeAttr("disabled");
				});
			});
		}
	}
	//数据校验
	function validationData(){
		if($("#questionnaireId").val()==""){
			$("#questionnaireId").tips({
				side:3,
	            msg:'请选择所属问卷!',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#questionnaireId").focus();
			return false;
		}
		var strLevel=$("#classification").val();
		if(strLevel==""){
			$("#classification").tips({
				side:3,
	            msg:'请选择问题分类',
	            bg:'#AE81FF',
	            time:2
	            
	        });
			$("#classification").focus();
			return false;
		}
		if('L0'==strLevel){
			if($("#types").val()==""){
				$("#types").tips({
					side:3,
		            msg:'请选择或录入题型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#types").focus();
				return false;
			}
		}
		
		if('L1'==strLevel){
			if($("#questionCode").val()==""){
				$("#questionCode").tips({
					side:3,
		            msg:'请输入问题编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#questionCode").focus();
				return false;
			}
		}
		
		if('L2'==strLevel){
			if($("#types").val()==""){
				$("#types").tips({
					side:3,
		            msg:'请选择或录入题型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#types").focus();
				return false;
			}
			
			//一级分类
			var parentId=$("#parentId").val();
			if(parentId=="" || parentId==null||parentId==undefined){
				$("#parentId").tips({
					side:3,
		            msg:'请选择问题题目类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#parentId").focus();
				return false;
			}
		}
		var types=$('#types').val();
		//alert(types);
		var isEmpty=true;
		if(('L0'==strLevel||'L2'==strLevel)&&(types!=null&&types!=''&&(types=='T1'||types=='T2'||types=='T3' ||types=='T13'||types=='T14'))){
			isEmpty=checkQuestionsCode();
		}
		if(!isEmpty){
			return false;
		}
		if(types=='T13'||types=='T14'){  //校验图片题图片必传
			var optionImg = $("img[name='optionImgPath']");
			for(var i=0;i<optionImg.length;i++){
				var optionImgSrc = optionImg[i].src;
				var oi = optionImgSrc.split(".");
				if(oi.length==1 && optionImgSrc.length<100){
					$(optionImg[i]).tips({
						side:3,
			            msg:'选项图片必填',
			            bg:'#AE81FF',
			            time:2
			        });
					$(optionImg[i]).focus();
					return false;
				}
			}
		}
		//公共校验
		var questionnaireType=$("#questionnaireType").val();
		if(questionnaireType=="${QUESTIONNAIRE_TYPE_COMMON}" || questionnaireType=="${QUESTIONNAIRE_TYPE_CUSTOM_TEMPLATE}"){
			if($("#title").val()==""){
				$("#title").tips({
					side:3,
		            msg:'请输入问题题目',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#title").focus();
				return false;
			}
		}else if(questionnaireType=="${QUESTIONNAIRE_TYPE_STAR_LEVEL}"){
			var value=title.getContent();
			//alert(value);
			//T10
			//分割线题，题目非必填
			if((types != 'T10'&& types != 'T12')&&value==""){
				$("#title").tips({
					side:3,
		            msg:'请输入问题题目',
		            bg:'#AE81FF',
		            time:2
		        });
				title.focus();
				return false;
			}else{
				$('#title1').val(value);
			}
		}
		//题目
		/*  */
		
		if($("#level").val()==""){
			$("#MySelectBox_ms").tips({
				side:3,
	            msg:'请输入问题级别',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MySelectBox_ms").focus();
			return false;
		}
		//排序
		if($("#sort").val()==""){
			$("#sort").tips({
				side:3,
	            msg:'请输入问题排序',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#sort").focus();
			return false;
		}
	}
	//保存
	function save(){
		if (validationData()!=false){
			showData();
			//questionnaireId"  <c:if test="${question.questionnaireId!=null && !empty question.questionnaireId }">disabled="true"</c:if> 
			if("${question.questionnaireId!=null && !empty question.questionnaireId }"){
				$('#questionnaireId').attr("disabled",false);
			}
			setDisable(false);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	
	/**
     * 加载并解析高级自定义数据项
     */
	function fun_loadData(){
		//find('input[id^=deptsIdCmp_]')
		questionnaireChange($('#questionnaireId'));
		levelChange($('#classification'),'hidden_types');
		
		var questionData=$('#questionData').val();
		if(questionData !=undefined && questionData !=''){
			var jsonObj=eval(questionData);
			//alert(jsonObj.length);
			var items=$("input[name='questionData_name']");// 选择所有的name属性等于'keleyicom'的input元素 
			var codeItems=$("input[name='questionData_code']");
			var itemsLength=items.length;
			for(var i=0; i<jsonObj.length; i++){
				var item=$(items)[i];
				var codeItem=$(codeItems)[i];
				if(i<itemsLength){
					//alert(jsonObj[i].key+"|"+jsonObj[i].value);
					//alert($(item).attr('id')+"|"+$(codeItem).attr('id'));
					$(codeItem).val(jsonObj[i].key);
					$(item).val(jsonObj[i].value);
				}else if(item==undefined || i>=itemsLength){
					add_option_item(i,jsonObj[i].key,jsonObj[i].value);
				}
				isShowMySelectBox(i,jsonObj[i].key); //隐藏题
				isShowImg(i,jsonObj[i].imgPath,jsonObj[i].img);  //图片题
			}
			
		}
	}
	//展示图片
	function isShowImg(id,imgPath,img){
		var isShowQuestion = "${question.types}";
		if(isShowQuestion =="T13" || isShowQuestion == "T14"){
			$(".imgPreview").css("display","block");
			$("#optionImgPath_"+id).attr("src",'<%=basePath%>'+imgPath);
			$("#optionImgId_"+id).val(img);
		}
		
	}
	//展示隐藏题
	function isShowMySelectBox(id,key){
		var isShowQuestion = "${question.types}";
        var questionnaireType = "${pd.questionnaireType}";
        if(isShowQuestion == 'T1' && questionnaireType == "${QUESTIONNAIRE_TYPE_STAR_LEVEL}"){
        	$("#isShowQuestion").css("display","block");
        	var isShow = "${question.isShow}";
            if(isShow == "1"){
             	$("#isShow").attr("disabled",false);
             	var questions ='${question.questionList}';
                if(questions != null){
                	var questionsObj =  JSON.parse(questions);//转换为json对象
                	$("#MySelectBox1_"+id).multiselect({
            			noneSelectedText: "请选择", 
            			checkAllText: "全选", 
            			uncheckAllText: '全不选', 
            			selectedList: 10, 
            		});
                	var vals = questionsObj[id].value.split(',');   
                	$('#MySelectBox1_'+id).val(vals);
                	$("#questionsList_"+id).val(questionsObj[id].value);
                    $('#MySelectBox1_'+id).multiselect("refresh"); 
                    $("#questionlistdiv_"+id).css("display","block");
                }
            }
        }
	}
	
	/**
     * 自定义数据配置项
     */
	function add_option_item(index,key,value){
		var newLii = $('#optionItem').clone(); //true：深度克隆
		//alert($(newLi).html());
		$(newLii).find("input[id='questionData_code_id_0_1']").attr("id","questionData_code_id_"+index+"_1").val(key);
		$(newLii).find("input[id='questionData_name_id_0_2']").attr("id","questionData_name_id_"+index+"_2").val(value);
		$(newLii).find("div:last").attr("id","questionlistdiv_"+index);
		$(newLii).find("input[id='questionsList_0']").attr("id","questionsList_"+index);
		$(newLii).find("select").attr("id","MySelectBox1_"+index);
		$(newLii).find("button:last").remove();
		$(newLii).find("input:first").on('input',function(e){  
	      $(this).nextAll("input").val($(this).val()); 
	    }); 
		$(newLii).find("input[id='optionImgPath_0']").attr("id","optionImgPath_"+index).val("");
        $(newLii).find("input[id='optionImgId_0']").attr("id","optionImgId_"+index).val("");
        $(newLii).find("input[type='button']").attr("onclick","deletePicture('optionImgId_"+index+"','optionImgPath_"+index+"');");
        $(newLii).find("input[type='file']").attr("onchange","changeImg(this,'optionImgPath_"+index+"')");
        $(newLii).find("img").attr("id","optionImgPath_"+index);
        $(newLii).find("img").attr("src","");
		$(optionUl).append(newLii);//.querySelector('.title_Code').focus();
		$("#MySelectBox1_"+index).multiselect({
			noneSelectedText: "请选择", 
			checkAllText: "全选", 
			uncheckAllText: '全不选', 
			selectedList: 10, 
		});
        
	}
	
	/**
     * 题型分类
     * 卷头L0、一级L1、二级L2
     */
	function levelChange(obj,typesValId){
		var selectVal=$(obj).val();
		var typesVal=$('#'+typesValId).val();
		$('#types').empty();
		if('L1'==selectVal){
			disabled_questionCode(false);
			disabled_option_header(true);
			disabled_userDefinedItems(true);
			disabled_option_content('option_content',true);
			$('#typesTd').css("display","none");
			$('#mustFlag_text').css("display","none");
			$('#isRemarks_text').css("display","none");
			$('#scale_type_T4').css('display','none');
			$('#list_linkage').css('display','none');
			$('#scale_type_T2').css('display','none');
			//分割线类型               cutoffRuleArr
			$('#cutoffRuleArr').css('display','none');
			// 范围            scale_content_T11
			$('#scale_content_T11').css('display','none');
			//return false;
			//$('#types').css('display','none');
			//$('#mustFlag_text').css('display','none');
			//$('#questionList').css('display','none');
		}else{
			$('#typesTd').css("display","");
			$('#mustFlag_text').css("display","inline-block");
			$('#isRemarks_text').css("display","inline-block");
			if('L0'==selectVal){
				//字母编码
				disabled_questionCode(true);
				disabled_option_content('option_content',true);
			}else if('L2'==selectVal){
				disabled_questionCode(true);
				disabled_option_content('scale_content',true);
				disabled_option_content('option_content',false);
				$('#option_content').css('display','block');
			}
			var questionnaireType=$("#questionnaireType").val();
			$.ajax({
				type: "POST",
				url: 'questions/level_change',
		    	data: {levelOption:selectVal,tm:new Date().getTime(),questionnaireType:questionnaireType},
				dataType:'json',
				cache: false,
				success: function(data){
					var jsonObj=eval(data.result);
					for(var i=0; i<jsonObj.length; i++){
						//alert(typesVal+'|'+jsonObj[i].key);
						if(typesVal==jsonObj[i].key){
							$('#types').append("<option value='"+jsonObj[i].key+"' selected='selected'>"+jsonObj[i].value+"</option>");
						}else{
							$('#types').append("<option value='"+jsonObj[i].key+"'>"+jsonObj[i].value+"</option>");
						}
					}
					//量表
					typesChange($('#types'));
					disabled_option_header(false);
					disabled_userDefinedItems(false);
					setDisable(true);
					//是否显示相应的选项
					//$('#types').css('display','block');
					//$('#mustFlag_text').css('display','block');
					//$('#questionList').css('display','block');
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){
					alert('数据获取异常');    
				}
			});
		}
		twoNumber(selectVal);
		setDisable(true);
	}
	//新增自动填充序号
	function twoNumber(selectVal){
		var types = '${msg}';
		//新增时
		if(types=='save'){
			//题目类别自动填充
			var questionnaireId = $("#questionnaireId").val();
			var parentId;
			if("L2"==selectVal){
				parentId = $("#parentId").val();
			}
			$.ajax({
				type: 'post',
				url : 'questions/findCode.do',
				data: {questionnaireId:questionnaireId,
					parentId:parentId,
					classification :selectVal},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.key!=""){
						$('#questionCode').val(data.key);
					}
					$("#sort").val(data.sort);
				}
			});
		}
	}
	
	
	/**
	 * 获取该问卷下的所属一级分类
	 */
	function questionnaireChange(obj){
		var questionnaireId=$(obj).val();
		var levels=$("#level").val();
		$('#parentId').empty();
		$('#MySelectBox').empty();
		$('#MySelectBox').multiselect('refresh');
		$.ajax({
			type: "POST",
			url: 'questions/questionnaire_change',
	    	data: {questionnaireId:questionnaireId,levels:levels,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				var jsonObj=eval(data.result);
				var parentId="${question.parentId}";
				for(var i=0; i<jsonObj.length; i++){
					var selected='';
					if(jsonObj[i].key==parentId){
						selected='selected=true';
					}
					$('#parentId').append("<option value='"+jsonObj[i].key+"' "+selected+" >"+jsonObj[i].value+"</option>");
				}
				var jsonObj1=eval(data.respondents);
				//更新调查对象下拉复选
				for(var i=0; i<jsonObj1.length; i++){
					opt = $('<option />', {  
                        value: jsonObj1[i].key,  
                        text: jsonObj1[i].value  
                    }); 
					opt.appendTo($('#MySelectBox')); 
				}
				var ids = "${question.level}".split(',');      
		        if (ids != null) {            
		            $('#MySelectBox').val(ids);
		            $('#MySelectBox').multiselect("refresh");           
		        }
				$('#MySelectBox').multiselect('refresh');
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				$('#parentId').empty();
				$('#MySelectBox').empty();
				$('#MySelectBox').multiselect('refresh');
				alert('数据获取异常');    
			}
		});
		
	}
	
	//题型发生变化时
	function typesChange(obj){
		var selectVal=$(obj).val();
		$('#scale_type_T4').css('display','none');
		$('#scale_type_T2').css('display','none');
		//联动题隐藏
		$('#list_linkage').css('display','none');
		//问诊信息隐藏
		$('#inquiryInformationArray').css('display','none');
		//分割线类型			cutoffRuleArr
		$('#cutoffRuleArr').css('display','none');
		$('#scale_content_T11').css('display','none');
		$('#scale_type_T16').css('display','none');
		$('#scale_type_T16_scaleRange').css('display','none');
		
		//量表
		if(selectVal=='T4'){
			disabled_option_content('scale_content',false);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('cutoffRuleArr',true);
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('scale_type_T16',true);
			//意向分值
		}else if(selectVal=='T11'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('scale_type_T16',true);
			//$("#scale_type_T4").css("dis");
			//zhi
			disabled_option_content('scale_content_T11',false);
			disabled_option_content('cutoffRuleArr',true);
			$('#scale_content_T11').css('display','block');
			//
		}else if(selectVal=='T7'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('scale_type_T4',false);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			//$("#scale_type_T4").css("dis");
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('cutoffRuleArr',true);
			$('#scale_type_T4').css('display','block');
			disabled_option_content('scale_type_T16',true);
			//
		}else if(selectVal=='T12'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',false);
			disabled_option_content('scale_content_T11',true);
			//disabled_option_content('scale_type_T4',false);
			//$("#scale_type_T4").css("dis");
			disabled_option_content('cutoffRuleArr',true);
			disabled_option_content('scale_type_T16',true);
			$('#inquiryInformationArray').css('display','block');
		}else if(selectVal=='T8'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('list_linkage',false);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('cutoffRuleArr',true);
			disabled_option_content('scale_type_T16',true);
			//disabled_option_content('scale_type_T4',false);
			//$("#scale_type_T4").css("dis");
			$('#list_linkage').css('display','block');
		}else if(selectVal=='T2' || selectVal=='T1' || selectVal=='T9'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',false);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('cutoffRuleArr',true);
			disabled_option_content('scale_content_T11',true);
			//disabled_option_content('scale_type_T4',false);
			//$("#scale_type_T4").css("dis");
			$('#scale_type_T2').css('display','block');
			disabled_option_content('scale_type_T16',true);
			//分割线类型
		}else if(selectVal=='T10'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('cutoffRuleArr',false);
			$('#cutoffRuleArr').css('display','block');
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('scale_type_T16',true);
			//disabled_option_content('scale_type_T4',false);
			//$("#scale_type_T4").css("dis");
			//分割线类型                          结束
		}else if(selectVal=='T16'){
			disabled_option_content('scale_content',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('cutoffRuleArr',true);
			$('#scale_type_T16').css('display','block');
			disabled_option_content('scale_content_T11',true);
			disabled_option_content('scale_type_T16',false);
			//scale_type_T16_scaleRange
			typesChangeForT16("scaleType");			
			//disabled_option_content('scale_type_T4',false);
			//$("#scale_type_T4").css("dis");
			//分割线类型                          结束
		}else{
			//alert("haha");
			disabled_option_content('scale_content',true);
			disabled_option_content('list_linkage',true);
			disabled_option_content('scale_type_T4',true);
			disabled_option_content('scale_type_T2',true);
			disabled_option_content('inquiryInformationArray',true);
			disabled_option_content('scale_content_T11',true);
		}
		var questionnaireType = "${pd.questionnaireType}";
		if(selectVal=='T1' && questionnaireType ==  "${QUESTIONNAIRE_TYPE_STAR_LEVEL}"){
			$("#isShowQuestion").css("display","block");
			$("#questionsList").attr("disabled",false);
        	$("#isShow").attr("disabled",false);
		}else{
			$("#isShowQuestion").css("display","none");
			//$("#questionlistdiv").css("display","none");
			$("div[id^='questionlistdiv']").css("display","none");
			$("#questionsList").val("");
			//$("#optionCreate").css("display","block");
			$("#isShow").attr("checked",false);
			$("#questionsList").attr("disabled","disabled");
		}
		if(selectVal == "T13" || selectVal == "T14"){
			$(".imgPreview").css("display","block");
		}else{
			$(".imgPreview").css("display","none");
		}
	}
	
	//必填标记
	function mustFlagChange(obj){
		if($(obj).is(":checked")){
			$(obj).val(1);
		}else{
			$(obj).val(0);
		}
	}
	//判断是否为空。高级设置  为空返回false。不为空返回true
	function checkQuestionsCode(){
		//questionData_code-questionData_name
		var isEmpty=true;
		var isEmptyCode=true;
		var notOneCodeEmpty=false;
		var questionData_code=$('input[name=questionData_code]');
		var questionData_name=$('input[name=questionData_name]');
		for(var i =0;i<questionData_name.length&&isEmpty;i++){
			var questionData_name_value=$(questionData_name[i]).val();
			if(questionData_name_value==''||questionData_name_value==null){
				$(questionData_name[i]).tips({
					side:3,
		            msg:'选项内容必填',
		            bg:'#AE81FF',
		            time:2
		        });
				$(questionData_name[i]).focus();
				isEmpty=false;
			}
			var questionData_code_value=$(questionData_code[i]).val();
			if(questionData_code_value!=null&&questionData_code_value!=''){
				isEmptyCode=false;
			}else{
				notOneCodeEmpty=true;
			}
		}
		var bool=true;
		if(isEmpty&&isEmptyCode){
			for(var j=0;j<questionData_code.length&&bool;j++){
				var questionData_code_value=$(questionData_code[j]).val();
				if(questionData_code_value==null||questionData_code_value==''){
					$(questionData_code[j]).tips({
						side:3,
			            msg:'编码内容必填一个',
			            bg:'#AE81FF',
			            time:2
			        });
					$(questionData_code[j]).focus();
					bool=false;
				}
			}
		}
		return isEmpty&&!isEmptyCode;
	}
	function setDisable(flg){
		var types = '${msg}';
		//指定位置问题设置下列不可选
		if(types=='pointSave'){
			if(flg){
				$('#classification').attr('disabled','disabled');
				$('#questionCode').attr('disabled','disabled');
				$('#sort').attr('disabled','disabled');
				$('#parentId').attr('disabled','disabled');
			}else{
				$('#classification').removeAttr("disabled");
				if('L1'==$('#classification').val()){
					$('#questionCode').removeAttr("disabled");
				}
				$('#sort').removeAttr("disabled");
				if('L2'==$('#classification').val()){
					$('#parentId').removeAttr("disabled");
				}
			}
		}
		
	}
	//级别变化时，只更新一级分类
	function oneLevelChangeByQuestionnaire(questionnaireIdVal,levelVal){
		levelVal=levelVal.toString().replace(/,/g, "|");
		$('#parentId').empty();
		$.ajax({
			type: "POST",
			url: 'questions/questionnaire_change',
	    	data:{questionnaireId:questionnaireIdVal,levels:levelVal,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				var jsonObj=eval(data.result);
				var parentId="${question.parentId}";
				for(var i=0; i<jsonObj.length; i++){
					var selected='';
					if(jsonObj[i].key==parentId){
						selected='selected=true';
					}
					$('#parentId').append("<option value='"+jsonObj[i].key+"' "+selected+" >"+jsonObj[i].value+"</option>");
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				$('#parentId').empty();
				alert('数据获取异常');    
			}
		});
		
	}
	function typesChangeForT16(id){
		//alert(id);
		var value=$("#"+id).val();
		$("#scale_type_T16_scaleRange").css("display","none");
		if(value == 'ST11'){
			$("#scale_type_T16_scaleRange").css("display","block");
		}else{
			$("#scale_type_T16_scaleRange").css("display","none");
		}
		//-
	}
</script>
	
</head>
<body class="g_wrapper page_edit" onload="fun_loadData();">
	<form action="questions/${msg}.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="questionId" id="questionId" onchange="" value="${question.questionId}"/>
	<input id="questionnaireType" type="hidden" name="questionnaireType" value="${pd.questionnaireType }" />
    <div class="contentWrapper">
        <div class="contentRight">
            <div class="mainEditor">
                <!--主体内容-->
                <div class="survey_main">
                    <div class="main_title">
                        <h4>问卷问题采集</h4>
                    </div>
                    <div class="main_content">
                        <div class="question_wrapper">
                            <div class="question_list">
                                <lable class="row_title" style="margin-right:15px;">问卷</lable>
                                <!--<div>问卷</div>-->
                                <select class="belongPage" name="questionnaireId" id="questionnaireId"  <c:if test="${question.questionnaireId!=null && !empty question.questionnaireId }">disabled="true"</c:if> onchange="questionnaireChange(this);">
                                	<option value="">请选择所属问卷</option>
                                	<c:forEach	items="${questionnaireList}" var="item">
                                		<c:if test="${item.questionnaireId eq question.questionnaireId}">
                                			<option selected="selected" value="${item.questionnaireId}">${item.title}</option>
                                		</c:if>
                                		<c:if test="${item.questionnaireId ne question.questionnaireId}">
                                			<option value="${item.questionnaireId}">${item.title}</option>
                                		</c:if>
                                	</c:forEach>
                                </select>
                            </div>
                            <div class="question_list ">
                                <label class="row_title alr" style="margin-right:15px;">分类名称</label>
                                <select class="belongPage" name="classification" id="classification" onchange="levelChange(this,'hidden_types');">
                                	<c:forEach items="${classifications }" var="item" varStatus="vs">
                                		<c:if test="${question.classification eq item.key }">
                                			<option value="${item.key}" selected="selected">${item.value}</option>
                                		</c:if>
                                		<c:if test="${question.classification ne item.key }">
                                			<option value="${item.key}">${item.value}</option>
                                		</c:if>
                                	</c:forEach>
                                </select>
                                <!-- 分类编号 -->
                                <label class="row_title alr" style="margin-right:15px;">编码 </label>
                                <select class="belongPage" name="questionCode" id="questionCode">
                                	<c:forEach items="${questionCodes}" var="item">
                                		<c:if test="${question.questionCode eq item.key }">
                                			<option value="${item.key}" selected="selected">${item.value}</option>
                                		</c:if>
                                		<c:if test="${question.questionCode ne item.key }">
                                			<option value="${item.key}">${item.value}</option>
                                		</c:if>
                                	</c:forEach>
                                </select>
                            </div>
                            <div class="question_list ">
                            		<c:if test="${pd.questionnaireType==QUESTIONNAIRE_TYPE_COMMON || pd.questionnaireType==QUESTIONNAIRE_TYPE_CUSTOM_TEMPLATE}">
                            			  <lable class="row_title">题目</lable>
                               				 <input type="text" name="title" id="title" value="${question.title}" placeholder="" style="margin-left:11px;">
                            		</c:if>
                            		<c:if test="${pd.questionnaireType==QUESTIONNAIRE_TYPE_STAR_LEVEL }">
                            		  <table>
                            			<tr>
	                            			<td class="row_title" style="margin-right:7px;">题目</td>
		                            		<td>  <script id="title" class="belongPage"  type="text/plain" >${question.title}</script>
											<input name="title" id="title1" value="" type="hidden"></td>
										</tr>
                          			 </table>
                            		</c:if>
                            		
                            	
                            </div>
                            <div class="question_list ">
                                <label class="row_title alr" style="margin-right:15px;">备注</label>
                                <input type="text" name="description" id="titleMark" value="${question.description}">
                            </div>
                            
                            <div class="question_list ">
                                <label class="row_title alr" style="margin-right:15px;">调查对象</label>
                                <input type="hidden" id="level" name="level" value="${question.level}"/>
                                <select class="belongPage" multiple="multiple" data-placeholder="请选择调查对象" id="MySelectBox" onchange="changeLeve(this);">
                                	<c:forEach items="${staffLevels }" var="item">
                                			<option value="${item.key}">${item.value}</option>
                                	</c:forEach>
                                </select>
                            </div>

                            <div class="row_content">
                            	<div id="option_header" style="display: ">
                            		<input type="hidden" id="hidden_types" value="${question.types}"/>
	                                <select name="types" id="types" style="display:;" onchange="typesChange(this);">
	                                	<c:forEach items="${questionTypes}" var="item">
	                                		<c:if test="${question.types == item.key }">
	                                			<option value="${item.key}" selected="selected">${item.value}</option>
	                                		</c:if>
	                                		<c:if test="${question.types ne item.key }">
	                                			<option value="${item.key}">${item.value}</option>
	                                		</c:if>
	                                	</c:forEach> 
	                                </select>
	                                <label class="mrl">排序<input name="sort" id="sort" class="mrl range" value="${question.sort }" type="number" style="display:;"></label>
	                                <label id="mustFlag_text" style="display:;"> 
	                                	<c:if test="${1 eq question.mustFlag }">
	                                		<input name="mustFlag" style="margin-right: 0; display:;" disabled="" id="mustFlag" type="checkbox" checked="checked" onchange="mustFlagChange(this)" value="1"> 必填
	                                	</c:if>
	                                    <c:if test="${1 ne question.mustFlag }">
	                                		<input name="mustFlag" style="margin-right: 0; display:;" disabled="" id="mustFlag" type="checkbox" onchange="mustFlagChange(this)" value="0"> 必填
	                                	</c:if>
                                	</label>
                                	 <label id="isRemarks_text" style="display:;"> 
	                                	<c:if test="${1 eq question.isRemarks }">
	                                		<input name="isRemarks" style="margin-right: 0; display:;" disabled="" id="isRemarks" type="checkbox" checked="checked" onchange="mustFlagChange(this)" value="1"> 是否备注
	                                	</c:if>
	                                    <c:if test="${1 ne question.isRemarks }">
	                                		<input name="isRemarks" style="margin-right: 0; display:;" disabled="" id="isRemarks" type="checkbox" onchange="mustFlagChange(this)" value="0"> 是否备注
	                                	</c:if>
                                	</label>
                            		<!-- 旧版本
                            		<table style="width: 80%">
                            		<tr><td id="typesTd" style="text-align: left;display: ;">
                            		<input type="hidden" id="hidden_types" value="${question.types}"/>
	                                <select name="types" id="types" style="display:;" onchange="typesChange(this);">
	                                	<c:forEach items="${questionTypes}" var="item">
	                                		<c:if test="${question.types == item.key }">
	                                			<option value="${item.key}" selected="selected">${item.value}</option>
	                                		</c:if>
	                                		<c:if test="${question.types ne item.key }">
	                                			<option value="${item.key}">${item.value}</option>
	                                		</c:if>
	                                	</c:forEach> 
	                                </select>
	                                </td> -->
	                                <!-- 排序 旧版本
	                                <td style="text-align: left;">
	                                <label  class="mrl">排序<input name="sort" id="sort" class="mrl range" value="${question.sort }" type="number" style="display:;"></label>
								</td>
								<td style="text-align: left;">
                                <label id="mustFlag_text" style="display:;"> 
                                	<c:if test="${1 eq question.mustFlag }">
                                		<input name="mustFlag" style="margin-right: 0; display:;" disabled="" id="mustFlag" type="checkbox" checked="checked" onchange="mustFlagChange(this)" value="1"> 必填
                                	</c:if>
                                    <c:if test="${1 ne question.mustFlag }">
                                		<input name="mustFlag" style="margin-right: 0; display:;" disabled="" id="mustFlag" type="checkbox" onchange="mustFlagChange(this)" value="0"> 必填
                                	</c:if>
                                </label>
                               	</td>
                                </tr></table>-->
                               </div>
                            </div>
                            <div class="option_wrapper" id="questionList" style="display: ">
                            		<div class="options_editor" id="scale_content_T11" style="margin-bottom:20px">
	                                    <label class="mrl" for="">范围
	                                    <input name="scaleRange" class="mrl range" value="${question.scaleRange }" type="number" ></label>
                                	</div>
                            		 <div class="options_editor" id="cutoffRuleArr" style="margin-bottom:20px;display: none;">
                                		<label for="">分割线类型
                                		 <select class="mrl" name="cutoffRule" id="cutoffRule">
                                		 	<c:forEach items="${cutoffRule}" var="map">
                                       			<c:if test="${question.cutoffRule eq map.key }">
                                        			<option value="${map.key }" selected="selected">${map.value }</option>
                                        		</c:if>
                                        		<c:if test="${question.cutoffRule ne map.key }">
                                        			<option value="${map.key }">${map.value }</option>
                                        		</c:if>
                                        	</c:forEach>
                                		 </select>
                                		 </label>
                                	</div>
                                	
                                	 <div class="options_editor" id="scale_type_T16" style="margin-bottom:20px;display: none;">
                                		<label for="" >展现形式
	                                		 <select class="mrl" name="scaleType" id="scaleType" onchange="typesChangeForT16('scaleType');">
	                                		 	<c:forEach items="${scaleTypeForT16}" var="map" >
	                                        		<c:if test="${question.scaleType eq map.key }">
	                                        			<option value="${map.key }" selected="selected">${map.value }</option>
	                                        		</c:if>
	                                        		<c:if test="${question.scaleType ne map.key }">
	                                        			<option value="${map.key }">${map.value }</option>
	                                        		</c:if>
	                                        	</c:forEach>
	                                        </select>
                                		 </label>
                                		
                               		     <label class="mrl" for="" id="scale_type_T16_scaleRange"  <c:if test="${question.scaleRange==null }" > style="display: none;" </c:if>>量表范围<input name="scaleRange" class="mrl range" value="${question.scaleRange }" type="number" ></label>
                                	</div>
                                	
                                	
		                             <div class="options_editor" id="inquiryInformationArray" style="margin-bottom:20px;display: none;">
                                		<label for="">信息排列
                                		 <select class="mrl" name="inquiryInformation" id="inquiryInformation">
                                		 	<c:forEach items="${inquiryInformationArray}" var="map">
                                       			<c:if test="${question.inquiryInformation eq map.key }">
                                        			<option value="${map.key }" selected="selected">${map.value }</option>
                                        		</c:if>
                                        		<c:if test="${question.inquiryInformation ne map.key }">
                                        			<option value="${map.key }">${map.value }</option>
                                        		</c:if>
                                        	</c:forEach>
                                		 </select>
                                		 </label>
                                	</div>
                            	 <div class="options_editor" id="list_linkage" style="margin-bottom:20px;display: none;">
                                		<label for="">联动类型
                                		 <select class="mrl" name="linkageId" id="linkageId">
                                		 	<c:forEach items="${listOneLevel}" var="map">
                                       			<c:if test="${question.linkageId eq map.linkageId }">
                                        			<option value="${map.linkageId }" selected="selected">${map.linkageName }</option>
                                        		</c:if>
                                        		<c:if test="${question.linkageId ne map.linkageId }">
                                        			<option value="${map.linkageId }">${map.linkageName }</option>
                                        		</c:if>
                                        	</c:forEach>
                                		 </select>
                                		 </label>
                                	</div>
                                	 <div class="options_editor" id="scale_type_T4" style="margin-bottom:20px;display: none;">
                                		<label for="">日历类型
                                		 <select class="mrl" name="formatData" id="formatData">
                                		 	<c:forEach items="${scaleTypesForT7}" var="map">
                                        		<c:if test="${question.formatData eq map.key }">
                                        			<option value="${map.key }" selected="selected">${map.value }</option>
                                        		</c:if>
                                        		<c:if test="${question.formatData ne map.key }">
                                        			<option value="${map.key }">${map.value }</option>
                                        		</c:if>
                                        	</c:forEach>
                                		 </select>
                                		 </label>
                                	</div>
                                	 <div class="options_editor" id="scale_type_T2" style="margin-bottom:20px;display: none;">
                                		<label for="">排列方式
                                		 <select class="mrl" name="typeSetting" id="typeSetting">
                                		 	<c:forEach items="${scaleTypeForT2}" var="map">
                                        		<c:if test="${question.typeSetting eq map.key }">
                                        			<option value="${map.key }" selected="selected">${map.value }</option>
                                        		</c:if>
                                        		<c:if test="${question.typeSetting ne map.key }">
                                        			<option value="${map.key }">${map.value }</option>
                                        		</c:if>
                                        	</c:forEach>
                                		 </select>
                                		 </label>
                                	</div>
                                <!-- 量表  非一级分类-->
                                <div class="options_editor" id="option_content" style="display: ">
                                	<div id="scale_content" style="margin-bottom:20px">
                                	<input type="hidden" id="hidden_scaleType" value="${question.scaleType}"/>
                                    <label for="">量表类型
                                        <select class="mrl" name="scaleType" id="">
                                        	<c:forEach items="${scaleTypes}" var="map">
                                        		<c:if test="${question.scaleType eq map.key }">
                                        			<option value="${map.key }" selected="selected">${map.value }</option>
                                        		</c:if>
                                        		<c:if test="${question.scaleType ne map.key }">
                                        			<option value="${map.key }">${map.value }</option>
                                        		</c:if>
                                        	</c:forEach>
                                        </select>
                                    </label>
                                    <label class="mrl" for="">量表范围<input name="scaleRange" class="mrl range" value="${question.scaleRange }" type="number" ></label>
                                	</div>
                                	<!-- 所属一级分类 begin -->
	                                <div class="question_list ">
	                                <label class="alr">题目分类
		                                <select class="belongPage" name="parentId" id="parentId" onchange="twoNumber('L2')">
		                                	<c:forEach items="${parentList }" var="item">
		                                		<c:if test="${question.parentId eq item.questionId }">
		                                			<option value="${item.questionId}" selected="selected">${item.title}</option>
		                                		</c:if>
		                                		<c:if test="${question.parentId ne item.questionId }">
		                                			<option value="${item.questionId}">${item.title}</option>
		                                		</c:if>
		                                	</c:forEach>
		                                </select>
		                            </label>
	                            	</div>
	                                <!-- 所属一级分类 end -->
                                </div>
                                <!-- 高级设置 begin-->
                                <div id="userDefinedItems">
                                <div class="options_split">
                                    <div class="split"></div>
                                    <a id="moreInfo" href="javascript:;">
                                        <span>展开高级设置</span>
                                        <i></i>
                                    </a>
                                </div>
                                <!--隐藏部分-->
                                <div class="options_list" style="display:none;" id="optionList">
                                	<input type="hidden" name="questionData" id="questionData" value='${question.questionData }'/>
                                	<div class="normal_options_list">
                                		 <li>
	                                        <span style="color: red;margin-left: 10%;">
		                                    	1.编码与内容尽量保持一致。</br>
		                                    </span>
		                                     <span style="color: red;margin-left: 10%;">
		                                    	2.如果使用“请选择”项，请把编码置空。</br>
		                                    </span>
	                                    	<span id="isShowQuestion" style="margin-left: 10%; display:none">
			                                     3.
			                                    <c:if test="${question.isShow eq 1}">
	                                           		 <input style="margin-left:1px" type="checkbox" name="isShow" id="isShow" checked="checked" disabled="disabled" value="1" onchange="isShowFlag(this)"/>是否隐藏问题
	                                            </c:if>
	                                            <c:if test="${question.isShow ne 1}">
	                                           		<input style="margin-left:1px" type="checkbox" name="isShow" id="isShow" value="0" disabled="disabled"  onchange="isShowFlag(this)"/>是否隐藏问题
	                                            </c:if>
	                                            </br>
		                                     </span>
	                                    </li>
                                		<li >
                                		
                                            <span style="margin-left: 22%;"></span>
                                         		   编码
                                         		    <span style="margin-right: 45%;"></span>
                                            <span ></span>
                                         		   内容
                                            
                                        </li>
                                	</div>
                                	<input type="hidden" id="questionsListVal" name="questionList" />
                                    <ul id= "optionUl" class="normal_options_list">
                                        <li id="optionItem" class="option_item">
                                            <span class="handle"></span>
                                            <input class="title_Code" type="text" name="questionData_code" id="questionData_code_id_0_1"  placeholder="选项代码">
                                            <span class="line">——</span>
                                            <input type="hidden" id="questionsList_0" name="questionList_0" />
                                            <input class="title_Name" type="text" name="questionData_name" id="questionData_name_id_0_2" style="background:#CCCCCC" placeholder="选项内容">
                                            <a href="javascript:;" class="btn_del">x</a>
                                            <!--图片题  -->
                                            <div class="imgPreview">
                                            	<div id="preview" >
													<a href="javascript:void"><img alt="optionImg" name="optionImgPath" id="optionImgPath_0" style="width: 50px;height: 50px;" src=""/></a>
													<input type="hidden" id="optionImgId_0" name="optionImgId" />
												</div>
												<input type="file" id="ImgFile" style=" font-size: 15px; width:200px"  name="ImgFile" onchange="changeImg(this,'optionImgPath_0')"/>
												<!-- <a style="height: 30px;width: 30px;padding: 3px;padding-left: 5px;" class="btn-small btn-danger" onclick="deletePicture('backgroundImgId_1','backgroundImgPath_1');" title="删除图片" >删除</a> -->
												<input type="button" onclick="deletePicture('optionImgId_0','optionImgPath_0');" value="删除"/>
                                            </div>
                                             <!--隐藏题  -->
                                            <div class="question_list" id="questionlistdiv_0" style="display:none;margin-left: 80px;margin-top:-15px; margin-bottom: 15px;">
				                                <select class="belongPage" multiple="multiple" data-placeholder="请选择问题" id="MySelectBox1_0" onchange="changeQuestion(this)">
				                                	<c:forEach items="${questionShow }" var="item">
				                                		<option value="${item.questionId}">${item.title}</option>
				                                	</c:forEach>
				                                </select>
			                            	</div>
			                            	
                                        </li>
                                        <li class="option_item">
                                            <span class="handle"></span>
                                            <input class="title_Code" type="text" name="questionData_code" id="questionData_code_id_1_1" placeholder="选项代码">
                                            <span class="line">——</span>
                                            <input type="hidden" id="questionsList_1" name="questionList_1" />
                                            <input class="title_Name" type="text" name="questionData_name" id="questionData_name_id_1_2" style="background:#CCCCCC" placeholder="选项内容">
                                            <a href="javascript:;" class="btn_del">x</a>
                                            <div class="question_list" id="questionlistdiv_1" style="display:none;margin-left: 80px;margin-top:-15px; margin-bottom: 15px;">
				                                <select class="belongPage" multiple="multiple" data-placeholder="请选择问题" id="MySelectBox1_1" onchange="changeQuestion(this)">
				                                	<c:forEach items="${questionShow }" var="item">
				                                			<option value="${item.questionId}">${item.title}</option>
				                                	</c:forEach>
				                                </select>
			                           		 </div>
			                           		 <div class="imgPreview">
			                           		 	<div id="preview">
													<a href="javascript:void"><img alt="optionImg" name="optionImgPath" id="optionImgPath_1" style="width: 50px;height: 50px;" src=""/></a>
													<input type="hidden" id="optionImgId_1" name="optionImgId"/>
												 </div>
												 <input type="file" id="ImgFile" style=" font-size: 15px; width:200px"  name="ImgFile" onchange="changeImg(this,'optionImgPath_1')"/>
												 <input type="button" onclick="deletePicture('optionImgId_1','optionImgPath_1');" value="删除"/>
			                           		 </div>
			                           		 
                                        </li>
                                        
                                    </ul>
                                    <li id="optionCreate" class="option_item option_create">
                                        <div><span class="add_option">新建选项</span></div>
                                    </li>
                                </div>
                                </div><!-- 高级设置 end-->
                            </div>
                            <div class="editor_control">
                                <a href="javascript:save();" class="btn btn_small btn_blue btn_confirm">确定</a>
                                <a href="javascript:top.Dialog.close();" class="btn btn_small btn_white btn-cancel">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<div id="zhongxin" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	</form>
		<!-- 引入 -->
		<script type="text/javascript" src="static/question/js/question.js"></script><!-- 页面操作 -->
		<script type="text/javascript">
		//显示控制问题
		function changeQuestion(obj){
			//显示选择项文本
			var array_of_checked_values = $("#"+obj.id).multiselect("getChecked").map(function(){
					return this.value; 
				}).get();
			var str = obj.id.split("_");
			$("#questionsList_"+str[1]).val(array_of_checked_values);
			showData();
		}
		
		function isShowFlag(obj){
			if($(obj).is(":checked")){
				$(obj).val(1);
				$("div[id^='questionlistdiv']").css("display","block");
				findQuestion();
				$("#questionsList").attr("disabled",false);
	        	$("#isShow").attr("disabled",false);
			}else{
				$(obj).val(0);
				$("div[id^='questionlistdiv']").css("display","none");
				$("#questionsListVal").val("");
			}
		}
		function findQuestion(){
			var questionnaireId = $("#questionnaireId").val();
			var questionId = $("#questionId").val();
			$.ajax({
				url:"questions/findQuestions.do",
				type:"post",
				data:{questionnaireId:questionnaireId,
					questionId:questionId},
				dataType:'json',
				cache: false,
				success:function(data){
					if(data!=null && data != ''){
						var html = "";
						$.each(data,function(key,val){
							html+="<option value="+val.questionId+">"+val.title+"</option>";
						});
					}
					$("select[id^='MySelectBox1']").each(function(){
						$("#"+this.id).empty();
						$("#"+this.id).append(html);
						$("#"+this.id).multiselect("refresh");
					})
				}
				
			});
		}
		
		var title = UE.getEditor('title', {
		    toolbars: [
["undo","redo","link","unlink","bold","italic","underline","fontborder","strikethrough","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","indent","removeformat","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize"
 	,'inserttable'//插入表格
	,'insertrow', //前插入行
	'insertcol',	 //前插入列
	 'mergeright', //右合并单元格
	 'mergedown', //下合并单元格
	 'deleterow', //删除行
	 'deletecol', //删除列
	 'splittorows', //拆分成行
	 'splittocols', //拆分成列
	 'splittocells' //完全拆分单元格
	 ]
		           ],
		           autoHeightEnabled: true,
		           autoFloatEnabled: true,
		           wordCountMsg:false,
		           elementPathEnabled:false,
		           initialFrameWidth : 630,
		       });
		$(top.hangge());
		</script>
</body>
</html>
package com.fh.controller.questionnaire;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.FileDetails;
import com.fh.entity.system.MapEntity;
import com.fh.entity.system.Questionnaire;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.questionnaire.FileDetailsService;
import com.fh.service.questionnaire.PageresultService;
import com.fh.service.questionnaire.QuestionnaireService;
import com.fh.service.system.user.impl.UserService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.DateUtil;
import com.fh.util.FileUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

import net.sf.json.JSONArray;

/** 
 * 类名称：QuestionnaireController
 * 创建人：FH 
 * 创建时间：2017-02-28
 */
@Controller
@RequestMapping(value="/questionnaire")
public class QuestionnaireController extends BaseController {
	
	String menuUrl = "questionnaire/list.do"; //菜单地址(权限用)

	@Resource(name="pageresultService")
	private PageresultService pageresultService;
	
	@Resource(name="questionnaireService")
	private QuestionnaireService questionnaireService;

	@Resource(name="fileDetailsService")
	private FileDetailsService fileDetailsService;
	
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="userService")
	private UserService userService;
	/**
	 * 一线服务确认(意见收集)
	 * @return
	 */
	@RequestMapping(value="toFeedbackPage")
	public ModelAndView toFeedbackPage(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<PageData> pdList = null;
		String pageCode = pd.getString("pageId");
		try {
//			pdList = questionService.findByPageIdUser(pd);
//			pd = questionpageService.findByIdUser(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("questionList", pdList);
		mv.addObject("pagePd", pd);
		mv.addObject("pageId", pageCode);
		mv.setViewName("questionnaire/userPage/feedback");
		return mv;
	}
	/* 0:单选 题2:主观题 3:评分题
	 * 用户提交问卷信息
	 */
	@RequestMapping(value="userAnswer")
	public ModelAndView userAnswer(){
		ModelAndView mv = new ModelAndView();
		List<PageData> listPd = new ArrayList<PageData>();
		PageData userPd = new PageData();
		userPd.put("QUESTIONUSER_ID", this.get32UUID());
		
		Map properties = this.getRequest().getParameterMap();
		String PageCode = this.getRequest().getParameter("pageId");
		Iterator entries = properties.entrySet().iterator(); 
		Map.Entry entry; 
		String name = "";  
		String value = "";  
		while (entries.hasNext()) {
			PageData questionPd = new PageData();
			questionPd.put("QUESTIONRESULT_ID", this.get32UUID());
			questionPd.put("USERCODE",userPd.getString("QUESTIONUSER_ID"));
			questionPd.put("ANSWERDATE",Tools.date2Str(new Date()));
			questionPd.put("PAGECODE", PageCode);
			entry = (Map.Entry) entries.next(); 
			Object valueObj = entry.getValue(); 
			if(null == valueObj){ 
				value = ""; 
			}else if(valueObj instanceof String[]){ 
				String[] values = (String[])valueObj;
				for(int i=0;i<values.length;i++){ 
					 value = values[i] + ",";
				}
				value = value.substring(0, value.length()-1); 
			}else{
				value = valueObj.toString(); 
			}
			
			name = (String) entry.getKey(); 
			if(name.indexOf("_") != -1 && value != null && !"".equals(value)){		//是问题的id
				questionPd.put("QUESTIONCODE", name.substring(0,name.indexOf("_")));
				if("2".equals(name.substring(name.indexOf("_") + 1,name.length()))){
					 	questionPd.put("ANSWERDATA", value); //是主观题id
					}else{ 
						questionPd.put("ANSWERNUM", value);
					}
					listPd.add(questionPd);
				}else{	
					//用户个人信息
					if("USERNAME".equals(name) || "COMPANY".equals(name) || "BUILDING".equals(name) || "TENANCYTIME".equals(name) ||"PHONE".equals(name) || "CHECKIN".equals(name)){
						userPd.put(name, value);
				}
			}
		}
		try {
			pageresultService.saveUser(listPd,userPd);
			mv.setViewName("questionnaire/userPage/answer_success");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("出现异常,将数据写入文件...");
			String userMsg = JSONObject.toJSONString(userPd);
			String pageMsg = JSONObject.toJSONString(listPd);
			String filePath = PathUtil.getClassResources();			//文件上传路径
			FileUtil.infoText(filePath,userMsg+"***"+pageMsg);
			mv.setViewName("questionnaire/userPage/order_lose");
		}
		return mv;
	}
	
	/**
	 * 新增保存
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(HttpServletRequest request,@RequestParam(value = "logoImgFile", required = false) MultipartFile logoImgFile,
			@RequestParam(value = "backgroundImgFile", required = false) MultipartFile backgroundImgFile,@ModelAttribute("questionnaireData")Questionnaire questionnaireData,ModelMap model) throws Exception{
		logBefore(logger, "新增Questionnaire");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String secCodePath = Const.FILEPATHFILE+pd.getString("questionnaireId")+".jpg";
		pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建日期
		pd.put("qrCodePath",secCodePath);
		pd.put("level",questionnaireData.getRespondents());
		/*********************/
//        String path = request.getSession().getServletContext().getRealPath("upload"); 
//        System.out.println(path); 
        questionnaireData.setQuestionnaireId(this.get32UUID());
        pd.put("questionnaireId", questionnaireData.getQuestionnaireId());	//主键
        multipartFileTransformFileDetail(logoImgFile, backgroundImgFile, questionnaireData);
        //File targetFile = new File(path, logoFileName);  
        
//        if(!targetFile.exists()){  
//            targetFile.mkdirs();  
//        }  
//        //保存  
//        try {  
//            logoImgFile.transferTo(targetFile);  
//        } catch (Exception e) {  
//            e.printStackTrace();  
//        }
		User user = Jurisdiction.getLoginUser();
        questionnaireData.setCreateUser(user.getUSER_ID());
        questionnaireData.setCreate_user(user.getUSER_ID());
        questionnaireData.setDepartment_id(user.getDepartment().getDEPARTMENT_ID());
//        System.out.print(request.getServletContext().getRealPath("/upload"));
        String path = request.getContextPath();
        String baseP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"+"zj/url?c=";
        pd.put("shortUri", baseP);
		questionnaireService.save(questionnaireData,pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除Questionnaire");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			List<PageData> listIsExistChild=questionnaireService.findListIsExistChild(pd);
			if(listIsExistChild == null || listIsExistChild .size()==0){
				questionnaireService.updateStatus(pd);
				out.write("success");
			}else{
				out.write("exist");
			}
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(HttpServletRequest request,@RequestParam(value = "logoImgFile", required = false) MultipartFile logoImgFile,
			@RequestParam(value = "backgroundImgFile", required = false) MultipartFile backgroundImgFile,@ModelAttribute("questionnaireData")Questionnaire questionnaireData,ModelMap model) throws Exception{
		logBefore(logger, "修改Questionnaire");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
        questionnaireData.setModifyUser(user.getUSER_ID());
        questionnaireData.setModifyTime(DateUtil.getTime());
		pd.put("level",questionnaireData.getRespondents());
		multipartFileTransformFileDetail(logoImgFile, backgroundImgFile, questionnaireData);
		String path = request.getContextPath();
		String baseP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"+"zj/url?c=";
        pd.put("shortUri", baseP);
		questionnaireService.edit(questionnaireData,pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表Questionnaire");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String startTime=pd.getString("lastLoginStart");
			String endTime=pd.getString("lastLoginEnd");
			StringBuffer startTimeHeader=new StringBuffer();
			Date date=new Date();
			String dateStr=sdfTime.format(date);
			//开始时间为空
			if(!Tools.isEmpty(startTime)&&Tools.isEmpty(endTime)){
				startTimeHeader.append("(  DATE(a.createTime)  BETWEEN  '"+startTime.trim()+"'  and  '"+dateStr.trim()+"' ) ");
			//结束时间为空
			}else if(Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" ( DATE(a.createTime)  BETWEEN '"+dateStr.trim()+"'   and '"+endTime.trim()+"'   )");
			}else if(!Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" (  DATE(a.createTime)  BETWEEN  '"+startTime.trim()+"'  and  '"+endTime.trim()+"'   )");
			}
			pd.put("startTimeStrHeader", startTimeHeader.toString());
			this.getUserHC(pd, departmentService);
			page.setPd(pd);
			List<PageData> varList = questionnaireService.list(page);	//列出QuestionPage列表
			//读取图片。将图片流读取到。相应路径下面     -------------------开始
			for (int i = 0; i < varList.size(); i++) {
				PageData data=varList.get(i);
				//问卷调查对象调整--------------开始
				String respondentsParentId=data.getString("respondentsParentId");
				String respondentsStr=data.getString("respondents");
				StringBuffer respondentsName=new StringBuffer();
				if(respondentsStr!=null&&respondentsStr!=""){
					Map<String,String> map=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
					varList.get(i).put("newRespondents", map);
					if(respondentsStr.indexOf(",")>-1){
						String[] respondentsArr=respondentsStr.split(",");
						for (int j = 0; j < respondentsArr.length; j++) {
							if(j==0){
								respondentsName.append(map.get(respondentsArr[j]));
							}else{
								respondentsName.append(","+map.get(respondentsArr[j]));
							}
							
						}
						
					}else{
						respondentsName.append(map.get(respondentsStr));
					}
					varList.get(i).put("respondents", respondentsName);
				}
				//问卷调差对象调整-------------结束
				//展示二维码--------------开始
				PageData pageData1=new PageData();
				pageData1.put("ownershipMasterId", data.get("questionnaireId"));
				pageData1.put("category", Const.FILE_CATEGORY_QR);
				List<FileDetails> fileDetails=fileDetailsService.listByMasterId(pageData1);
				List<MapEntity> listEntity=new ArrayList<MapEntity>();
				for (FileDetails detail:fileDetails) {
					MapEntity entity=new MapEntity();
					entity.setKey("uploadFiles"+File.separator+"file"+File.separator+detail.getFileName());
					entity.setValue(detail.getFileTitle());
					entity.setEnCodePath(detail.getEnCodePath());
					listEntity.add(entity);
					byte2File(detail.getContent(),this.getRequest().getServletContext().getRealPath("uploadFiles")+File.separator+"file",detail.getFileName());
				}
				varList.get(i).put("list", listEntity);
				//展示二维码--------------开始
			}
			//读取图片。将图片流读取到。相应路径下面     ------------------结束
			//获取问卷的形式
			getQuestionnaireTypeForAll(mv);
			
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.setViewName("questionnaire/questionnaireList");
			mv.addObject("questionsStatus", ConversionUtil.getStatus());
			getQuestionnaireDataDictionary(mv,pd);
			mv.addObject("page",page);
			mv.addObject(Const.SESSION_QX,Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Questionnaire页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			getQuestionnaireDataDictionary(mv,pd);
			mv.setViewName("questionnaire/questionnaireEdit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(HttpServletRequest request){
		logBefore(logger, "去修改Questionnaire页面");
		ModelAndView mv = this.getModelAndView();
		PageData pageData=new PageData();
		pageData = this.getPageData();
		try {
			Questionnaire questionnaire = questionnaireService.entityFindDataByIdForUpdate(pageData);	//根据ID读取
			PageData pageData1=new PageData();
			pageData1.put("fileIds","('"+questionnaire.getLogoImgId()+"','"+questionnaire.getBackgroundImgId()+"')");
			List<FileDetails> fileDetails=fileDetailsService.getEntityByIds(pageData1);
			for (FileDetails detail:fileDetails) {
				if(Const.FILE_CATEGORY_LOGO.equals(detail.getCategory())){
					questionnaire.setLogoImgPath(Const.FILEPATHIMG+detail.getFileId()+detail.getFileExtension());
				}else if(Const.FILE_CATEGORY_BG.equals(detail.getCategory())){
					questionnaire.setBackgroundImgPath(Const.FILEPATHIMG+detail.getFileId()+detail.getFileExtension());
				}
				byte2File(detail.getContent(),this.getRequest().getServletContext().getRealPath("uploadFiles")+File.separator+Const.IMGPATH,detail.getFileId()+detail.getFileExtension());
			}
			getQuestionnaireDataDictionary(mv,pageData);
			mv.addObject("pd", questionnaire);
			//判断是否进入星级评定的修改页面
			String questionnaireType=questionnaire.getQuestionnaireType();
			mv.addObject("respondentsForListByParentId", ConversionUtil.getStaffLevelByParentId( questionnaire.getRespondentsParentId()));
			if(Const.QUESTIONNAIRE_TYPE_STAR_LEVEL.equals(questionnaireType)){
				getHospitalCodeType(mv);
				mv.setViewName("questionnaire/questionnaire_star_level_edit");
			}else{
				mv.setViewName("questionnaire/questionnaireEdit");
			}
			mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());
			mv.addObject("msg", "edit");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	public void deleteAll(PrintWriter out) {
		logBefore(logger, "批量删除Questionnaire");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		//Map<String,Object> map = new HashMap<String,Object>();
		String message="";
		//需要移除的questionid
		List<String> removeListQuestionnaireId=new ArrayList<String>();
		try {
			pd = this.getPageData();
			//List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				List<String> listQuestionnaireId=new ArrayList<String>();
				Collections.addAll(listQuestionnaireId, ArrayDATA_IDS);
				List<PageData> listIsExistChild=questionnaireService.findListIsExistChild(pd);
				if(listIsExistChild !=null && listIsExistChild.size() != 0){
					for (int i = 0; i < listIsExistChild.size(); i++) {
						PageData pageData=listIsExistChild.get(i);
						String questionnaireId=pageData.getString("questionnaireId");
						if(listQuestionnaireId.contains(questionnaireId)){
							listQuestionnaireId.remove(questionnaireId);
							removeListQuestionnaireId.add(questionnaireId);
						}
					}
				}
				
				if(listQuestionnaireId !=null &&listQuestionnaireId.size()>0){
					ArrayDATA_IDS=(String[])listQuestionnaireId.toArray(new String[listQuestionnaireId.size()]);
					questionnaireService.updateAll(ArrayDATA_IDS);
				}
				if(removeListQuestionnaireId !=null &&removeListQuestionnaireId.size()>0 ){
					message="notAll |" + removeListQuestionnaireId.size();
				}else{
					message="all";
				}
			}else{
				message="no";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			message="no";
		} finally {
			out.write(message);
			out.close();
			logAfter(logger);
		}
		//return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出Questionnaire到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("问卷名称");	//1
			titles.add("创建日期");	//2
			titles.add("问卷状态");	//3
			titles.add("二维码");	//4
			titles.add("问卷访问地址");	//5
			titles.add("备用字段");	//6
			titles.add("备用字段");	//7
			dataMap.put("titles", titles);
			List<PageData> varOList = questionnaireService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("PAGENAME"));	//1
				vpd.put("var2", varOList.get(i).getString("CREATETIME"));	//2
				vpd.put("var3", varOList.get(i).get("PAGESTATUS").toString());	//3
				vpd.put("var4", varOList.get(i).getString("SECONDCODE"));	//4
				vpd.put("var5", varOList.get(i).getString("PAGEADDRESS"));	//5
				vpd.put("var6", varOList.get(i).getString("PAGEDATA"));	//6
				vpd.put("var7", varOList.get(i).get("PAGEDATAS").toString());	//7
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	
	/**
	 * 获取公共数据项
	 * @param mv
	 * @throws Exception
	 */
	private void getQuestionnaireDataDictionary(ModelAndView mv,PageData pd) throws Exception{
		List<Questionnaire>	questionnaireList = questionnaireService.findQuestionnaireList(pd);	//列出Question列表
		mv.addObject("questionnaireList", questionnaireList);//所属问卷
		mv.addObject("releaseStatusList",ConversionUtil.getReleaseStatus());//发布状态
		mv.addObject("staffLevels",ConversionUtil.getStaffLevel());//员工级别
		mv.addObject("status",ConversionUtil.getStatus());//数据状态
		mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());//获取调查对象类型
		mv.addObject("getHosName", ConversionUtil.getHosName());
//		获取当前用户的医院
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USERROL);		
		String path=user.getDepartment().getPATH();
		String level=user.getDepartment().getLEVE();
		if(!Tools.isEmpty(path)&&!Tools.isEmpty(level)){
			Integer levelInt=Integer.parseInt(level);
			if(path.indexOf(Const.BEIJING_YANYUAN_KANGFU_CODE_HOSPITAL)>-1){
				mv.addObject("getInterName",ConversionUtil.getInterName());
				mv.addObject("hospitalCode", Const.YANYUAN_HOSPITALID);
			}else if(path.indexOf(Const.TAIKANG_XIANLIN_GULOU_HOSPITAL_CODE)>-1){
				mv.addObject("getInterName", ConversionUtil.getXLInterName());
				mv.addObject("hospitalCode", Const.XIANLIN_HOSPITALID);
			}else if(levelInt<2 ){
				mv.addObject("hospitalCodeStr", "hospitalCodeStr");//显示两家医院
			}
		}
	}
	
	/**
	 * 文件写入磁盘目录
	 * @param buf
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	private void byte2File(byte[] buf, String filePath, String fileName){  
		
        BufferedOutputStream bos = null;  
        FileOutputStream fos = null;  
        File file = null;  
        try  
        {  
            File dir = new File(filePath);  
            if (!dir.exists() && dir.isDirectory())  
            {  
                dir.mkdirs();  
            }  
            file = new File(filePath + File.separator + fileName);  
            fos = new FileOutputStream(file);  
            bos = new BufferedOutputStream(fos);  
            bos.write(buf);  
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
        finally  
        {  
            if (bos != null)  
            {  
                try  
                {  
                    bos.close();  
                }  
                catch (IOException e)  
                {  
                    e.printStackTrace();  
                }  
            }  
            if (fos != null)  
            {  
                try  
                {  
                    fos.close();  
                }  
                catch (IOException e)  
                {  
                    e.printStackTrace();  
                }  
            }  
        }  
    } 
	
	/**
	 * 文件流转对象
	 * @param logoImgFile
	 * @param backgroundImgFile
	 * @param questionnaireData
	 * @throws Exception
	 */
	private void multipartFileTransformFileDetail(MultipartFile logoImgFile,MultipartFile backgroundImgFile,Questionnaire questionnaireData)throws Exception{
		List<FileDetails> fileDetails=new ArrayList<FileDetails>();
        FileDetails detail=new FileDetails();
        if(null !=logoImgFile && !logoImgFile.isEmpty()){
        	if(Tools.isEmpty(questionnaireData.getLogoImgId())){
        		questionnaireData.setLogoImgId(this.get32UUID());
        		detail.setCreateTime(Tools.date2Str(new Date()));
        	}else{
        		detail.setModifyTime(Tools.date2Str(new Date()));
        	}
	        byte [] logoData=logoImgFile.getBytes();
	        String logoFileName = logoImgFile.getOriginalFilename().toLowerCase(); 
	        detail.setFileId(String.valueOf(questionnaireData.getLogoImgId()));
	        detail.setOwnershipMasterId(questionnaireData.getQuestionnaireId());
	        detail.setContent(logoData);
	        detail.setCategory(Const.FILE_CATEGORY_LOGO);
	        detail.setFileName(logoFileName);
	        detail.setFileExtension(logoFileName.substring(logoFileName.lastIndexOf(".")));
	        //model.addAttribute("fileUrl", request.getContextPath()+"/upload/"+logoFileName); 
	        fileDetails.add(detail);
        }else{
        	//questionnaireData.setLogoImgId(null);
        }
//        fileDetailsService.save(detail);
        if(null !=backgroundImgFile && !backgroundImgFile.isEmpty()){
        	detail=new FileDetails();
        	if(Tools.isEmpty(questionnaireData.getBackgroundImgId())){
        		questionnaireData.setBackgroundImgId(this.get32UUID());
        		detail.setCreateTime(Tools.date2Str(new Date()));
        	}else{
        		detail.setModifyTime(Tools.date2Str(new Date()));
        	}
	        String bgFileName = backgroundImgFile.getOriginalFilename().toLowerCase();  
	        byte [] backgroundImgData=backgroundImgFile.getBytes();
	        detail.setFileId(String.valueOf(questionnaireData.getBackgroundImgId()));
	        detail.setOwnershipMasterId(questionnaireData.getQuestionnaireId());
	        detail.setContent(backgroundImgData);
	        detail.setCategory(Const.FILE_CATEGORY_BG);
	        detail.setFileName(bgFileName);
	        detail.setFileExtension(bgFileName.substring(bgFileName.lastIndexOf(".")));
	        fileDetails.add(detail);
        }else{
        	//questionnaireData.setBackgroundImgId(null);
        }
        questionnaireData.setFileDetails(fileDetails);
	}
	/**
	 * 加载二维码下载页面
	 * @return
	 */
	@RequestMapping(value="/uploadEnCode")
	public ModelAndView uploadEnCode(){
		ModelAndView model=new ModelAndView();
		PageData pd=this.getPageData();
		try {
			Questionnaire questionnaire = questionnaireService.getEntityById(pd);	//根据ID读取
			String level=pd.getString("level");
			if(level!=null&&!level.isEmpty()){
				//根据questionnaireId获取             调查对象父类id 				开始
				Map<String,String> mapTotal = new HashMap<String,String>();
				mapTotal=ConversionUtil.getStaffLevelByParentId(questionnaire.getRespondentsParentId());
//				String levelStr=ConversionUtil.getStaffLevel().get(level);
				String levelStr=mapTotal.get(level);
				pd.put("level", levelStr);
			}
			FileDetails file=fileDetailsService.getFileByQIDAndLevel(pd);
			MapEntity entity=new MapEntity();
			entity.setKey("uploadFiles"+File.separator+"file"+File.separator+file.getFileName());
			entity.setValue(file.getFileTitle());
			entity.setEnCodePath(file.getEnCodePath());
			// addby shanghz 短链接字段
			entity.setShortUrl(file.getShortUrl());
			
			byte2File(file.getContent(),this.getRequest().getServletContext().getRealPath("uploadFiles")+File.separator+"file",file.getFileName());
			model.addObject("file",file);
			model.setViewName("questionnaire/uploadQR");
			model.addObject("entity",entity);
			model.addObject("questionnaire",questionnaire);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除图片
	 * @param out
	 */
	@RequestMapping(value="/deletePicture")
	public void deletePicture(PrintWriter out){
		logBefore(logger, "删除Questionnaire图片");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			Questionnaire questionnaire=new Questionnaire();
			questionnaire.setQuestionnaireId(pd.getString("questionnaireId"));
			questionnaire.setModifyTime(DateUtil.getTime());
			// 获取当前登录用户的信息以及其子级部门列表
			User user = Jurisdiction.getLoginUser();
			questionnaire.setModifyUser(user.getUSER_ID());
			String type=pd.getString("type");
			//logo
			if(type!=null && !type.isEmpty() &&type.equals("logoImgPath")){
				questionnaire.setLogoImgId("");
			//background
			}else if(type!=null && !type.isEmpty() &&type.equals("backgroundImgPath")){
				questionnaire.setBackgroundImgId("");
			}
			questionnaireService.deletePicture(pd,questionnaire);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	/**
	 * 复制问卷
	 * @param out
	 */
	@RequestMapping(value="/copyQuestion")
	public ModelAndView copyQuestion(HttpServletRequest request){
		logBefore(logger, "复制问卷Questionnaite");
		PageData pd = new PageData();
		ModelAndView mv = new ModelAndView();
		try {
			pd = this.getPageData();
			String path = request.getContextPath();
	        String baseP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"+"zj/url?c=";
	        pd.put("shortUri", baseP);
			questionnaireService.saveCopyQuestionList(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 去复制问卷页面
	 * @return
	 */
	@RequestMapping(value="/goCopyQuestionnaire")
	public ModelAndView goCopyQuestionnaire(){
		logBefore(logger, "去复制问卷Questionnaite页面");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			Questionnaire questionnaire = questionnaireService.getEntityById(pd);//查询复制问卷
			mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());//获取调查对象类型
			mv.addObject("respondentsForListByParentId", ConversionUtil.getStaffLevelByParentId(questionnaire.getRespondentsParentId()));
			mv.addObject("questionnaire",questionnaire);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("pd",pd);
		mv.setViewName("questionnaire/questionnaireCopy");
		return mv;
	}
	@RequestMapping(value="/goTransfer")
	public ModelAndView goTransferQuestionnaire(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		User user = Jurisdiction.getLoginUser();
		try {
			pd = this.getPageData();
			List<PageData> zrolePdList = new ArrayList<PageData>();
			List<PageData> departmentList = departmentService.listAllDepartmentToSelect(user.getDepartment().getDEPARTMENT_ID(),zrolePdList); //部门
			if(!"0".equals(user.getDepartment().getDEPARTMENT_ID())){  //部门下拉框+自己部门
				PageData pdf = new PageData();
				pdf.put("DEPARTMENT_ID", user.getDepartment().getDEPARTMENT_ID());
				PageData pdfEntity= departmentService.findById(pdf);
				PageData p = new PageData();
				p.put("id", pdfEntity.getString("DEPARTMENT_ID"));
				p.put("parentId", pdfEntity.getString("PARENT_ID"));
				p.put("name", pdfEntity.getString("NAME"));
				p.put("icon", "static/images/user.gif");
				departmentList.add(p);
			}
			mv.addObject("pd",pd);
			JSONArray arr = JSONArray.fromObject(departmentList);
			mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
			mv.setViewName("questionnaire/questionnaireTransfer");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	//查询部门下员工
	@RequestMapping(value="/findDepartmentUser")
	@ResponseBody
	public List<PageData> findDepartmentUser(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			List<PageData> list = userService.findByDepartment(pd);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 问卷转移
	 * @return
	 */
	@RequestMapping(value="/saveTransfer")
	public ModelAndView saveTransfer(){
		ModelAndView mv = new ModelAndView(); 
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			questionnaireService.updateQuestionnaireDepartment(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	/**
	 * 加载新增星际问卷的页面
	 * @return
	 *2017年11月2日
	 * xiaoding
	 */
	@RequestMapping(value="/goAddForStarLevel")
	public ModelAndView goAddForStarLevel(){
		logBefore(logger, "去新增星级问卷Questionnaire页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			getQuestionnaireDataDictionary(mv,pd);
			//获取医院代码基础编码
			getHospitalCodeType(mv);
			mv.setViewName("questionnaire/questionnaire_star_level_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		//	mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	/**
	 * 根据调差对象类型查询具体的调察对象
	 * @return
	 *2017年11月2日
	 * xiaoding
	 */
	@RequestMapping(value="/getRespondentsForParentIdByAjax")
	@ResponseBody
	public  Object getRespondentsForParentIdByAjax(){
		logBefore(logger, "异步加载调查对象的");
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,String> map = new HashMap<String,String>();
		Map<String,String> map1 = new HashMap<String,String>();
		try{
			String parentId=pd.getString("parentId");
			map1=ConversionUtil.getStaffLevelByParentId(parentId);
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("respondents", transformToJson(map1));
		return  AppUtil.returnObject(new PageData(),map);
	}
	/**
	 * map2json(javascript json)
	 * @param map
	 * @return
	 */
	private String transformToJson(Map<String,String> map){ 
        StringBuilder json = new StringBuilder();  
        json.append("[");
        for (String key : map.keySet()) {
        	if (!Tools.isEmpty(key)&&!Tools.isEmpty(map.get(key))){
        		json.append("{key:'"+key+"',value:'"+map.get(key)+"'},");
        	}
		}
        if(json.length()>0 && (json.lastIndexOf(",")==(json.length()-1))){
        	json.deleteCharAt(json.length()-1);
        }
        json.append("]");
        return json.toString();  
	}
	/**
	 * 根据医院编码获取医院接口
	 * @return
	 *2017年11月2日
	 * xiaoding
	 */
	@RequestMapping(value="/changeHospitalCode")
	@ResponseBody
	public  Object changeHospitalCode(){
		logBefore(logger, "异步加载调查对象的");
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,String> map = new HashMap<String,String>();
		Map<String,String> map1 = new HashMap<String,String>();
		try{
			String data=pd.getString("data");
			if(Const.YANYUAN_HOSPITALID.equals(data)){
				map1=ConversionUtil.getInterName();
			}else if(Const.XIANLIN_HOSPITALID.equals(data)){
				map1=ConversionUtil.getXLInterName();
			}
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("respondents", transformToJson(map1));
		return  AppUtil.returnObject(new PageData(),map);
	}
	
	/**
	 * 
	 * @param mv
	 *2017年12月26日
	 * xiaoding
	 */
	private void getQuestionnaireTypeForAll(ModelAndView mv){
		mv.addObject("QUESTIONNAIRE_TYPE_COMMON", Const.QUESTIONNAIRE_TYPE_COMMON);
		mv.addObject("QUESTIONNAIRE_TYPE_STAR_LEVEL", Const.QUESTIONNAIRE_TYPE_STAR_LEVEL);
		mv.addObject("QUESTIONNAIRE_TYPE_CUSTOM_TEMPLATE", Const.QUESTIONNAIRE_TYPE_CUSTOM_TEMPLATE);
	}
	/**
	 * 
	 * 
	 *2017年12月26日
	 * xiaoding
	 */
	private void getHospitalCodeType(ModelAndView mv){
		mv.addObject("XIANLIN_HOSPITALID", Const.XIANLIN_HOSPITALID);
		mv.addObject("YANYUAN_HOSPITALID", Const.YANYUAN_HOSPITALID);
	}
}

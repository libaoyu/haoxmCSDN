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

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.FileDetails;
import com.fh.entity.system.Questionnaire;
import com.fh.entity.system.Questions;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.questionnaire.FileDetailsService;
import com.fh.service.questionnaire.LinkagePullDataService;
import com.fh.service.questionnaire.QuestionnaireService;
import com.fh.service.questionnaire.QuestionsHeaderService;
import com.fh.service.questionnaire.QuestionsService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * 类名称：QuestionsController
 * 创建人：zhangxq 
 * 创建时间：2017-04-28
 */
@Controller
@RequestMapping(value="/questions")
public class QuestionsController extends BaseController {
	
	
	String menuUrl = "questions/list.do"; //菜单地址(权限用)
	@Resource(name="questionsService")
	private QuestionsService questionsService;
	@Resource(name="questionnaireService")
	private QuestionnaireService questionnaireService;
	@Resource(name="questionsHeaderService")
	QuestionsHeaderService questionsHeaderService;
	@Resource(name="linkagePullDataService")
	private LinkagePullDataService linkagePullDataService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="fileDetailsService")
	private FileDetailsService fileDetailsService;
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(@ModelAttribute("questionsData")Questions questionsData,@RequestParam(value = "ImgFile", required = false) MultipartFile[] files) throws Exception{
		logBefore(logger, "新增Questionnaire");
		ModelAndView mv = this.getModelAndView();		
		questionsData.setQuestionId(this.get32UUID());
		questionsData.setQuestionData(this.transformToJson(questionsData.getQuestionData_code(),questionsData.getQuestionData_name(),files,questionsData));
		questionsData.setCreateTime(DateUtil.getTime());
		questionsService.save(questionsData);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 * 新增指定位置问题
	 */
	@RequestMapping(value="/pointSave")
	public ModelAndView pointSave(@ModelAttribute("questionsData")Questions questionsData,@RequestParam(value = "ImgFile", required = false) MultipartFile[] files) throws Exception{
		logBefore(logger, "新增Questionnaire");
		ModelAndView mv = this.getModelAndView();		
		questionsData.setQuestionId(this.get32UUID());
		questionsData.setQuestionData(this.transformToJson(questionsData.getQuestionData_code(),questionsData.getQuestionData_name(),files,questionsData));
		questionsData.setCreateTime(DateUtil.getTime());
		questionsService.savePoint(questionsData);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除Questions");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//判断是否存在子数据
			List<PageData>listParentId=questionsHeaderService.finParentIdByQuestionsId(pd);
			//判断是否存在结果
			List<PageData> listQuestionResult=questionsHeaderService.findCoutQuestioneResult(pd);
			if((listQuestionResult==null || listQuestionResult.size()==0) && (listParentId == null || listParentId.size()==0)){
				questionsService.update(pd);
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
	public ModelAndView edit(@ModelAttribute("questionsData")Questions questionsData,@RequestParam(value = "ImgFile", required = false) MultipartFile[] files) throws Exception{
		logBefore(logger, "修改Questions");
		ModelAndView mv = this.getModelAndView();
		questionsData.setQuestionData(this.transformToJson(questionsData.getQuestionData_code(),questionsData.getQuestionData_name(),files,questionsData));
		questionsData.setModifyTime(DateUtil.getTime());
		questionsData.setModifyUser(Jurisdiction.getLoginUser().getUSER_ID());
		questionsService.edit(questionsData);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	
	
	/**
	 * 获取问题列表
	 * @author zhangxq
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		logBefore(logger, "列表Questions");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
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
			page.setPd(pd);
			List<Questions>	varList = questionsService.list(page);	//列出一级Question列表
			for (int i = 0; i < varList.size(); i++) {
				Questions entity=varList.get(i);
				//问卷调查对象调整--------------开始
				String respondentsStr=entity.getLevel();
				StringBuffer respondentsName=new StringBuffer();
				if(respondentsStr!=null&&respondentsStr!=""){
					Map<String,String> map=ConversionUtil.getStaffLevel();
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
					varList.get(i).setLevel(respondentsName.toString());
				}
			}
			
			
			getDataDictionary(mv,"",pd);
			mv.setViewName("questionnaire/questionsList");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 树状数据展示
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/treeList")
	public ModelAndView treeList(Page page){
		logBefore(logger, "列表Questions");
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
			page.setPd(pd);
			List<Questions>	parentList = questionsService.onelist(page);
			List<Questions> childList=questionsService.childList(pd);
			
			for (int i = 0; i < parentList.size(); i++) {
				Questions entity=parentList.get(i);
				//问卷调查对象调整--------------开始
				String respondentsStr=entity.getLevel();
				StringBuffer respondentsName=new StringBuffer();
				if(respondentsStr!=null&&respondentsStr!=""){
					Map<String,String> map=ConversionUtil.getStaffLevel();
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
					parentList.get(i).setLevel(respondentsName.toString());
				}
				//获取对应二级列表
				List<Questions> toParent = new ArrayList<Questions>();
				for (Questions questions : childList) {
					if(entity.getQuestionId().equals(questions.getParentId())){
						toParent.add(questions);
					}
				}
				if(toParent.size()>0){
					entity.setSUBQUESTIONS(toParent);
				}
				
			}
			//查询此问卷类目头尾
			pd.put("classification", "L1");
			List<PageData> questionCodeListL1 = questionsService.findQuestionCode(pd);
			pd.put("classification", "L0");
			List<PageData> questionCodeListL0 = questionsService.findQuestionCode(pd);
			pd.remove("classification");
			
			getDataDictionary(mv,"",pd);
			mv.setViewName("questionnaire/questions_List");
			mv.addObject("varList", parentList);
			mv.addObject("codeL1Count",questionCodeListL1.size());
			mv.addObject("codeL0Count",questionCodeListL0.size());
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping(value="/questionsList")
	@ResponseBody
	public Object questionList(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = this.getPageData();
		List<PageData> pdList = null;
		try {
			pdList = questionsService.findByPageId(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 问题上移(只限制同类)
	 * @return
	 */
	@RequestMapping(value="/upMove")
	@ResponseBody
	public Object upMove(){
		logBefore(logger, "问题上下移动开始");
		PageData pd = new PageData();
		Map<String,String> map = new HashMap<String,String>();
		try {
			synchronized (this) {
				pd = this.getPageData();
				List<PageData> questions = questionsService.findByFlag(pd);
				if(questions.size()>0){
					PageData pageDataOld = questions.get(0);
					List<PageData> listQuestions =questionsService.findByParentId(pageDataOld);
					int index = listQuestions.indexOf(questions.get(0));
					if(listQuestions.size()>1){
						PageData qDown = new PageData();
						//顶部转尾部
						if(("up".equals(pd.get("move")) && index == 0)){
							PageData topPd = listQuestions.get(0);
							listQuestions.remove(0);
							listQuestions.add(topPd);
							questionsService.updateOldCodeById(listQuestions);
							map.put("result", "success");
							return AppUtil.returnObject(new PageData(),map);
						}
						if(("down".equals(pd.get("move")) && index==listQuestions.size()-1)){
							PageData bottomPd = listQuestions.get(listQuestions.size()-1);
							listQuestions.remove(listQuestions.size()-1);
							listQuestions.add(0,bottomPd);
							questionsService.updateOldCodeById(listQuestions);
							map.put("result", "success");
							return AppUtil.returnObject(new PageData(),map);
						}
						//获取被移动数据
						if("up".equals(pd.get("move")) && index != 0){
							index = index - 1;
							logBefore(logger, "问题上移");
						}else if("down".equals(pd.get("move")) && index!=listQuestions.size()-1){
							index = index + 1;
							logBefore(logger, "问题下移");
						}
						qDown = listQuestions.get(index);
						if(pageDataOld.get("questionCode")!=null && !"".equals(pageDataOld.get("questionCode"))){
							String questionCodeNew = pageDataOld.getString("questionCode");
							pageDataOld.put("questionCode", qDown.get("questionCode"));
							qDown.put("questionCode", questionCodeNew);
						}
						int qup = (Integer) pageDataOld.get("sort");
						//开始移动
						pageDataOld.put("sort", qDown.get("sort"));
						questionsService.edit(pageDataOld);
						qDown.put("sort", qup);
						questionsService.edit(qDown);
						map.put("result", "success");
					}
				}
			}
			
		} catch (Exception e) {
			logger.error(e.toString(),e);
		}
		return AppUtil.returnObject(new PageData(),map);
	}
	/**
	 * 新增编码序号自动填充
	 * @return
	 */
	@RequestMapping(value="/findCode")
	@ResponseBody
	public Object getQuestionCode(){
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> questionCodeList = questionsService.findQuestionCode(pd);
			PageData code = null;
			List<String> codeList = new ArrayList<String>();
			if(questionCodeList.size()>0){
				code = questionCodeList.get(questionCodeList.size()-1);
			}
			if("L1".equals(pd.get("classification")) ){
				Map<String,String> codeMap = ConversionUtil.getDefaultQuestionCode();
				Iterator<String> it = codeMap.keySet().iterator();
				while (it.hasNext()) {
					String key = it.next();
					codeList.add(codeMap.get(key));
				}
				int index=0;
				if(code!=null){
					index = codeList.indexOf(code.get("questionCode"));
				}
				map.put("key", codeList.get(index+1));
			}
			if(code!=null){
				int sort = (Integer) code.get("sort");
				map.put("sort", sort+1);
			}else{
				map.put("sort", "1");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return AppUtil.returnObject(new PageData(),map);
	}
	
	/**
	 * 指定新增位置页面
	 * @return
	 */
	@RequestMapping(value="/goPointAdd")
	public ModelAndView goPointAdd(){
		logBefore(logger, "去指定新增Questions页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Questions question=new Questions();
		question.setMustFlag(1);
		question.setScaleRange(5);
		question.setQuestionnaireId(pd.getString("questionnaireId"));
		//获取指定位置数据
		String questionCodeNew ="";
		Integer sortNew=0;
		String classification ="";
		PageData pointPd = new PageData();
		try {
			pointPd = questionsService.findById(pd);
			questionCodeNew = pointPd.getString("questionCode");
			sortNew = (Integer) pointPd.get("sort");
			classification = pointPd.getString("classification");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		List<String> code = ConversionUtil.getQuestionCode();
		if("down".equals(pd.get("point"))){
			if(!Tools.isEmpty(questionCodeNew)){
				questionCodeNew = code.get(code.indexOf(questionCodeNew)+1);
			}
			sortNew = sortNew+1;
		}
		question.setQuestionCode(questionCodeNew);
		question.setSort(sortNew);
		question.setClassification(classification);
		question.setParentId(pointPd.getString("parentId"));
		try {
			getDataDictionary(mv,"",pd);//加载数据项
			mv.addObject("msg", "pointSave");
			mv.addObject("question", question);
			mv.addObject("pd",pd);
			getQuestionnaireTypeForAll(mv);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		mv.setViewName("questionnaire/questionsEdit");
		return mv;
		
		
	}
	/**
	 * 去新增页面
	 * questionnaireType=custom_template_questionnaire
	 * QUESTIONNAIRE_TYPE_CUSTOM_TEMPLATE=custom_template_questionnaire
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Questions页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Questions question=new Questions();
		question.setMustFlag(1);
		question.setScaleRange(5);
		question.setQuestionnaireId(pd.getString("questionnaireId"));
		
		try {
			//根据问卷id获取调查对象                  开始
			getLevelByQuestionnaireId(pd.getString("questionnaireId"),mv);
			getQuestionnaireTypeForAll(mv);
			//根据问卷id获取调查对象                  结束
			mv.addObject("msg", "save");
			mv.addObject("question", question);
			getDataDictionary(mv,"",pd);//加载数据项
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		mv.setViewName("questionnaire/questionsEdit");
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改Questions页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
//			pd = questionsService.findById(pd);	//根据ID读取
			Questions questions = questionsService.findByQuestionId(pd);	//列出Question列表
			if("1".equals(questions.getIsShow())){
				pd.put("questionnaireId", questions.getQuestionnaireId());
				mv.addObject("questionShow", findQuestionCommon(pd));
			}
			if("T13".equals(questions.getTypes()) || "T14".equals(questions.getTypes())){
				JSONArray jsonArr = JSONArray.fromObject(questions.getQuestionData());
				if(jsonArr != null){
					for (int i = 0; i < jsonArr.size(); i++) {
						JSONObject jb = jsonArr.getJSONObject(i);
						PageData pd2 = new PageData();
						pd2.put("fileId", jb.optString("img"));
						FileDetails detail =  fileDetailsService.getEntityById(pd2);
						if(detail!=null){
							jsonArr.getJSONObject(i).put("imgPath", Const.FILEPATHIMG+detail.getFileId()+detail.getFileExtension());
							byte2File(detail.getContent(),this.getRequest().getServletContext().getRealPath("uploadFiles")+File.separator+Const.IMGPATH,detail.getFileId()+detail.getFileExtension());
						}
					}
				}
				questions.setQuestionData(jsonArr.toString());
			}
			
			mv.addObject("question", questions);
			//根据问卷id获取调查对象                  开始
			getLevelByQuestionnaireId(questions.getQuestionnaireId(),mv);
			//根据问卷id获取调查对象                  结束
			getDataDictionary(mv,questions.getQuestionnaireId(),pd);//加载数据项
			mv.addObject("msg", "edit");
			mv.addObject("pd",pd);
			getQuestionnaireTypeForAll(mv);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		mv.setViewName("questionnaire/questionsEdit");
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	public void deleteAll(PrintWriter out) {
		logBefore(logger, "批量删除Questions");
		PageData pd = new PageData();		
		//Map<String,Object> map = new HashMap<String,Object>();
		String message="";
		//需要移除的questionid
		List<String> removeListQuestionId=new ArrayList<String>();
		try {
			pd = this.getPageData();
			//List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				List<String> listQuestionId=new ArrayList<String>();
				Collections.addAll(listQuestionId, ArrayDATA_IDS);
				//判断是否存在子数据
				List<PageData>listParentId=questionsHeaderService.finParentIdByQuestionsId(pd);
				if(listParentId !=null && listParentId.size()>0){
					for (int i = 0; i < listParentId.size(); i++) {
						PageData pageData=listParentId.get(i);
						String questionId=pageData.getString("parentId");
						if(listQuestionId.contains(questionId)){
							listQuestionId.remove(questionId);
							removeListQuestionId.add(questionId);
						}
					}
				}
				//判断结果表里面是否存在对应问题的结果
				List<PageData> listQuestionResult=questionsHeaderService.findCoutQuestioneResult(pd);
				if(listQuestionResult !=null && listQuestionResult.size() != 0){
					for (int i = 0; i < listQuestionResult.size(); i++) {
						PageData pageData=listQuestionResult.get(i);
						String questionId=pageData.getString("questionId");
						if(listQuestionId.contains(questionId)){
							listQuestionId.remove(questionId);
							removeListQuestionId.add(questionId);
						}
					}
				}
				if(listQuestionId !=null &&listQuestionId.size()>0){
					ArrayDATA_IDS=(String[])listQuestionId.toArray(new String[listQuestionId.size()]);
					questionsService.updateAll(ArrayDATA_IDS);
				}
				if(removeListQuestionId !=null &&removeListQuestionId.size()>0 ){
					message="notAll |" + removeListQuestionId.size();
				}else{
					message="all";
				}
			}else{
				message="no";
			}
			//pdList.add(pd);
			//map.put("list", pdList);
		} catch (Exception e) {
			message="no";
			logger.error(e.toString(), e);
		} finally {
			out.print(message);
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
		logBefore(logger, "导出Questions到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("问题标题");	//1
			titles.add("问题编号");	//2
			titles.add("问卷编号");	//3
			titles.add("问题类型");	//4
			titles.add("问题分值");	//5
			dataMap.put("titles", titles);
			List<PageData> varOList = questionsService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("QUESTIONTITLE"));	//1
				vpd.put("var2", varOList.get(i).getString("QUESTIONCODE"));	//2
				vpd.put("var3", varOList.get(i).getString("QUESTIONPAGE"));	//3
				vpd.put("var4", varOList.get(i).get("QUESTIONTYPE").toString());	//4
				vpd.put("var5", varOList.get(i).get("QUESTIONSCORE").toString());	//5
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
	 * 根据问卷分类（卷头、一级分类、二级分类）
	 * 获取所属的问题题型列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/level_change")
	@ResponseBody
	public Object getQuestionTypeByLevel()throws Exception{
		logBefore(logger,"问题分类修改...");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String option=pd.getString("levelOption");
		String questionnaireType=pd.getString("questionnaireType");
		String resultInfo = "success";
		Map<String, String> types=ConversionUtil.getQuestionType(option,questionnaireType);
		//JSONObject json=new JSONObject((Map)maps);
		//String jsonStr=json.toJSONString();
		map.put("result", transformToJson(types));
		return AppUtil.returnObject(new PageData(),map);
	}
	
	/**
	 * 获取该问卷的所属一级问题
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/questionnaire_change")
	@ResponseBody
	public Object getQuestionOneLevelById()throws Exception{
		logBefore(logger,"问题分类修改...");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String questionnaireId=pd.getString("questionnaireId");
		String levels=pd.getString("levels");
		String resultInfo = "success";
		List<Map> OneLevels=getOneLevelAll(questionnaireId,levels);
		Questionnaire questionnaire=questionnaireService.getEntityById(pd);
		
		//根据questionnaireId获取             调查对象父类id 				开始
		Map<String,String> mapTotal = new HashMap<String,String>();
		mapTotal=ConversionUtil.getStaffLevelByParentId(questionnaire.getRespondentsParentId());
		//根据questionnaireId获取             调查对象父类id 				结束
		List<Map> respondents=new ArrayList<Map>();
		Map<String,String> map1=new HashMap<String,String>();
		if(questionnaire !=null && !Tools.isEmpty(questionnaire.getRespondents())){
			for (String str:questionnaire.getRespondents().split(",")) {
//				map1.put(str, ConversionUtil.getStaffLevel().get(str));
				map1.put(str, mapTotal.get(str));//从获取到的调查对象取值
			}
		}
		map.put("result", transformListToJson(OneLevels, "questionId","title"));
		//if(map1!=null && map1.size()>0){
		map.put("respondents", transformToJson(map1));
		//}
		return AppUtil.returnObject(new PageData(),map);
	}
	
	@RequestMapping(value="findQuestions")
	@ResponseBody
	public List<PageData> findQusetions(){
		List<PageData> pdList = new ArrayList<PageData>();
		PageData pd = this.getPageData();
		pdList = findQuestionCommon(pd);
		
		return pdList;
	}
	
	public List<PageData> findQuestionCommon(PageData pd){
		List<PageData> pdList = new ArrayList<PageData>();
		try {
			pd.put("classification", "'L0','L1'");
			List<PageData> pdListOne = questionsService.findQuestions(pd);
			pd.put("classification", "'L2'");
			List<PageData> pdListTwo = questionsService.findQuestions(pd);
			if(pdListOne != null ){
				if(pdListTwo != null){
					for (PageData pdOne : pdListOne) {
						if("L1".equals(pdOne.getString("classification"))){
							pdOne.put("title", pdOne.getString("questionCode")+pdOne.getString("title"));
						}
						pdList.add(pdOne);
						for (PageData pdTwo : pdListTwo) {
							if(pdTwo.getString("parentId").equals(pdOne.getString("questionId"))){
								pdList.add(pdTwo);
							}
						}
					}
				}else{
					pdList.addAll(pdListOne);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pdList;
	}
	
	/**
	 * 删除图片
	 * @param out
	 */
	@RequestMapping(value="/deletePicture")
	public void deletePicture(PrintWriter out){
		logBefore(logger, "删除Questions图片");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			fileDetailsService.deleteById(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	
	/**
	 * 多个数据项转换为json数据格式
	 * @param keys
	 * @param values
	 * @return
	 * @throws IOException 
	 */
	private String transformToJson(String keys,String values,MultipartFile[] files,Questions questions) throws IOException{ 
	        StringBuilder json = new StringBuilder();  
	        json.append("[");//datas:
	        if (!Tools.isEmpty(keys)&&!Tools.isEmpty(values) && !Tools.isEmpty(keys.replace(",","")) && !Tools.isEmpty(values.replace(",",""))) {
	        	String [] valueArray=values.split(","); 
	        	String [] keyArray=keys.split(",");
	        	List<FileDetails> fileDetails=new ArrayList<FileDetails>();
	            for (int i=0;i<keyArray.length;i++) {  
	                json.append("{key:").append("\""+keyArray[i]+"\",");  
	                if(files!=null && files.length>0){
	                	MultipartFile file = files[i];
	                	if(file!=null && !file.isEmpty()){
	                		FileDetails detail=new FileDetails();
	                		String detailid ="";
	                		if(questions.getQuestionData().isEmpty()){
	                			detailid = this.get32UUID();
	                			detail.setCreateTime(Tools.date2Str(new Date()));
	                		}else{
	                			JSONArray jsonArr = JSONArray.fromObject(questions.getQuestionData());
	                			if(i<jsonArr.size()){
	                				JSONObject j = (JSONObject) jsonArr.get(i);
	                				detailid = j.getString("img");
	                			}else{
	                				detailid = this.get32UUID();
	                			}
	                			detail.setModifyTime(Tools.date2Str(new Date()));
	                		}
	                		json.append("img:").append("\""+detailid+"\",");
	                		byte [] logoData=files[i].getBytes();
	                		String logoFileName = files[i].getOriginalFilename().toLowerCase(); 
	                		detail.setFileId(detailid);
	                		detail.setOwnershipMasterId(questions.getQuestionnaireId());
	                		detail.setContent(logoData);
	                		detail.setCategory(Const.FILE_CATEGORY_TOPIC);
	                		detail.setFileName(logoFileName);
	                		detail.setFileExtension(logoFileName.substring(logoFileName.lastIndexOf(".")));
	                		fileDetails.add(detail);
	                	}else if("T13".equals(questions.getTypes()) || "T14".equals(questions.getTypes())){
	                		JSONArray jsonArr = JSONArray.fromObject(questions.getQuestionData());
	                		JSONObject j = (JSONObject) jsonArr.get(i);
	                		String detailid = j.getString("img");
	                		json.append("img:").append("\""+detailid+"\",");
	                	}
	                }
	                json.append("value:").append("\""+valueArray[i]+"\"},");
	            }
	            questions.setFileDetails(fileDetails);
	            json.setCharAt(json.length() - 1, ']');
	        } else {  
	            json.append("]");  
	        }  
	        return json.toString();  
	}
	/**
	 * 文件流转对象
	 * @param logoImgFile
	 * @param backgroundImgFile
	 * @param questionnaireData
	 * @throws Exception
	 */
	private void multipartFileTransformFileDetail(MultipartFile[] imgFile,Questions Questions,boolean flag)throws Exception{
		List<FileDetails> fileDetails=new ArrayList<FileDetails>();
        FileDetails detail=new FileDetails();
        if(null !=imgFile && (imgFile.length>0)){
        	for (int i = 0; i < imgFile.length; i++) {
        		byte [] logoData=imgFile[i].getBytes();
    	        String logoFileName = imgFile[i].getOriginalFilename().toLowerCase(); 
    	        detail.setFileId(this.get32UUID());
    	        detail.setOwnershipMasterId(Questions.getQuestionnaireId());
    	        detail.setContent(logoData);
    	        detail.setCategory(Const.FILE_CATEGORY_LOGO);
    	        detail.setFileName(logoFileName);
    	        detail.setFileExtension(logoFileName.substring(logoFileName.lastIndexOf(".")));
    	        fileDetails.add(detail);
			}
	        
        }else{
        	//questionnaireData.setLogoImgId(null);
        }
        Questions.setFileDetails(fileDetails);
	}
	
	
	/**
	 * 获取公共数据项
	 * @param mv
	 * @throws Exception
	 */
	private void getDataDictionary(ModelAndView mv,String questionnaireId,PageData pd) throws Exception{
		this.getUserHC(pd, departmentService);
		List<Questionnaire>	questionnaireList = questionnaireService.findQuestionnaireList(pd);	//列出Question列表
		mv.addObject("questionnaireList", questionnaireList);//所属问卷
		String questionnaireType=pd.getString("questionnaireType");
		mv.addObject("questionTypes",ConversionUtil.getQuestionType("",questionnaireType));//问题类型
		mv.addObject("releaseStatus",ConversionUtil.getReleaseStatus());//发布状态
		mv.addObject("scaleTypes",ConversionUtil.getScaleType());//量表类型
		//mv.addObject("staffLevels",ConversionUtil.getStaffLevel());//员工级别
		mv.addObject("status",ConversionUtil.getStatus());//数据状态
		mv.addObject("classifications",ConversionUtil.getClassification());//问题分类
		mv.addObject("questionCodes",ConversionUtil.getDefaultQuestionCode());//默认英文字母字符编码
		//获取日历类型的类型
		mv.addObject("scaleTypesForT7", ConversionUtil.getScaleTypeForT7());
		//获取复选框的排列方式
		mv.addObject("scaleTypeForT2", ConversionUtil.getScaleTypeForT2());
		//获取联动下拉框      内容
		mv.addObject("listOneLevel", linkagePullDataService.listOneLevel(pd));
		//推荐意向题
		mv.addObject("scaleTypeForT16", ConversionUtil.getScaleTypeForT16());
		//获取问诊信息的排列方式
		mv.addObject("inquiryInformationArray", ConversionUtil.getInquiryInformationArray());
		//获取分割线的类型（实线，还是虚线）
		mv.addObject("cutoffRule", ConversionUtil.getCutoffRule());
		//获取该问卷下的所有一级分类问题
		if(!Tools.isEmpty(questionnaireId)){
			mv.addObject("parentList",getOneLevelAll(questionnaireId,""));//该问卷下的所属一级分类
		}
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
	 * List<map>2json(javascript json)
	 * @param map
	 * @return
	 */
	private String transformListToJson(List<Map> list,String key,String valueKey){ 
        StringBuilder json = new StringBuilder();  
        json.append("[");
        for (Map map : list) {
        	if (null !=map){
        		json.append("{key:'"+map.get(key)+"',value:'"+map.get(valueKey)+"'},");
        	}
		}
        if(json.length()>0 && (json.lastIndexOf(",")==(json.length()-1))){
        	json.deleteCharAt(json.length()-1);
        }
        json.append("]");
        return json.toString();  
	}
	
	/**
	 * 获取当前文件一级
	 * @return
	 * @throws Exception
	 */
	private List<Map> getOneLevelAll(String questionnaireId,String levels) throws Exception{
		Map<String,String> parameters=new HashMap();
		StringBuffer sqlBuf=new StringBuffer();
		sqlBuf.append("select CONCAT(IFNULL(questionCode,''),IFNULL(title,''))title,questionId from tb_questions q where parentId is null AND classification='L1' AND questionnaireId=#{questionnaireId} and status = 1 ");
		if(!Tools.isEmpty(levels)){
			String sqlLevel="";
			if(levels.indexOf("|")>0){
				for (String level : levels.split("\\|")) {
					sqlLevel+="level like '%"+level+"%' or ";
				}
				sqlLevel=sqlLevel.substring(0,sqlLevel.lastIndexOf("or"));
				sqlBuf.append("AND (").append(sqlLevel).append(")");
			}else if(levels.indexOf(",")<0){
				sqlBuf.append("AND level like '%"+levels+"%'");
			}
		}
		sqlBuf.append(" ORDER BY sort");
		parameters.put("questionnaireId", questionnaireId);
		parameters.put("sql",sqlBuf.toString());	
		return questionsService.executeSql(parameters);
	}
	/**
	 * 根据questionnaireId获取判断当前问卷的类型
	 * 
	 *2017年11月3日
	 * xiaoding
	 * @throws Exception 
	 */
	private void getQuestionnaireType(String questionnaireId) throws Exception{
		logBefore(logger,"根据问卷id查询");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("questionnaireId", questionnaireId);
		PageData data=questionnaireService.findById(pd);
	}
	
	/**
	 * 根据问卷id查询所属调查对象
	 * 
	 *2017年11月6日
	 * xiaoding
	 */
	private void getLevelByQuestionnaireId(String questionnaireId,ModelAndView mv){
		/**
		 * 根据questionnaireId 查询     当前问卷所属的调查对象                          开始
		 */
		PageData pd=new PageData();
		pd.put("questionnaireId", questionnaireId);
		logBefore(logger, "根据问卷id查询所属调查对象");
		
		Map<String,String> map = new HashMap<String,String>();//接收调查对象的集合
		try {
			PageData data=questionnaireService.findById(pd);
			Map<String,String> mapTotal = new HashMap<String,String>();
			mapTotal=ConversionUtil.getStaffLevelByParentId(data.getString("respondentsParentId"));
			String level=data.getString("respondents");
			if(!Tools.isEmpty(level)){
				//存在多个调查对象时
				if(level.indexOf(",")>-1){
					String[] levelArr=level.split(",");
					for (int i = 0; i < levelArr.length; i++) {
						map.put(levelArr[i], mapTotal.get(levelArr[i]));
					}
				//存在单个调查对象时
				}else{
					map.put(level, mapTotal.get(level));
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		mv.addObject("staffLevels", map);//增加                             调查对象
		/**
		 * 根据questionnaireId 查询     当前问卷所属的调查对象                          结束
		 */
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
	
}

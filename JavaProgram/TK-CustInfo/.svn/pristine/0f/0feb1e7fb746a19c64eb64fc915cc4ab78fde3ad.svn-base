package com.fh.controller.questionnaire;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.PageAjax;
import com.fh.entity.system.Questionnaire;
import com.fh.entity.system.Questions;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.questionnaire.QuestionnaireResultsService;
import com.fh.service.questionnaire.QuestionnaireService;
import com.fh.service.questionnaire.QuestionsHeaderService;
import com.fh.service.questionnaire.QuestionsService;
import com.fh.service.record.SectionBaseService;
import com.fh.service.system.dictionaries.DictionariesManager;
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
 * QuestionStaticController
 * 
 * @author yaoning 
 * 创建时间：2017-08-01
 */

@Controller
@RequestMapping(value = "/questionStatic")
public class QuestionStaticController extends BaseController {
	
	String menuUrl = "questionStatic/starRat.do";
	
	@Resource(name = "questionnaireService")
	private QuestionnaireService questionnaireService;
	@Resource(name = "questionsService")
	private QuestionsService questionsService;
	@Resource(name = "questionsHeaderService")
	private QuestionsHeaderService questionsHeaderService;
	@Resource(name = "sectionBaseService")
	private SectionBaseService sectionBaseService;
	@Resource(name="questionnaireResultsService")
	private QuestionnaireResultsService questionnaireResultsService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	/**
	 * 去统计图表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/goStatisChart")
	public ModelAndView goStatisticsChart() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		List<Questionnaire> list = new ArrayList<Questionnaire>();
		try {
			list = questionnaireService.findQuestionnaireList(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pageList", list);
		mv.setViewName("questionnaire/questionStatisChart");
		return mv;
	}

	@RequestMapping(value = "/goStatissticsData")
	public ModelAndView goStatissticsData(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String startTime = pd.getString("lastLoginStart");
			String endTime = pd.getString("lastLoginEnd");
			page.setPd(pd);
			List<Questions> parentList = questionsService.oneStatislist(page);
			List<Questions> childList = questionsService.childList(pd);
			// 查询结果百分比
			pd.put("tx", "qb");
			PageData qb = questionnaireResultsService.findCountResultStatL1(pd);
			for (int i = 0; i < parentList.size(); i++) {
				Questions entity = parentList.get(i);
				// 问卷调查对象调整--------------开始
				String respondentsStr = entity.getLevel();
				StringBuffer respondentsName = new StringBuffer();
				if (respondentsStr != null && respondentsStr != "") {
					Map<String, String> map = ConversionUtil.getStaffLevel();
					if (respondentsStr.indexOf(",") > -1) {
						String[] respondentsArr = respondentsStr.split(",");
						for (int j = 0; j < respondentsArr.length; j++) {
							if (j == 0) {
								respondentsName.append(map.get(respondentsArr[j]));
							} else {
								respondentsName.append("," + map.get(respondentsArr[j]));
							}
						}
					} else {
						respondentsName.append(map.get(respondentsStr));
					}
					parentList.get(i).setLevel(respondentsName.toString());
				}
				// 一级类目满意度计算
				if ("L1".equals(entity.getClassification())) {
					PageData entitypd = new PageData();
					entitypd.put("questionId", entity.getQuestionId());
					entitypd.put("tx", "L1");
					entitypd.put("lastLoginStart", startTime);
					entitypd.put("lastLoginEnd", endTime);
					// 查询结果百分比
					PageData pdf = questionnaireResultsService.findCountResultStatL1(entitypd);
					if (!Tools.isEmpty(pdf.getString("fm"))) {
						entity.setQuestionYx(pdf.getString("yxyb"));
						entity.setQuestionWx(pdf.getString("wxyb"));
						entity.setSatisfaction(pdf.getString("bfb"));
						entity.setQuestionFm(pdf.getString("fm"));
						entity.setQuestionFz(pdf.getString("fz"));
					}

				}
				// 获取对应二级列表
				List<Questions> toParent = new ArrayList<Questions>();
				for (Questions questions : childList) {
					if (entity.getQuestionId().equals(questions.getParentId())) {
						if ("T0".equals(questions.getTypes())) {
							PageData entitypd = new PageData();
							entitypd.put("questionId", questions.getQuestionId());
							entitypd.put("tx", "L2");
							entitypd.put("lastLoginStart", startTime);
							entitypd.put("lastLoginEnd", endTime);
							// 查询结果百分比
							PageData pdf = questionnaireResultsService.findCountResultStatL1(entitypd);
							questions.setQuestionYx(pdf.getString("yxyb"));
							questions.setQuestionWx(pdf.getString("wxyb"));
							questions.setSatisfaction(pdf.getString("bfb"));
							questions.setQuestionFm(pdf.getString("fm"));
							questions.setQuestionFz(pdf.getString("fz"));
						}
						if ("T4".equals(questions.getTypes())) {
							PageData entitypd = new PageData();
							entitypd.put("questionId", questions.getQuestionId());
							entitypd.put("lastLoginStart", startTime);
							entitypd.put("lastLoginEnd", endTime);
							PageData pdf = questionnaireResultsService.findCountResultStatT4(entitypd);
							questions.setSatisfaction(pdf.getString("bfb"));
							questions.setQuestionFm(pdf.getString("fm"));
							questions.setQuestionFz(pdf.getString("fz"));
						}
						toParent.add(questions);
					}
				}
				if (toParent.size() > 0) {
					entity.setSUBQUESTIONS(toParent);
				}

			}
			this.getUserHC(pd, departmentService);
			pd.put("questionnaireType", Const.QUESTIONNAIRE_TYPE_COMMON);
			List<Questionnaire> questionnaireList = questionnaireService.findQuestionnaireList(pd); // 列出Question列表
			mv.addObject("questionnaireList", questionnaireList);// 所属问卷
			mv.setViewName("questionnaire/questionSatisData");
			mv.addObject("varList", parentList);
			mv.addObject("pd", pd);
			mv.addObject("qb", qb);
			mv.addObject(Const.SESSION_QX, Jurisdiction.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	
	@RequestMapping(value="exportExcel")
	public ModelAndView exportExcel(Page page){
		ModelAndView mv = new ModelAndView();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		//标题
		List<String> titles = new ArrayList<String>();
		List<PageData> varList = new ArrayList<PageData>();
		titles.add("所属问卷");
		titles.add("问题题目");
		titles.add("有效样本");
		titles.add("无效样本");
		titles.add("所有有效样本的分数之和");
		titles.add("有效问卷样本数*5");
		titles.add("满意度(%)");
		dataMap.put("titles", titles);
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String startTime = pd.getString("lastLoginStart");
			String endTime = pd.getString("lastLoginEnd");
			String isExportAll = pd.getString("isExportAll");
			page.setPd(pd);
			if("yes".equals(isExportAll)){
				page.setShowCount(100);//每页显示数量
			}
			List<Questions> parentList = questionsService.oneStatislist(page);
			List<Questions> childList = questionsService.childList(pd);
			// 查询结果百分比
			pd.put("tx", "qb");
		//	PageData qb = questionnaireResultsService.findCountResultStatL1(pd);
			for (int i = 0; i < parentList.size(); i++) {
				
				Questions entity = parentList.get(i);
				// 一级类目满意度计算
				if ("L1".equals(entity.getClassification())) {
					PageData pdExl1 = new PageData();
					PageData entitypd = new PageData();
					entitypd.put("questionId", entity.getQuestionId());
					entitypd.put("tx", "L1");
					entitypd.put("lastLoginStart", startTime);
					entitypd.put("lastLoginEnd", endTime);
					// 查询结果百分比
					PageData pdf = questionnaireResultsService.findCountResultStatL1(entitypd);
					if (!Tools.isEmpty(pdf.getString("fm"))) {
						entity.setQuestionYx(pdf.getString("yxyb"));
						entity.setQuestionWx(pdf.getString("wxyb"));
						entity.setSatisfaction(pdf.getString("bfb"));
						entity.setQuestionFm(pdf.getString("fm"));
						entity.setQuestionFz(pdf.getString("fz"));
					}
					dataConversion(pdExl1, entity, titles.size());
					varList.add(pdExl1);
					// 获取对应二级列表
					for (Questions questions : childList) {
						if (entity.getQuestionId().equals(questions.getParentId())) {
							PageData pdExl2 = new PageData();
							if ("T0".equals(questions.getTypes())) {
								PageData entitypd0 = new PageData();
								entitypd0.put("questionId", questions.getQuestionId());
								entitypd0.put("tx", "L2");
								entitypd0.put("lastLoginStart", startTime);
								entitypd0.put("lastLoginEnd", endTime);
								// 查询结果百分比
								PageData pdf0 = questionnaireResultsService.findCountResultStatL1(entitypd0);
								questions.setQuestionYx(pdf0.getString("yxyb"));
								questions.setQuestionWx(pdf0.getString("wxyb"));
								questions.setSatisfaction(pdf0.getString("bfb"));
								questions.setQuestionFm(pdf0.getString("fm"));
								questions.setQuestionFz(pdf0.getString("fz"));
								questions.setQuestionCode(entity.getQuestionCode());
								questions.setQuestionnaireTitle(entity.getQuestionnaireTitle());
								dataConversion(pdExl2, questions, titles.size());
							}else if ("T4".equals(questions.getTypes())){
								PageData entitypd4 = new PageData();
								entitypd4.put("questionId", questions.getQuestionId());
								entitypd4.put("lastLoginStart", startTime);
								entitypd4.put("lastLoginEnd", endTime);
								PageData pdf4 = questionnaireResultsService.findCountResultStatT4(entitypd4);
								questions.setSatisfaction(pdf4.getString("bfb"));
								questions.setQuestionFm(pdf4.getString("fm"));
								questions.setQuestionFz(pdf4.getString("fz"));
								questions.setQuestionCode(entity.getQuestionCode());
								questions.setQuestionnaireTitle(entity.getQuestionnaireTitle());
								dataConversion(pdExl2, questions, titles.size());
							}else{
								questions.setQuestionCode(entity.getQuestionCode());
								questions.setQuestionnaireTitle(entity.getQuestionnaireTitle());
								dataConversion(pdExl2, questions, titles.size());
							}
							varList.add(pdExl2);
						}
					}
				}else{
					PageData pdExl = new PageData();
					dataConversion(pdExl, entity, titles.size());
					varList.add(pdExl);
				}
				
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return mv;
	}
	//数据转换
	public void dataConversion(PageData pd, Questions questions,int size){
		for (int i = 0; i < size; i++) {
			if(i==0){
				pd.put("var1", questions.getQuestionnaireTitle());
			}
			if(i==1){
				if("L2".equals(questions.getClassification())){
					pd.put("var2", questions.getQuestionCode()+questions.getSort()+"."+questions.getTitle());
				}else{
					if(Tools.isEmpty(questions.getQuestionCode())){
						pd.put("var2", questions.getTitle());
					}else{
						pd.put("var2", questions.getQuestionCode()+"."+questions.getTitle());
					}
				}
				
			}
			if(i==2){
				pd.put("var3", questions.getQuestionYx());
			}
			if(i==3){
				pd.put("var4", questions.getQuestionWx());
			}
			if(i==4){
				pd.put("var5", questions.getQuestionFz());
			}
			if(i==5){
				pd.put("var6", questions.getQuestionFm());
			}
			if(i==6){
				pd.put("var7", questions.getSatisfaction());
			}
		}
	}
	
	
	/**
	 * 统计图表数据组装
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/chartList")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		List<Questionnaire> wjlist = new ArrayList<Questionnaire>();
		PageData pd = null;
		pd = this.getPageData();
		page.setPd(pd);
		try {
			this.getUserHC(pd, departmentService);
			pd.put("questionnaireType", Const.QUESTIONNAIRE_TYPE_COMMON);
			wjlist = questionnaireService.findQuestionnaireList(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 查询问卷下属问题
		try {
			// 判断是否存在结果
			// List<PageData>
			// listQuestionResult=questionsHeaderService.findCoutQuestioneResult(pd);
			List<PageData> pdList = questionsService.findByStatIdlist(page);
			if (pdList != null) {
				// 循环问题查找答案

				for (PageData pageData : pdList) {
					// 组装饼图数据
					List<PageData> bt = new ArrayList<PageData>();
					String[] btData = null;
					// 组装柱状图数据
					String[] xData = null;
					String[] yData = null;

					// 组装返回结果
					List<PageData> result = new ArrayList<PageData>();
					// 总数量
					Long count = 0L;

					List<PageData> resultList = new ArrayList<PageData>();
//					if ("L0".equals(pageData.get("classification"))) {
//						// 查询卷头问题
//						resultList = questionsHeaderService.findCountHeaderResult(pageData);
//					} else {
						// 复选题
						if ("T2".equals(pageData.get("types"))) {
							// 获取复选题选项
							String questionData = pageData.getString("questionData");// T3选项
							JSONArray json = JSONArray.fromObject(questionData);
							resultList = questionnaireResultsService.findCountResultT2(pageData, json);
							// T2类型结果总数
							count = questionnaireResultsService.findCountT2Sum(pageData);

						} else {
							resultList = questionnaireResultsService.findCountResult(pageData);
						}
//					}
					if (!"T2".equals(pageData.get("types"))) {
						for (PageData pageData2 : resultList) {
							Long s = (Long) pageData2.get("sum");
							count = count + s;
						}
					}
					if (count == 0) {
						pageData.put("isChart", false);
					} else {
						pageData.put("isChart", true);
					}
					if (count != 0) {
						for (PageData pageData2 : resultList) {
							Long s = (Long) pageData2.get("sum");
							BigDecimal sum = new BigDecimal(s);
							BigDecimal bfb = sum.divide(new BigDecimal(count), 4, RoundingMode.HALF_DOWN)
									.multiply(new BigDecimal(100)).stripTrailingZeros();
							if (bfb.compareTo(BigDecimal.ZERO) != 0) {
								pageData2.put("bfb", bfb);
							}
						}
					}
					// 默认题型计算
					if ("T0".equals(pageData.get("types"))) {
						// 组装前台展示数据
						Map<String, String> map = ConversionUtil.getDefaultOption();// T0选项
						// 初始化各图表
						btData = new String[map.size()];
						xData = new String[map.size()];
						yData = new String[map.size()];
						Set<String> set = map.keySet();
						int i = 0;
						for (String str : set) {
							PageData btpd2 = new PageData();
							btpd2.put("name", map.get(str));
							btpd2.put("value", 0);
							btData[i] = map.get(str);
							xData[i] = map.get(str);
							PageData respd = new PageData();
							respd.put("opt", map.get(str));
							for (PageData pd2 : resultList) {
								if (str.equals(pd2.getString("opt"))) {
									respd.put("sum", pd2.get("sum"));
									respd.put("bfb", pd2.get("bfb"));
									btpd2.put("value", pd2.get("sum"));
									yData[i] = String.valueOf((Long) pd2.get("sum"));
									break;
								}
							}
							result.add(respd);
							bt.add(btpd2);
							i++;
						}

					}

					// 单选题型或复选
					if ("T1".equals(pageData.get("types")) || "T2".equals(pageData.get("types"))
							|| "T4".equals(pageData.get("types"))) {
						// 获取前台选项组装数据
						String questionData = pageData.getString("questionData");// T1选项
						JSONArray json = JSONArray.fromObject(questionData);
						// 初始化各图表
						btData = new String[json.size()];
						xData = new String[json.size()];
						yData = new String[json.size()];

						for (int i = 0; i < json.size(); i++) {
							JSONObject j = json.getJSONObject(i);
							PageData pd2 = new PageData();
							pd2.put("opt", j.getString("key"));
							PageData btpd2 = new PageData();
							btpd2.put("name", j.getString("key"));
							btData[i] = j.getString("key");
							xData[i] = j.getString("key");
							for (PageData pageData2 : resultList) {
								if (j.getString("value").equals(pageData2.get("opt"))) {
									pd2.put("sum", pageData2.get("sum"));
									pd2.put("bfb", pageData2.get("bfb"));
									yData[i] = String.valueOf((Long) pageData2.get("sum"));
									btpd2.put("value", pageData2.get("sum"));
								}

							}
							result.add(pd2);
							bt.add(btpd2);
						}
					}
					// 下拉
					if ("T3".equals(pageData.get("types"))) {
						// 获取前台选项组装数据
						String questionData = pageData.getString("questionData");// T3选项
						JSONArray json = JSONArray.fromObject(questionData);
						// 初始化各图表
						btData = new String[json.size() - 1];
						xData = new String[json.size() - 1];
						yData = new String[json.size() - 1];
						for (int i = 1; i < json.size(); i++) {
							JSONObject j = json.getJSONObject(i);
							PageData pd2 = new PageData();
							PageData btpd2 = new PageData();
							pd2.put("opt", j.getString("key"));
							btpd2.put("name", j.getString("key"));
							btData[i - 1] = j.getString("key");
							xData[i - 1] = j.getString("key");
							for (PageData pageData2 : resultList) {
								if (j.getString("value").equals(pageData2.get("opt"))) {
									pd2.put("sum", pageData2.get("sum"));
									pd2.put("bfb", pageData2.get("bfb"));
									yData[i - 1] = String.valueOf((Long) pageData2.get("sum"));
									btpd2.put("value", pageData2.get("sum"));
								}
							}
							result.add(pd2);
							bt.add(btpd2);
						}
					}
					pageData.put("btData", btData);
					pageData.put("bt", bt);
					pageData.put("xData", xData);
					pageData.put("yData", yData);

					PageData respd = new PageData();
					respd.put("opt", "有效填写量");
					respd.put("sum", count);
					result.add(respd);
					pageData.put("resultList", result);
				}
			}
			mv.addObject("pdList", pdList);
			JSONArray json = JSONArray.fromObject(pdList);
			mv.addObject("pdListJson", json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.addObject("pageList", wjlist);
		mv.addObject("page", page);
		mv.setViewName("questionnaire/questionStatisChart");
		return mv;

	}

	/**
	 * 去统计页面
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/starRat")
	public ModelAndView getStarRat(Page page) {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		PageData pd = new PageData();
		ModelAndView mv = this.getModelAndView();
		try {
			pd = this.getPageData();
			User user = Jurisdiction.getLoginUser();
			String DEPARTMENT_ID = user.getDepartment().getDEPARTMENT_ID();
			List<PageData> zrolePdList = new ArrayList<PageData>();
			List<PageData> departmentList = departmentService.listAllDepartmentToSelect(DEPARTMENT_ID,zrolePdList);
			if(!"0".equals(DEPARTMENT_ID)){  //部门下拉框+自己部门
				PageData pdf = new PageData();
				pdf.put("DEPARTMENT_ID", DEPARTMENT_ID);
				PageData pdfEntity= departmentService.findById(pdf);
				PageData p = new PageData();
				p.put("id", pdfEntity.getString("DEPARTMENT_ID"));
				p.put("parentId", pdfEntity.getString("PARENT_ID"));
				p.put("name", pdfEntity.getString("NAME"));
				p.put("icon", "static/images/user.gif");
				departmentList.add(p);
			}
			pd.put("DEPARTMENT_IDQ", DEPARTMENT_ID);
			JSONArray arr = JSONArray.fromObject(departmentList);
			mv.addObject("zTreeNodes", (null == arr ?"":arr.toString()));
			mv.addObject("kdList",ConversionUtil.getKDType()); //刻度列表
			mv.addObject("pd",pd);
			mv.setViewName("questionnaire/questionStarLeve");
			mv.addObject(Const.SESSION_QX, Jurisdiction.getHC()); // 按钮权限
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	/**
	 * 星级评定计算
	 * @param page
	 * @param response
	 */
	@RequestMapping(value="/starRatJson")
	public void getStarRatJson(PageAjax page,HttpServletResponse response) {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return;} //校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String,Object>();
		response.setCharacterEncoding("UTF-8");  
		try {
			pd = this.getPageData();
			String DEPARTMENT_ID = pd.getString("DEPARTMENT_IDQ");
			if(Tools.notEmpty(DEPARTMENT_ID)){
				if(Tools.isEmpty(pd.getString("questionnaireId"))){    //判断传入问卷id，否则查所有
					//权限组装条件-------start
					User user = Jurisdiction.getLoginUser();
					String CREATE_USER = user.getUSER_ID();
					String USER_DEPARTMENT_ID = user.getDepartment().getDEPARTMENT_ID();
					List<PageData> zrolePdList = new ArrayList<PageData>();
					List<PageData> departmentList = departmentService.listAllDepartmentToSelect(DEPARTMENT_ID,zrolePdList);//列出所有部门下属所有(下拉框)
					ArrayList<String> arr = new ArrayList<String>();
					for (PageData department : departmentList) {
						arr.add(department.getString("id"));
					}
					if(USER_DEPARTMENT_ID.equals(DEPARTMENT_ID)){ //如果传入部门id为本人则加入create_user  否则加入传入部门id
						pd.put("CREATE_USER", CREATE_USER);
					}else{
						arr.add(DEPARTMENT_ID);
					}
					if("0".equals(USER_DEPARTMENT_ID)){
						arr.add("0");
					}
					if(arr.size()==0){
						arr = null;
					}
					pd.put("DEPARTMENT_ID", arr);
					pd.put("questionnaireType", Const.QUESTIONNAIRE_TYPE_STAR_LEVEL);
					//权限组装条件-------end
					List<Questionnaire> questionnaireList = questionnaireService.findQuestionnaireList(pd); // 查询列出问卷列表
					if(questionnaireList != null && questionnaireList.size()>0){ 
						pd.put("questionnaireList",questionnaireList);
					}
				}else{
					List<Questionnaire> list = new ArrayList<Questionnaire>();
					Questionnaire q = new Questionnaire();
					q.setQuestionnaireId(pd.getString("questionnaireId"));
					list.add(q);
					pd.put("questionnaireList",list );
				}
				page.setPd(pd);
				List<PageData> questionList = questionsHeaderService.findQuestion(page);//分页查询问题
				if (questionList != null) {
					// 循环问题查询答案
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					int isFinance = Integer.valueOf(pd.getString("isFinance")); //是否财务月
					int kd =  Integer.valueOf(pd.getString("kd"));  //统计刻度
					String lastLoginStart = "";
					String lastLoginEnd = "";
					if(isFinance == 0){  //财务月
						Date startBT = new Date();
						Date endBt = new Date();
						if (!Tools.isEmpty(pd.getString("btEndTime"))) {
							SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
							endBt = sdf1.parse(pd.getString("btEndTime"));
						}
						Calendar calendarL = Calendar.getInstance();
						calendarL.setTime(endBt);
						if (calendarL.get(Calendar.MONDAY) == 0) { //一月份
							calendarL.set(Calendar.DAY_OF_MONTH, 1);
						} else {
							calendarL.add(Calendar.MONDAY, -1);
							calendarL.set(Calendar.DAY_OF_MONTH, 26);
						}
						startBT = calendarL.getTime();
						calendarL.setTime(endBt);
						if (calendarL.get(Calendar.MONDAY) == 11) { //12月份
							calendarL.set(Calendar.DAY_OF_MONTH, 31);
						} else {
							calendarL.set(Calendar.DAY_OF_MONTH, 25);
						}
						endBt = calendarL.getTime();
						lastLoginStart = sdf.format(startBT);
						lastLoginEnd = sdf.format(endBt);
					}else{ //非财务月
						lastLoginStart = pd.getString("zxStartTime");
						lastLoginEnd = pd.getString("zxEndTime");
						Date endZX= sdf.parse(lastLoginEnd);//结束时间
						Date startZX= sdf.parse(lastLoginStart);// 开始时间
						int day = DateUtil.differentDaysByMillisecond(startZX, endZX)+1;
						map.put("notFinanceDay",day);
					}
					Long startTime = System.currentTimeMillis();
					for (PageData pdret : questionList) {
						// 组装饼图数据---------start
						pd.put("lastLoginStart",lastLoginStart);
						pd.put("lastLoginEnd", lastLoginEnd);
						pd.put("questionId", pdret.getString("questionId"));
						//查询出题目答案数量、并组装饼图数据
						Long startTime2 = System.currentTimeMillis();
						questionnaireResultsService.findStarBt(pdret,pd);
						Long endTime2 = System.currentTimeMillis();
						// 组装饼图数据---------end
						//折线图数据组装---------------------start
						Date endZX= sdf.parse(lastLoginEnd);//结束时间
						Date startZX= sdf.parse(lastLoginStart);// 开始时间
						Long startTime1 = System.currentTimeMillis();
						Map<String, Object> mapZX = questionnaireResultsService.findStarZX(isFinance,kd,pdret.getString("questionId"),startZX,endZX,pd);
						Long endTime1 = System.currentTimeMillis();
						System.out.println(startTime1 - endTime1 +"折线时间-------------------------------------------");
						System.out.println(startTime2 - endTime2 +"饼图时间-------------------------------------------");
						pdret.put("xData", mapZX.get("x"));
						pdret.put("yData", mapZX.get("y"));
						pdret.put("averAgeRes", mapZX.get("averAgeRes"));
						pdret.put("avgerStr", mapZX.get("avgerStr"));
					}
					Long endTime = System.currentTimeMillis();
					System.out.println(startTime - endTime +"总时间-------------------------------------------");
					
					System.out.println(startTime - endTime +"总时间-------------------------------------------");
					map.put("questionList", questionList);//饼图、折线图数据集合
				}
			}
			page.setPageStr(page.getPageStr());
			map.put("page",page);
			map.put(Const.SESSION_QX, Jurisdiction.getHC()); // 按钮权限
			PrintWriter print =  response.getWriter();
			JSONObject json = JSONObject.fromObject(map);
			print.write(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="/findQuestionList")
	@ResponseBody
	public PageData findQuestionList(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
			User user = Jurisdiction.getLoginUser();
			String CREATE_USER = user.getUSER_ID();
			String USER_DEPARTMENT_ID = user.getDepartment().getDEPARTMENT_ID();
			List<PageData> zrolePdList = new ArrayList<PageData>();
			List<PageData> departmentList = departmentService.listAllDepartmentToSelect(DEPARTMENT_ID,zrolePdList);//列出所有系统用户部门(下拉框)
			ArrayList<String> arr = new ArrayList<String>();
			for (PageData department : departmentList) {
				arr.add(department.getString("id"));
			}
			if(USER_DEPARTMENT_ID.equals(DEPARTMENT_ID)){
				pd.put("CREATE_USER", CREATE_USER);
			}else{
				arr.add(DEPARTMENT_ID);
			}
			if("0".equals(USER_DEPARTMENT_ID)){
				arr.add("0");
			}
			if(arr.size()==0){
				arr = null;
			}
			pd.put("DEPARTMENT_ID", arr);
			pd.put("questionnaireType", Const.QUESTIONNAIRE_TYPE_STAR_LEVEL);
			List<Questionnaire> questionnaireList = questionnaireService.findQuestionnaireList(pd); // 列出Question列表
			pd.put("questionnaireList", questionnaireList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd;
	}
	/**
	 * 根据医院code获取对应科室
	 * @param HOSIPITAL_CODE
	 * @return
	 */
	@RequestMapping(value="/findSectionCodeName")
	@ResponseBody
	public List<PageData> findSectionCodeName(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			List<PageData> sectionList = sectionBaseService.findSectionCodeName(pd);
			return sectionList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 查询医生下拉数据
	 * @param HOSIPITAL_CODE,SECTION_CODE
	 * @return
	 */
	@RequestMapping(value="/findDoctorCodeName")
	@ResponseBody
	public List<PageData> findDoctorCodeName(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			List<PageData> sectionList = sectionBaseService.findDoctorCodeName(pd);
			return sectionList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 单题饼图统计
	 * @return
	 */
	@RequestMapping(value="/findBtData")
	@ResponseBody
	public PageData findBtData(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			int isFinance = Integer.valueOf(pd.getString("isFinance")); //是否财务月
			String lastLoginStart = "";
			String lastLoginEnd = "";
			Date startBT = new Date();
			Date endBt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM");
			if(isFinance == 0){  //财务月
				endBt = sdf.parse(pd.getString("btEndTime"));
				Calendar calendarL = Calendar.getInstance();
				calendarL.setTime(endBt);
				if (calendarL.get(Calendar.MONDAY) == 0) { //一月份
					calendarL.set(Calendar.DAY_OF_MONTH, 1);
				} else {
					calendarL.add(Calendar.MONDAY, -1);
					calendarL.set(Calendar.DAY_OF_MONTH, 26);
				}
				startBT = calendarL.getTime();
				calendarL.setTime(endBt);
				if (calendarL.get(Calendar.MONDAY) == 11) { //12月份
					calendarL.set(Calendar.DAY_OF_MONTH, 31);
				} else {
					calendarL.set(Calendar.DAY_OF_MONTH, 25);
				}
				endBt = calendarL.getTime();
				lastLoginStart = DateUtil.formatDate(startBT);
				lastLoginEnd = DateUtil.formatDate(endBt);
			}else{ //非财务月
				sdf = new SimpleDateFormat("yy-MM-dd");
				String endTime = pd.getString("btEndTime");
				endTime = endTime.split("至")[0];
				endBt = sdf.parse(endTime);
				lastLoginStart = pd.getString("zxStartTime");
				lastLoginEnd = pd.getString("zxEndTime");
				long day = DateUtil.getDaySub(lastLoginStart, lastLoginEnd);
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(endBt);
				calendar.add(Calendar.DAY_OF_MONTH, (int)day);
				lastLoginEnd = DateUtil.formatDate(calendar.getTime());
				lastLoginStart = DateUtil.formatDate(endBt);
			}
			pd.put("lastLoginStart",lastLoginStart);
			pd.put("lastLoginEnd", lastLoginEnd);
			questionnaireResultsService.findStarBt(pd,pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd;
	}
	@RequestMapping(value="/findDictionHosipatl")
	@ResponseBody
	public List<PageData> findDictionHosipatl(){
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			PageData pd1 = departmentService.findById(pd);	//根据ID读取
			if(pd1!=null){
				return dictionariesService.findHosiptalList(pd1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
}

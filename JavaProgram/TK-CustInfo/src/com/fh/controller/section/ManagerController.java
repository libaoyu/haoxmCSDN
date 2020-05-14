package com.fh.controller.section;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.section.SectionService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.StringUtil;
import com.fh.util.Tools;
import com.fh.util.exportExcle.ExportToExcelUtil;

/** 
 * 类名称：ManagerController
 * 创建人：shanghz 
 * 创建时间：2017-06-07
 */
@Controller
@RequestMapping(value="/manager")
public class ManagerController extends BaseController {
	
	@Resource(name="sectionService")
	private SectionService sectionService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			
			List<PageData> varList = sectionService.list(page);
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (PageData detail : varList) {
				Map<String, String> map;
				String commonEval = detail.getString("COMMON_EVAL");
				
				if(detail !=null && detail.get("VISIT_DATE")!=null && !Tools.isEmpty(detail.get("VISIT_DATE").toString())){
					detail.put("VISIT_DATE", sdf.format(detail.get("VISIT_DATE")));
				}
				if(detail !=null && detail.get("CREATE_TIME")!=null && !Tools.isEmpty(detail.get("CREATE_TIME").toString())){
					detail.put("CREATE_TIME", sdf.format(detail.get("CREATE_TIME")));
				}
				if(detail.get("LEVEL")!=null){
					int level = (Integer)detail.get("LEVEL");
					if(level<=3){
						map = ConversionUtil.getCommonEval("",Const.VISIT_TYPE_ZY);
					}else{
						map = ConversionUtil.getCommonEval(Const.VISIT_TYPE_THREE,"");
					}
					if(!Tools.isEmpty(commonEval)){
						String s = "";
						String[] com = commonEval.split(",");
						TreeMap<String,String> m=new TreeMap<String, String>();
						for (String key : com) {
							m.put(key, map.get(key));
							s+=map.get(key)==null?"":map.get(key)+",";
						}
						if(!Tools.isEmpty(s)){
							s = s.substring(0,s.length()-1);
						}
						detail.put("commonEval", s);
					}
				}
			}
			mv.setViewName("questionnaire/section/section_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
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
			sectionService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除问诊数据");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				sectionService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok好的");
			}else{
				pd.put("msg", "no不阿红");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 导出excel 
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page,@Param(value="type")String type,HttpServletRequest request){
		logBefore(logger, "导出VideoLog到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("问诊类型");	//1
			titles.add("诊疗时间");	//2
			titles.add("患者姓名");	//3
			titles.add("患者性别");	//4
			titles.add("患者电话");	//5
			titles.add("就诊次数");	//6
			titles.add("医生姓名");	//7
			titles.add("医生职称");	//8
			titles.add("科室名称");	//9
			titles.add("评价星级");	//10
			titles.add("评价选项");	//11
			titles.add("评语");	//12
			titles.add("评价时间");	//13
			List<PageData> varOList =new ArrayList<PageData>();
			if(type!=null&&!type.isEmpty()){
				if(type.equals("all")){
					 varOList = sectionService.listAll(pd);
				}else if(type.equals("part")){
					 varOList = sectionService.list(page);
				}
			}
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dataMap.put("titles", titles);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("VISIT_TYPE"));	//1
				if(varOList.get(i) !=null && varOList.get(i).get("VISIT_DATE")!=null && !Tools.isEmpty(varOList.get(i).get("VISIT_DATE").toString())){
					vpd.put("var2", sdf.format(varOList.get(i).get("VISIT_DATE")));	//2
				}else{
					vpd.put("var2", "");	//2
				}
				
				vpd.put("var3", varOList.get(i).getString("PATIENT_NAME"));	//3
				vpd.put("var4", varOList.get(i).getString("SEX"));	//4
				vpd.put("var5", varOList.get(i).getString("PHONE_NUMBER"));	//5
				vpd.put("var6", varOList.get(i).getString("TIMES"));	//6
				vpd.put("var7", varOList.get(i).getString("EMP_NAME"));	//7
				vpd.put("var8", Tools.isEmpty(varOList.get(i).getString("DOCTORTYPE"))?"医师":varOList.get(i).getString("DOCTORTYPE"));	//8
				vpd.put("var9", varOList.get(i).getString("SECTION_NAME"));	//9
				vpd.put("var10", varOList.get(i).get("LEVEL")==null?"":varOList.get(i).get("LEVEL").toString());
				
				Map<String, String> map;
				String commonEval = varOList.get(i).getString("COMMON_EVAL");
				if(varOList.get(i).get("LEVEL")!=null){
					int level = (Integer)varOList.get(i).get("LEVEL");
					
					if(level<=3){
						map = ConversionUtil.getCommonEval("",Const.VISIT_TYPE_ZY);
					}else{
						map = ConversionUtil.getCommonEval(Const.VISIT_TYPE_THREE,"");
					}
					if(!Tools.isEmpty(commonEval)){
						String s = "";
						String[] com = commonEval.split(",");
						TreeMap<String,String> m=new TreeMap<String, String>();
						for (String key : com) {
							m.put(key, map.get(key));
							s+=map.get(key)==null?"":map.get(key)+",";
						}
						if(!Tools.isEmpty(s)){
							s = s.substring(0,s.length()-1);
						}
						vpd.put("var11",s);
					}
				}else{
					vpd.put("var11","");
				}
				vpd.put("var12", varOList.get(i).getString("EVALUATE"));
				if(varOList.get(i) !=null && varOList.get(i).get("CREATE_TIME")!=null && !Tools.isEmpty(varOList.get(i).get("CREATE_TIME").toString())){
					vpd.put("var13", sdf.format(varOList.get(i).get("CREATE_TIME")));	//13
				}else{
					vpd.put("var13", "");	//13
				}
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ExportToExcelUtil erv=new ExportToExcelUtil();
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
}

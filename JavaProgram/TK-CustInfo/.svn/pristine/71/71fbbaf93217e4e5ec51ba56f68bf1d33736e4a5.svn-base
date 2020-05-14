package com.fh.controller.section;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.section.PatientInfo;
import com.fh.service.section.SectionService;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.DateUtil;
import com.fh.util.GetBaseSectionUtil;
import com.fh.util.GetWebserviceData;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 类名称：SectionController
 * 创建人：shanghz 
 * 创建时间：2017-06-07
 */
@Controller
@RequestMapping(value="/section")
public class SectionController extends BaseController {
	
	@Resource(name="sectionService")
	private SectionService sectionService;
	
	/***
	 * 星级评价页面 
	 */
	@RequestMapping(value="/goExpress")
	public ModelAndView goExpress() throws Exception{
		PageData pd = new PageData();
		PageData pds = new PageData();
		pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		// 调用webservice获取单条问诊数据
		String strIndex = pd.getString("strIndex");
		if(!Tools.isEmpty(strIndex)){
			PatientInfo patientInfo = GetWebserviceData.getPatientInfo(strIndex);
			if(patientInfo!=null){
				pds = sectionService.findById(pd);
				if(pds==null){
					// 本地数据库中不存在，需要入库
					patientInfo.setCreateTime(DateUtil.getTime());
					sectionService.save(patientInfo);
				}
				pd = sectionService.findById(pd);
				
				String pName = pd.getString("PATIENT_NAME");
				String vType = pd.getString("VISIT_TYPE");
				String sex = pd.getString("SEX");
				if(!Tools.isEmpty(pName) && !Tools.isEmpty(sex)){
					if("男".equals(sex)){
						pd.put("PATIENT_NAME", pName.toCharArray()[0]+"先生");
					}else{
						pd.put("PATIENT_NAME", pName.toCharArray()[0]+"女士");
					}
				}
				if(!Tools.isEmpty(vType)){
					if("门诊".equals(vType)){
						// 若是住院病患，增加两个选项
						pd.put("commonEval", ConversionUtil.getCommonEval("",Const.VISIT_TYPE_MZ));
						pd.put("commonEvals", ConversionUtil.getCommonEval(Const.VISIT_TYPE_THREE,Const.VISIT_TYPE_MZ));//超过三星级的评价选项
					}else{
						pd.put("commonEval", ConversionUtil.getCommonEval("",Const.VISIT_TYPE_ZY));
						pd.put("commonEvals", ConversionUtil.getCommonEval(Const.VISIT_TYPE_THREE,Const.VISIT_TYPE_ZY));//超过三星级的评价选项
					}
				}
				
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(pd.get("VISIT_DATE")!=null){
					pd.put("VISIT_DATE", sdf.format(pd.get("VISIT_DATE")));
				}
				mv.addObject("pd", pd);
				mv.setViewName("questionnaire/section/doctor_eva");
			}else{
				// 获取问诊数据失败,暂跳转到评价成功页
				mv.addObject("isAdd",3);
				mv.setViewName("questionnaire/section/doctor_eva_success");
			}
		}else{
			mv.setViewName("error");
		}
		return mv;
	}
	
	@RequestMapping(value="/submission")
	public ModelAndView submission() throws Exception{
		PageData pd = new PageData();
		PageData pds = new PageData();
		pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		pds = sectionService.findById(pd);
		if(pds!=null){
			if(pds.get("LEVEL")!=null){
				mv.addObject("isAdd", 1);//已经作出了评价
				mv.setViewName("questionnaire/section/doctor_eva_success");
			}else{
				pd.put("modifyTime", DateUtil.getTime());
				int num = sectionService.edit(pd);
				if(num>0){
					// 评价成功,modify by shanghz 20170703 重新修改了评价成功页面，评价信息不需要回显
					/*PageData detail = sectionService.findById(pd);
					String pName = pd.getString("PATIENT_NAME");
					String vType = pd.getString("VISIT_TYPE");
					String sex = pd.getString("SEX");
					if(!Tools.isEmpty(pName) && !Tools.isEmpty(sex)){
						if("男".equals(sex)){
							pd.put("PATIENT_NAME", pName.toCharArray()[0]+"先生");
						}else{
							pd.put("PATIENT_NAME", pName.toCharArray()[0]+"女士");
						}
					}
					Map<String, String> map;
					String commonEval = detail.getString("COMMON_EVAL");
					int level = (Integer)detail.get("LEVEL");
					DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					if(detail !=null && detail.get("VISIT_DATE")!=null && !Tools.isEmpty(detail.get("VISIT_DATE").toString())){
						detail.put("VISIT_DATE", sdf.format(detail.get("VISIT_DATE")));
					}
					
					if(level<=3){
						map = ConversionUtil.getCommonEval(Const.VISIT_TYPE_ZY);
					}else{
						map = ConversionUtil.getCommonEval(Const.VISIT_TYPE_THREE);
					}
					if(!Tools.isEmpty(commonEval)){
						String[] com = commonEval.split(",");
						TreeMap<String,String> m=new TreeMap<String, String>();
						for (String key : com) {
							m.put(key, map.get(key));
						}
						pd.put("commonEval", m);
					}
					mv.addObject("pd", pd);
					mv.addObject("detail", detail);*/
					mv.addObject("isAdd", 2);
					mv.setViewName("questionnaire/section/doctor_eva_success");
				}else{
					// 评价不成功
					mv.setViewName("error");
				}
			}
		}
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

package com.fh.controller.record;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.section.Patient;
import com.fh.service.record.RecordService;
import com.fh.service.record.SectionBaseService;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.record.GetXianlinRecordData;
import com.fh.util.record.GetYanyuanRecordData;

/** 
 * 类名称：RecordController
 * 创建人：shanghaizhao 
 * 创建时间：2017-11-06
 */
@Controller
@RequestMapping(value="/record")
public class RecordController extends BaseController {
	
	@Resource(name="recordService")
	private RecordService recordService;
	
	@Resource(name="sectionBaseService")
	private SectionBaseService sectionBaseService;
	
	
	/***
	 * 星级评价页面 
	 */
	@RequestMapping(value="/goSection")
	public ModelAndView goSection(Page page) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		// 调用获取仙林鼓楼医院接口获取单条问诊数据
		String visitCode = pd.getString("visitCode");
		if(!Tools.isEmpty(visitCode)){
			Patient patient = GetXianlinRecordData.getPatient(visitCode);
			if(patient!=null){
				PageData pInfo = sectionBaseService.getPatientById(pd);
				if(pInfo==null){
					// 本地数据库中不存在，先入库
					sectionBaseService.save(patient);
				}
				//从本地库中取出单条详细数据
				PageData pds = sectionBaseService.getPatientById(pd);
				if(pds != null) {
					// 根据所属医院ID从配置表中获取配置名称及顺序
					pd.put("isShow", 1);
					pd.put("hosipitalId", Const.XIANLIN_HOSPITALID);
					page.setPd(pd);
					List<PageData> varList = recordService.configList(page);
					LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
					for (PageData conf : varList) {
						map.put(conf.getString("LABEL"), pds.getString(conf.getString("FIELD_NAME")));
					}
					mv.addObject("mapInfo", map);
					mv.addObject("pd", pds);
					mv.setViewName("section/doctor_eva");
				}
				
			}else{
				// 获取问诊数据失败,暂跳转到评价成功页
				mv.addObject("isAdd",3);
				mv.setViewName("section/doctor_eva_success");
			}
		}else{
			mv.setViewName("error");
		}
		return mv;
	}
	
	/***
	 * 燕园星级评价页面 
	 */
	@RequestMapping(value="/goYanySection")
	public ModelAndView goYanySection(Page page) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		// 调用获取仙林鼓楼医院接口获取单条问诊数据
		String visitCode = pd.getString("visitCode");
		if(!Tools.isEmpty(visitCode)){
			// 暂时取住院接口的数据，后期在短信接口中加入一个参数区分不同接口
			Patient patient = GetYanyuanRecordData.getPatient(visitCode,Const.YANYUAN_VISIT_INHOS);
			if(patient!=null){
				PageData pInfo = sectionBaseService.getPatientById(pd);
				if(pInfo==null){
					// 本地数据库中不存在，先入库
					sectionBaseService.save(patient);
				}
				//从本地库中取出单条详细数据
				PageData pds = sectionBaseService.getPatientById(pd);
				if(pds != null) {
					// 根据所属医院ID从配置表中获取配置名称及顺序
					pd.put("isShow", 1);
					pd.put("hosipitalId", Const.YANYUAN_HOSPITALID);
					// 根据短信链接中的类型值，判定访问的哪个接口,确定从配置表中根据接口类型查询相关配置
					//pd.put("interType", );
					page.setPd(pd);
					List<PageData> varList = recordService.configList(page);
					LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
					for (PageData conf : varList) {
						map.put(conf.getString("LABEL"), pds.getString(conf.getString("FIELD_NAME")));
					}
					mv.addObject("mapInfo", map);
					mv.addObject("pd", pds);
					mv.setViewName("section/doctor_eva");
				}
				
			}else{
				// 获取问诊数据失败,暂跳转到评价成功页
				mv.addObject("isAdd",3);
				mv.setViewName("section/doctor_eva_success");
			}
		}else{
			mv.setViewName("error");
		}
		return mv;
	}

	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

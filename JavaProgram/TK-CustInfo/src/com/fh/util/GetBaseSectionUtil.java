package com.fh.util;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.fh.entity.Page;
import com.fh.entity.section.Patient;
import com.fh.service.record.RecordService;
import com.fh.service.record.SectionBaseService;
import com.fh.util.record.GetXianlinRecordData;
import com.fh.util.record.GetYanyuanRecordData;

@Component
public class GetBaseSectionUtil {
	
	@Resource(name="recordService")
	private RecordService recordService;
	
	@Resource(name="sectionBaseService")
	private SectionBaseService sectionBaseService;
	
	private static GetBaseSectionUtil getBaseSectionUtil;
	
	@PostConstruct
	public void init() {
		getBaseSectionUtil = this;
		getBaseSectionUtil.recordService = this.recordService;
		getBaseSectionUtil.sectionBaseService = this.sectionBaseService;
	}
	
	/**
	 * 通过医院编号、接口编号、问诊编号获取问诊数据
	 * @param hospitalId
	 * @param interType
	 * @param visitCode
	 * @param showType
	 **/
	public static BizOutMap getSection(String hospitalId,String interType,String visitCode,String showType) throws Exception{
		BizOutMap out = new BizOutMap();
		PageData pd = new PageData();
		Page page = new Page();
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		pd.put("visitCode", visitCode);
		Patient patient = null;
		if(Const.XIANLIN_HOSPITALID.equals(hospitalId) && !Tools.isEmpty(visitCode)) {
			patient = GetXianlinRecordData.getPatient(visitCode);
			if(patient != null) {
				PageData pInfo = getBaseSectionUtil.sectionBaseService.getPatientById(pd);
				if(pInfo==null){
					// 本地数据库中不存在，先入库
					patient.setCreateTime(DateUtil.getTime());
					patient.setHosipitalCode(Const.XIANLIN_HOSPITALID);
					patient.setHosipitalName("泰康仙林鼓楼医院");
					getBaseSectionUtil.sectionBaseService.save(patient);
				}
				//从本地库中取出单条详细数据
				PageData pds = getBaseSectionUtil.sectionBaseService.getPatientById(pd);
				if(pds != null) {
					// 根据所属医院ID从配置表中获取配置名称及顺序
					pd.put("isShow", 1);
					pd.put("hosipitalId", Const.XIANLIN_HOSPITALID);
					pd.put("interType", interType);
					pd.put("showType", showType);
					page.setPd(pd);
					List<PageData> varList = getBaseSectionUtil.recordService.configList(page);
					for (PageData conf : varList) {
						if("PATIENT_NAME".equals(conf.getString("FIELD_NAME"))) {
							String sex = pds.getString("SEX");
							if("男".equals(sex)){
								map.put(conf.getString("LABEL"), pds.getString("PATIENT_NAME").toCharArray()[0]+"先生");
							}else{
								map.put(conf.getString("LABEL"), pds.getString("PATIENT_NAME").toCharArray()[0]+"女士");
							}
						}else {
							map.put(conf.getString("LABEL"), pds.getString(conf.getString("FIELD_NAME")));
						}
						
					}
					
				}
			}
		}else if(Const.YANYUAN_HOSPITALID.equals(hospitalId) && !Tools.isEmpty(visitCode)){
			patient = GetYanyuanRecordData.getPatient(visitCode,interType);
			if(patient != null) {
				PageData pInfo = getBaseSectionUtil.sectionBaseService.getPatientById(pd);
				if(pInfo==null){
					// 本地数据库中不存在，先入库
					patient.setCreateTime(DateUtil.getTime());
					patient.setHosipitalCode(Const.YANYUAN_HOSPITALID);
					patient.setHosipitalName("燕园康复医院");
					getBaseSectionUtil.sectionBaseService.save(patient);
				}
				//从本地库中取出单条详细数据
				PageData pds = getBaseSectionUtil.sectionBaseService.getPatientById(pd);
				if(pds != null) {
					// 根据所属医院ID从配置表中获取配置名称及顺序
					pd.put("isShow", 1);
					pd.put("hosipitalId", Const.YANYUAN_HOSPITALID);
					pd.put("interType", interType);
					page.setPd(pd);
					List<PageData> varList = getBaseSectionUtil.recordService.configList(page);
					for (PageData conf : varList) {
						map.put(conf.getString("LABEL"), pds.getString(conf.getString("FIELD_NAME")));
					}
					
				}
			}
		}else {
			out.setSuccess(false);
		}
		out.put("patient", patient);
		out.put("mapInfo", map);
		System.out.println(map);
		return out;
	}
	
}
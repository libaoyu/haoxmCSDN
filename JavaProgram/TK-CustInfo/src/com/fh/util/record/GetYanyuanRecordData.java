package com.fh.util.record;

import com.alibaba.fastjson.JSONObject;
import com.fh.entity.section.Patient;
import com.fh.util.Const;
import com.fh.util.DbFH;
import com.fh.util.HttpClientUtil;
import com.fh.util.UuidUtil;

/** 
 * 类名称：GetYanyuanRecordData
 * 创建人：shanghaizhao 
 * 创建时间：2017-12-01
 */
public class GetYanyuanRecordData {
	
	/**
	 * 获取问诊信息接口
	 * @param resourceId 数据标识
	 * @param type 请求接口类型（住院信息、护理业态信息...） 
	 **/
	@SuppressWarnings("null")
	public static Patient getPatient(String resourceId,String type) throws Exception{
		Patient patient = null;
		String url = "";
		if(type.equals(Const.YANYUAN_VISIT_INHOS)) {
			// 住院
			url = DbFH.getPprVue().getProperty("url_inHosptal")+resourceId;
		}else if(type.equals(Const.YANYUAN_VISIT_CAREFORM)) {
			// 护理业态
			url = DbFH.getPprVue().getProperty("url_careForm")+resourceId;
		}else if(type.equals(Const.YANYUAN_VISIT_PHYS)) {
			// 体检信息
			url = DbFH.getPprVue().getProperty("url_physical")+resourceId;
		}else if(type.equals(Const.YANYUAN_VISIT_ENCOUNTER)) {
			// 门诊就诊信息
			url = DbFH.getPprVue().getProperty("url_encounter")+resourceId;
		}else {
			return patient;
		}
		JSONObject jsonObj = HttpClientUtil.httpGet(url,DbFH.getPprVue().getProperty("req_token"));
		if("success".equals(jsonObj.get("status"))) {
			patient = new Patient();
			JSONObject detail = jsonObj.getJSONObject("data");
				patient.setRecordId(UuidUtil.get32UUID());
				patient.setVisitCode(resourceId);
				patient.setHosipitalName(detail.getString("hospitalName"));
				patient.setVisitType(detail.getString("type"));
				patient.setPatientName(detail.getString("customerName"));
				patient.setSex(detail.getString("customerSex"));
			if(type.equals(Const.YANYUAN_VISIT_INHOS)) {
				// 住院
				patient.setVisitDate(detail.getString("inHospitalDate"));
				patient.setOutHospitalDate(detail.getString("outHospitalDate"));
				patient.setTimes(detail.getString("count"));
				patient.setBed(detail.getString("bed"));
			}else if(type.equals(Const.YANYUAN_VISIT_CAREFORM)) {
				// 护理业态
				patient.setVisitDate(detail.getString("liveDate"));
				patient.setBuildingNum(detail.getString("bulidingNum"));
				patient.setRootNum(detail.getString("roomNum"));
			}else if(type.equals(Const.YANYUAN_VISIT_PHYS)) {
				// 体检信息
				patient.setVisitDate(detail.getString("phyDate"));
				patient.setTimes(detail.getString("count"));
			}else if(type.equals(Const.YANYUAN_VISIT_ENCOUNTER)) {
				// 门诊就诊信息
				patient.setEmpName(detail.getString("doctorName"));
				patient.setDoctorType(detail.getString("doctorTitle"));
				patient.setSectionName(detail.getString("departName"));
				patient.setVisitDate(detail.getString("encountDate"));
				patient.setTimes(detail.getString("count"));
			}else {
				return patient;
			}
		}else {
			return patient;
		}
		return patient;
	}

}

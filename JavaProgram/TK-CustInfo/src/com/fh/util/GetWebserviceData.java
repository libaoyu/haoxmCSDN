package com.fh.util;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.fh.entity.section.PatientInfo;

public class GetWebserviceData {
	
	/**
	 * 通过strIndex获取单条问诊数据 
	 **/
	public static PatientInfo getPatientInfo(String strIndex) throws Exception{
		//通过UrlConnection调用webservice服务
				//String wsUrl = DbFH.getPprVue().getProperty("xl_his_url");
				String wsUrl = "http://218.94.72.190:58082/Service.asmx";
				URL url = new URL(wsUrl);
				URLConnection conn = url.openConnection();
		        HttpURLConnection con = (HttpURLConnection) conn;
		        con.setDoInput(true);                  //是否有入参
		        con.setDoOutput(true);                //是否有出参
		        con.setRequestMethod("POST");   // 设置请求方式
		        con.setRequestProperty("content-type", "text/xml;charset=UTF-8");
		        //手动构造请求体  
		        String soap = getSoapRequest(strIndex);
		        //获得输出流
		        OutputStream out = con.getOutputStream();
		        out.write(soap.getBytes());
		        out.close();
		        
				int code = con.getResponseCode();
				PatientInfo patientInfo = null;
				// 服务端返回正常
				if (code == 200) {
					InputStream is = con.getInputStream();
					byte[] b = new byte[1024];
					StringBuffer sb = new StringBuffer();
					int len = 0;
					while ((len = is.read(b)) != -1) {
						String str = new String(b, 0, len, "UTF-8");
						sb.append(str);
					}
					System.out.println(sb.toString());
					// 替换&lt、&gt
					String xmlStr = sb.toString().replace("&lt;", "<" + "").replace("&gt;", ">" + "").trim();
					is.close();
					// 转xml并解析
					System.out.println(xmlStr);
					Document document = DocumentHelper.parseText(xmlStr);
					Element rootEle = document.getRootElement();
					Iterator body = rootEle.elementIterator("Body");
					while (body.hasNext()) {
						Element recordEless = (Element) body.next();
						Iterator getPResponse = recordEless.elementIterator("GetPatiInfoResponse"); 
						while(getPResponse.hasNext()){
							Element returnValue = (Element)getPResponse.next();
							Iterator returnIt = returnValue.elementIterator("GetPatiInfoResult"); 
							while(returnIt.hasNext()){
								Element item = (Element)returnIt.next();
								// 子节点数为1，则是没有查询到相关数据
								if(item.elements().size()==1){
									return patientInfo;
								}else{
									patientInfo = new PatientInfo();
									patientInfo.setRecordId(UuidUtil.get32UUID());
									// 返回的报文中不包含strIndex
									patientInfo.setStrIndex(strIndex);
									patientInfo.setVisitType(item.elementTextTrim("visit_type")==null?"":item.elementTextTrim("visit_type"));
									patientInfo.setVisitDate(item.elementTextTrim("visit_date")==null?null:DateUtil.fomatTime(item.elementTextTrim("visit_date")));
									patientInfo.setPatientId(item.elementTextTrim("patient_id")==null?"":item.elementTextTrim("patient_id"));
									patientInfo.setPatientName(item.elementTextTrim("patient_name")==null?"":item.elementTextTrim("patient_name"));
									patientInfo.setSex(item.elementTextTrim("sex")==null?"":item.elementTextTrim("sex"));
									patientInfo.setPhoneNumber(item.elementTextTrim("phone_number")==null?"":item.elementTextTrim("phone_number"));
									patientInfo.setTimes(item.elementTextTrim("times")==null?"":item.elementTextTrim("times"));
									patientInfo.setEmpCode(item.elementTextTrim("emp_code")==null?"":item.elementTextTrim("emp_code"));
									patientInfo.setEmpName(item.elementTextTrim("emp_name")==null?"":item.elementTextTrim("emp_name"));
									patientInfo.setSectionCode(item.elementTextTrim("section_code")==null?"":item.elementTextTrim("section_code"));
									patientInfo.setSectionName(item.elementTextTrim("section_name")==null?"":item.elementTextTrim("section_name"));
									patientInfo.setDoctortype(Tools.isEmpty(item.elementTextTrim("doctortype"))?"医师":item.elementTextTrim("doctortype"));
									
								}
							}
						}
					}
				}
				con.disconnect();
				        
				return patientInfo;
	}
	
	//手动封装请求体
	private static String getSoapRequest(String strIndex) {
		StringBuilder sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+ "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
				+ "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
				+ "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
				+ "<soap:Body>"
				+ "<GetPatiInfo xmlns=\"http://tempuri.org/\">"
			    + "<strIndex>"
				+ strIndex
			    + "</strIndex></GetPatiInfo>"
				+ "</soap:Body></soap:Envelope>");
		return sb.toString(); 
	}
}

package com.fh.service.questionnaire;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.Questionnaire;
import com.fh.util.ConversionUtil;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("questionnaireResultsService")
public class QuestionnaireResultsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public List<PageData> findCountResultT2(PageData pd, JSONArray json) throws Exception {
		List<PageData> list = new ArrayList<PageData>();
		for (int i = 0; i < json.size(); i++) {
			JSONObject obj = json.getJSONObject(i);
			pd.put("answerResult", obj.get("value"));
			Long sum = (Long) dao.findForObject("QuestionnaireResultsMapper.finCountResultT2", pd);
			PageData pd2 = new PageData();
			pd2.put("opt", obj.get("key"));
			pd2.put("sum", sum);
			list.add(pd2);
		}
		return list;
	}

	public List<PageData> findCountResult(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResult", pd);
	}

	public Long findCountT2Sum(PageData pd) throws Exception {
		return (Long) dao.findForObject("QuestionnaireResultsMapper.findCountT2Sum", pd);
	}

	/**
	 * 满意度计算
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findCountResultStatL1(PageData pd) throws Exception {
		PageData pdf = new PageData();
		List<PageData> list = new ArrayList<PageData>();
		if ("L1".equals(pd.get("tx"))) {
			list = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResultStatL1", pd);
		}
		if ("L2".equals(pd.get("tx"))) {
			list = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResultStatL2", pd);
		}
		if ("qb".equals(pd.get("tx"))) {
			list = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResultStat", pd);
		}
		if (list.size() == 0) {
			return pdf;
		}
		Long yxyb = 0L;
		Long wxyb = 0L;
		Long fz = 0L;
		Long fm = 0L;
		for (int i = 0; i < list.size(); i++) {
			PageData ybPd = list.get(i);
			Long sum = (Long) ybPd.get("sum");
			if (!"".equals(ybPd.getString("opt"))) {
				Long opt = Long.valueOf(ybPd.getString("opt"));
				if (!"0".equals(ybPd.get("opt")) && !"".equals(opt)) {
					yxyb = yxyb + sum;
					fz = fz + sum * opt;
				} else {
					wxyb = wxyb + sum;
				}
			} else {
				wxyb = wxyb + sum;
			}
		}
		fm = yxyb * 5;
		BigDecimal bfb = new BigDecimal("0");
		if (fm != 0) {
			BigDecimal bigFz = new BigDecimal(fz);
			BigDecimal bigFm = new BigDecimal(fm);
			bfb = bigFz.divide(bigFm, 4, RoundingMode.HALF_DOWN).multiply(new BigDecimal(100)).stripTrailingZeros();
			if (bfb.compareTo(BigDecimal.ZERO) == 0) {
				bfb = new BigDecimal("0");
			}
		}
		pdf.put("bfb", bfb.toPlainString());
		pdf.put("yxyb", yxyb.toString());
		pdf.put("wxyb", wxyb.toString());
		pdf.put("fz", fz.toString());
		pdf.put("fm", fm.toString());
		return pdf;

	}

	public PageData findCountResultStatT4(PageData pd) throws Exception {
		PageData pdf = new PageData();
		List<PageData> list = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResultStatL2", pd);
		Long fz = 0L;
		Long fm = 0L;
		Long l = 0L;
		Long d = 0L;
		for (int i = 0; i < list.size(); i++) {
			PageData ybPd = list.get(i);
			Long sum = (Long) ybPd.get("sum");
			String opt = ybPd.getString("opt");
			if (!"".equals(opt)) {
				if(opt.indexOf("分")!=-1){
					opt = opt.substring(0, opt.indexOf("分"));
				}
				Long optl = Long.valueOf(opt);
				// 9-10
				if (optl <= 10 && optl >= 9) {
					l = l + sum;
				}
				// 0-6
				if (optl >= 0 && optl <= 6) {
					d = d + sum;
				}
				fm = fm + sum;
			}

		}
		fz = l - d;
		BigDecimal bfb = new BigDecimal("0");
		if (fm != 0) {
			BigDecimal bigFz = new BigDecimal(fz);
			BigDecimal bigFm = new BigDecimal(fm);
			bfb = bigFz.divide(bigFm, 4, RoundingMode.HALF_DOWN).multiply(new BigDecimal(100)).stripTrailingZeros();
			if (bfb.compareTo(BigDecimal.ZERO) == 0) {
				bfb = new BigDecimal("0");
			}
		}
		pdf.put("bfb", bfb.toPlainString());
		pdf.put("fz", fz.toString());
		pdf.put("fm", fm.toString());
		return pdf;
	}

	/**
	 * 星级评定饼图
	 * 
	 * @throws Exception
	 * 
	 */
	public PageData findStarBt(PageData pdret,PageData pd) throws Exception {
		List<PageData> btList = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findCountResultStarLeve",pd);
		String sqlAvg = "";
		if(!Tools.isEmpty(pd.getString("EMP_CODE"))){  //如果医生不为空，则计算科室下所有医生
			sqlAvg = getSql("1",pd,pdret.getString("questionId"),pd.getString("lastLoginStart"),pd.getString("lastLoginEnd"));//医生月平均分
		}
		if(!Tools.isEmpty(pd.getString("SECTION_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE"))){  //如果医生为空，科室不为空，则计算医院下所有科室
			sqlAvg = getSql("2",pd,pdret.getString("questionId"),pd.getString("lastLoginStart"),pd.getString("lastLoginEnd"));//科室月平均分
		}
		if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE")) && Tools.isEmpty(pd.getString("SECTION_CODE"))){
			sqlAvg = getSql("3",pd,pdret.getString("questionId"),pd.getString("lastLoginStart"),pd.getString("lastLoginEnd"));//医院月平均分
		}
		if(Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE")) && Tools.isEmpty(pd.getString("SECTION_CODE"))){
			sqlAvg = getSql("4",pd,pdret.getString("questionId"),pd.getString("lastLoginStart"),pd.getString("lastLoginEnd"));//全院院月平均分
		}
		PageData avgRes = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", sqlAvg);
		
		// 组装前台展示数据
		String[] btData = null; //
		List<PageData> bt = new ArrayList<PageData>();
		// 初始化饼图
		if(btList!=null){
			btData = new String[btList.size()];
		}
		int i = 0;
		Long fz = 0L;
		Long fm = 0L;
		for (PageData pd2 : btList) {
			PageData btpd2 = new PageData();
			Long sum = (Long) pd2.get("sum");//人数
			Long source = Long.valueOf(pd2.getString("opt"));//分数
			fz += sum * source;
			fm += sum;
			if(source == 0){
				btData[i] = "不适用";
				btpd2.put("name","不适用");
			}else{
				btData[i] = source+"分";
				btpd2.put("name", source+"分");
			}
			btpd2.put("value", pd2.get("sum"));
			
			bt.add(btpd2);
			i++;
		}
		BigDecimal bfb = new BigDecimal("0");
		if(avgRes!=null){
			bfb = (BigDecimal) avgRes.get("average");
		}
		pdret.put("bfb", bfb);
		pdret.put("bt", bt);
		pdret.put("btData", btData);

		return pdret;
	}

	/**
	 * 星级评定折线图数据查询时间段
	 * 
	 * @param start
	 * @param end
	 * @throws Exception
	 */
	public Map<String, Object> findStarZX(int isFinance, int kd, String questionId, Date start, Date end,PageData pd) throws Exception {
		List<String> listkey = new ArrayList<String>();
		List<String> listkeyEMP = new ArrayList<String>();
		BigDecimal averAgeRes = new BigDecimal("0");  //折现图基线初始化
		String avgerStr = "";
		PageData pdResult = null;
		PageData averAge = null;
		PageData pdEmp = new PageData();
		//判断查询平均分
		if(!Tools.isEmpty(pd.getString("EMP_CODE"))){  //如果医生不为空，则计算科室下所有医生
			avgerStr = "科室平均分";
			String sqlAvg = getDoceorAverAgeSql("1",isFinance, kd, start, end, listkey, questionId,pd);//医生月平均分
			pdResult = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", sqlAvg);
			pdEmp.put("SECTION_CODE", pd.get("SECTION_CODE"));
			pdEmp.put("HOSIPITAL_CODE", pd.get("HOSIPITAL_CODE"));
			if(pdResult!=null){
				String averSql = getDoceorAverAgeSql("2",isFinance, kd, start, end, listkeyEMP, questionId,pdEmp); //科室月平均分
				averAge = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", averSql);//平均分结果
			}
		}
		if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) && !Tools.isEmpty(pd.getString("SECTION_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE"))){  //如果医生为空，科室不为空，则计算医院下所有科室
			avgerStr = "医院平均分";
			String sqlAvg = getDoceorAverAgeSql("2",isFinance, kd, start, end, listkey, questionId,pd);//科室月平均分
			pdResult = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", sqlAvg);
			pdEmp.put("HOSIPITAL_CODE", pd.get("HOSIPITAL_CODE"));
			if(pdResult!=null){
				String averSql = getDoceorAverAgeSql("3",isFinance, kd, start, end, listkeyEMP, questionId,pdEmp); //医院月平均分
				averAge = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", averSql);//平均分结果
			}
		}
		if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE")) && Tools.isEmpty(pd.getString("SECTION_CODE"))){
			avgerStr = "全院平均分";
			String sqlAvg = getDoceorAverAgeSql("3",isFinance, kd, start, end, listkey, questionId,pd);//科室月平均分
			pdResult = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", sqlAvg);
			if(pdResult!=null){
				String averSql = getDoceorAverAgeSql("4",isFinance, kd, start, end, listkeyEMP, questionId,pdEmp); //医院月平均分
				averAge = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", averSql);//平均分结果
			}
		}if(Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) && Tools.isEmpty(pd.getString("EMP_CODE")) && Tools.isEmpty(pd.getString("SECTION_CODE"))){
			String sqlAvg = getDoceorAverAgeSql("4",isFinance, kd, start, end, listkey, questionId,pd);//全院月平均分
			pdResult = (PageData) dao.findForObject("QuestionnaireResultsMapper.commonSql", sqlAvg);
		}
		Collections.reverse(listkeyEMP);//反转集合
		if(averAge != null){ //计算折线图基线数值
			Double fz = 0.0;
			for (int i = listkeyEMP.size()-1; i >=0 ; i--) {
				Object obj = averAge.get(listkeyEMP.get(i));
				if (obj != null) {
					 fz += Double.valueOf(obj.toString());
				}
			}
			BigDecimal bigFz = new BigDecimal(fz);
			BigDecimal bigFm = new BigDecimal(kd);
			averAgeRes = bigFz.divide(bigFm,2,RoundingMode.HALF_DOWN).stripTrailingZeros();
			if(averAgeRes.compareTo(BigDecimal.ZERO)==0){
				averAgeRes = new BigDecimal("0");
			}
		}
		Collections.reverse(listkey);//反转集合
		String[] xData = new String[listkey.size()];
		String[] yData = new String[listkey.size()];
		for (int i = listkey.size()-1; i >=0 ; i--) {
			xData[i] = listkey.get(i);
			if (pdResult == null) {
				yData[i] = "0";
			} else {
				Object obj = pdResult.get(listkey.get(i));
				if (obj != null) {
					yData[i] = pdResult.get(listkey.get(i)).toString();
				} else {
					yData[i] = "0";
				}
			}
		}
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("x", xData);
		map.put("y", yData);
		map.put("averAgeRes", averAgeRes);
		map.put("avgerStr", avgerStr);
		return map;
	}

	//计算医生平均分
	/**
	 * 
	 * @param types 1:医生2：科室3：医院4：全院
	 * @param isFinance是否财务月
	 * @param kd刻度
	 * @param start开始时间
	 * @param end结束时间
	 * @param listkey
	 * @param questionId
	 * @param pd
	 * @return
	 */
	public String getDoceorAverAgeSql(String types,int isFinance, int kd, Date start, Date end, List<String> listkey ,String questionId,PageData pd) {
		// 时间段差值
		StringBuffer sb = new StringBuffer("select ");
		SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfdy = new SimpleDateFormat("yy-MM-dd");
		SimpleDateFormat sf = new SimpleDateFormat("yy-MM");
		SimpleDateFormat sfdd = new SimpleDateFormat("dd");
		int day = DateUtil.differentDaysByMillisecond(start, end)+1;
		for (int i = 0; i < kd; i++) {
			Date s1 = new Date(); // 开始时间x月25
			Date s2 = new Date(); // 结束时间x月26
			Calendar calendarL = Calendar.getInstance();
			calendarL.setTime(end);
			if (isFinance == 1) {// 非财务月
				calendarL.setTime(end);
				calendarL.add(Calendar.DAY_OF_MONTH, -day);
				s1 = calendarL.getTime();
				s2 = end;
				end = s1;
				calendarL.add(Calendar.DAY_OF_MONTH, 1);
				s1 = calendarL.getTime();
			} else {
				if (calendarL.get(Calendar.MONDAY) == 0) { //一月份
					calendarL.set(Calendar.DAY_OF_MONTH, 1);
				} else {
					calendarL.add(Calendar.MONDAY, -1);
					calendarL.set(Calendar.DAY_OF_MONTH, 26);
				}
				s1 = calendarL.getTime();
				calendarL.setTime(end);
				if (calendarL.get(Calendar.MONDAY) == 11) { //12月份
					calendarL.set(Calendar.DAY_OF_MONTH, 31);
					s2 = calendarL.getTime();
				} else {
					calendarL.set(Calendar.DAY_OF_MONTH, 25);
					s2 = calendarL.getTime();
				}
				calendarL.add(Calendar.MONDAY, -1);
				end = calendarL.getTime();
			}
			// 组装各时间段sql ---(),
			StringBuffer sb1 = new StringBuffer();
			sb1.append("(");
			sb1.append(getSql(types,pd,questionId,sdfd.format(s1),sdfd.format(s2)));
			if(isFinance == 1){
				sb1.append(") as '" + sdfdy.format(s1) + "至" + sfdd.format(s2) + "',");
				listkey.add(sdfdy.format(s1) + "至" + sfdd.format(s2));
			}else{
				sb1.append(") as '" + sf.format(s2) + "',");
				listkey.add(sf.format(s2));
			}
			sb.append(sb1.toString());
		}
		sb.deleteCharAt(sb.length() - 1);
		return sb.toString();
	}
	/**
	 * 获取对应sql
	 * @param types1:医生2：科室3：医院4：全院
	 * @param pd
	 * @param questionId
	 * @param date1
	 * @param date2
	 * @return
	 */
	public String getSql(String types,PageData pd,String questionId,String date1,String date2){
		StringBuffer sb1 = new StringBuffer();
		if("1".equals(types)){  //医生平均分
			sb1.append("select cast(avg(answerResult) as decimal(3, 2)) as average from tb_section_base t1,tb_questionnaire_results t2 where");
			sb1.append(" questionId = '" + questionId + "' ");
			sb1.append(" AND `status` = 1 ");
			sb1.append(" AND answerResult != ''");
			sb1.append(" AND Date(createTime) >= '" + date1+ "'  and Date(createTime) <= '" + date2 + "'");
			sb1.append(" AND t1.VISIT_CODE = visitCode");
			sb1.append(" AND t1.HOSIPITAL_CODE = hosipitalcode");
			sb1.append(" AND t1.HOSIPITAL_CODE = '"+pd.getString("HOSIPITAL_CODE")+"'");
			sb1.append(" AND t1.SECTION_CODE = '"+pd.getString("SECTION_CODE")+"'");
			sb1.append(" AND t1.EMP_CODE = '"+pd.getString("EMP_CODE")+"'");
		}
		if("2".equals(types)){ //科室平均分
			sb1.append("select cast(avg(t3.avgerAvg1) AS DECIMAL (3, 2)) AS average from (");
			sb1.append("SELECT AVG(answerResult) AS avgerAvg1,t1.EMP_CODE");
			sb1.append(" FROM tb_section_base t1,tb_questionnaire_results t2 WHERE");
			sb1.append(" questionId = '" + questionId + "' ");
			sb1.append(" AND `status` = 1 ");
			sb1.append(" AND answerResult != ''");
			sb1.append(" AND Date(createTime) >= '" + date1 + "'  and Date(createTime) <= '" + date2 + "'");
			sb1.append(" AND t1.VISIT_CODE = visitCode");
			sb1.append(" AND t1.HOSIPITAL_CODE = hosipitalcode");
			sb1.append(" AND t1.HOSIPITAL_CODE = '"+pd.getString("HOSIPITAL_CODE")+"'");
			sb1.append(" AND t1.SECTION_CODE = '"+pd.getString("SECTION_CODE")+"'");
			sb1.append(" AND t1.EMP_CODE !=''");
			sb1.append(" GROUP BY t1.EMP_CODE) t3");
			
		}
		if("3".equals(types)){ //医院平均分
			sb1.append("select cast(avg(t4.avgerAvg2) as decimal(3, 2)) as average from (");
			sb1.append("select avg(t3.avgerAvg1) as avgerAvg2,t3.SECTION_CODE,t3.HOSIPITAL_CODE from (");
			sb1.append("SELECT AVG(answerResult) AS avgerAvg1,t1.EMP_CODE,t1.SECTION_CODE,t1.HOSIPITAL_CODE");
			sb1.append(" FROM tb_section_base t1,tb_questionnaire_results t2 WHERE");
			sb1.append(" questionId = '" + questionId + "' ");
			sb1.append(" AND `status` = 1 ");
			sb1.append(" AND answerResult != ''");
			sb1.append(" AND Date(createTime) >= '" + date1 + "'  and Date(createTime) <= '" + date2 + "'");
			sb1.append(" AND t1.VISIT_CODE = visitCode");
			sb1.append(" AND t1.HOSIPITAL_CODE = hosipitalcode");
			sb1.append(" AND t1.HOSIPITAL_CODE = '"+pd.getString("HOSIPITAL_CODE")+"'");
			sb1.append(" AND t1.SECTION_CODE !=''");
			sb1.append(" AND t1.EMP_CODE !=''");
			sb1.append(" GROUP BY t1.EMP_CODE,t1.SECTION_CODE,t1.HOSIPITAL_CODE" );
			sb1.append(" ) t3  GROUP BY t3.SECTION_CODE,t3.HOSIPITAL_CODE");
			sb1.append(" ) t4 GROUP BY t4.HOSIPITAL_CODE");
		}
		if("4".equals(types)){ //全院平均分
			sb1.append("SELECT cast(avg(t5.avgerAvg3) as decimal(3, 2)) as average from (");
			sb1.append("select  avg(t4.avgerAvg2) as avgerAvg3,t4.HOSIPITAL_CODE  from (");
			sb1.append("select avg(t3.avgerAvg1) as avgerAvg2,t3.SECTION_CODE,t3.HOSIPITAL_CODE from (");
			sb1.append("SELECT AVG(answerResult) AS avgerAvg1,t1.EMP_CODE,t1.SECTION_CODE,t1.HOSIPITAL_CODE");
			sb1.append(" FROM tb_section_base t1,tb_questionnaire_results WHERE");
			sb1.append(" questionId = '" + questionId + "' ");
			sb1.append(" AND `status` = 1 ");
			sb1.append(" AND answerResult != ''");
			sb1.append(" AND Date(createTime) >= '" + date1 + "'  and Date(createTime) <= '" + date2 + "'");
			sb1.append(" AND t1.VISIT_CODE = visitCode");
			sb1.append(" AND t1.HOSIPITAL_CODE = hosipitalcode");
			sb1.append(" AND t1.HOSIPITAL_CODE !=''");
			sb1.append(" AND t1.SECTION_CODE !=''");
			sb1.append(" AND t1.EMP_CODE !=''");
			sb1.append(" GROUP BY t1.EMP_CODE,t1.SECTION_CODE,t1.HOSIPITAL_CODE");
			sb1.append(") t3 GROUP BY t3.SECTION_CODE,t3.HOSIPITAL_CODE");
			sb1.append(") t4 GROUP BY t4.HOSIPITAL_CODE");
			sb1.append(") t5");
		}
		return sb1.toString();
	}
	
	
	/**
	 * 
	 * @param isFinance
	 *            是否财务月
	 * @param kd
	 *            刻度
	 * @param start
	 *            开始时间
	 * @param end
	 *            结束时间
	 */
	public static String getFinanceSql(int isFinance, int kd, Date start, Date end, List<String> listkey ,String questionId,PageData pd) {
		// 时间段差值
		StringBuffer sb = new StringBuffer("select ");
		SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfdy = new SimpleDateFormat("yy-MM-dd");
		SimpleDateFormat sf = new SimpleDateFormat("yy-MM");
		SimpleDateFormat sfdd = new SimpleDateFormat("dd");
		
		int day = DateUtil.differentDaysByMillisecond(start, end)+1;
		for (int i = 0; i < kd; i++) {
			Date s1 = new Date(); // 开始时间x月25
			Date s2 = new Date(); // 结束时间x月26
			Calendar calendarL = Calendar.getInstance();
			calendarL.setTime(end);
			if (isFinance == 1) {// 非财务月
				calendarL.setTime(end);
				calendarL.add(Calendar.DAY_OF_MONTH, -day);
//				calendarL.set(Calendar.HOUR_OF_DAY, 0);
//				calendarL.set(Calendar.MINUTE, 0);
//				calendarL.set(Calendar.SECOND, 0);
				s1 = calendarL.getTime();
				s2 = end;
				end = s1;
				calendarL.add(Calendar.DAY_OF_MONTH, 1);
				s1 = calendarL.getTime();
			} else {
				if (calendarL.get(Calendar.MONDAY) == 0) { //一月份
					calendarL.set(Calendar.DAY_OF_MONTH, 1);
				} else {
					calendarL.add(Calendar.MONDAY, -1);
					calendarL.set(Calendar.DAY_OF_MONTH, 25);
				}
//				calendarL.set(Calendar.HOUR_OF_DAY, 0);
//				calendarL.set(Calendar.MINUTE, 0);
//				calendarL.set(Calendar.SECOND, 0);
				s1 = calendarL.getTime();
				calendarL.setTime(end);
				if (calendarL.get(Calendar.MONDAY) == 11) { //12月份
					calendarL.set(Calendar.DAY_OF_MONTH, 31);
//					calendarL.set(Calendar.HOUR_OF_DAY, 23);
//					calendarL.set(Calendar.MINUTE, 59);
//					calendarL.set(Calendar.SECOND, 59);
					s2 = calendarL.getTime();
				} else {
					calendarL.set(Calendar.DAY_OF_MONTH, 25);
//					calendarL.set(Calendar.HOUR_OF_DAY, 23);
//					calendarL.set(Calendar.MINUTE, 59);
//					calendarL.set(Calendar.SECOND, 59);
					s2 = calendarL.getTime();
				}
				calendarL.add(Calendar.MONDAY, -1);
				end = calendarL.getTime();
			}
			// 组装各时间段sql ---(),
			StringBuffer sb1 = new StringBuffer();
			sb1.append(
					"(select cast(avg(answerResult) as decimal(2,1)) as average from tb_questionnaire_results where questionId=");
			sb1.append("'" + questionId + "' ");
			sb1.append("and `status` = 1 ");
			sb1.append("and Date(createTime) >= '" + sdfd.format(s1) + "'  and Date(createTime) <= '" + sdfd.format(s2) + "'");
			if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE")) || !Tools.isEmpty(pd.getString("SECTION_CODE")) || !Tools.isEmpty(pd.getString("EMP_CODE"))){
				sb1.append("and visitCode in ( SELECT VISIT_CODE FROM tb_section_base WHERE 1=1 ");
				if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE"))){
					sb1.append("AND	HOSIPITAL_CODE = ");
					sb1.append("'"+pd.getString("HOSIPITAL_CODE")+"'");
				}
				if(!Tools.isEmpty(pd.getString("SECTION_CODE"))){
					sb1.append("AND	SECTION_CODE = ");
					sb1.append("'"+pd.getString("SECTION_CODE")+"'");
				}
				if(!Tools.isEmpty(pd.getString("EMP_CODE"))){
					sb1.append("AND	EMP_CODE = ");
					sb1.append("'"+pd.getString("EMP_CODE")+"'");
				}
				sb1.append("GROUP BY VISIT_CODE)");
				if(!Tools.isEmpty(pd.getString("HOSIPITAL_CODE"))){
					sb1.append("AND hosipitalCode ='"+pd.getString("HOSIPITAL_CODE")+"'");
				}
			}
			if(isFinance == 1){
				sb1.append(") as '" + sdfdy.format(s1) + "至" + sfdd.format(s2) + "',");
				listkey.add(sdfdy.format(s1) + "至" + sfdd.format(s2));
			}else{
				sb1.append(") as '" + sf.format(s2) + "',");
				listkey.add(sf.format(s2));
			}
			sb.append(sb1.toString());
		}
		sb.deleteCharAt(sb.length() - 1);
		return sb.toString();
	}

	/**
	 * 计算全部问卷结果总共
	 * @param questionnaires
	 * @return 
	 * @throws Exception 
	 */
	public PageData findQuestionnaireRest(PageData pd) throws Exception{
		PageData pdr = new PageData();
		List<PageData> listPd = (List<PageData>) dao.findForList("QuestionnaireResultsMapper.findResultSum", pd);
		String[] legendData = new String[listPd.size()];
		List<Map<String,Object>> seriesData = new ArrayList<Map<String,Object>>();
		Long count = 0L;
		if(listPd != null){
			for (int i = 0; i < listPd.size(); i++) {
				Map<String,Object> serMap = new HashMap<String, Object>();
				Object obj = listPd.get(i).get("count");
				Long sum = 0L;
				if(obj!=null){
					sum = (Long) obj;
				}
				count += sum;
				legendData[i] = listPd.get(i).getString("title")+"("+sum+")";
				serMap.put("name", listPd.get(i).getString("title")+"("+sum+")");
				serMap.put("value", sum);
				seriesData.add(serMap);
			}	
		}
		pdr.put("legendData", legendData);
		pdr.put("seriesData", seriesData);
		pdr.put("count", count);
		return pdr;
	}
	/**
	 * 根据就诊code，医院编码获取结果列表数量
	 * @param pd
	 * @return
	 */
	public Long findQuestionnaireResultCountByVisitCodeAndHosipitalCode(PageData pd)throws Exception{
		return (Long) dao.findForObject("QuestionnaireResultsMapper.findQuestionnaireResultCountByVisitCodeAndHosipitalCode", pd);
	}
	

	public List<String> findSectionQuestionnaire(PageData pd) throws Exception{
		return (List<String>) dao.findForList("QuestionnaireResultsMapper.findSectionQuestionnaire", pd);
	}
	
}

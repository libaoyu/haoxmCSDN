package com.fh.service.questionnaire;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.MapEntity;
import com.fh.entity.system.QuestionnaireResults;
import com.fh.entity.system.Questions;
import com.fh.entity.system.QuestionsHeader;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

@Service("questionsHeaderService")
public class QuestionsHeaderService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/*
	* 新增
	*/
	public void save(Questions questions)throws Exception{
		dao.save("QuestionsHeaderMapper.save", questions);
	}
	/**
	 * 批量插入数据
	 * by xiaoding
	 * @return
	 * @throws Exception 
	 */
	public void saveList(List<QuestionsHeader> list,List<QuestionnaireResults> listBody) throws Exception{
		/*两张结果表合并为一张表
		 * if(list!=null&&list.size()>0){
			dao.save("QuestionsHeaderMapper.insertAll", list);
		}*/
		if(listBody!=null&&listBody.size()>0){
			dao.save("QuestionnaireResultsMapper.insertAll", listBody);
		}
	}
	/**
	 * 查询列表的标题
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<MapEntity> findTitleByQuestionsnaireId(PageData pd) throws Exception{
		String level=pd.getString("level");
		
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
			}
			levelStr.append(")");
			pd.put("levelStr", levelStr);
		}
		List<PageData> listPageData=(List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd);
		List<MapEntity> listMap=new ArrayList<MapEntity>();
		//获取问卷的标题
		if(listPageData!=null && listPageData.size()>0){
			//MapEntity entity=new MapEntity();
			//问诊信息						开始
			PageData pageData=(PageData)dao.findForObject("QuestionnaireMapper.findHistoryResultsById", pd);//问卷实体
			if(null !=pageData){
				String questionnaireType=pageData.getString("questionnaireType");
				//只有星级评定问卷才会涉及-----------增加就诊数据基本信息
				if(Const.QUESTIONNAIRE_TYPE_STAR_LEVEL.equals(questionnaireType)){
					//根据       问卷                       医院编码    和              医院借口编码         获取基础配置信息
					String hospitalCode=pageData.getString("hospitalCode");//问卷对应的医院编码
					String interfaceCode=pageData.getString("interfaceCode");//问卷能对应的借口编码
					List<PageData > titleList=getSectionConfigureForQuestionnaire(hospitalCode,interfaceCode,pd.getString("showType"));
					if(titleList!=null){
	//					for (int i = 0; i < titleList.size(); i++) {
						for (PageData conf : titleList) {
							MapEntity entityDataTile=new MapEntity();
							entityDataTile.setKey(conf.getString("LABEL"));
							entityDataTile.setValue(conf.getString("LABEL"));
							listMap.add(entityDataTile);
						}
					}
				}
			}
			//问诊信息						结束
			MapEntity entityData=new MapEntity();
			entityData.setKey("问卷名称");
			entityData.setValue("问卷名称");
			listMap.add(entityData);
			String dcdx="";
			for (int i = 0; i < listPageData.size(); i++) {
				MapEntity entity=new MapEntity();
				PageData data=listPageData.get(i);
				String classification=data.getString("classification");
			
				if(classification!=null){
					//卷头的话取        title  
					if(classification.equals("L0")){
						entity.setKey("title");
						entity.setValue(data.getString("title"));
						listMap.add(entity);
						if(i==listPageData.size()-1){
							MapEntity entity1=new MapEntity();
							dcdx="调查对象";
							entity1.setKey(dcdx);
							entity1.setValue(dcdx);
							listMap.add(entity1);
							MapEntity entity2=new MapEntity();
							entity2.setKey("回答时间");
							entity2.setValue("回答时间");
							listMap.add(entity2);
						}
					//正文去code
					}else{
						if(Tools.isEmpty(dcdx)){
							MapEntity entity1=new MapEntity();
							dcdx="调查对象";
							entity1.setKey(dcdx);
							entity1.setValue(dcdx);
							listMap.add(entity1);
							MapEntity entity2=new MapEntity();
							entity2.setKey("回答时间");
							entity2.setValue("回答时间");
							listMap.add(entity2);
						}
						entity.setKey(data.getString("code"));
						entity.setValue(data.getString("code"));
						listMap.add(entity);
					}
				}else 
				listMap.add(entity);
			}
		}
		return listMap;
	}
	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listBatch(Page pd) throws Exception{
		//根据 问卷id查询   所有批次号。
		return (List<PageData>) dao.findForList("QuestionsHeaderMapper.datalistPage", pd);
				
	}
	/**
	 * 查询卷头   正文  的所有值
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<List<String>> listQuestionsResult(Page data,PageData pd) throws Exception{	
		Date date=new Date();
		String level=pd.getString("level");
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			StringBuffer respondentCodeStr=new StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" a.respondentCode like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" or a.respondentCode like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
				respondentCodeStr.append(" a.respondentCode like '%"+level+"%' ");
			}
			levelStr.append(")");
			respondentCodeStr.append(")");
			pd.put("levelStr", levelStr);
			pd.put("respondentCodeStr", respondentCodeStr);
			data.setPd(pd);
		}
		List<PageData> listBatchId=new ArrayList<PageData>();
		String questionnaireId=pd.getString("questionnaireId");
		if(questionnaireId !=null && !questionnaireId.isEmpty()){
			listBatchId=this.listBatch(data);
		}
		//获取标题
		List<PageData> titleList=(List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd);
//		//获取卷头
//		List<QuestionsHeader> listTitle=(List<QuestionsHeader>) dao.findForList("QuestionsHeaderMapper.listQuestionsHeader", pd);
//		//获取正文
//		List<QuestionnaireResults> listResult=(List<QuestionnaireResults>) dao.findForList("QuestionsHeaderMapper.listQuestionsResult", pd);
		List<List<String>> listHang=new ArrayList<List<String>>();
		//遍历所有批次号。
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		if(listBatchId!=null&&titleList!=null&&titleList.size()>0&&listBatchId.size()>0){
			for (int i = 0; i < listBatchId.size(); i++) {
				List<String> listLie=new ArrayList<String>();
				PageData pageData=listBatchId.get(i);
				listLie.add(pageData.getString("title"));
				String batchId=pageData.getString("batch_id");
				//标题里面包含当提问题id
				String respondent="";//调查对象
				String respondentCode="";//备用调查对象。假如，卷头。为空时。正文不从第一个开始。就会出现调查对象为空。
				for (PageData page : titleList) {
					String questionId=page.getString("questionId");
					String classification=page.getString("classification");
					pd.put("questionId", questionId);
					pd.put("batchId", batchId);
					if(classification!=null){
						/*if(classification.equals("L0")){
							List<QuestionsHeader> listTitle=(List<QuestionsHeader>) dao.findForList("QuestionsHeaderMapper.listQuestionsHeader", pd);
							if(listTitle!=null&&listTitle.size()>0){
								for (int j = 0; j < listTitle.size(); j++) {
									QuestionsHeader header =listTitle.get(j);
									if(Tools.isEmpty(respondentCode)){
										respondentCode=header.getRespondentCode();
									}
									listLie.add(header.getTitleValue());
								}
							}else{
								listLie.add("");
							}
						}else{*/
							List<QuestionnaireResults> listResult=(List<QuestionnaireResults>) dao.findForList("QuestionnaireResultsMapper.listQuestionsResult", pd);
							if(listResult!=null&&listResult.size()>0){
								for (int j = 0; j < listResult.size(); j++) {
									QuestionnaireResults header =listResult.get(j);
									if(Tools.isEmpty(respondent)){
										respondent=header.getRespondentCode();
										//Map<String,String> staffLevel=ConversionUtil.getStaffLevel();
										Map<String,String> staffLevel;
										String respondentsParentId=pageData.getString("respondentsParentId");
										staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
										String respondentUser=staffLevel.get(respondent);
										if(!Tools.isEmpty(respondentUser)){
											listLie.add(respondentUser);//增加调差对象列
											//增加回答时间列
											listLie.add(sdfTime.format(header.getCreateTime()));
										}
									}
									listLie.add(header.getAnswerResult());
								}
							}else{
								if(Tools.isEmpty(respondent)){
									respondent=respondentCode;
//									Map<String,String> staffLevel=ConversionUtil.getStaffLevel();
									Map<String,String> staffLevel;
									String respondentsParentId=pageData.getString("respondentsParentId");
									staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
									String respondentUser=staffLevel.get(respondent);
									if(!Tools.isEmpty(respondentUser)){
										listLie.add(respondentUser);
									}
								}
									listLie.add("");
							}
						//}
					}else{
						listLie.add("");
					}
				}
				pd.put("questionId", "");
				pd.put("batchId", "");
				listHang.add(listLie);
			}
		}
		Date date1=new Date();
		System.out.println("============================================================");
		System.err.println(date1.getTime()-date.getTime());
		System.out.println("============================================================");
		return listHang; 
	}
	/**
	 * 
	 */
	public List<List<String>> listQuestionsResultForExport(Page data,PageData pd) throws Exception{	
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String level=pd.getString("level");
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			StringBuffer respondentCodeStr=new StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" a.respondentCode like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" or a.respondentCode like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
				respondentCodeStr.append(" a.respondentCode like '%"+level+"%' ");
			}
			levelStr.append(")");
			respondentCodeStr.append(")");
			pd.put("levelStr", levelStr);
			pd.put("respondentCodeStr", respondentCodeStr);
			data.setPd(pd);
		}
		String listQuestionResultIdStr=pd.getString("listBatchId");
		String isExportAll=pd.getString("isExportAll");
		List<PageData> listBatchId=new ArrayList<PageData>();
		//StringBuffer startTimeHeader=new StringBuffer();
		StringBuffer startTimeRe=new StringBuffer();
		if(!Tools.isEmpty(listQuestionResultIdStr) && isExportAll.equals("no")){
			String listQuestionResultId=" a.batch_id  in  ('"+listQuestionResultIdStr.replace(",", "','")+"')";
			pd.put("listQuestionResultId", listQuestionResultId);
			
		}else{
			String startTime=pd.getString("startTime");
			String endTime=pd.getString("endTime");
			
			Date date=new Date();
			String dateStr=sdfTime.format(date);
			//开始时间为空
			if(!Tools.isEmpty(startTime)&&Tools.isEmpty(endTime)){
				//startTimeHeader.append("(  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+dateStr.trim()+"' ) ");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and   '"+dateStr.trim()+"' )");
			//结束时间为空
			}else if(Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
			//	startTimeHeader.append(" ( DATE(a.create_time)  BETWEEN '"+dateStr.trim()+"'   and '"+endTime.trim()+"'   )");
				startTimeRe.append(" ( DATE(a.createTime) BETWEEN   '"+dateStr.trim()+"'  and    '"+ endTime.trim()+"'  )");
			}else if(!Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
			//	startTimeHeader.append(" (  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+endTime.trim()+"'   )");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and  '"+endTime.trim()+"'   )");
			}
			
		}
	//	pd.put("startTimeStrHeader", startTimeHeader.toString());
		pd.put("startTimeStrRe", startTimeRe.toString());
		listBatchId= (List<PageData>) dao.findForList("QuestionsHeaderMapper.listDataForExprot", pd);
		//获取标题
		@SuppressWarnings("unchecked")
		List<PageData> titleList=(List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd);
		List<List<String>> listHang=new ArrayList<List<String>>();
		//遍历所有批次号。
		
		if(listBatchId!=null&&titleList!=null&&titleList.size()>0&&listBatchId.size()>0){
			for (int i = 0; i < listBatchId.size(); i++) {
				PageData pageData=listBatchId.get(i);
				String batchId=pageData.getString("batch_id");
				pd.put("batchId", batchId);
				List<PageData> listData=(List<PageData>) dao.findForList("QuestionsHeaderMapper.listQuestionsResultForNew", pd);
				String respondentCode="";//备用调查对象。假如，卷头。为空时。正文不从第一个开始。就会出现调查对象为空。
				Timestamp createTime=null;
				List<String> listLie=new ArrayList<String>();
				listLie.add(pageData.getString("title"));
				//循环遍历每个列
				for (PageData dataPage: listData) {
					String classification  =dataPage.getString("classification");
					String answerResult =dataPage.getString("answerResult");
					Timestamp create_time=(Timestamp)dataPage.get("create_time");
					String respondentCodeStr=dataPage.getString("respondentCode");
					if(Tools.isEmpty(respondentCode)){
						respondentCode=respondentCodeStr;
					}
					if(createTime == null || Tools.isEmpty(createTime.toString())){
						createTime=create_time;
					}
					if(classification!=null){
						if(classification.equals("L0")){
							
							listLie.add(answerResult);
						}else{
							if(!Tools.isEmpty(respondentCode) && !"respondentCode".equals(respondentCode)){
//								Map<String,String> staffLevel=ConversionUtil.getStaffLevel();
								Map<String,String> staffLevel;
								String respondentsParentId=pageData.getString("respondentsParentId");
								staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
								
								String respondentUser=staffLevel.get(respondentCode);
								if(!Tools.isEmpty(respondentUser)){
									listLie.add(respondentUser);//增加调差对象列
								}else{
									listLie.add("");//增加调差对象列
								}
								if(createTime != null &&!Tools.isEmpty(createTime.toString())){
									//增加回答时间列
									listLie.add(sdfTime.format(createTime));
									createTime=null;
								}else{
									
								}
								respondentCode="respondentCode";
							}
							listLie.add(answerResult);
						}
					}else{
						listLie.add("");
					}
				}
				pd.put("batchId", "");
				listHang.add(listLie);
			}
		}
		return listHang; 
	}
	/**
	 * 优化方案
	 * @param data
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<List<String>> listQuestionsResultForNew(Page data,PageData pd) throws Exception{	
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String level=pd.getString("level");
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			StringBuffer respondentCodeStr=new StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" a.respondentCode like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" or a.respondentCode like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
				respondentCodeStr.append(" a.respondentCode like '%"+level+"%' ");
			}
			levelStr.append(")");
			respondentCodeStr.append(")");
			pd.put("levelStr", levelStr);
			pd.put("respondentCodeStr", respondentCodeStr);
		}
		List<PageData> listBatchId=new ArrayList<PageData>();
		String questionnaireId=pd.getString("questionnaireId");
		if(questionnaireId !=null && !questionnaireId.isEmpty()){
			String startTime=pd.getString("startTime");
			String endTime=pd.getString("endTime");
			StringBuffer startTimeHeader=new StringBuffer();
			StringBuffer startTimeRe=new StringBuffer();
			Date date=new Date();
			String dateStr=sdfTime.format(date);
			//开始时间为空
			if(!Tools.isEmpty(startTime)&&Tools.isEmpty(endTime)){
				startTimeHeader.append("(  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+dateStr.trim()+"' ) ");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and   '"+dateStr.trim()+"' )");
			//结束时间为空
			}else if(Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" ( DATE(a.create_time)  BETWEEN '"+dateStr.trim()+"'   and '"+endTime.trim()+"'   )");
				startTimeRe.append(" ( DATE(a.createTime) BETWEEN   '"+dateStr.trim()+"'  and    '"+ endTime.trim()+"'  )");
			}else if(!Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" (  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+endTime.trim()+"'   )");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and  '"+endTime.trim()+"'   )");
			}
			pd.put("startTimeStrHeader", startTimeHeader.toString());
			pd.put("startTimeStrRe", startTimeRe.toString());
			data.setPd(pd);
			listBatchId=this.listBatch(data);
		}
		//获取问诊信息                     开始
		PageData pageDataQuestionnaire=(PageData)dao.findForObject("QuestionnaireMapper.findHistoryResultsById", pd);//问卷实体
		String questionnaireType=null;
		if(pageDataQuestionnaire!=null){
			questionnaireType=pageDataQuestionnaire.getString("questionnaireType");
		}
		List<PageData > titleListForConfigure =null;//接收问诊信息基本配置的集合
		String hospitalCode=null;
		//只有星级评定问卷才会涉及-----------增加就诊数据基本信息
		if(Const.QUESTIONNAIRE_TYPE_STAR_LEVEL.equals(questionnaireType)){
			//根据       问卷                       医院编码    和              医院借口编码         获取基础配置信息
			hospitalCode=pageDataQuestionnaire.getString("hospitalCode");//问卷对应的医院编码
			String interfaceCode=pageDataQuestionnaire.getString("interfaceCode");//问卷能对应的借口编码
			titleListForConfigure=getSectionConfigureForQuestionnaire(hospitalCode,interfaceCode,Const.SHOWTYPE_JGZS);
		}
		PageData pageDataForSectionConfigure=new PageData();
		//获取问诊信息结束
		//获取标题
		List<PageData> titleList=(List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd);
		//定义一行的接收值
		List<List<String>> listHang=new ArrayList<List<String>>();
		//遍历所有批次号。
		if(listBatchId!=null&&titleList!=null&&titleList.size()>0&&listBatchId.size()>0){
			for (int i = 0; i < listBatchId.size(); i++) {
				PageData pageData=listBatchId.get(i);
				String batchId=pageData.getString("batch_id");
				pd.put("batchId", batchId);
				List<String> listLie=new ArrayList<String>();
				listLie.add(batchId);
				List<PageData> listData=(List<PageData>) dao.findForList("QuestionsHeaderMapper.listQuestionsResultForNew", pd);
				pageDataForSectionConfigure.put("visitCode", pageData.getString("visitCode"));
				pageDataForSectionConfigure.put("hosipitalCode", hospitalCode);
				PageData pds = (PageData)dao.findForObject("SectionBaseMapper.getInfoById", pageDataForSectionConfigure);
				//    
				if(titleListForConfigure!=null&&pds!=null){
//					for (int j = 0; j < titleListForConfigure.size(); j++) {
					for (PageData conf : titleListForConfigure) {
						listLie.add(pds.getString(conf.getString("FIELD_NAME")));
					}
				}
				String respondentCode="";//备用调查对象。假如，卷头。为空时。正文不从第一个开始。就会出现调查对象为空。
				Timestamp createTime=null;
				listLie.add(pageData.getString("title"));
				Integer countQuestions=0;
				//循环遍历每个列
				for (PageData dataPage: listData) {
					String classification  =dataPage.getString("classification");
					String answerResult =dataPage.getString("answerResult");
					Timestamp create_time=(Timestamp)dataPage.get("create_time");
					String respondentCodeStr=dataPage.getString("respondentCode");
					Map<String,String> staffLevel;
					String respondentsParentId=pageData.getString("respondentsParentId");
					staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
					String respondentUser="";
					if(Tools.isEmpty(respondentCode)){
						respondentCode=respondentCodeStr;
					}
					if(!Tools.isEmpty(respondentCodeStr)){
						respondentUser=staffLevel.get(respondentCodeStr);
					}
					if(createTime == null || Tools.isEmpty(createTime.toString())){
						createTime=create_time;
					}
					if(classification!=null){
						if(classification.equals("L0")){
							listLie.add(answerResult);
							if(countQuestions==listData.size()-1){
								if(!Tools.isEmpty(respondentUser)){
									listLie.add(respondentUser);//增加调差对象列
								}else{
									listLie.add("");//增加调差对象列
								}
								//增加回答时间列
								listLie.add(sdfTime.format(createTime));
							}
						}else{
							if(!Tools.isEmpty(respondentCode) && !"respondentCode".equals(respondentCode)){
								//Map<String,String> staffLevel=ConversionUtil.getStaffLevel();
								if(!Tools.isEmpty(respondentUser)){
									listLie.add(respondentUser);//增加调差对象列
								}else{
									listLie.add("");//增加调差对象列
								}
								if(createTime != null &&!Tools.isEmpty(createTime.toString())){
									//增加回答时间列
									listLie.add(sdfTime.format(createTime));
									createTime=null;
								}else{
									
								}
								respondentCode="respondentCode";
							}
							listLie.add(answerResult);
						}
					}else{
						listLie.add("");
					}
					countQuestions++;
				}
				listHang.add(listLie);
				pd.put("batchId", "");
			}
		}
		return listHang; 
	}
	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> findCoutQuestioneResult(PageData pd) throws Exception{
		String questionId=pd.getString("questionId");
		if(!Tools.isEmpty(questionId)){
			pd.put("questionResultId", " tqr.questionId= '"+questionId+"'");
			pd.put("titleName", " tqh.title_name= '"+questionId+"'");
		//	pd.put("parentId", " tq.parentId = '"+questionId+"'");
		}else{
			String DATA_IDS = pd.getString("DATA_IDS");
			DATA_IDS=DATA_IDS.replace(",", "','");
			pd.put("questionResultId", " tqr.questionId in ('"+DATA_IDS+"') ");
			pd.put("titleName", " tqh.title_name in ('"+DATA_IDS+"') ");
			//pd.put("parentIds", " tq.parentId in  ('"+DATA_IDS+"') ");
		}
		return (List<PageData>)dao.findForList("QuestionsHeaderMapper.findCoutQuestioneResult", pd);
	}
	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> finParentIdByQuestionsId(PageData pd) throws Exception{
		String questionId=pd.getString("questionId");
		if(!Tools.isEmpty(questionId)){
			pd.put("parentId", " tq.parentId = '"+questionId+"'");
		}else{
			String DATA_IDS = pd.getString("DATA_IDS");
			DATA_IDS=DATA_IDS.replace(",", "','");
			pd.put("parentId", " tq.parentId in  ('"+DATA_IDS+"') ");
		}
		return (List<PageData>)dao.findForList("QuestionsHeaderMapper.finParentIdByQuestionsId", pd);
	}
	public void updateStatusForBatchId(PageData pd) throws Exception{
		String batchId=pd.getString("batchId");
		if(!Tools.isEmpty(batchId)){
			//batch_id
			pd.put("batch_id", " batch_id = '"+ batchId+"' ");
		}else{
			String DATA_IDS=pd.getString("DATA_IDS");
			if(!Tools.isEmpty(DATA_IDS)){
				DATA_IDS=DATA_IDS.replace(",", "','");
				pd.put("batch_id", " batch_id in  ('"+ DATA_IDS+"')  ");
			}
		}
		dao.update("QuestionsHeaderMapper.updateStatusForQuestionsHeader", pd);
		dao.update("QuestionsHeaderMapper.updateStatusForQuestionsResult", pd);
	}
	
	
	public List<PageData> findCountHeaderResult(PageData pd) throws Exception{
		
		return (List<PageData>) dao.findForList("QuestionsHeaderMapper.findCountHeaderResult", pd);
	}
	
	/**
	 * 星级评定查询问卷
	 * @return 
	 * @throws Exception 
	 */
	public List<PageData> findQuestion(Page page) throws Exception{
		List<PageData> questionList = (List<PageData>) dao.findForList("QuestionsHeaderMapper.findQuestionlistPage", page);
		return questionList;
	}
	
	/**
	 * 问卷结果测试优化
	 * @param data
	 * @param pd
	 * @return
	 * @throws Exception
	 *2017年12月20日
	 * xiaoding
	 */
	public List<List<String>> listQuestionsResultForExportByTest(Page data,PageData pd) throws Exception{	
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String level=pd.getString("level");
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			StringBuffer respondentCodeStr=new StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" a.respondentCode like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" or a.respondentCode like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
				respondentCodeStr.append(" a.respondentCode like '%"+level+"%' ");
			}
			levelStr.append(")");
			respondentCodeStr.append(")");
			pd.put("levelStr", levelStr);
			pd.put("respondentCodeStr", respondentCodeStr);
			data.setPd(pd);
		}
		String listQuestionResultIdStr=pd.getString("listBatchId");
		String isExportAll=pd.getString("isExportAll");
		List<PageData> listBatchId=new ArrayList<PageData>();
		//StringBuffer startTimeHeader=new StringBuffer();
		StringBuffer startTimeRe=new StringBuffer();
		if(!Tools.isEmpty(listQuestionResultIdStr) && "no".equals(isExportAll)){
			String listQuestionResultId=" a.batch_id  in  ('"+listQuestionResultIdStr.replace(",", "','")+"')";
			pd.put("listQuestionResultId", listQuestionResultId);
			
		}else{
			String startTime=pd.getString("startTime");
			String endTime=pd.getString("endTime");
			
			Date date=new Date();
			String dateStr=sdfTime.format(date);
			//开始时间为空
			if(!Tools.isEmpty(startTime)&&Tools.isEmpty(endTime)){
				//startTimeHeader.append("(  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+dateStr.trim()+"' ) ");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and   '"+dateStr.trim()+"' )");
			//结束时间为空
			}else if(Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
			//	startTimeHeader.append(" ( DATE(a.create_time)  BETWEEN '"+dateStr.trim()+"'   and '"+endTime.trim()+"'   )");
				startTimeRe.append(" ( DATE(a.createTime) BETWEEN   '"+dateStr.trim()+"'  and    '"+ endTime.trim()+"'  )");
			}else if(!Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
			//	startTimeHeader.append(" (  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+endTime.trim()+"'   )");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and  '"+endTime.trim()+"'   )");
			}
			
		}
	//	pd.put("startTimeStrHeader", startTimeHeader.toString());
		pd.put("startTimeStrRe", startTimeRe.toString());
		listBatchId= (List<PageData>) dao.findForList("QuestionsHeaderMapper.listDataForExprot", pd);
		
		//总共的list
		List<List<String>> listHang=new ArrayList<List<String>>();
		
		PageData pageData1=(PageData)dao.findForObject("QuestionnaireMapper.findHistoryResultsById", pd);//问卷实体
		String questionnaireType=pageData1.getString("questionnaireType");
		String hospitalCode=null;
		List<PageData > titleList=new ArrayList<PageData>();;
		List<PageData > sectionBaseList=new ArrayList<PageData>();
		//只有星级评定问卷才会涉及-----------增加就诊数据基本信息
		if(Const.QUESTIONNAIRE_TYPE_STAR_LEVEL.equals(questionnaireType)){
			//根据       问卷                       医院编码    和              医院借口编码         获取基础配置信息
			hospitalCode=pageData1.getString("hospitalCode");//问卷对应的医院编码
			String interfaceCode=pageData1.getString("interfaceCode");//问卷能对应的借口编码
			sectionBaseList=getSectionConfigureForQuestionnaire(hospitalCode,interfaceCode,Const.SHOWTYPE_EXPORT);
			//sectionBaseList.addAll(titleList);
			
		}
		PageData pageDataForSectionConfigure=new PageData();
		pageDataForSectionConfigure.put("hosipitalCode", hospitalCode);
		@SuppressWarnings("unchecked")
		List<PageData> sectionPageDatas = (List<PageData>)dao.findForList("SectionBaseMapper.getInfoByIdForResult", pageDataForSectionConfigure);
		
		//获取标题
		titleList.addAll((List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd));
		//获取问卷结果所有数据
		List<PageData> listAllData=(List<PageData>) dao.findForList("QuestionsHeaderMapper.listQuestionsResultAllByQuestionnaireId", pd);
		//将问卷结果数据格式化转换map，key为questionId+batch_id
		Map<String,PageData> mapAllData = new HashMap<String,PageData>(); 
		for (int i = 0; i < listAllData.size(); i++) {
			PageData pdMap = new PageData();
			pdMap = listAllData.get(i);
			mapAllData.put(pdMap.getString("questionId")+pdMap.getString("batch_id"), pdMap);
		}
		
		if(listBatchId!=null&&listBatchId.size()>0){
			//遍历所有批次号。         每个批次号，代表一行
			for (int i = 0; i < listBatchId.size(); i++) {
				//定义列的list
				List<String> listLie=new ArrayList<String>();
				String respondentCodeStr=null;
				PageData batchIdPageData=listBatchId.get(i);
				String batchId=batchIdPageData.getString("batch_id");//用于对比
				String resultVisiCode=batchIdPageData.getString("visitCode");
//				for (PageData pageData : titleList) {
				Long countL2=0l;
				Long countL0=0l;
				String respondentUserStr="";
				String create_timeStr="";
				for (int j = 0; j < titleList.size(); j++) {
					PageData pageData=titleList.get(j);
					String questionId=pageData.getString("questionId");
					String classification  =pageData.getString("classification");
					if(j==0){
						if(Const.QUESTIONNAIRE_TYPE_STAR_LEVEL.equals(questionnaireType)){
							if(sectionPageDatas!=null&&sectionBaseList!=null){
								
								for (PageData titlePageData : sectionBaseList) {
									for (PageData sectionBase : sectionPageDatas) {
									String visitCode=sectionBase.getString("VISIT_CODE");
									if(!Tools.isEmpty(resultVisiCode)&&!Tools.isEmpty(visitCode)&&resultVisiCode.equals(visitCode)){
											String filed_name=sectionBase.getString(titlePageData.get("FIELD_NAME"));	
											listLie.add(sectionBase.getString(titlePageData.get("FIELD_NAME")));
										}
									}
								}
							}
						}
						listLie.add(batchIdPageData.getString("title"));
					}
//					String nullValueForAll=null;
// 					for (PageData allData : listAllData) {
	/*
					for (int k = 0; k < listAllData.size(); k++) {
						PageData allData=listAllData.get(k);
						String respondentCode= allData.getString("respondentCode");
						Map<String,String> staffLevel;
						String respondentsParentId=batchIdPageData.getString("respondentsParentId");
						staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
						String respondentUser=staffLevel.get(respondentCode);
						respondentUserStr=respondentUser;
						Timestamp create_time=(Timestamp)allData.get("createTime");
						create_timeStr=sdfTime.format(create_time);
						if(!Tools.isEmpty(questionId)&&!Tools.isEmpty(batchId)&& questionId.equals(allData.getString("questionId"))&&batchId.equals(allData.getString("batch_id"))){
							countL2=(Long)(allData.get("countL2"));
							countL0=(Long)(allData.get("countL0"));
							if(classification.equals("L0")){
								respondentCodeStr="respondentCodeStrL0";
							}else if(classification.equals("L2")){
								if(Tools.isEmpty(respondentCodeStr)||"respondentCodeStrL0".equals(respondentCodeStr)){
									//获取调查对象
									listLie.add(respondentUser);//增加调查对象
//									listLie.add(allData.getString("createTime"));//增加创建时间
									listLie.add(sdfTime.format(create_time));
									respondentCodeStr="respondentCodeStrL2";
								}
							}
							listLie.add(allData.getString("answerResult"));
							listAllData.remove(allData);
							nullValueForAll="hasValue";
							break;
						}
						if(k==listAllData.size()-1&&Tools.isEmpty(nullValueForAll)){
							listLie.add(null);
						}
					}*/
					
					//导出循环优化------------start-------yaoning
					PageData allData = mapAllData.get(questionId+batchId);
					if(allData == null){ //数据为空
						listLie.add(null);
					}else{
						String respondentCode= allData.getString("respondentCode");
						Map<String,String> staffLevel;
						String respondentsParentId=batchIdPageData.getString("respondentsParentId");
						staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
						String respondentUser=staffLevel.get(respondentCode);
						respondentUserStr=respondentUser;
						Timestamp create_time=(Timestamp)allData.get("createTime");
						create_timeStr=sdfTime.format(create_time);
						countL2=(Long)(allData.get("countL2"));
						countL0=(Long)(allData.get("countL0"));
						if(classification.equals("L0")){
							respondentCodeStr="respondentCodeStrL0";
						}else if(classification.equals("L2")){
							if(Tools.isEmpty(respondentCodeStr)||"respondentCodeStrL0".equals(respondentCodeStr)){
								//获取调查对象
								listLie.add(respondentUser);//增加调查对象
//							listLie.add(allData.getString("createTime"));//增加创建时间
								listLie.add(sdfTime.format(create_time));
								respondentCodeStr="respondentCodeStrL2";
							}
						}
						listLie.add(allData.getString("answerResult"));
					}
					//导出循环优化------------end-------yaoning
				}
				if(countL2==0&&countL0==titleList.size()){
					listLie.add(respondentUserStr);//增加调查对象
//					listLie.add(allData.getString("createTime"));//增加创建时间
					listLie.add(create_timeStr);
				}
				listHang.add(listLie);
			}
		}
		return listHang; 
	}
	/**
	 * 问卷结果列表--------
	 * @param data
	 * @param pd
	 * @return
	 * @throws Exception
	 *2017年12月20日
	 * xiaoding
	 */
	public List<List<String>> listQuestionsResultForListByTest(Page data,PageData pd) throws Exception{	
		SimpleDateFormat sdfTime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String level=pd.getString("level");
		if(level!=null&& !level.isEmpty()){
			StringBuffer levelStr=new  StringBuffer("(");
			StringBuffer respondentCodeStr=new StringBuffer("(");
			if(level.indexOf(",")>-1){
				String[] levels=level.split(",");
				for (int i = 0; i < levels.length; i++) {
					if(i==0){
						levelStr.append(" `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" a.respondentCode like '%"+levels[i]+"%' ");
					}else{
						levelStr.append(" or  `level` like '%"+levels[i]+"%' ");
						respondentCodeStr.append(" or a.respondentCode like '%"+levels[i]+"%' ");
					}
				}
			}else{
				levelStr.append("  `level` like '%"+level+"%' ");
				respondentCodeStr.append(" a.respondentCode like '%"+level+"%' ");
			}
			levelStr.append(")");
			respondentCodeStr.append(")");
			pd.put("levelStr", levelStr);
			pd.put("respondentCodeStr", respondentCodeStr);
			data.setPd(pd);
		}
		String listQuestionResultIdStr=pd.getString("listBatchId");
		List<PageData> listBatchId=new ArrayList<PageData>();
		String questionnaireId=pd.getString("questionnaireId");
		//总共的list
		List<List<String>> listHang=new ArrayList<List<String>>();
		if(questionnaireId !=null && !questionnaireId.isEmpty()){
			String startTime=pd.getString("startTime");
			String endTime=pd.getString("endTime");
			StringBuffer startTimeHeader=new StringBuffer();
			StringBuffer startTimeRe=new StringBuffer();
			Date date=new Date();
			String dateStr=sdfTime.format(date);
			//开始时间为空
			if(!Tools.isEmpty(startTime)&&Tools.isEmpty(endTime)){
				startTimeHeader.append("(  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+dateStr.trim()+"' ) ");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and   '"+dateStr.trim()+"' )");
			//结束时间为空
			}else if(Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" ( DATE(a.create_time)  BETWEEN '"+dateStr.trim()+"'   and '"+endTime.trim()+"'   )");
				startTimeRe.append(" ( DATE(a.createTime) BETWEEN   '"+dateStr.trim()+"'  and    '"+ endTime.trim()+"'  )");
			}else if(!Tools.isEmpty(startTime)&&!Tools.isEmpty(endTime)){
				startTimeHeader.append(" (  DATE(a.create_time)  BETWEEN  '"+startTime.trim()+"'  and  '"+endTime.trim()+"'   )");
				startTimeRe.append("(  DATE(a.createTime) BETWEEN  '" + startTime.trim()+"' and  '"+endTime.trim()+"'   )");
			}
			pd.put("startTimeStrHeader", startTimeHeader.toString());
			pd.put("startTimeStrRe", startTimeRe.toString());
			data.setPd(pd);
			listBatchId=this.listBatch(data);
			//获取标题
			@SuppressWarnings("unchecked")
			List<PageData> titleList=(List<PageData>) dao.findForList("QuestionsHeaderMapper.findTitleByQuestionsnaireId", pd);
			//获取问卷结果所有数据
			List<PageData> listAllData=(List<PageData>) dao.findForList("QuestionsHeaderMapper.listQuestionsResultAllByQuestionnaireId", pd);
			if(listBatchId!=null&&listBatchId.size()>0){
				//遍历所有批次号。         每个批次号，代表一行
				for (int i = 0; i < listBatchId.size(); i++) {
					//定义列的list
					List<String> listLie=new ArrayList<String>();
					String respondentCodeStr=null;
					PageData batchIdPageData=listBatchId.get(i);
					String batchId=batchIdPageData.getString("batch_id");//用于对比
//					for (PageData pageData : titleList) {
					for (int j = 0; j < titleList.size(); j++) {
						PageData pageData=titleList.get(j);
						String questionId=pageData.getString("questionId");
						String classification  =pageData.getString("classification");
						if(j==0){
							listLie.add(batchId);
							listLie.add(batchIdPageData.getString("title"));
						}
						String nullValueForAll=null;
//	 					for (PageData allData : listAllData) {
						for (int k = 0; k < listAllData.size(); k++) {
							PageData allData=listAllData.get(k);
							if(!Tools.isEmpty(questionId)&&!Tools.isEmpty(batchId)&& questionId.equals(allData.getString("questionId"))&&batchId.equals(allData.getString("batch_id"))){
								
								if(classification.equals("L0")){
									respondentCodeStr="respondentCodeStrL0";
								}else if(classification.equals("L2")){
									if(Tools.isEmpty(respondentCodeStr)||"respondentCodeStrL0".equals(respondentCodeStr)){
										//获取调查对象
										String respondentCode= allData.getString("respondentCode");
										Map<String,String> staffLevel;
										String respondentsParentId=batchIdPageData.getString("respondentsParentId");
										staffLevel=ConversionUtil.getStaffLevelByParentId(respondentsParentId);
										String respondentUser=staffLevel.get(respondentCode);
										listLie.add(respondentUser);//增加调查对象
										Timestamp create_time=(Timestamp)allData.get("createTime");
//										listLie.add(allData.getString("createTime"));//增加创建时间
										listLie.add(sdfTime.format(create_time));
										respondentCodeStr="respondentCodeStrL2";
									}
								}
								listLie.add(allData.getString("answerResult"));
								listAllData.remove(allData);
								nullValueForAll="hasValue";
								break;
							}
							if(k==listAllData.size()-1&&Tools.isEmpty(nullValueForAll)){
								listLie.add(null);
							}
						}
					}
					listHang.add(listLie);
				}
			}
		}
		return listHang; 
		
		
	}
	/**
	 * 根据医院编码                接口类型获取基础配置项
	 * @param hospitalCode
	 * @param interfaceCode
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSectionConfigureForQuestionnaire(String hospitalCode,String interfaceCode,String showType) throws Exception{
		PageData pd=new PageData();
		Page page=new Page();
		// 根据所属医院ID从配置表中获取配置名称及顺序
		pd.put("interType",interfaceCode );
		//pd.put("isShow", 1);
		pd.put("showType", showType);
		pd.put("hosipitalId",hospitalCode);
		page.setPd(pd);
		List<PageData> varList = (List<PageData>) dao.findForList("RecordMapper.datalistPage", page);
		return varList;
	}
}

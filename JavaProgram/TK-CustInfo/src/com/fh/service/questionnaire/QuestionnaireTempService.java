package com.fh.service.questionnaire;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.QuestionnaireTemp;
import com.fh.entity.system.Questionnaire;
import com.fh.entity.system.Questions;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

@Service("questionnaireTempService")
public class QuestionnaireTempService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> list(Page page) throws Exception{
		return (List<PageData>) dao.findForList("", page);
	}
	public Integer saveList(List<QuestionnaireTemp> list)throws Exception{
		return (Integer) dao.save("QuestionnaireTempMapper.saveList", list);
	}
	/**
	 * 根据批次号
	 * @param page
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<QuestionnaireTemp> getListByListBatchId(Page page) throws Exception{
		return (List<QuestionnaireTemp>) dao.findForList("QuestionnaireTempMapper.getListByListBatchId", page);
	}
	/**
	 * 根据问卷的id查询当前问卷批次下面所有导入的问题
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public PageData getBatchIdByQuestionnaireId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("QuestionnaireTempMapper.getBatchIdByQuestionnaireId", pd);
	}
	/**
	 * 导入问卷数据管理。
	 * @param page
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<QuestionnaireTemp> getListByListBatchIdByPage(Page page) throws Exception{
		return (List<QuestionnaireTemp>) dao.findForList("QuestionnaireTempMapper.getDatalistPageByListBatchId", page);
	}
	
	public List<PageData> getQuestionnaireTempByAll(PageData pd)throws Exception{
		return ( List<PageData>)dao.findForList("QuestionnaireTempMapper.getQuestionnaireTempByAll", pd);
	}
	/**
	 * 根据id删除单个
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public int deleteOne(PageData pd)throws Exception{
		String type=pd.getString("type");
		String questionId=pd.getString("questionId");
		List<PageData> list=null;
		if(!Tools.isEmpty(type)){
			//删除需要考虑下属，是否存在问题
			if("questionnaire".equals(type)){
				pd.put("questionnaireId", questionId);
				list=(List<PageData>)dao.findForList("QuestionnaireTempMapper.selectOneByIdForDelete", pd);
			//删除问题需要考虑，下属是否子问题
			}else if("question".equals(type)){
				pd.put("parentId", questionId);
				list=(List<PageData>)dao.findForList("QuestionnaireTempMapper.selectOneByIdForDelete", pd);
			//删除问卷卷头
			}
			if(list ==null || list.size()==0 || "question_header".equals(type)){
				dao.delete("QuestionnaireTempMapper.deleteOne", pd);
				return 1;
			}else{
				return 0;
			}
		}
		return 0;
	}
	/**
	 * 批量删除
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void deleteAll(PageData pd)throws Exception{
		dao.delete("QuestionnaireTempMapper.deleteAll", pd);
	}
	/**
	 * 删除时查询问题
	 * @param list
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> selectTempForDelete(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("QuestionnaireTempMapper.selectTempForDelete", pd);
	}
	
	/**
	 * 获取所有的批次号
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> getAllBatchId(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("QuestionnaireTempMapper.getAllBatchId", pd);
	}
	/**
	 * 根据批次号获取问卷信息
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> getTempByAllBatchId(PageData pd)throws Exception{
		return ( List<PageData> )dao.findForList("QuestionnaireTempMapper.getQuestionnaireTempByAll", pd);
	}
	/**
	 * 删除方法。提供同一批次删除处在一个事务里面
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public String delAll(PageData pd)throws Exception{
		List<String> deleteList=new ArrayList<String>();
		String message="";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			List<String> listQuestionId=new ArrayList<String>();
			Collections.addAll(listQuestionId, ArrayDATA_IDS);
			//定义一个选中值得总数量
			int total=listQuestionId.size();
			//先查询2级问题，再删除2级问题。然后查询一级问题。
			StringBuffer delQuestionIds=new StringBuffer();
			PageData delPd=new PageData();
			
			String questionIds=DATA_IDS.replace(",", "','");
			pd.put("classification", "classification !='L1'");
			pd.put("questionId", " questionId in  ('"+questionIds+"')");
			List<PageData> listTwoQuestions=selectTempForDelete(pd);
			if(listTwoQuestions!=null){
				for (int i = 0; i < listTwoQuestions.size(); i++) {
					PageData data=listTwoQuestions.get(i);
					String questionId=data.getString("questionId");
					if(listQuestionId.contains(questionId)){
						deleteList.add(questionId);
						//listQuestionId.remove(questionId);
						delQuestionIds.append(questionId+",");
					}
				}
				delPd.put("questionId", "questionId  in ('"+delQuestionIds.toString().replace(",","','")+"')");
				pd.remove("questionId");
				pd.remove("classification");
				deleteAll(delPd);
				listQuestionId.removeAll(deleteList);
			}
			if(listQuestionId !=null && listQuestionId.size()>0){
				StringBuffer parentIds =new StringBuffer(" questionId in ('");
				for (int i = 0; i < listQuestionId.size(); i++) {
					parentIds.append(listQuestionId.get(i)+"','");
				}
				parentIds.append("')");
				pd.put("parentId", parentIds);
				pd.put("classification", " 1=1 ");
				List<PageData> listOneQuestions=selectTempForDelete(pd);
				if(listOneQuestions!=null){
					List<PageData> isChild=new ArrayList<PageData>();
					for (int i = 0; i < listOneQuestions.size(); i++) {
						PageData data=listOneQuestions.get(i);
						Long countChild=(Long)data.get("countChild");
						String questionnaireId =data.getString("questionnaireId");
						String questionId=data.getString("questionId");
						if(!Tools.isEmpty(questionnaireId)&&countChild>0){
							listQuestionId.remove(questionId);
							//deleteList.add(parentId);
							isChild.add(data);
						}
					}
					listOneQuestions.removeAll(isChild);
					delQuestionIds=new StringBuffer();
					for (int i = 0; i < listOneQuestions.size(); i++) {
						deleteList.add(listOneQuestions.get(i).getString("questionId"));
						delQuestionIds.append(listOneQuestions.get(i).getString("questionId")+",");
					}
					delPd.put("questionId", "questionId  in ('"+delQuestionIds.toString().replace(",","','")+"')");
					deleteAll(delPd);
					listQuestionId.removeAll(deleteList);
				}
				pd.remove("parentId");
			}
			if(listQuestionId !=null && listQuestionId.size()>0){
				String questionnaireId=listQuestionId.get(0);
				deleteList.add(questionnaireId);
				pd.put("questionnaireId", questionnaireId);
				List<PageData> listOneQuestions=selectTempForDelete(pd);
				if(listOneQuestions ==null || listOneQuestions.size()==0){
					delPd.put("questionId","questionId ='" +questionnaireId+"'");
					deleteAll(delPd);
				}
			}
			int shengYu=total-deleteList.size();
			if(shengYu>0){
				message="notAll |" +shengYu;
			}else{
				message="all";
			}
		}else{
			message="no";
		}
		return message;
	}
	/**
	 * 根据questionId 查询临时表的一些信息
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public QuestionnaireTemp getTempByQuestionId(PageData pd)throws Exception{
		return (QuestionnaireTemp)dao.findForObject("QuestionnaireTempMapper.getTempByQuestionId", pd);
	}
	/**
	 * 对导入的数据进行保存操作
	 * @param data
	 * @throws Exception
	 * xiaoding
	 */
	public void editTemp(QuestionnaireTemp data)throws Exception{
		dao.update("QuestionnaireTempMapper.editTemp", data);
	}
	/**
	 * 根据 问卷的id获取该问卷所有导入的数据
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<QuestionnaireTemp> findTempByQuestionnaireId(PageData pd)throws Exception{
		return (List<QuestionnaireTemp>)dao.findForList("QuestionnaireTempMapper.findTempByQuestionnaireId", pd);
	}
	/**
	 * 将导入的问卷，问题。批量导入到业务表。
	 * @param questionnaire
	 * @param list
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void exportQuestionnaire(Questionnaire questionnaire,List<Questions> list,PageData pd)throws Exception{
		try {
			dao.save("QuestionnaireMapper.save", questionnaire);
			dao.save("QuestionsMapper.saveList", list);
			pd.put("isImport", 1);
			dao.update("QuestionnaireTempMapper.updateIsImportByQuestionnaireId", pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 问卷导入数据，撤销导入到业务表
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public String deleteQuestionnaireByTemp(PageData pd)throws Exception{
		String message="";
		try {
			String questionId=pd.getString("questionId");
			if(!Tools.isEmpty(questionId)){
				pd.put("questionId", Const.importQuestionsId+questionId);
				//删除问卷问题
				dao.delete("QuestionnaireTempMapper.deleteQuestionsByTempQuestionId", pd);
				//删除问卷
				dao.delete("QuestionnaireTempMapper.deleteQuestionnaireByTempQuestionId", pd);
				pd.put("isImport", 0);
				pd.put("questionId",questionId);
				dao.update("QuestionnaireTempMapper.updateIsImportByQuestionnaireId", pd);
				message="success";
			}else 
			message="fail";
		} catch (Exception e) {
			e.printStackTrace();
			message="error";
		}
		return message;
	}
	/**
	 * 删除问卷及下属问题方法
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void deleteAllTempByQuestionnaireId(PageData pd)throws Exception{
		dao.delete("QuestionnaireTempMapper.deleteAllTempByQuestionnaireId", pd);
	}
	/**
	 * 判断错误数据是否等于0.等于0才能导入业务表
	 * @param out
	 * xiaoding
	 */
	public Integer findCountTempByQuestionnaireId(PageData pd)throws Exception{
		List<QuestionnaireTemp> list=(List<QuestionnaireTemp>)dao.findForList("QuestionnaireTempMapper.findTempByQuestionnaireId", pd);
		if(list!=null){
			return list.size();
		}else return 0;
	}
} 

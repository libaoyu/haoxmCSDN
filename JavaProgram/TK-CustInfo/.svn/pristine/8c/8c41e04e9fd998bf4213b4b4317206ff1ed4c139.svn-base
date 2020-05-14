package com.fh.service.questionnaire;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.FileDetails;
import com.fh.entity.system.Questions;
import com.fh.util.ConversionUtil;
import com.fh.util.PageData;

@Service("questionsService")
public class QuestionsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name="fileDetailsService")
	private FileDetailsService fileDetailsService;
	/*
	 * 新增
	 */
	public void save(Questions questions) throws Exception {
		//保存图片
		if(questions.getFileDetails()!=null){
			for (FileDetails detail:questions.getFileDetails()) {
				dao.save("FileDetailsMapper.save", detail);
			}
		}
		dao.save("QuestionsMapper.save", questions);
	}

	public void savePoint(Questions questions) throws Exception {
		if(questions.getFileDetails()!=null){
			for (FileDetails detail:questions.getFileDetails()) {
				dao.save("FileDetailsMapper.save", detail);
			}
		}
		dao.save("QuestionsMapper.save", questions);
		// 获取需要重新排序的问题
		PageData pd = new PageData();
		pd.put("questionnaireId", questions.getQuestionnaireId());
		pd.put("classification", questions.getClassification());
		pd.put("parentId", questions.getParentId());
		List<PageData> questionOld = findByParentId(pd);

		updateOldCodeById(questionOld);

	}

	/*
	 * 删除
	 */
	public void update(PageData pd) throws Exception {
		// 查询需要删除的问题
		PageData questionpd = findById(pd);
		dao.delete("QuestionsMapper.update", pd);
		// 获取需要重新排序的问题
		List<PageData> questionOld = findByParentId(questionpd);
		if (questionOld != null && questionOld.size() > 0) {
			// 重新分配
			updateOldCodeById(questionOld);
		}
	}

	/*
	 * 修改
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("QuestionsMapper.edit", pd);
	}

	/*
	 * 列表
	 */
	public List<Questions> list(Page page) throws Exception {
		return (List<Questions>) dao.findForList("QuestionsMapper.datalistPage", page);
	}

	/*
	 * 一级列表
	 */
	public List<Questions> onelist(Page page) throws Exception {
		return (List<Questions>) dao.findForList("QuestionsMapper.dataOnelistPage", page);
	}

	/*
	 * 数据统计一级列表
	 */
	public List<Questions> oneStatislist(Page page) throws Exception {
		return (List<Questions>) dao.findForList("QuestionsMapper.statisOnelistPage", page);
	}

	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Questions> childList(PageData pd) throws Exception {
		return (List<Questions>) dao.findForList("QuestionsMapper.childList", pd);
	}

	/*
	 * 列表(全部)
	 */
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.listAll", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("QuestionsMapper.findById", pd);
	}

	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Questions findByQuestionId(PageData pd) throws Exception {
		return (Questions) dao.findForObject("QuestionsMapper.findByQuestionId", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public List<PageData> findByFlag(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findByFlag", pd);
	}

	/*
	 * 通过pageid获取数据
	 */
	public List<PageData> findByPageId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findByPageId", pd);
	}

	/*
	 * 用户访问问卷列表
	 */
	public List<PageData> findByPageIdUser(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findByPageIdUser", pd);
	}

	/*
	 * 批量删除
	 */
	/*
	 * public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
	 * dao.delete("QuestionsMapper.deleteAll", ArrayDATA_IDS); }
	 */
	public void updateAll(String[] ArrayDATA_IDS) throws Exception {
		PageData pd = new PageData();
		pd.put("questionId", ArrayDATA_IDS[0]);
		// 先查询需要删除的问题
		PageData questionpd = findById(pd);
		dao.delete("QuestionsMapper.updateAll", ArrayDATA_IDS);
		// 获取需要重新排序的问题
		List<PageData> questionOld = findByParentId(questionpd);
		if (questionOld != null && questionOld.size() > 0) {
			// 重新分配
			updateOldCodeById(questionOld);
		}
	}

	/**
	 * List通用查询
	 * 
	 * @param parameters
	 * @return
	 * @throws Exception
	 */
	public List<Map> executeSql(Map parameters) throws Exception {
		return dao.executeBySql(parameters);
	}

	/**
	 * List通用查询
	 * 
	 * @param parameters
	 * @return
	 * @throws Exception
	 */
	public Map mapExecuteBySql(Map parameters, String key) throws Exception {
		return dao.mapExecuteBySql(parameters, key);
	}

	public List<Questions> listQuestionnaireId(PageData pd) throws Exception {
		return (List<Questions>) dao.findForList("QuestionsMapper.listQuestionnaireId", pd);
	}

	/*
	 * 修改
	 */
	public void edit(Questions questions) throws Exception {
		if(questions.getFileDetails()!=null){
			for (FileDetails detail:questions.getFileDetails()) {
				PageData pd = new PageData();
				pd.put("fileId", detail.getFileId());		
				FileDetails filed = fileDetailsService.getEntityById(pd);
				if(filed !=null){
					dao.update("FileDetailsMapper.edit", detail);
				}else{
					dao.save("FileDetailsMapper.save", detail);
				}
			}
		}
		dao.update("QuestionsMapper.editByEntity", questions);
	}

	/**
	 * 根据parentid获取数据
	 */
	public List<PageData> findByParentId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findByParentId", pd);
	}

	/**
	 * 获取问卷题目类型
	 */
	public List<PageData> findQuestionCode(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findQuestionCode", pd);
	}

	/**
	 * 批量更新问题排序问题
	 * 
	 * @throws Exception
	 */
	public void updateOldCodeById(List<PageData> questionOld) throws Exception {
		List<String> code = ConversionUtil.getQuestionCode();
		// 重新排序后更新
		for (int i = 0; i < questionOld.size(); i++) {
			if ("L1".equals(questionOld.get(i).get("classification"))) {
				questionOld.get(i).put("questionCode", code.get(i));
			}
			questionOld.get(i).put("sort", i + 1);
		}
		dao.batchUpdate("QuestionsMapper.updateCodeSort", questionOld);
	}

	/**
	 * 数据统计查询问题
	 * 
	 * @throws Exception
	 */
	public List<PageData> findByStatIdlist(Page page) throws Exception {
		return (List<PageData>) dao.findForList("QuestionsMapper.findByStatIdlistPage", page);
	}

	/**
	 * 复制问题查询
	 */
	public List<Questions> findCopyQuestion(PageData pd) throws Exception{
		return  (List<Questions>) dao.findForList("QuestionsMapper.findCopyQuestion", pd);
	}

	public List<PageData> findQuestions(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("QuestionsMapper.findQuestions",pd);
	}
	
	
}

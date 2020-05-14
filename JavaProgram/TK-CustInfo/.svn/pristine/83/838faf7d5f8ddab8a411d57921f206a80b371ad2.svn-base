package com.fh.service.questionnaire;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("pageresultService")
public class PageresultService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("QuestionresultMapper.save", pd);
	}
	
	/*
	* 批量增加
	*/
	public void saveUser(List<PageData> listPd,PageData pd) throws Exception{
			try {
				dao.save("QuestionUserMapper.save", pd);
				for(PageData pdlist : listPd){
					if(!"".equals(pdlist.getString("ANSWERNUM")) && null !=pdlist.getString("ANSWERNUM")){
						dao.save("QuestionresultMapper.singleSave", pdlist);}
					else{
						dao.save("QuestionresultMapper.saveData", pdlist);}
				}
			} catch (Exception e) {
				e.printStackTrace();
				 throw new Exception("在这里出错了，参数是null对象");
			}
		}		
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("QuestionresultMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("QuestionresultMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page pd)throws Exception{
		return (List<PageData>)dao.findForList("QuestionresultMapper.datalistPage", pd);
	}
	/*
	*到处execl
	*/
	public List<PageData> execlList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("QuestionresultMapper.execlPage", pd);
	}
	public List<PageData> userAnswer(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("QuestionresultMapper.userAnswer", pd);
	}
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("QuestionresultMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("QuestionresultMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("QuestionresultMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


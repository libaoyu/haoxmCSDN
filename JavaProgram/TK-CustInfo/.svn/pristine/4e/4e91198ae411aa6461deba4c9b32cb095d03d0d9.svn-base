package com.fh.service.advice;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Question;
import com.fh.util.PageData;
@Service("advicePictureService")
public class AdvicePictureService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("AdvicePictureMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("AdvicePictureMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("AdvicePictureMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<Question> list(Page page)throws Exception{
		return (List<Question>)dao.findForList("AdvicePictureMapper.datalistPage", page);
	}
	public List<Question> childList(PageData pd)throws Exception{
		return (List<Question>)dao.findForList("AdvicePictureMapper.childList", pd);
	}
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdvicePictureMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AdvicePictureMapper.findById", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public List<PageData> findByFlag(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdvicePictureMapper.findByFlag", pd);
	}
	
	/*
	* 通过pageid获取数据
	*/
	public List<PageData> findByPageId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdvicePictureMapper.findByPageId", pd);
	}
	/*
	 * 用户访问问卷列表
	 */
	public List<PageData> findByPageIdUser(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdvicePictureMapper.findByPageIdUser", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AdvicePictureMapper.deleteAll", ArrayDATA_IDS);
	}
	
	public List<PageData> listAllForAdviceId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdvicePictureMapper.listAllForAdviceId", pd);
	}
}

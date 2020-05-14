package com.fh.service.advice;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.advice.Advice;
import com.fh.util.PageData;

@Service("adviceService")
public class AdviceService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("AdviceMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("AdviceMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("AdviceMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AdviceMapper.datalistPage", page);
	}
	public List<Advice> childList(PageData pd)throws Exception{
		return (List<Advice>)dao.findForList("AdviceMapper.childList", pd);
	}
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdviceMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AdviceMapper.findById", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public List<PageData> findByFlag(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdviceMapper.findByFlag", pd);
	}
	
	/*
	* 通过pageid获取数据
	*/
	public List<PageData> findByPageId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdviceMapper.findByPageId", pd);
	}
	/*
	 * 用户访问问卷列表
	 */
	public List<PageData> findByPageIdUser(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdviceMapper.findByPageIdUser", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AdviceMapper.deleteAll", ArrayDATA_IDS);
	}
}


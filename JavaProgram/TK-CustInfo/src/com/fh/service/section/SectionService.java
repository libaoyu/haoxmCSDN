package com.fh.service.section;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.section.PatientInfo;
import com.fh.util.PageData;

@Service("sectionService")
public class SectionService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SectionMapper.findById", pd);
	}
	
	/*
	* 保存数据
	*/
	public void save(PatientInfo patientInfo) throws Exception{
		dao.save("SectionMapper.save", patientInfo);
	}
	
	/*
	* 获取列表数据
	*/
	public List<PageData> list(Page page) throws Exception{
		return (List<PageData>) dao.findForList("SectionMapper.datalistPage", page);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("SectionMapper.delete", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SectionMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SectionMapper.listAll", pd);
	}
	
	/*
	* 通过id修改评价信息
	*/
	public int edit(PageData pd)throws Exception{
		return (Integer)dao.update("SectionMapper.edit", pd);
	}
	
	/*
	* 获取字段配置列表数据
	*/
	public List<PageData> configList(Page page) throws Exception{
		return (List<PageData>) dao.findForList("SectionMapper.datalistPage", page);
	}
}

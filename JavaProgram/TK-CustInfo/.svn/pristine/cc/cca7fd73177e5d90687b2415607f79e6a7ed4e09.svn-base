package com.fh.service.record;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.section.Patient;
import com.fh.util.PageData;

/** 
 * 类名称：sectionBaseService
 * 创建人：shanghaizhao 
 * 创建时间：2017-11-06
 */
@Service("sectionBaseService")
public class SectionBaseService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	 * 根据id查询单个问诊数据实体
	 */
	public PageData getPatientById(PageData pd) throws Exception{
		return (PageData)dao.findForObject("SectionBaseMapper.getInfoById", pd);
	}
	
	/*
	* 保存数据
	*/
	public void save(Patient patient) throws Exception{
		dao.save("SectionBaseMapper.save", patient);
	}
	/**
	 * 查询医院下科室
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findSectionCodeName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("SectionBaseMapper.findSectionCodeName", pd); 
	}
	/**
	 * 查询医院、科室下的医生
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findDoctorCodeName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("SectionBaseMapper.findDoctorCodeName", pd); 
	}
	
	
	
}

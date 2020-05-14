package com.fh.service.questionnaire;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.FileDetails;
import com.fh.entity.system.Questions;
import com.fh.util.PageData;


@Service("fileDetailsService")
public class FileDetailsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(FileDetails fileDetails)throws Exception{
		dao.save("FileDetailsMapper.save", fileDetails);
	}
	
	/*
	* 删除
	*/
	public void deleteById(PageData pd)throws Exception{
		dao.delete("FileDetailsMapper.deleteById", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("FileDetailsMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<FileDetails> list(Page page)throws Exception{
		return (List<FileDetails>)dao.findForList("FileDetailsMapper.datalistPage", page);
	}

	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileDetailsMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileDetailsMapper.findById", pd);
	}
	
	
	/*
	* 通过id获取数据
	*/
	public FileDetails getEntityById(PageData pd)throws Exception{
		return (FileDetails)dao.findForObject("FileDetailsMapper.getEntityById", pd);
	}
	
	
	/*
	* 通过id获取数据
	*/
	public List<FileDetails> getEntityByIds(PageData pd)throws Exception{
		return (List<FileDetails>)dao.findForList("FileDetailsMapper.getEntityByIds", pd);
	}
	
	
	/*
	* 批量删除
	*/
	public void deleteByMasterId(String masterId)throws Exception{
		dao.delete("FileDetailsMapper.deleteByMasterId", masterId);
	}
	
	
	public List<FileDetails> listByMasterId(PageData pd) throws Exception{
		return (List<FileDetails>)dao.findForList("FileDetailsMapper.listByMasterId", pd);
	}
	/**
	 * 根据问卷id查询所有附件lo
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<FileDetails> findListByMasterId(PageData pd) throws Exception{
		return (List<FileDetails>)dao.findForList("FileDetailsMapper.findListByMasterId", pd);
	}

	
	/**
	 * 根据短链接码查询长连接url 
	 */
	public PageData findByShortUrl(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileDetailsMapper.findByShortUrl", pd);
	}

	/**
	 * 根据问卷id
	 * @return
	 */
	public FileDetails getFileByQIDAndLevel(PageData pd)throws Exception{
		return (FileDetails)dao.findForObject("FileDetailsMapper.getFileByQIDAndLevel", pd);
	}

	/*
	* 修改短链接
	*/
	public void editShortUrl(PageData pd)throws Exception{
		dao.update("FileDetailsMapper.editShortUrl", pd);
	}
	
	
}


package com.fh.service.questionnaire;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Link;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.LinkagePullData;
import com.fh.util.PageData;
import com.fh.util.Tools;

@Service("linkagePullDataService")
public class LinkagePullDataService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**
	 * 展示所以的联动基础数据
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> list(PageData pd)throws Exception{
		return ( List<PageData>)dao.findForList("LinkagePullDataMapper.list", pd);
	}
	/**
	 * 联动基础数据增加
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void saveLinkagePullData(PageData pd)throws Exception{
		LinkagePullData data=new LinkagePullData();
		String name=pd.getString("name");
		String parentId=pd.getString("parentId");
		String linkageId=pd.getString("linkageId");
		data.setLinkageName(name);
		data.setLinkageId(linkageId);
		data.setCreateTime(Tools.date2Str(new Date()));
		data.setCreateUser(pd.getString("createUser"));
		//父类id为空时，说明表示是一级
		if(Tools.isEmpty(parentId)){
			data.setLevel(1);
		}else{
			data.setParentId(parentId);
			PageData parentData=(PageData)dao.findForObject("LinkagePullDataMapper.findLinkagePullDataById", pd);
			pd.put("linkageId",parentId);
			PageData countData=(PageData)dao.findForObject("LinkagePullDataMapper.findLinkageByParentIdForLinkageCount", pd);
			if(parentData!=null){
				Integer levelStr=(Integer)parentData.get("level");
				Long sort=0l;
				if(countData!=null){
					sort=(Long)countData.get("countLinkage");
				}
				
				data.setSort(sort+1);
				data.setLevel(levelStr+1);
			}
		}
		dao.save("LinkagePullDataMapper.saveLinkagePullData", data);
	}
	/**
	 * 联动删除功能
	 * @param pd
	 * xiaoding
	 */
	public void deleteLinkagePullData(PageData pd)throws Exception{
//		dao.delete("LinkagePullDataMapper.deleteAllLinkagePullData", pd);
		dao.delete("LinkagePullDataMapper.deleteLinkagePullData", pd);
	}
	/**
	 * 修改节点名称
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void updateLinkagePullData(PageData pd)throws Exception{
		dao.update("LinkagePullDataMapper.updateLinkagePullData", pd);
	}
	/**
	 * 批量删除子节点
	 * @param pd
	 * @throws Exception
	 * xiaoding
	 */
	public void deleteAllLinkagePullData(PageData pd)throws Exception{
		dao.delete("LinkagePullDataMapper.deleteAllLinkagePullData", pd);
	}
	/**
	 * 查看详情
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public PageData lookDetailForLinkageId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LinkagePullDataMapper.lookDetailForLinkageId", pd);
	}
	/**
	 * 下拉框中展示所有一级联动菜单
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> listOneLevel(PageData pd)throws Exception{
		return ( List<PageData>)dao.findForList("LinkagePullDataMapper.listOneLevel", pd);
	}
	/**
	 * 根据父类id查询联动
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> findLinkageByParentId(PageData pd)throws Exception{
		return ( List<PageData>)dao.findForList("LinkagePullDataMapper.findLinkageByParentId", pd);
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public int findLinkageByParentIdForLinkageCount(String  linkageId)throws Exception{
		PageData pd=new PageData();
		pd.put("linkageId", linkageId);
		PageData listFirstData=( PageData)dao.findForObject("LinkagePullDataMapper.findLinkageByParentIdForLinkageCount", pd);
		if(listFirstData!=null){
			Long ll=(Long)listFirstData.get("countLinkage");
			return Integer.parseInt(String.valueOf(ll));
		}else{
			return 0;
		}
	}
	
	/**
	 * 拼接json串
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public Link[] findLinkageByParentIdForLinkage(PageData pd)throws Exception{
		//定义一个总共的返回list
		List<Map<String ,Object>> returnList=new ArrayList<Map<String,Object>>();
		
		//根据联动菜单的id查询所有的一级子类。
		List<PageData> listFirstData=( List<PageData>)dao.findForList("LinkagePullDataMapper.findLinkageByParentId", pd);
		
		//递归调用，查询下级菜单。
		if(listFirstData!=null){
			Link[] linkOne = new Link[listFirstData.size()];
			for (int i = 0; i < listFirstData.size(); i++) {
//				//定义的多个map
//				Map<String ,Object> childrenMap=new HashMap<String ,Object>();
//				//根据
//				String linkageId=listFirstData.get(i).getString("id");
//				childrenMap.put("n", listFirstData.get(i).getString("name"));
//				
//				Map<String ,Object> map = getLinkageJsonForParentId(linkageId);
//				//子类为空
//				if(map!=null){
//					childrenMap.put("a", map);
//					childrenMap.put("t", 1);
//				}
//				returnList.add(childrenMap);
				Link link = new Link();
				String linkageId=listFirstData.get(i).getString("id");
				int cout=findLinkageByParentIdForLinkageCount(linkageId);
				Link[] linkArr = new Link[cout];
				link.setN(listFirstData.get(i).getString("name"));
				
				
				String t = getlink(linkageId,linkArr);
				link.setT(t);
				link.setA(linkArr);
				linkOne[i]=link;
			}
			return linkOne;
		}else
			return null;
	}
	/**
	 * 递归调用，拼接json
	 * @return
	 * xiaoding
	 */
	public  Map<String ,Object> getLinkageJsonForParentId(String parentId)throws Exception{
		PageData pd=new PageData();
		pd.put("linkageId", parentId);
		Map<String ,Object> childrenMap=new HashMap<String ,Object>();
		//List<>
		List<PageData> listFirstData=( List<PageData>)dao.findForList("LinkagePullDataMapper.findLinkageByParentId", pd);
		//当存在下一级时
		if(listFirstData!=null&&listFirstData.size()>0){
			for (int i = 0; i < listFirstData.size(); i++) {
				String linkageId=listFirstData.get(i).getString("id");
				Map<String ,Object> map = getLinkageJsonForParentId(linkageId);
				childrenMap.put("n", listFirstData.get(i).getString("name"));
				//子类为空
				if(map!=null){
					childrenMap.put("a", map);
					childrenMap.put("t", 1);
				}else{
					
				}
			}
			return childrenMap;
		}else{
			return null;
		}
	}
	
	public String getlink(String parentId, Link[] linkArrOld) throws Exception{
		PageData pd=new PageData();
		pd.put("linkageId", parentId);
		//List<>
		List<PageData> listFirstData=( List<PageData>)dao.findForList("LinkagePullDataMapper.findLinkageByParentId", pd);
		if(listFirstData == null || listFirstData.isEmpty()){
			return "0";
		}
		for (int i = 0; i < listFirstData.size(); i++) {
			Link link = new Link();
			String linkageId=listFirstData.get(i).getString("id");
			int cout=findLinkageByParentIdForLinkageCount(linkageId);
			Link[] linkArr = new Link[cout];
//			Link[] linkArr = new Link[50];
			link.setN(listFirstData.get(i).getString("name"));
			
			String t = getlink(linkageId,linkArr);
			link.setT(t);
			link.setA(linkArr);
			linkArrOld[i]=link;
		}
		return "1";
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> findLinkageParentAll()throws Exception{
		PageData pd=new PageData();
		return (List<PageData>) dao.findForList("LinkagePullDataMapper.findLinkageParentAll", pd);
	}
	
	/**
	 * 根据父类id查询联动
	 * @param pd
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	public List<PageData> findLinkageByParentIdForPage(Page page)throws Exception{
		return ( List<PageData>)dao.findForList("LinkagePullDataMapper.findLinkageByParentIdForPage", page);
	}
	/**
	 * 查询所有的一级
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<LinkagePullData> listAllLinkage(String  linkageId,PageData pd)throws Exception{
		pd.put("parentId", linkageId);
		List<LinkagePullData> dictList = this.listSubLinkageByParentId(pd);
		for(LinkagePullData link : dictList){
			link.setTreeurl("linkagePullData/listAllByPage.do?linkageId="+link.getLinkageId());
			link.setSubLinkage(this.listAllLinkage(link.getLinkageId(),pd));
			link.setTarget("treeFrame");
		}
		return dictList;
	}
	/**
	 * 根据父类id获取所有子类
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<LinkagePullData> listSubLinkageByParentId(PageData pd)throws Exception{
		return ( List<LinkagePullData>)dao.findForList("LinkagePullDataMapper.listSubLinkageByParentId", pd);
	}
	
	/**
	 * 根据id查询父类详细信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findLinkagePullDataById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LinkagePullDataMapper.findLinkagePullDataById", pd);
	}
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("LinkagePullDataMapper.save", pd);
	}
}

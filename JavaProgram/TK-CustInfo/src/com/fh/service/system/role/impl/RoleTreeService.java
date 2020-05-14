package com.fh.service.system.role.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.Roles;
import com.fh.service.system.role.RoleTreeManager;
import com.fh.util.PageData;

/**	角色
 * @author FHadmin QQ313596790
 * 修改日期：2015.11.6
 */
@Service("roleTreeService")
public class RoleTreeService implements RoleTreeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	

	@Override
	public List<Roles> listAllRolesByPId(String parentId) throws Exception {
		List<Roles> rolesList = this.listSubRolesByParentId(parentId);
		for(Roles depar : rolesList){
			depar.setTreeurl("roleTree/list.do?ROLE_ID="+depar.getROLE_ID());
			depar.setSubRoles(this.listAllRolesByPId(depar.getROLE_ID()));
			depar.setTarget("treeFrame");
			depar.setIcon("static/images/user.gif");
		}
		return rolesList;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Roles> listSubRolesByParentId(String parentId) throws Exception {
		return (List<Roles>) dao.findForList("RolesMapper.listSubRolesByParentId", parentId);
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>)dao.findForList("RolesMapper.datalistPage", page);
	}


	/**删除角色
	 * @param ROLE_ID
	 * @throws Exception
	 */
	@Override
	public void deleteRoleById(String ROLE_ID) throws Exception {
		dao.delete("RolesMapper.deleteRoleById", ROLE_ID);
	}
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData findObjectById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("RolesMapper.findObjectById", pd);
	}
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("RolesMapper.edit", pd);
	}


	@Override
	public void save(PageData pd) throws Exception {
		dao.save("RolesMapper.save", pd);
	}


	@Override
	public List<PageData> listAllRolesToSelect(String parentId, List<PageData> zrolePdList) throws Exception{
		List<PageData>[] arrayDep = this.listAllbyPd(parentId,zrolePdList);
		List<PageData> departmentPdList = arrayDep[1];
		for(PageData pd : departmentPdList){
			this.listAllRolesToSelect(pd.getString("id"),arrayDep[0]);
		}
		return arrayDep[0];
	}
	
	/**下拉ztree用
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData>[] listAllbyPd(String parentId,List<PageData> zdepartmentPdList) throws Exception {
		List<Roles> departmentList = this.listSubRolesByParentId(parentId);
		List<PageData> departmentPdList = new ArrayList<PageData>();
		for(Roles depar : departmentList){
			PageData pd = new PageData();
			pd.put("id", depar.getROLE_ID());
			pd.put("parentId", depar.getPARENT_ID());
			pd.put("name", depar.getROLE_NAME());
			pd.put("icon", "static/images/user.gif");
			departmentPdList.add(pd);
			zdepartmentPdList.add(pd);
		}
		List<PageData>[] arrayDep = new List[2];
		arrayDep[0] = zdepartmentPdList;
		arrayDep[1] = departmentPdList;
		return arrayDep;
	}

	/**通过id查找
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	@Override
	public Roles getRoleById(String ROLE_ID) throws Exception {
		return (Roles) dao.findForObject("RolesMapper.getRoleById", ROLE_ID);
	}

	/**给当前角色附加菜单权限
	 * @param role
	 * @throws Exception
	 */
	@Override
	public void updateRoleRights(Roles role) throws Exception {
		dao.update("RolesMapper.updateRoleRights", role);
	}


	/**给全部子角色加菜单权限
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void setAllRights(PageData pd) throws Exception {
		dao.update("RolesMapper.setAllRights", pd);
	}


	/**权限(增删改查)
	 * @param msg 区分增删改查
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void saveB4Button(String msg,PageData pd) throws Exception {
		dao.update("RolesMapper."+msg, pd);
	}

}

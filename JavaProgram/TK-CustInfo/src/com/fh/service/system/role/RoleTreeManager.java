package com.fh.service.system.role;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.Roles;
import com.fh.util.PageData;

/**	角色树接口类
 * @author shanghz
 * 修改日期：2017.09.04
 */
public interface RoleTreeManager {
	
	/**列出此组下级角色组
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Roles> listAllRolesByPId(String parentId) throws Exception;

	/**列出此组下级角色组
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;
	
	/**删除角色
	 * @param ROLE_ID
	 * @throws Exception
	 */
	public void deleteRoleById(String ROLE_ID) throws Exception;
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;

	/**查询下拉框角色列表
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAllRolesToSelect(String parentId, List<PageData> zrolePdList) throws Exception;

	/**通过id查找
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public Roles getRoleById(String ROLE_ID) throws Exception;
	
	/**给当前角色附加菜单权限
	 * @param role
	 * @throws Exception
	 */
	public void updateRoleRights(Roles role) throws Exception;
	
	/**给全部子角色加菜单权限
	 * @param pd
	 * @throws Exception
	 */
	public void setAllRights(PageData pd) throws Exception;
	
	/**权限(增删改查)
	 * @param msg 区分增删改查
	 * @param pd
	 * @throws Exception
	 */
	public void saveB4Button(String msg,PageData pd) throws Exception;

}

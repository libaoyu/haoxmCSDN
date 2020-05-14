package com.fh.controller.base;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.Logger;
import com.fh.util.PageData;
import com.fh.util.UuidUtil;

/**
 * @author FH Q313596790
 * 修改时间：2015、12、11
 */
public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());

	private static final long serialVersionUID = 6357869213649815390L;
	
	/** new PageData对象
	 * @return
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**得到ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**得到request对象
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	/**得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		return UuidUtil.get32UUID();
	}
	
	/**得到分页列表的信息
	 * @return
	 */
	public Page getPage(){
		return new Page();
	}
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}

	public void getUserHC(PageData pd,DepartmentManager departmentService) throws Exception{
		// 获取当前登录用户的信息以及其子级部门列表
		User user = Jurisdiction.getLoginUser();
		String DEPARTMENT_ID = user.getDepartment().getDEPARTMENT_ID();
		String CREATE_USER = user.getUSER_ID();
		List<PageData> zrolePdList = new ArrayList<PageData>();
		List<PageData> departmentList = departmentService.listAllDepartmentToSelect(DEPARTMENT_ID,zrolePdList);//列出所有系统用户部门(下拉框)
		ArrayList<String> arr = new ArrayList<String>();
		arr.add(DEPARTMENT_ID);//添加当前登陆人员所属部门信息
		for (PageData department : departmentList) {
			arr.add(department.getString("id"));
		}
		if(arr.size()==0){
			arr = null;
		}
		pd.put("CREATE_USER", CREATE_USER);
		pd.put("DEPARTMENT_ID", arr);
	}
	
	
	
	
}

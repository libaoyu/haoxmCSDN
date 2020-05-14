package com.fh.controller.questionnaire;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.questionnaire.LinkagePullDataService;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value="/linkagePullData")
public class LinkagePullDataController extends BaseController{
	
	@Resource(name="linkagePullDataService")
	private LinkagePullDataService linkagePullDataService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	/**
	 * 加载联动下拉的树形结构
	 * @return
	 * xiaoding
	 */
	@RequestMapping("list_old")
	public ModelAndView list(){
		ModelAndView mv=new ModelAndView();
		PageData pd=this.getPageData();
		try {
			List<PageData>listData=linkagePullDataService.list(pd);
			String strData=JSON.toJSONString(listData);
			mv.addObject("strData", strData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("questionnaire/linkage/edit_super");
		return mv;
	}
	/**
	 * 保存节点方法
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("saveLinkagePullData")
	public void saveLinkagePullData(PrintWriter out){
		String result="";
		PageData pd=this.getPageData();
		try {
			pd.put("linkageId",this.get32UUID());
			pd.put("createUser", Jurisdiction.getLoginUser().getUSER_ID());
			linkagePullDataService.saveLinkagePullData(pd);
			result=pd.getString("linkageId");
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}finally{
			out.print(result);
			out.close();
		}
	}
	/**
	 * 删除节点的方法
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("deleteLinkagePullData")
	public void deleteLinkagePullData(PrintWriter out){
		PageData pd=this.getPageData();
		String result="";
		try {
			linkagePullDataService.deleteLinkagePullData(pd);
			result="success";
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}finally{
			out.print(result);
			out.close();
		}
	}
	/**
	 * 修改节点的方法
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("updateLinkagePullData")
	public void updateLinkagePullData(PrintWriter out){
		PageData pd=this.getPageData();
		String result="";
		try {
			pd.put("updateUser", Jurisdiction.getLoginUser().getUSER_ID());
			pd.put("updateTime", Tools.date2Str(new Date()));
			linkagePullDataService.updateLinkagePullData(pd);
			result="success";
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}finally{
			out.print(result);
			out.close();
		}
	}
	/**
	 * 修改节点的方法
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("deleteAllLinkagePullData")
	public  void deleteAllLinkagePullData(PrintWriter out){
		PageData pd=this.getPageData();
		String result="";
		try {
			linkagePullDataService.deleteAllLinkagePullData(pd);
			result="success";
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}finally{
			out.print(result);
			out.close();
		}
	}
	/**
	 * 根据id查看右边详情
	 * @return
	 * xiaoding
	 */
	@RequestMapping("lookDetailForLinkageId")
	public ModelAndView lookDetailForLinkageId(){
		ModelAndView mv=new ModelAndView();
		PageData pd=this.getPageData();
		try {
			PageData data=linkagePullDataService.lookDetailForLinkageId(pd);
			mv.addObject("data",data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("questionnaire/linkage/lookDetailLinkage");
		return mv;
	}
	//一下为新方法                     
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView listAllDict(Model model,String linkageId)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
//			List<PageData>listData=linkagePullDataService.list(pd);
			this.getUserHC(pd, departmentService);
			JSONArray arr = JSONArray.fromObject(linkagePullDataService.listAllLinkage("0",pd));
			String json = arr.toString();
			json = json.replaceAll("linkageId", "id").replaceAll("parentId", "pId").replaceAll("linkageName", "name").replaceAll("subLinkage", "nodes").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("linkageId","0");
			mv.addObject("pd", pd);	
			mv.setViewName("questionnaire/linkage/linkage_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listAllByPage")
	public ModelAndView listAllByPage(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表linkage");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String linkageId = null == pd.get("linkageId")?"":pd.get("linkageId").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			linkageId = pd.get("id").toString();
		}
		pd.put("linkageId", linkageId);	
		this.getUserHC(pd, departmentService);//上级ID
		page.setPd(pd);
		List<PageData> listData=linkagePullDataService.findLinkageByParentIdForPage(page);
		mv.addObject("linkageId", linkageId);	//上级ID
		pd.put("parentId", linkageId);
		mv.addObject("pd", linkagePullDataService.findLinkagePullDataById(pd));		//传入上级所有信息
		mv.setViewName("questionnaire/linkage/linkage_list");
		mv.addObject("varList", listData);
		mv.addObject("QX",Jurisdiction.getHC());					//按钮权限
		return mv;
	}
	/**
	 * 删除节点的方法
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("deleteLinkagePullData_new")
	@ResponseBody
	public Object deleteLinkagePullData_new(){
		PageData pd=this.getPageData();
		String result="";
		Map<String,String> map = new HashMap<String,String>();
		try {
//			linkagePullDataService.deleteLinkagePullData(pd);
			List<PageData> dataList=linkagePullDataService.findLinkageByParentId(pd);
			if(dataList!=null &&dataList.size()>0){
				result="false";
			}else{
				linkagePullDataService.deleteLinkagePullData(pd);
				result="success";
			}
		} catch (Exception e) {
			result="fail";
			e.printStackTrace();
		}
		map.put("result", result);
		return AppUtil.returnObject(new PageData(), map);
	}
	/**
	 * 加载新增页面
	 * @return
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, Jurisdiction.getUsername()+"加载linkage页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd=this.getPageData();
		try {
			PageData data=linkagePullDataService.findLinkagePullDataById(pd);
			mv.addObject("pds", data);
			mv.addObject("msg", "saveLink");
			mv.setViewName("questionnaire/linkage/linkage_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	/**
	 * baocun 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveLink")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增linkage");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String parentId=pd.getString("parentId");
		if(Tools.isEmpty(parentId)){
			parentId="0";
			pd.put("parentId", parentId);
		}
		pd.put("linkageId",this.get32UUID());
		pd.put("createUser", Jurisdiction.getLoginUser().getUSER_ID());
//		data.setCreateTime(Tools.date2Str(new Date()));
		pd.put("createTime", Tools.date2Str(new Date()));
		linkagePullDataService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = linkagePullDataService.lookDetailForLinkageId(pd);	//根据ID读取
		PageData pds=linkagePullDataService.findLinkagePullDataById(pd);
		mv.addObject("pd", pd);					//放入视图容器
		mv.addObject("pds", pds);					//放入视图容器
		mv.setViewName("questionnaire/linkage/linkage_edit");
		mv.addObject("msg", "edit");
		return mv;
	}
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改LINKAGE");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String parentId=pd.getString("parentId");
		if(Tools.isEmpty(parentId)){
			parentId="0";
			pd.put("parentId", parentId);
		}
		pd.put("updateUser", Jurisdiction.getLoginUser().getUSER_ID());
		pd.put("updateTime", Tools.date2Str(new Date()));
		linkagePullDataService.updateLinkagePullData(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
}

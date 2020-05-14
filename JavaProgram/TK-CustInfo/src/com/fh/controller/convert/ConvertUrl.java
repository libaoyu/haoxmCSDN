package com.fh.controller.convert;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fh.controller.base.BaseController;
import com.fh.service.questionnaire.FileDetailsService;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 类名称：ConvertUrl
 * 创建人：shanghz 
 * 创建时间：2017-6-12
 */
@Controller
@RequestMapping(value="/zj")
public class ConvertUrl extends BaseController{
	
	@Resource(name="fileDetailsService")
	private FileDetailsService fileDetailsService;
	
	
	/**
	 * 问卷网址url 
	 */
	@RequestMapping(value="/url")
	public void convertUrl(String c,HttpServletResponse resp) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("shortUrl", c);
		// 根据code从数据库中查出对应关系
		PageData pdata = fileDetailsService.findByShortUrl(pd);
		String url = (String) pdata.get("enCodePath");
		String code=pd.getString("code");
		
		if(url!=null){
			if(!Tools.isEmpty(code)){
				resp.sendRedirect(url+"&code="+code);
			}else{
				resp.sendRedirect(url);
			}
			
		}else{
			resp.sendError(404);
		}
		
	}
	
	/**
	 * 仙林鼓楼医院星级评价url短链接 
	 */
	@RequestMapping(value="/xl")
	public void xl(String c,HttpServletRequest request,HttpServletResponse resp) throws Exception{
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String url = basePath+Const.XL_XJPJ_PATH+c;
		if(!Tools.isEmpty(c)){
			resp.sendRedirect(url);
		}else{
			resp.sendError(404);
		}
	}
	
	/**
	 * 仙林鼓楼医院星级评价url短链接(新)
	 */
	@RequestMapping(value="/wj")
	public void wj(String c,HttpServletRequest request,HttpServletResponse resp) throws Exception{
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String url = basePath+Const.XL_XJPJ_PATH_NEW+c;
		if(!Tools.isEmpty(c)){
			resp.sendRedirect(url);
		}else{
			resp.sendError(404);
		}
	}

}

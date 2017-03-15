package com.yt.framework.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Maps;
import com.yt.framework.service.VisitorService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *用户操作
 *@autor ylt
 *@date2015-8-31下午5:16:49
 */
@RequestMapping(value="/visitor/")
@Controller
public class VisitorController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(VisitorController.class);

	@Autowired
	private VisitorService visitorService;
	
	/**
	 * 访问用户列表
	 *@param visit_type 0:非俱乐部，1 俱乐部
	 *@param visit_url 访问模块
	 *@param user_id 访问者
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date 2015-9-14下午5:43:15
	 */
	@RequestMapping(value="visitorList")
	public String visitorList(HttpServletRequest request, PageModel pageModel){
		String m_visitor_id = request.getParameter("user_id");
		String t_visitor_id = request.getParameter("teaminfo_id");
		String visit_type = request.getParameter("visit_type");
		String visit_url =  request.getParameter("visit_url");
		String path = "visitorlist";
		if(StringUtils.isNotBlank(visit_type) && StringUtils.isNotBlank(visit_url) ) {
			Map<String,Object> params = Maps.newHashMap();
			if(StringUtils.isNotBlank(m_visitor_id)){
				params.put("p_visitor_id", m_visitor_id);
			}else{
				params.put("p_visitor_id", t_visitor_id);
				path = "t_visitorlist";
			}
			params.put("visit_url", visit_url);
			params.put("visit_type", visit_type);
			AjaxMsg ajaxMsg = visitorService.queryForPageList(params, pageModel);
			request.setAttribute("visitors", ajaxMsg.getData("page"));
			request.setAttribute("visitCount", ajaxMsg.getData("visitCount"));
		}
		return "visitor/"+path;
	}
	
}

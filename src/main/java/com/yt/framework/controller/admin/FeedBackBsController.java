package com.yt.framework.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.service.admin.FeedBackBsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Controller
@RequestMapping(value="/admin/feedback")
public class FeedBackBsController {
	
	private static Logger logger = LogManager.getLogger(FeedBackBsController.class);
	
	@Autowired
	private FeedBackBsService feedBackBsService;

	/**
	 * 进入角色管理页面
	 * @param request
	 * @param pageModel
	 * @return role.jsp
	 */
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(status)) params.put("status", status);
		AjaxMsg msg = feedBackBsService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/feedback/feedback"; 
	}
	
	@RequestMapping(value="/changeStatus")
	@ResponseBody
	public String changeStatus(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = feedBackBsService.changeStatus(id);
		return msg.toJson();
	}
}

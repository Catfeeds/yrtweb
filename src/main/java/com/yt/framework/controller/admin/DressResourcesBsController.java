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

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.service.admin.DressResourcesBsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;


/**
 * 个人中心皮肤管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/dressres")
public class DressResourcesBsController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(DressResourcesBsController.class);

	@Autowired
	private DressResourcesBsService dressResourcesBsService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		AjaxMsg msg = dressResourcesBsService.queryResources(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/dress/dressres"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		DressResources dres = new DressResources();
		if(StringUtils.isNotBlank(id)){
			dres = dressResourcesBsService.getEntityById(id);
		}
		request.setAttribute("dres", dres);
		return "admin/dress/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,DressResources dres){
		dres.setUser_id(getUserId());
		AjaxMsg msg = dressResourcesBsService.saveOrUpdate(dres);
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String deleteRole(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = dressResourcesBsService.delete(id);
		return msg.toJson();
	}
}

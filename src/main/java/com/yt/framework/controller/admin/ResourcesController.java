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

import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.security.WebSecurityMetadataSource;
import com.yt.framework.service.admin.ResourcesService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Controller
@RequestMapping(value="/admin/resources")
public class ResourcesController {
	
	private static Logger logger = LogManager.getLogger(ResourcesController.class);
	
	@Autowired
	private ResourcesService resourcesService;
	
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String res_name = request.getParameter("res_name");
		String res_parentid = request.getParameter("res_parentid");
		String parent_name = request.getParameter("parent_name");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("res_name", res_name);
		params.put("res_parentid", res_parentid);
		AjaxMsg msg = resourcesService.queryResources(params, pageModel);
		params.put("parent_name", parent_name);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		//request.setAttribute("parentRes", resourcesService.queryParents());
		return "admin/resources/resources"; 
	}
	
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		Resources resources = new Resources();
		String flag = "1";
		String parent_name = "";
		if(StringUtils.isNotBlank(id)){
			resources = resourcesService.getResources(id);
			flag = "2";
			Integer pid = resources.getRes_parentid();
			if(pid!=null){
				Resources pres = resourcesService.getResources(pid.toString());
				parent_name = pres.getRes_name();
			}
		}
		//request.setAttribute("parentRes", resourcesService.queryParents());
		request.setAttribute("resources", resources);
		request.setAttribute("flag", flag);
		request.setAttribute("parent_name", parent_name);
		return "admin/resources/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,Resources resources){
		String flag = request.getParameter("flag");
		AjaxMsg msg = resourcesService.saveOrUpdate(resources,flag);
		if(msg.isSuccess()){
			WebSecurityMetadataSource.hasChange = true;
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = resourcesService.delete(id);
		if(msg.isSuccess()){
			WebSecurityMetadataSource.hasChange = true;
		}
		return msg.toJson();
	}
	@RequestMapping(value="/getLastRes")
	@ResponseBody
	public String getLastRes(HttpServletRequest request){
		String pval = request.getParameter("pval");
		AjaxMsg msg = resourcesService.getLastRes(pval);
		return msg.toJson();
	}
}

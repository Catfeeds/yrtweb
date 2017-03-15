package com.yt.framework.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.security.WebSecurityMetadataSource;
import com.yt.framework.service.SecurityService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 角色管理
 * @author GL
 * @date 2015年7月27日 上午10:25:03 
 */
@Controller
@RequestMapping(value="/admin/role")
public class RoleController {
	
	private static Logger logger = LogManager.getLogger(RoleController.class);
	
	@Autowired
	private SecurityService securityService;

	/**
	 * 进入角色管理页面
	 * @param request
	 * @param pageModel
	 * @return role.jsp
	 */
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String role_name = request.getParameter("role_name");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("role_name", role_name);
		AjaxMsg msg = securityService.findRoleByPage(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/role/role"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String roleId = request.getParameter("id");
		Role role = new Role();
		if(StringUtils.isNotBlank(roleId)){
			role = securityService.getRoleById(roleId);
		}
		request.setAttribute("role", role);
		return "admin/role/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,Role role){
		AjaxMsg msg = securityService.saveOrUpdate(role);
		return msg.toJson();
	}
	@RequestMapping(value="/deleteRole")
	@ResponseBody
	public String deleteRole(HttpServletRequest request){
		String roleId = request.getParameter("id");
		AjaxMsg msg = securityService.deleteRole(roleId);
		return msg.toJson();
	}
	
	/**
	 * 进入角色管理资源编辑页面
	 * @param request
	 * @return role-res.jsp
	 */
	@RequestMapping(value="/roleResources")
	public String roleResources(HttpServletRequest request){
		String roleId = request.getParameter("id");
		Role role = new Role();
		List<Resources> res = new ArrayList<Resources>(); 
		String resIds = "";
		if(StringUtils.isNotBlank(roleId)){
			role = securityService.getRoleById(roleId);
			res = securityService.queryResourcesByRoleId(roleId);
		}
		if(res!=null&&res.size()>0){
			for (Resources r : res) {
				String rid = r.getRes_id().toString();
				resIds+=(rid+",");
			}
			if(StringUtils.isNotBlank(resIds)&&resIds.indexOf(",")>0)
				resIds = resIds.substring(0,resIds.lastIndexOf(","));
		}
		request.setAttribute("role", role);
		request.setAttribute("resIds", resIds);
		return "admin/role/role-res"; 
	}
	@RequestMapping(value="/queryResources")
	@ResponseBody
	public List<Resources> queryResources(HttpServletRequest request){
		List<Resources> res = securityService.queryAllResources();
		return res;
	}
	
	@RequestMapping(value="/saveRoleRes")
	@ResponseBody
	public String saveRoleRes(HttpServletRequest request){
		String roleid = request.getParameter("role_id");
		String residsStr = request.getParameter("resids");
		AjaxMsg msg = securityService.saveRoleRes(roleid,residsStr);
		if(msg.isSuccess()){
			WebSecurityMetadataSource.hasChange = true;
		}
		return msg.toJson();
	}
}

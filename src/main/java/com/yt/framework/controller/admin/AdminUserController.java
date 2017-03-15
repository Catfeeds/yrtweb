package com.yt.framework.controller.admin;

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

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.admin.AdminUserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台用户管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/user")
public class AdminUserController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminUserController.class);

	@Autowired
	private AdminUserService adminUserService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String usernick = request.getParameter("usernick");
		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(usernick)) params.put("usernick", usernick);
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		if(StringUtils.isNotBlank(phone)) params.put("phone", phone);
		if(StringUtils.isNotBlank(email)) params.put("email", email);
		AjaxMsg msg = adminUserService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/user/user"; 
	}
	
	@RequestMapping(value="/selectUser")
	public String dialog(HttpServletRequest request,PageModel pageModel){
		String usernick = request.getParameter("usernick");
		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(usernick)) params.put("usernick", usernick);
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		if(StringUtils.isNotBlank(phone)) params.put("phone", phone);
		if(StringUtils.isNotBlank(email)) params.put("email", email);
		AjaxMsg msg = adminUserService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		params.put("type", type);
		request.setAttribute("params",params);
		return "admin/user/select_user"; 
	}
	
	@RequestMapping(value="/roleForm")
	public String userRole(HttpServletRequest request){
		String id = request.getParameter("id");
		User user = adminUserService.getUserById(id);
		List<Role> roles = adminUserService.queryBmsRoles();
		List<Role> userRoles = adminUserService.queryBUserRoles(id);
		request.setAttribute("user", user);
		request.setAttribute("roles", roles);
		request.setAttribute("userRoles", userRoles);
		return "admin/user/user_role";
	}
	
	@RequestMapping(value="/updateUserRole")
	@ResponseBody
	public String updateUserRole(HttpServletRequest request,String userId,String roles){
		AjaxMsg msg = adminUserService.updateUserRole(userId,roles);
		return msg.toJson();
	}
	

}

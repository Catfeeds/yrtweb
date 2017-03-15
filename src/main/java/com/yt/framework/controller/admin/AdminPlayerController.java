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
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.service.admin.AdminPlayerInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台用户管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/player")
public class AdminPlayerController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminPlayerController.class);

	@Autowired
	private AdminPlayerInfoService adminPlayerInfoService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String username = request.getParameter("username");
		String name = request.getParameter("name");
		String level = request.getParameter("level");
		String if_daji = request.getParameter("if_daji");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(level)) params.put("level", level);
		if(StringUtils.isNotBlank(if_daji)) params.put("if_daji", if_daji);
		AjaxMsg msg = adminPlayerInfoService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/player/player"; 
	}
	
	@RequestMapping(value="/updatePlayerLevel")
	@ResponseBody
	public String updatePlayerLevel(HttpServletRequest request,PlayerInfo playerInfo){
		AjaxMsg msg = AjaxMsg.newError();
		msg = adminPlayerInfoService.updatePlayerLevel(playerInfo);
		return msg.toJson();
	}

}

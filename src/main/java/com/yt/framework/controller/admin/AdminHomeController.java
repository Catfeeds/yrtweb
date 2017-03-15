package com.yt.framework.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yt.framework.utils.URLHelper;

/**
 * 后台管理
 * @author GL
 * @date 2015年7月25日 上午11:30:32 
 */
@Controller
@RequestMapping(value="/admin")
public class AdminHomeController {
	private static Logger logger = LogManager.getLogger(AdminHomeController.class);

	/**
	 * 后台首页
	 * @param request
	 * @return admin/index.jsp
	 */
	@RequestMapping(value="")
	public String main(HttpServletRequest request){
		
		return "admin/index"; 
	}
	
	@RequestMapping(value="/dialog")
	public String dialog(HttpServletRequest request){
		Map<String, Object> params = URLHelper.getParams4Map(request);
		request.setAttribute("params", params);
		return "admin/common/dialog";
	} 
}

package com.yt.framework.controller.admin;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *后台登录
 *@autor bo.xie
 *@date2015-7-24下午3:10:23
 */
@Controller
@RequestMapping(value="/admin/login/")
public class AdminLoginController {
	
	private static Logger logger = LogManager.getLogger(AdminLoginController.class);

	@RequestMapping(value="")
	public String loginPage(){
		
		return "admin/login";
	}
}

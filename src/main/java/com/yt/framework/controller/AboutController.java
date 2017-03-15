package com.yt.framework.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 关于
 * @author bo.xie
 * @date 2015年10月11日10:40:31
 */
@Controller
public class AboutController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AboutController.class);

	@RequestMapping(value="/about/{page}")
	public String aboutPage(@PathVariable("page")String page){
		
		return "about/"+page;
	}
}

package com.yt.framework.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;

@Controller
@RequestMapping(value="/messageResource")
public class MessageResourceController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(MessageResourceController.class);

	@Autowired
	private MessageResourceService messageResourceService;
	
	/**
	 * 获取对应消息
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="getMsg")
	@ResponseBody
	public String getMsg(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String key = request.getParameter("key");
		if(StringUtils.isNotBlank(key)){
			msg.addMessage(messageResourceService.getMessage(key));
		}
		return msg.toJson();
	}
	
}

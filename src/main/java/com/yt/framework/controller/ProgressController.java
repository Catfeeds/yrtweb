package com.yt.framework.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.Progress;
import com.yt.framework.utils.AjaxMsg;

/**
 * @ClassName: ProgressController 
 * @Description: 获取上传文件进度controller
 * @author zjh
 * @date 2015年7月24日 下午2:51:09 
 */
@Controller
@RequestMapping("/fileStatus")
public class ProgressController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(ProgressController.class);

	@RequestMapping(value = "/upfile/progress", method = RequestMethod.POST )
	@ResponseBody
	public String initCreateInfo(HttpServletRequest request) {
		Progress status = (Progress) request.getSession().getAttribute("upload_ps");
		if(status==null){
			return "{}";
		}
		return AjaxMsg.toJson(status);
	}
}
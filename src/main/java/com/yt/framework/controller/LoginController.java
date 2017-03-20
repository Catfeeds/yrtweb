package com.yt.framework.controller;

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

import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;

/**
 * @Title: LoginController.java 
 * @Package com.yt.framework.controller
 * @author GL
 * @date 2015年7月24日 上午11:13:16 
 */
@Controller
public class LoginController {
	
	private static Logger logger = LogManager.getLogger(LoginController.class);
	
	@Autowired
	private UserService userService;

	@RequestMapping(value="/login")
	public String login(HttpServletRequest request) {
		String flag = request.getParameter("error");
		String captcha = request.getParameter("captcha");
		String errorMsg = "";
		String username = BeanUtils.nullToString(request.getSession().getAttribute("username"));
		if(StringUtils.isNotBlank(username)){
//			errorMsg = "请先退出同一浏览器登陆的用户";
		}
		if(StringUtils.isNotBlank(flag)){
			errorMsg = "用户名或密码错误";
		}else if(StringUtils.isNotBlank(captcha)){
//			errorMsg = "验证码错误";
		}else{
			request.getSession().removeAttribute("username");
		}
		request.setAttribute("errorMsg", errorMsg);
		return "login";
	}
	
	@RequestMapping(value="/ajaxlogin")
	public String ajaxLogin(HttpServletRequest request){
		return "ajaxlogin";
	}
	@RequestMapping(value="/ajaxLoginFailure")
	@ResponseBody
	public Map<String, Object> ajaxLoginFailure(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("loginState", 1);
		map.put("captcha", 1);
		return map;
	}
	
	@RequestMapping("/login/accessDenied")
    public String accessDenied() {
        return "403";
    }
	
	/**
	 * 登出操作
	 *@param request
	 *@return 回到首页
	 *@autor bo.xie
	 *@date2015-7-23下午6:22:56
	 */
	@RequestMapping(value="/login/loginOut")
	public String loginOut(HttpServletRequest request){
		Common.removeSessionValue("session_user_id");
		Common.removeSessionValue("session_usernick");
		return "redirect:/logout"; //update by gl
	}
	
	/**
	 * 弹窗登陆判断
	 *@param request
	 *@return 回到首页
	 *@autor ylt
	 *@date2015-7-23下午6:22:56
	 */
	@RequestMapping(value="/ifLogin")
	@ResponseBody
	public String ifLogin(HttpServletRequest request){
		if(null == Common.getCurrentSessionValue(request, "session_user_id")){
			return AjaxMsg.newError().toJson();
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
}

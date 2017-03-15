package com.yt.framework.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.util.WebUtils;

import com.mysql.jdbc.StringUtils;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.security.WebUserDetails;
import com.yt.framework.utils.Setting;
import com.yt.framework.utils.exceptions.NeedLoginException;

/**
 *公共Controller
 *@autor bo.xie
 *@date2015-7-21下午2:06:27
 */
public class BaseController {
	
	protected static Logger logger = LogManager.getLogger(BaseController.class.getName());
	
	/**
	 * 获取登录用户ID
	 * @return userID
	 */
	protected String getUserId(){
		try {
			WebUserDetails user = (WebUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			return user.getUserId();
		} catch (Exception e) {
			return null;
		}
	}
	
	protected UserRole getUser(){
		try {
			WebUserDetails webUser = (WebUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserRole user = webUser.getUser();
			user.setPassword(null);
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	
	protected int isme(String oth_user_id){
		int isme = 0;
		String uid = getUserId();
		if(org.apache.commons.lang.StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		return isme;
	}
	
	/*
	 * 根据key获取session中的value
	 */
	public String getValueByKey(HttpServletRequest request, String key) {
		return request.getSession(true).getAttribute(key) == null ? null : request.getSession(true).getAttribute(key).toString();
	}
	
	/**
	 * 调用该方法检查用户 是否登录，没有登录则跳转到登录页面。<br/>
	 * 该方法只能在Controller内调用
	 * 
	 * @param target
	 *            跳转的目标页面，如果没有指定，则使用默认跳转
	 * @return 当前登录用户ID
	 */
	protected String needLogin(HttpServletRequest request, String target) {
		String user_id = WebUtils.getSessionAttribute(request, User.LOGIN_USER_ID_SESSION_NAME).toString();
		//如果不是站外链接，则附加contextPath
		if (!StringUtils.isNullOrEmpty(target) && !target.startsWith("http://")) {
			target = request.getContextPath()  + target;
		}
		if (StringUtils.isNullOrEmpty(user_id)) {
			throw new NeedLoginException(target);
		} else {
			return user_id;
		}
	}
	
	/**
	 * 调用该方法检查用户 是否登录，没有登录则跳转到登录页面<br/>
	 * 这个方法会自动解析Controller内的方法来组成URL
	 * 
	 */
	protected String needLogin(HttpServletRequest request) {
		return needLogin(request, null);
	}
	
	/**
	 * JSON  提交数据时 验证登录
	 */
	protected String needLoginAjaxJson(HttpServletRequest request){
		String uId = getValueByKey(request, User.LOGIN_USER_ID_SESSION_NAME);
		String userId = (org.apache.commons.lang.StringUtils.isNotBlank(uId)&&NumberUtils.isDigits(uId))?uId:null;
		return userId;
	}
	
	/**
	 * 返回当前服务器的运行模式是否是开发模式。
	 * @return
	 */
	protected Boolean isDevMode(){
		return Setting.global("system.devMode").boolValue();
	}
	
}

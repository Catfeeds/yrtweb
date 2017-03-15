package com.yt.framework.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.SystemSettingsService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.Md5Encrypt;
import com.yt.framework.utils.URLHelper;
import com.yt.framework.utils.emailSend.EmailNoticeDto;
import com.yt.framework.utils.emailSend.MailService;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @ClassName: RegisterController
 * @Description: 注册相关
 * @author zjh
 * @date 2015年7月24日 上午11:52:40
 */
@Controller
@RequestMapping("/register")
public class RegisterController extends BaseController {
	private static Logger logger = LogManager.getLogger(RegisterController.class);
	private String PHONE = "phone";
	private String EMAIL = "email";
	@Autowired
	private UserService userService;
	
	@Autowired
	private SystemSettingsService systemSettingsService;

	@RequestMapping(value="agreen")
	public String agreePage(){
		
		return "agreen";
	}
	
	@RequestMapping("/registerAccount")
	public String registerUser() {
		return "register";
	}

	@RequestMapping("/saveAccount")
	@ResponseBody
	public String saveAccount(HttpServletRequest request){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String volidCode = request.getParameter("volidCode");
		AjaxMsg msg_iau  =userService.isAvailableUsername(username);
		//用户名被占用
		if(msg_iau.isError()){
			return msg_iau.toJson();
		}
		String str = this.isMobileOrEmail(username);
		AjaxMsg msg = systemSettingsService.checkCode(volidCode, username,request.getSession());
		if(msg.isError()){
			return msg.toJson();
		}
		User u = new User();
		u.setVideo_count(2);
		u.setImage_count(5);
		u.setPassword(password);
		if(str.equals(PHONE)){
			u.setPhone(username);
		}else{
			u.setEmail(username);
		} 
		u.setHead_icon("headImg/headimg.png");
		AjaxMsg usermsg = userService.savaAccount(request,u);
		User user = (User) usermsg.getData("user");
		if(StringUtils.isNotBlank(user.getId())){
			Common.setSessionValue("user", user);
			Common.setSessionValue("session_user_id", user.getId());
			Common.setSessionValue("session_usernick", user.getUsernick());
		}
		if(str.equals(PHONE)){
			this.SendSms(user);
		}else if(str.equals(EMAIL)){
			this.sendEmail(user);
		}else{
			logger.error("账号："+user.getUsername()+"校验异常，邮件或者短信发送失败。");
		}
		
		return usermsg.toJson();
	}
	
	/**
	 * @Title: isMobileOrEmail
	 * @Description: 校验注册账户是手机号还是邮箱
	 * @param @param
	 *            str
	 * @param @return
	 *            设定文件
	 * @return String 返回类型
	 * @throws @author
	 *             zjh
	 * @date:2015年7月27日上午11:02:21
	 */
	private String isMobileOrEmail(String str) {

		if (Common.isMobile(str)) {
			return PHONE;
		} else if (Common.isEmail(str)) {
			return EMAIL;
		} else {
			return "";
		}

	}
	/**
	 * @Title: sendEmail 
	 * @Description: 邮箱注册完成发送通知邮件 
	 * @param @param u    设定文件 
	 * @return void    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日上午11:37:24
	 */
	private void sendEmail(User u){
		String num = u.getUsernick();
		String txt ="亲爱的用户："+num+"恭喜您注册成功！";
		EmailNoticeDto emailDto = new EmailNoticeDto();
		List<String> sendTo=new ArrayList<String>();
		sendTo.add(num);
		emailDto.setSendTo(sendTo);
		emailDto.setText(txt);
		try {
			MailService.getInstance().send(emailDto);
		} catch (Exception e) {
			logger.error(num+":注册成功邮件发送失败");
		}
	}
	/**
	 * 
	 * @Title: SendSms 
	 * @Description: 手机号注册完成发送通知短信
	 * @param @param u    设定文件 
	 * @return void    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日上午11:36:53
	 */
	private void SendSms(User u){
		String num = u.getUsername();
		String txt ="亲爱的用户："+num+"恭喜您注册成功！";
		AjaxMsg msg = SendMsg.getInstance().sendSMS(num, txt);
		if(msg.isError()){
			logger.error(num+":注册成功短信发送失败");
		}
	}
	/**
	 * @Title: checkUsername 
	 * @Description: 检查用户名是否可用 
	 * @param @param username
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日下午2:44:46
	 */
	@RequestMapping("/checkUsername")
	@ResponseBody
	public String checkUsername(HttpServletRequest request){
		String username = request.getParameter("username");
		AjaxMsg msg = userService.isAvailableUsername(username);
		return msg.toJson();
	}
	
	/**
	 * 忘记密码页面
	 * /forgetpwd  验证用户名
	 * /forgetpwd/next 修改密码
	 * /forgetpwd/finnally 修改成功
	 * @param request
	 * @return forgetpwd.jsp
	 */
	@RequestMapping("/forgetpwd/**")
	public String forgetPwd(HttpServletRequest request){
		String[] paths = URLHelper.getPaths(request);
		int len = paths.length;
		String type = "";
		if(len==2){
			if("next".equals(paths[1])||"finally".equals(paths[1])){
				type = paths[1];
				Object userId = request.getSession().getAttribute("forgetUserId");
				if("next".equals(paths[1])&&userId==null){
					return "redirect:/forgetpwd";
				}
			}
		}
		request.setAttribute("type", type);
		return "forgetpwd";
	}
	@RequestMapping("/forgetpwd/volid")
	@ResponseBody
	public String forgetVolid(HttpServletRequest request){
		String username = request.getParameter("username");
		String volidCode = request.getParameter("volidCode");
		AjaxMsg msg = systemSettingsService.checkCode(volidCode, username,request.getSession());
		if(msg.isSuccess()){
			User user = userService.getUserByUsername(username);
			msg.addData("user", user);
			request.getSession().setAttribute("forgetUserId", user.getId());
		}
		return msg.toJson();
	}
	@RequestMapping("/forgetpwd/updateForgetPwd")
	@ResponseBody
	public String updateForgetPwd(HttpServletRequest request){
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String passwordb = request.getParameter("passwordb");
		if(password.equals(passwordb)){
			User user = userService.getEntityById(userId);
			user.setPassword(Md5Encrypt.md5(password));
			AjaxMsg msg = userService.update(user);
			request.getSession().removeAttribute("forgetUserId");
			return msg.toJson();
		}else{
			return AjaxMsg.newError().addMessage("两次密码输入不一致").toJson();
		}
	}
}
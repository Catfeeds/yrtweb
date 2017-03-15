package com.yt.framework.controller;

import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.UserEnum.BINDTYPE;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.service.SystemSettingsService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.Md5Encrypt;
import com.yt.framework.utils.PropertiesUtils;
import com.yt.framework.utils.http.HttpRequestUtil;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @ClassName: SystemSettingsController 
 * @Description: 系统设置相关 
 * @author zjh
 * @date 2015年8月3日 上午10:21:32 
 */
@Controller
@RequestMapping(value = "/system")
public class SystemSettingsController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(SystemSettingsController.class);
	
	@Autowired
	private UserService userService;
	@Autowired
	private SystemSettingsService systemSettingsService;
	@Autowired
	private SecurityService securityService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="")
	public String indexPage(Model model,HttpServletRequest request){
		User user = super.getUser();
		String last_login_ip = user.getLast_login_ip();//上次登录IP
		Date last_login = user.getLast_login();//上次登录时间
		String urlStr = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip="+last_login_ip;
		//上次登录城市{ret=1.0, desc=, start=-1.0, isp=, province=, type=, district=, end=-1.0, city=, country=}
		String re_str = HttpRequestUtil.executeRquest(urlStr, null, true, null, null, "UTF-8", null, null, ",");
		Gson gson;
		try {
			if(!re_str.equals("-3")){
				gson = GsonBuilder.class.newInstance().create();
				Map<String,Object> map = gson.fromJson(re_str, Maps.newHashMap().getClass());
				model.addAttribute("map", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		model.addAttribute("last_login_ip", last_login_ip);
		model.addAttribute("last_login", last_login);
		model.addAttribute("user", user);
		return "system/index";
	}
	
	/**
	 * @Title: baseinfo 
	 * @Description: 跳转至基础信息设置
	 * @param @param request
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月3日下午2:30:56
	 */
	@RequestMapping(value = "/baseInfo")
	public String baseInfo(HttpServletRequest request){
		String uid = super.getUserId();
		User user = userService.getEntityById(uid);
		request.setAttribute("user", user);
//		return "/system/baseinfo";
		return "center/user-info"; //update by gl 20150828
	}
	/**
	 * @Title: modifyPassword 
	 * @Description: 跳转至密码修改页面
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 	
	 * @author zjh
	 * @date  2015年8月5日下午4:06:17
	 */
	@RequestMapping(value = "/modifyPassword")
	public String modifyPassword(Model model,HttpServletRequest request){
		model.addAttribute("user", super.getUser());
		return "/system/pass/modifypassword"; // update by ylt 2015-08-24
	}
	
	/**
	 * 人间基本信息
	 * @author gl
	 * @return
	 */
	@RequestMapping(value = "/userInfo")
	@ResponseBody
	public String userInfo(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		AjaxMsg msg = AjaxMsg.newError();
		String uid = super.getUserId();
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		if(StringUtils.isNotBlank(uid)){
			msg = userService.getUserById(uid,getUserId());
		}
		return msg.toJson();
	}
	
	
	/**
	 * @Title: saveBaseInfo 
	 * @Description:  更新当前用户的基本信息
	 * @param @param request
	 * @param @param user
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月3日下午3:22:47
	 */
	@RequestMapping(value = "/saveBaseInfo",method = RequestMethod.POST)
	@ResponseBody
	public String saveBaseInfo(HttpServletRequest request,User user){
		String uid = user.getId();
		String usernick = user.getUsernick();
		if(userService.hasUserByNick(uid,usernick)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.nickused")).toJson();
		}
		if(usernick.indexOf("宇任拓")>=0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.nickkey")).toJson();
		}
		
		//update by gl 20150828
		String county = request.getParameter("county");
		user.setArea(county);
		//update by gl 20150828
		String date = request.getParameter("date");
		//数据库user信息
		User resouce_user = userService.getEntityById(uid);
		//头像
		resouce_user.setHead_icon(user.getHead_icon());
		//昵称
		resouce_user.setUsernick(user.getUsernick());
//		//姓名
		resouce_user.setUsername(user.getUsername());
		//性别
		resouce_user.setSex(user.getSex());
		//出生年月
		//update by bo.xie 2015年12月14日10:34:46	start
		if(StringUtils.isNotBlank(date)){
			resouce_user.setBorndate(Common.parseStringDate(date, "yyyy-MM-dd"));
		}
		//update by bo.xie 2015年12月14日10:34:46	end
		//所在省
		resouce_user.setProvince(user.getProvince());
		//市
		resouce_user.setCity(user.getCity());
		//区域
		resouce_user.setArea(user.getArea());
		//个性签名
		resouce_user.setSignature(user.getSignature());
		//基本资料填写完毕 ，则奖励3个相片位，1个视频位
		/*if(Common.isNotEmpty(resouce_user.getHead_icon()) &&
			Common.isNotEmpty(resouce_user.getUsernick()) &&
			Common.isNotEmpty(resouce_user.getUsername()) &&
			Common.isNotEmpty(resouce_user.getBorndate()) &&
			Common.isNotEmpty(resouce_user.getProvince()) &&
			Common.isNotEmpty(resouce_user.getCity()) &&
			Common.isNotEmpty(resouce_user.getArea()) &&
			Common.isNotEmpty(resouce_user.getSignature()) 
			){
			resouce_user.setImage_count(3);
			resouce_user.setVideo_count(1);
		}*/
		
		AjaxMsg msg = userService.update(resouce_user);
		if(msg.isSuccess()){
			securityService.reloadUserRole(resouce_user, request);
			//更新后的user 存入session
			Common.setSessionValue("session_usernick", resouce_user.getUsernick());
			Common.setSessionValue(User.LOGIN_USER_SESSION_NAME, msg.getData("user"));
			msg = userService.getUserById(uid,uid);
			msg.addMessage("基本信息更新成功");
		}else if(msg.isError()){
			logger.error(uid+":基本信息更新失败");
			msg.addMessage("基本信息更新失败");
		}
		
		return msg.toJson();
	}
	/**
	 * @Title: updatePassword 
	 * @Description: 更改当前用户密码 
	 * @param @param request
	 * @param @param user
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月3日下午3:33:53
	 */
	@RequestMapping(value="/updatePassword",method = RequestMethod.POST)
	@ResponseBody
	public String updatePassword(HttpServletRequest request){
		//String uid = this.needLogin(request);
		String uid = super.getUserId();
		String newpwd = request.getParameter("newpwd");
		String oldpwd = Md5Encrypt.md5(request.getParameter("oldpwd"));
		//数据库user信息
		User resouce_user = userService.getEntityById(uid);
		if(!resouce_user.getPassword().equals(oldpwd)){
			return AjaxMsg.newError().addMessage("原始密码不正确").toJson();
		}
		//密码
		resouce_user.setPassword(Md5Encrypt.md5(newpwd));
		AjaxMsg msg = userService.update(resouce_user);
		if(msg.isSuccess()){
			logger.info(uid+":"+resouce_user.getUsername()+"密码更新成功");
			msg.addMessage("密码更新成功");
		}else{
			logger.error(uid+":"+resouce_user.getUsername()+"密码更新失败");
			msg.addMessage("密码更新失败");
		}
		
		return msg.toJson();
		
	}
	
	/**
	 * @Title: isHavaEmail 
	 * @Description: 检查当前用户是否已经注册邮箱或者手机号
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月5日上午11:12:45
	 */
	@RequestMapping(value="/isHavaEmailOrPhone",method = RequestMethod.POST)
	@ResponseBody
	public String isHavaEmailOrPhone(HttpServletRequest request){
		String uid = null;
		//uid = this.needLogin(request);
		  uid = super.getUserId();
		String type = request.getParameter("type");
		if(type == null && Common.isEmpty(type)){
			return AjaxMsg.newWarn().addMessage("查询类型出错").toJson();
		}
		AjaxMsg msg = systemSettingsService.isHavaEmailOrPhone(type,uid);
		return  msg.toJson();
	}
	
	/**
	 * @Title: sendActivationUrl 
	 * @Description: 发送邮箱激活链接 
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月4日上午9:57:18
	 */
	@RequestMapping(value="/sendActivationUrl",method = RequestMethod.POST)
	@ResponseBody
	public String sendActivationUrl(HttpServletRequest request){
		String sCodeEmail = Common.getSecurityCode(6);
		Long sendTimeEmail = new Date().getTime();
		String email = request.getParameter("email");
		
		//获取带部署环境上下文的域名，如： http://localhost:7070/yt/
		StringBuffer url = request.getRequestURL();  
		url = url.delete(url.length() - request.getRequestURI().length(), url.length()).append(request.getServletContext().getContextPath()).append("/system/updateEmail?");
		url.append("c="+sCodeEmail).append("&d="+sendTimeEmail).append("&e="+email);
		
		AjaxMsg msg = systemSettingsService.sendEmail(url.toString(), email);
		if(msg.isSuccess()){
			Common.setSessionValue("sCodeEmail", sCodeEmail);
			Common.setSessionValue("sendTimeEmail", sendTimeEmail);
			Common.setSessionValue("email", email);
		}
		
		return msg.toJson();
	}
	
	@RequestMapping(value="/updateEmail",method = RequestMethod.GET)
	public String updateEmail(HttpServletRequest request,@RequestParam("c") String code,@RequestParam("e") String email){
		AjaxMsg msg = systemSettingsService.checkCode(code, email,request.getSession());
		String uid = null;
		User resouce_user = null;
		if(msg.isSuccess()){
			//uid = this.needLogin(request);
			uid = super.getUserId();
			//数据库user信息
			resouce_user = userService.getEntityById(uid);
			resouce_user.setEmail(email);
			msg = userService.update(resouce_user);
		}else{
			return msg.toJson();
		}
		
		if(msg.isSuccess()){
			logger.info(uid+":"+resouce_user.getUsername()+"更新邮箱为："+email+"成功");
			//跳转至激活成功页面
			return "system/activesuccess";
		}else{
			logger.error(uid+":"+resouce_user.getUsername()+"更新邮箱为："+email+"失败");
			//跳转至激活失败页面
			return "system/activefail";
		}
	}
	
	/**
	 * @Title: sendSecurityCode 
	 * @Description: 发送验证码（4位）
	 * @param @param request
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月6日下午3:04:21
	 */
	@RequestMapping(value="/sendSecurityCode",method = RequestMethod.POST)
	@ResponseBody
	public String sendSecurityCode(HttpServletRequest request){
		String receiver = request.getParameter("username"); 
		//生成4位验证码
		String sCode = Common.getSecurityCode(6);
		Long sendTime = new Date().getTime();
		AjaxMsg msg = null;
		//接收人不能为空
		if(receiver == null ){
			return AjaxMsg.newError().addMessage("验证码接收人不能为空").toJson();
		}
		//校验接收人为手机号或者为邮箱
		if(Common.isEmail(receiver)){
			msg = systemSettingsService.sendEmail("您本次的验证码为：<font color='blue'>"+sCode+"</font>,请在10分钟内完成验证。", receiver);
		}else if(Common.isMobile(receiver)){
			msg = SendMsg.getInstance().sendSMS(receiver, sCode+"请在10分钟内完成验证");
		}else{
			return AjaxMsg.newError().addMessage("接收人只能为手机号或者邮箱").toJson();
		}
		if(msg.isSuccess()){
			Common.setSessionValue("sCode", sCode);
			Common.setSessionValue("sendTime", sendTime);
			Common.setSessionValue("receiver", receiver);
			return msg.toJson();
		}else{
			return AjaxMsg.newError().addMessage("发送验证码失败").toJson();
		}
	}
	
	
	/**
	 * 绑定手机或修改绑定手机页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20上午10:53:00
	 */
	@RequestMapping(value="phonePage")
	public String phonePage(Model model,HttpServletRequest request){
		User user = (User) super.getUser();
		String phone_num = user.getPhone();//当前手机号码
		//通过手机获取用户基本信息	
		model.addAttribute("user", user);
		if(StringUtils.isBlank(phone_num)){
			return "system/phone/bind_phone";
		}else{
			return "system/phone/modify_phone";
		}
	}
	
	/**
	 * 获取验证码
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:06:37
	 */
	@RequestMapping(value="/getCode")
	public @ResponseBody String sendCode(HttpServletRequest request){
		String user_id = super.getUserId();
		AjaxMsg msg = AjaxMsg.newError();
		String name = request.getParameter("bindName");
		if(StringUtils.isBlank(name)) return msg.addMessage("请输入相应的号码").toJson();
		String type = request.getParameter("type");
		StringBuilder sb = new StringBuilder();//邮件文本信息
		String code = String.valueOf(Common.getRandomNum6());
		if(StringUtils.isBlank(type)){//绑定手机、邮箱号时调用以下方法
			User user = userService.getUserByPhoneOrEmail(name);
			if(user!=null) return msg.addMessage("该号已被绑定！").toJson();
			sb.append("尊敬的会员，您本次的验证码为：<font color='blue'>").append(code).append("</font></br>该信息10分钟内有效，请勿泄露。");
		}
		Common.setSessionValue(BINDTYPE.BINDNAME.toString(), name);
		if(Common.isEmail(name)){
			Common.setSessionValue(BINDTYPE.EMAIL.toString(), code);
			//设置邮件消息前缀
			if(StringUtils.isNotBlank(type) && type.equals("modify")){
				sb = new StringBuilder();
				sb.append("尊敬的会员，您本次的验证码为：<font color='blue'>").append(code).append("</font></br>该信息10分钟内有效，请勿泄露。");
			}else if(StringUtils.isNotBlank(type) && type.equals("email_link")){
				//判断新邮箱是否已被绑定
				User user = userService.getUserByPhoneOrEmail(name);
				if(user!=null) return msg.addMessage("该号已被绑定！").toJson();
				
				sb = new StringBuilder();
				Properties properties = PropertiesUtils.loadSetting("/messages/common.properties");
				String base_url =String.valueOf(properties.get("system.base.url"));
				StringBuilder href= new StringBuilder();
				href.append(base_url).append("/system/activation/?sendTime=").append(Common.formatDate(new Date(), "yyyy-MM-dd HH:mm")).append("&email=").append(name).append("&user_id=").append(user_id);
				sb.append("尊敬的会员，请点击<a href='"+href+"' target='_blank'>激活</a>按钮来完成邮箱绑定").append("</br>该信息2小时内有效，请勿泄露。");
			}
			
			msg = systemSettingsService.sendEmail(sb.toString(), name);
		}else if(Common.isMobile(name)){
			Common.setSessionValue(BINDTYPE.PHONE.toString(), code);
			msg = SendMsg.getInstance().sendSMS(name, code+"该验证码10分钟内有效");
		}
	
		return msg.toJson();
	}
	
	/**
	 * 校验验证码是否相等
	 *@param code 验证码
	 *@param name 手机或邮箱
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21上午11:01:04
	 */
	@RequestMapping(value="/valid")
	public @ResponseBody String validateCode(HttpServletRequest request){
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(name) || StringUtils.isBlank(code)) return msg.addMessage("手机号或验证码为空！").toJson();
		
		msg = userService.validateCode(request, name, code);
		
		return msg.toJson();
	}
	
	/**
	 * 清除验证码code值
	 *@param request
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:54:19
	 */
	@RequestMapping(value="removeCode")
	public @ResponseBody String removeCode(HttpServletRequest request){
		String name = request.getParameter("bindName");
		if(Common.isEmail(name)){
			Common.removeSessionValue(BINDTYPE.EMAIL.toString());
		}else if(Common.isMobile(name)){
			Common.removeSessionValue(BINDTYPE.PHONE.toString());
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 绑定手机
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:00:12
	 */
	@RequestMapping(value="/bindPhone")
	public @ResponseBody String bindPhone(HttpServletRequest request){
		String user_id =super.getUserId();
		String phone = request.getParameter("phone");
		String code = request.getParameter("code");
		AjaxMsg msg = userService.bindPhone(request,user_id,phone, code);
		return msg.toJson();
	}
	
	/**
	 * 绑定、修改绑定邮箱页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21下午4:07:46
	 */
	@RequestMapping(value="/emailPage")
	public String emailPage(Model model,HttpServletRequest request){
		//String email = request.getParameter("email");//当前邮箱号码
		User user = super.getUser();
		String email = user.getEmail();//当前手机号码
		//通过手机获取用户基本信息
		model.addAttribute("user", user);
		if(StringUtils.isBlank(email)){
			return "system/email/bind_email";
		}else{
			return "system/email/modify_email";
		}
	}
	
	/**
	 * 绑定邮箱
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21下午4:09:10
	 */
	@RequestMapping(value="/bindEmail")
	public @ResponseBody String bindEmail(HttpServletRequest request){
		String user_id =super.getUserId();
		String email = request.getParameter("email");
		String code = request.getParameter("code");
		AjaxMsg msg = userService.bindEmail(request, user_id, email, code);
		return msg.toJson();
	}
	
	/**
	 * 通过点击链接来激活重新绑定邮箱
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21下午5:02:34
	 */
	@RequestMapping(value="/activation",method=RequestMethod.GET)
	public String activationEmail(Model model,HttpServletRequest request){
		String sendTime = request.getParameter("sendTime");//发送时间
		String user_id = request.getParameter("user_id");//用户ID
		String email = request.getParameter("email");//邮箱
		
		if(StringUtils.isNotBlank(user_id) && StringUtils.isNotBlank(sendTime)){
			String pattern= "yyyy-MM-dd HH:mm";
			Date nowDate = new Date();
			Date sendDate = Common.parseStringDate(sendTime, pattern);
			long times = (nowDate.getTime()-sendDate.getTime())/60000;//获取到分钟数
			if(times>120){
				model.addAttribute("msg", "该链接失效，请重新绑定！");
			}else{
				User u = userService.getUserByPhoneOrEmail(email);
				if(u!=null){
					 model.addAttribute("msg", "该邮箱已被绑定，请重新绑定");
				}
				User user = userService.getEntityById(user_id);
				if(user!=null){
					 user.setEmail(email);
					 AjaxMsg msg = userService.update(user);
					 if(msg.isSuccess()){
						 model.addAttribute("msg", "绑定成功");
					 }else{
						 model.addAttribute("msg", "绑定失败，请重新绑定");
					 }
				}else{
					model.addAttribute("msg", "绑定失败，请重新绑定");
				}
			}
			
		}else{
			model.addAttribute("msg", "绑定失败，请重新绑定！");
		}
		
		return "system/email/modify_success";
	}
	
	/**
	 * 用户接受短信设置
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="settingSms")
	public String settingSms(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		User user = userService.getEntityById(user_id);
		model.addAttribute("user", user);
		return "system/settingSms";
	}

	@RequestMapping(value="updateSms")
	public @ResponseBody String updateSms(HttpServletRequest request){
		User user = userService.getEntityById(super.getUserId());
		user.setReceive_sms(Integer.valueOf(request.getParameter("receive_sms")));
		return userService.update(user).toJson();
	}
	
}

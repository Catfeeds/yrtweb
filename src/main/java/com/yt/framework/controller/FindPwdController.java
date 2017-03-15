package com.yt.framework.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.SystemSettingsService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.Md5Encrypt;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *找回密码
 *@autor bo.xie
 *@date2015-9-3上午10:59:02
 */
@Controller
@RequestMapping(value="/find/")
public class FindPwdController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(FindPwdController.class);
	
	@Autowired
	private UserService userService;
	@Autowired
	private SystemSettingsService systemSettingsService;

	/**
	 * 找回密码页面
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-3上午10:59:58
	 */
	@RequestMapping(value="way")
	public String findPwdIndex(HttpServletRequest request){
		
		return "findpwd/findPwd_way";
	}
	
	@RequestMapping(value="isway/{way}",method=RequestMethod.GET)
	public String findPwdByWay(HttpServletRequest request,@PathVariable("way")String way){
		if(way.equals("phone")){
			return "findpwd/findPwd_phone";
		}else if(way.equals("email")){
			return "findpwd/findPwd_email";
		}
		return null;
	}
	
	/**
	 * 获取验证码
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:06:37
	 */
	@RequestMapping(value="getCode")
	public @ResponseBody String sendCode(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String name = request.getParameter("bindName");
		if(StringUtils.isBlank(name)) return msg.addMessage("请输入相应的号码").toJson();
		User user = userService.getUserByPhoneOrEmail(name);
		String code = String.valueOf(Common.getRandomNum6());
		if(Common.isEmail(name)){
			if(user==null) return msg.addMessage("该邮箱没有注册").toJson();
			StringBuilder sb = new StringBuilder();//邮件文本信息
			sb.append("尊敬的会员，您本次的验证码为：").append(code).append("该信息10分钟内有效，请勿泄露。如有问题请联系：4000-777-366");
			msg = systemSettingsService.sendEmail(sb.toString(), name);
		}else if(Common.isMobile(name)){
			if(user==null) return msg.addMessage("该手机号没有注册").toJson();
			
			msg = SendMsg.getInstance().sendSMS(name, code+"该验证码10分钟内有效");
		}else{
			return msg.addMessage("请输入正确格式的号码！").toJson();
		}
		Common.setSessionValue("FINDPWD", code);
		Common.setSessionValue("FINDWNAME", name);
		
		return msg.toJson();
	}
	
	/**
	 * 清除找回密码验证码code值
	 *@param request
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:54:19
	 */
	@RequestMapping(value="removeCode")
	public @ResponseBody String removeCode(HttpServletRequest request){
		Common.removeSessionValue("FINDPWD");
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 校验验证码
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-3下午2:38:03
	 */
	@RequestMapping(value="valid")
	public @ResponseBody String validateCodeNum(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String name = request.getParameter("name");//电话号码或者邮箱号码
		String codeNum = request.getParameter("codeNum");//前台传来验证码code
		String sessionName = String.valueOf(Common.getCurrentSessionValue(request, "FINDWNAME"));//获取session中获取验证码的手机或者邮箱
		String sessionCodeNum = String.valueOf(Common.getCurrentSessionValue(request, "FINDPWD"));//获取找回密码存于session的值
		if(StringUtils.isBlank(name) || StringUtils.isBlank(codeNum)) return msg.addMessage("请完整填写参数！").toJson();
		if(Common.isEmail(name)){
			if(!name.equals(sessionName)) return msg.addMessage("邮箱与获取验证码的邮箱不一致！").toJson();
		}else if(Common.isMobile(name)){
			if(!name.equals(sessionName)) return msg.addMessage("手机号与获取验证码的手机号不一致！").toJson();
		}else{
			return msg.addMessage("请输入正确格式的号码！").toJson();
		}
		
		if(!codeNum.equals(sessionCodeNum))return msg.addMessage("验证码输入错误！").toJson();
		
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 重置密码页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-3下午3:03:59
	 */
	@RequestMapping(value="rePwd")
	public String rePwdPage(Model model,HttpServletRequest request){
		String name = request.getParameter("name");
		Boolean flag = false;//是否是邮箱 false:手机 true:邮箱
		if(Common.isEmail(name))flag = Boolean.TRUE;
		model.addAttribute("name", name);
		model.addAttribute("flag", flag);
		return "findpwd/findPwd_modify";
	}
	
	/**
	 * 重置密码
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-3下午3:29:51
	 */
	@RequestMapping(value="updatePwd")
	public @ResponseBody String updatePwd(HttpServletRequest request){
		String name = request.getParameter("name");
		String newpwd = request.getParameter("newPwd");
		String repwd = request.getParameter("rePwd");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(newpwd) || StringUtils.isBlank(repwd)) return msg.addMessage("密码不能为空").toJson();
		if(!newpwd.equals(repwd)) return msg.addMessage("两次输入的密码不一致！").toJson();
		User user = userService.getUserByPhoneOrEmail(name);
		user.setPassword(Md5Encrypt.md5(newpwd));
		msg = userService.update(user);
		return msg.toJson();
	}
	
	/**
	 * 重置结果页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-3下午4:02:20
	 */
	@RequestMapping(value="result",method = RequestMethod.GET)
	public String resultPage(Model model,HttpServletRequest request){
		String status = request.getParameter("status");
		model.addAttribute("status", status);
		return "findpwd/findPwd_result";
	}
}

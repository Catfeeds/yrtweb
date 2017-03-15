package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.UserMapper;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.SystemSettingsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.emailSend.EmailNoticeDto;
import com.yt.framework.utils.emailSend.MailService;

/**
 * @ClassName: SystemSettingsServiceImpl 
 * @Description: 系统设置 
 * @author zjh
 * @date 2015年8月5日 上午11:21:47 
 *
 */
@Service("systemSettingsService")
public class SystemSettingsServiceImpl extends BaseServiceImpl<User> implements SystemSettingsService {
	
	protected static Logger logger = LogManager.getLogger(SystemSettingsServiceImpl.class);
	
	@Autowired
	private UserMapper userMapper;
	/**
	 * 根据ID查询用户是否注册邮箱或者手机号
	 */
	@Override
	public AjaxMsg isHavaEmailOrPhone(String type,String id) {
		User user = userMapper.getEntityById(id);
		AjaxMsg msg = null;
		if(type.equals("phone")){
			String phone = user.getPhone();
			if(Common.isEmpty(phone) ){
				msg = AjaxMsg.newError().addMessage("手机号为空，需设置");
			}else{
				msg = AjaxMsg.newSuccess().addMessage("已存在手机号，只能进行修改");
			}
		}else if(type.equals("email")){
			String email = user.getEmail();
			if(Common.isEmpty(email) ){
				msg = AjaxMsg.newError().addMessage("邮箱为空，需设置");
			}else{
				msg = AjaxMsg.newSuccess().addMessage("已存在邮箱，只能进行修改");
			}
			
		}
		return msg;
	}

	/**
	 * @Title: sendEmail 
	 * @Description: 发送邮件 
	 * @param @param txt
	 * @param @param addressee
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月4日上午10:30:11
	 */
	public AjaxMsg sendEmail(String txt,String addr){
		EmailNoticeDto emailDto = new EmailNoticeDto();
		List<String> sendTo=new ArrayList<String>();
		sendTo.add(addr);
		emailDto.setSendTo(sendTo);
		emailDto.setText(txt);
		try {
			MailService.getInstance().send(emailDto);
			return AjaxMsg.newSuccess().addMessage("邮件发送成功");
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("邮件发送失败");
		}
	}
	
	/**
	 * @Title: checkCode 
	 * @Description: 校验验证码是否正确，以及它的有效性 
	 * @param @param code 验证码
	 * @param @param date 时间
	 * @param @param txt 需要更新的email/phone
	 * @param @param type email?phone
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月4日上午10:20:33
	 */
	public AjaxMsg checkCode(String code,String txt,HttpSession session){
		Long sys_date = new Date().getTime();
		//phone
		String sCode = (String) session.getAttribute("sCode");
		Long sendTime = (Long) session.getAttribute("sendTime");
		String receiver = (String) session.getAttribute("receiver");
		
		//验证码有效时间10min(10*60*1000)
		long activeTime = 10*60*1000;
		//正确性
		if(!code.toLowerCase().equals(sCode)){
			return AjaxMsg.newError().addMessage("验证码错误");
		}
		//电话号码是否相同
		if(!txt.equals(receiver)){
			return AjaxMsg.newError().addMessage("号码前后不一致");
		}
		//有效性
		if(sys_date-sendTime>activeTime){
			return AjaxMsg.newError().addMessage("验证码失效");
		}
		removeSessionParameters();
		return AjaxMsg.newSuccess().addMessage("验证通过");
	}
	
	/**
	 * @Title: removeSessionParameters 
	 * @Description: 移除session中存储的与验证码有关的内容 
	 * @param     设定文件 
	 * @return void    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月4日下午1:51:22
	 */
	private void removeSessionParameters(){
		//phone
		Common.removeSessionValue("sCodePhone");
		Common.removeSessionValue("sendTimePhone");
		Common.removeSessionValue("phone");
		
		//email
		Common.removeSessionValue("sCodeEmail");
		Common.removeSessionValue("sendTimeEmail");
		Common.removeSessionValue("email");
	}
	
}

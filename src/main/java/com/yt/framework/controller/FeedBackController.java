package com.yt.framework.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.FeedBack;
import com.yt.framework.service.FeedBackService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PropertiesUtils;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.emailSend.EmailNoticeDto;
import com.yt.framework.utils.emailSend.MailService;

/**
 *一键反馈
 *@autor bo.xie
 *@date2015-8-19下午5:02:43
 */
@Controller
@RequestMapping(value="/feedback/")
public class FeedBackController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(FeedBackController.class);

	@Autowired
	private FeedBackService feedBackService;
	
	@RequestMapping(value="save",method=RequestMethod.POST)
	public @ResponseBody String saveFeedBack(HttpServletRequest request){
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String content = request.getParameter("content");
		String image_url = request.getParameter("image_url");
		String ip_str = Common.toIpAddr(request);//访问IP
		
		FeedBack feedBack = new FeedBack();
			feedBack.setId(UUIDGenerator.getUUID());
			feedBack.setContent(content);
			feedBack.setEmail(email);
			feedBack.setImage_url(image_url);
			feedBack.setIp_str(ip_str);
			feedBack.setName(name);
			feedBack.setPhone(phone);
		AjaxMsg msg = feedBackService.save(feedBack);
		if(msg.isSuccess()){
			EmailNoticeDto emailDto = new EmailNoticeDto();
			List<String> sendTo = new ArrayList<String>();
			String mail = PropertiesUtils.loadSetting("/messages/common.properties").getProperty(
					"mail.receive");
			String[] mails = mail.split(",");
			for (String str : mails) {
				sendTo.add(str);
			}
			String mail_content = "<span>姓 名:"+name+"</span></br>"+
								  "<span>联系电话:"+phone+"</span></br>"+
								  "<span>邮箱地址:"+email+"</span></br>"+
								  "<span>反馈意见:"+content+"</span></br>"+
								  "<span>上传图片:</br><img src='"+request.getRequestURI()+image_url+"'></img></span>";
			System.out.println(request.getRequestURI());
			System.out.println(request.getSession().getServletContext().getRealPath("/"));
			emailDto.setSendTo(sendTo);
			emailDto.setText(mail_content);
			try {
				MailService.getInstance().send(emailDto);
			} catch (Exception e) {
				return AjaxMsg.newError().addMessage("邮件发送失败").toJson();
			}
		}
		return msg.toJson();
	}
}

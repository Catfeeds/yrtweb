package com.yt.framework.utils.emailSend;

import java.util.ArrayList;
import java.util.List;


public class MailTest {

	public static void main(String[] args) {
		String strScore = "测试内容";
		EmailNoticeDto emailDto = new EmailNoticeDto();
		List<String> sendTo=new ArrayList<String>();
//		sendTo.add("yejinghua@net-future.com.cn");
		sendTo.add("306912728@qq.com");
		emailDto.setSendTo(sendTo);
		emailDto.setText(strScore);
		MailService.getInstance().send(emailDto);
	}
}

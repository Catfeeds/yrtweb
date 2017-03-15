package com.yt.framework.utils.emailSend;

import java.io.Serializable;

public class EmailNoticeDto extends EmailDto implements Serializable{

	private static final long serialVersionUID = 1L;

	private String text2;
	
	public EmailNoticeDto() {
		super();
//		SysConfig conf = new SysConfig();
//		this.subject = conf.getString("mail.send.title");
		this.text2 = "";
	}

	public String getText2() {
		return text2;
	}

	public void setText2(String text2) {
		this.text2 = text2;
	}

	

}

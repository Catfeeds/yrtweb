package com.yt.framework.utils.emailSend;

import java.io.Serializable;
import java.io.StringWriter;
import java.net.URL;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;



public abstract class EmailDto implements Serializable{
	
	static Logger logger = LogManager.getLogger(EmailDto.class.getName());
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String subject;
	protected String mailSubject;
	protected String dataCreated;
	protected String text;
	protected String text2;
	protected List<String> sendTo;
	protected String filepath;
	protected String filename;
	
	
	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getFilepath() {
		return filepath;
	}


	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}


	public String getText2() {
		return text2;
	}


	public void setText2(String text2) {
		this.text2 = text2;
	}


	public String getText() {
		return text;
	}


	public void setText(String text) {
		this.text = text;
	}


	public static String formatDate(java.util.Date date, String format) {
		if (date == null) {
			return "";
		}
		try {
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
					format);
			return dateFormat.format(date);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return "";
	}


	public EmailDto() {
		this.subject = "标题";
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDataCreated() {
		return dataCreated;
	}

	public void setDataCreated(String dataCreated) {
		this.dataCreated = dataCreated;
	}


	public List<String> getSendTo() {
		return sendTo;
	}


	public void setSendTo(List<String> sendTo) {
		this.sendTo = sendTo;
	}


	public String getMailSubject() {
		return mailSubject;
	}

	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}


	public String getContextTemplate(String tp) throws Exception {
		String text;
		Properties configPro = new Properties();
		configPro.setProperty(VelocityEngine.ENCODING_DEFAULT, "UTF-8");
		configPro.setProperty(VelocityEngine.INPUT_ENCODING, "UTF-8");
		configPro.setProperty(VelocityEngine.OUTPUT_ENCODING, "UTF-8");
		URL uri = Properties.class.getResource("/");// 控制台运行有值
		if (uri == null)
			uri = this.getClass().getClassLoader().getResource("/");// web运行有值
		configPro.setProperty(VelocityEngine.FILE_RESOURCE_LOADER_PATH,
				uri.getPath());// 模板所在路径
		StringWriter sw = new StringWriter();
		VelocityEngine ve=new VelocityEngine();
		ve.init(configPro);
		VelocityContext context = new VelocityContext();
		context.put("M", this);

		Template t = ve.getTemplate(tp);
		t.setEncoding("UTF-8");
		t.merge(context, sw);
		text = sw.toString();
		return text;
	}

	public String getContext() {
		String text = ".";
		try {
			text = getContextTemplate("Email_Template.html");
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return text;
	}

}

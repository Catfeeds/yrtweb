package com.yt.framework.utils.emailSend;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.entity.MsgHistory;
import com.yt.framework.service.CommonService;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PropertiesUtils;
import com.yt.framework.utils.SpringContextUtil;


/**
 * 
 * @author Administrator
 * 
 */
public class MailService {
	static Logger logger = LogManager.getLogger(MailService.class.getName());
	private static final String COMMON="/messages/common.properties";
	private String rootDir;
	private String displayName;
	private String smtpServer;
	private String formEmail;
	private String auth;
	private boolean ifAuth = true;
	static MailService mailService = null;
	private CommonService commonService;
	
	public MailService() {
		Properties pro = PropertiesUtils.loadSetting(COMMON);
		displayName = String.valueOf(pro.get("mail.send.displayName"));
		smtpServer =  String.valueOf(pro.get("mail.send.smtpServer"));
		formEmail = String.valueOf(pro.get("mail.send.formEmail"));
		auth = String.valueOf(pro.get("mail.send.auth"));
		rootDir = String.valueOf(pro.get("app.upload.dir"));
		commonService = (CommonService) SpringContextUtil.getBean("commonService");
	}

	public static MailService getInstance() {
		if (mailService == null)
			mailService = new MailService();
		return mailService;
	}

	/**
	 * 发送邮件
	 */
	public void send(EmailDto emailDto) {
		saveEmailToHtmlFile(emailDto);
		

		List<String> tos = emailDto.getSendTo();	
		int ls = tos.size();
		if(ls==0){
			logger.info("收件人为空,邮件取消发送");
			return ;
		}
		
		Session session = null;
		SmtpAuth smtpAuth = new SmtpAuth(auth);
		final String username = smtpAuth.getUsername();
		final String password = smtpAuth.getPassword();
		Properties props = System.getProperties();
		props.put("mail.smtp.host", smtpServer);
		if (ifAuth) { // 服务器需要身份认证
			props.put("mail.smtp.auth", "true");
//			session = Session.getDefaultInstance(props, smtpAuth);
			session = Session.getInstance(props,new Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username,password);}});
		} else {
			props.put("mail.smtp.auth", "false");
			session = Session.getDefaultInstance(props, null);
		}
		session.setDebug(false);
		Transport trans = null;
		try {
			Message msg = new MimeMessage(session);
			try {
				Address from_address = new InternetAddress(formEmail,
						encodeText(displayName));
				msg.setFrom(from_address);
			} catch (java.io.UnsupportedEncodingException e) {
				logger.error(e.getLocalizedMessage(), e);
			}		 
			msg.setSubject(encodeText(emailDto.getSubject()));
			Multipart mp = new MimeMultipart();
			MimeBodyPart mbp = null;
			MimeBodyPart bodyTextMbp = null;
			if(emailDto.getFilepath() != null){
				mbp = new MimeBodyPart();
				bodyTextMbp = new MimeBodyPart();
				bodyTextMbp.setText(emailDto.getText());
				bodyTextMbp.setContent(emailDto.getContext(),"text/html;charset=utf-8");
				mbp.setContent(emailDto.getContext(),"text/html;charset=utf-8");
				File file = new File(emailDto.getFilepath());
				DataSource source = new FileDataSource(file);
				mbp.setDataHandler(new DataHandler(source));//设置附件
				//sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
				//mbp.setFileName("=?UTF8?B?"+enc.encode("feedback.jpg".getBytes())+"?=");//设置文件名编码
				mbp.setFileName(MimeUtility.encodeWord(file.getName()));
				
				mp.addBodyPart(bodyTextMbp);
				mp.addBodyPart(mbp);
			}else{
				bodyTextMbp = new MimeBodyPart();
				bodyTextMbp.setContent(emailDto.getContext(),"text/html;charset=utf-8");
				mp.addBodyPart(bodyTextMbp);
			}
			msg.setContent(mp);
			msg.setSentDate(new Date());
			msg.saveChanges();
			trans = session.getTransport("smtp");
			trans.connect(smtpServer, username, password);
			InternetAddress[] intAddr = new InternetAddress[tos.size()];
			StringBuilder sb = new StringBuilder();
			for(int i=0;i<ls;i++){
				intAddr[i]=new InternetAddress(tos.get(i));
				sb.append(tos.get(i)).append(";");
			}
			msg.setRecipients(Message.RecipientType.TO, intAddr);
			trans.sendMessage(msg, intAddr);
			logger.info("Send mail to :"+sb.toString());
			trans.close();
			
			for(int i=0;i<ls;i++){
				MsgHistory history = new MsgHistory();//保存历史记录
				history.setEmail(tos.get(i));
				history.setContent(emailDto.getText());
				history.setType(2);
				history.setResult("");
				commonService.saveMsgHistory(history);
			}
			
		} catch (MessagingException e) {
			logger.info(e.getLocalizedMessage()+"[本机发送邮件失败,将使用邮件转发服务]");
		}catch (Exception e) {
			logger.error(e.getLocalizedMessage(),e);
		}
	}
	public String encodeText(String txt){
		try {
			return MimeUtility.encodeText(txt, "UTF-8", "B");
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return txt;
	}

	private void saveEmailToHtmlFile(EmailDto emailDto) {
		String filePath= rootDir;
		String tfn=Common.formatDate(new Date(), "yyyyMMddHHmmss")+".html";
		
		if(emailDto instanceof EmailNoticeDto){
			filePath+="mail_"+tfn;
		}else{
			filePath+=tfn;
		}
		
		List<String> strList =new ArrayList<String>();
		strList.add(emailDto.getContext());
		writerFileUTF8(filePath, strList);
	}
	
	public  void writerFileUTF8(String filePath, List<String> strList) {
		try {
			FileOutputStream fos = new FileOutputStream(filePath);
			OutputStreamWriter osw = new OutputStreamWriter(fos,"UTF-8");
			BufferedWriter bw = new BufferedWriter(osw);
			for (String str : strList) {
				bw.write(str);
				bw.newLine();
			}
			bw.close();
		} catch (IOException e) {
			logger.error(e.getLocalizedMessage(),e);
		}

	}
	
	public static void main(String[] args) {
			String strScore = "测试内容123123123123";
			EmailNoticeDto emailDto = new EmailNoticeDto();
			List<String> sendTo=new ArrayList<String>();
//			sendTo.add("yejinghua@net-future.com.cn");
			sendTo.add("2774803381@qq.com");
			emailDto.setSendTo(sendTo);
			emailDto.setText(strScore);
			emailDto.setSubject("邮件测试");
			MailService.getInstance().send(emailDto);
	}
}
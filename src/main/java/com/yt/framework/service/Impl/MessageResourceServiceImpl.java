package com.yt.framework.service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;

import org.apache.commons.lang.LocaleUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.TeamDynamic;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.EhCache;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.http.HttpRequestUtil;

/**
 *国际化文件操作实现类
 *@autor ylt
 *@date2015-8-11下午5:01:15
 */
@Transactional
@Service("messageResourceService")
public class MessageResourceServiceImpl extends BaseServiceImpl<Message> implements MessageResourceService,ServletContextAware{
	
	protected static Logger logger = LogManager.getLogger(MessageResourceServiceImpl.class);
	
	@Autowired
	DynamicService dynamicService;
	 
	private ServletContext servletContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
	public WebApplicationContext getWebApplicationContext(){
		return WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}
	
	public AjaxMsg saveTeamDynamicMessage(Object[] obj,String type,String teaminfo_id)throws Exception{
		//保存俱乐部动态
		TeamDynamic teamDynamic = new TeamDynamic();
		teamDynamic.setId(UUIDGenerator.getUUID());
		String message = this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale());
		System.out.println(message);
		teamDynamic.setText(message);
		teamDynamic.setTeaminfo_id(teaminfo_id);
		dynamicService.saveTeamDynamic(teamDynamic);
		return  AjaxMsg.newSuccess();
	}
	
	public AjaxMsg saveUserDynamicMessage(Object[] obj, String type, String user_id) throws Exception {
		Dynamic dynamic = new Dynamic();
		dynamic.setId(UUIDGenerator.getUUID());
		dynamic.setUser_id(user_id);
		dynamic.setType(0);//设置type为个人动态
		String message = this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale());
		dynamic.setText(message); 
		dynamic.setCreate_time(new Date());
	    AjaxMsg reMsg = dynamicService.save(dynamic);
	    EhCache.getInstance().addDymsg(dynamicService.transformationDynamic(dynamic));
	   	if(reMsg.isError()) logger.error("error:dynamic is error");
		return  AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg saveMessage(Object[] obj,String enumType,String type,String user_id,String s_user_id,String relate_id,Integer sys_type) throws Exception{
		List<Message> msgs = messageMapper.queryMsg(user_id,s_user_id,enumType);
		if(msgs!=null&&msgs.size()>0){
			String message = this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale());
			return AjaxMsg.newError().addMessage(message);
		}else{
			Message message = new Message();
			message.setId(UUIDGenerator.getUUID());
			message.setUser_id(user_id);
			message.setS_user_id(s_user_id);
			message.setContent(this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale()));
			message.setType(enumType);
			message.setRelate_id(relate_id);
			message.setM_style(1);
			message.setSys_type(sys_type);
			messageMapper.save(message);
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg saveMessageNoReply(Object[] obj,String type,String user_id,String s_user_id,Integer sys_type) throws Exception{
		Message message =new Message();
		message.setId(UUIDGenerator.getUUID());
		message.setUser_id(user_id);
		message.setS_user_id(s_user_id);
		message.setContent(this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale()));
		message.setType(type);
		message.setM_style(1);
		message.setSys_type(sys_type);
		messageMapper.save(message);
		return AjaxMsg.newSuccess();
	}
	
	public AjaxMsg saveCNUserDynamicMessage(Object[] obj, String type, String user_id) throws Exception {
		Dynamic dynamic = new Dynamic();
		dynamic.setId(UUIDGenerator.getUUID());
		dynamic.setUser_id(user_id);
		dynamic.setType(0);//设置type为个人动态
		String message = this.getWebApplicationContext().getMessage(type,obj,LocaleUtils.toLocale("zh_CN"));
		dynamic.setText(message); 
		dynamic.setCreate_time(new Date());
	    AjaxMsg reMsg = dynamicService.save(dynamic);
	    EhCache.getInstance().addDymsg(dynamicService.transformationDynamic(dynamic));
	   	if(reMsg.isError()) logger.error("error:dynamic is error");
		return  AjaxMsg.newSuccess();
	}
	
	
	@Override
	public AjaxMsg saveCNMessageNoReply(Object[] obj,String type,String user_id,String s_user_id,Integer sys_type) throws Exception{
		Message message =new Message();
		message.setId(UUIDGenerator.getUUID());
		message.setUser_id(user_id);
		message.setS_user_id(s_user_id);
		message.setContent(this.getWebApplicationContext().getMessage(type,obj,LocaleUtils.toLocale("zh_CN")));
		message.setType(type);
		message.setM_style(1);
		message.setSys_type(sys_type);
		messageMapper.save(message);
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public String getMessage(String type) {
		return this.getWebApplicationContext().getMessage(type,null,HttpRequestUtil.getLocale());
		
	}
	
	
	@Override
	public String getMessage(Object[] obj,String type) {
		return this.getWebApplicationContext().getMessage(type,obj,HttpRequestUtil.getLocale());
		
	}

	
}

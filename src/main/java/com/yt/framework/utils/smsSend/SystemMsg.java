package com.yt.framework.utils.smsSend;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.SpringContextUtil;

/**
 *短信发送工具
 *@autor bo.xie
 *@date2015-7-24上午11:46:16
 */
public class SystemMsg{
	static Logger logger = LogManager.getLogger(SystemMsg.class.getName());
	public static SystemMsg systemMsg = null;
	private MessageResourceService messageResourceService;
	
	public SystemMsg() {
		messageResourceService = (MessageResourceService) SpringContextUtil.getBean("messageResourceService");
	}

	public static SystemMsg getInstance() {
		if (systemMsg == null)
			systemMsg = new SystemMsg();
		return systemMsg;
	}
	
	/**
	 * 私信发送
	 *@param Map map
	 *@return
	 *@autor ylt
	 *@date2016-7-24上午11:47:46
	 */
	public AjaxMsg saveCNMessageNoReply(Object[] obj,String type,String user_id,String s_user_id,Integer sys_type) throws Exception{
		return messageResourceService.saveCNMessageNoReply(obj, type, user_id, s_user_id, sys_type);
	};
	
	/**
	 * 动态发送
	 *@param Map map
	 *@return
	 *@autor ylt
	 *@date2016-7-24上午11:47:46
	 */
	public AjaxMsg saveDynamicMessageNoReply(Object[] obj,String type,String user_id) throws Exception{
		return messageResourceService.saveCNUserDynamicMessage(obj, type, user_id);
	};
}

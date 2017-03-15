package com.yt.framework.service;

import com.yt.framework.utils.AjaxMsg;

/**
 *信息推送
 *@autor bo.xie
 *@date2015-8-18上午11:38:10
 */
public interface AutoInfoMationService {

	/**
	 * 信息内容推送
	 *@param user_id 信息接收者
	 *@param s_user_id 信息发送者
	 *@param msgType 用户、俱乐部、首页推送  具体值查看SystemEnum.MSGTYPE
	 *@param type 信息类型 SystemEnum.SYSTYPE
	 *@param content 信息内容
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-18上午11:40:34
	 */
	public AjaxMsg sendInfo(String user_id,String s_user_id,String msgType,String type,String content);
}

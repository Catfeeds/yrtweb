package com.yt.framework.service;

import com.yt.framework.persistent.entity.MessageRecords;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: MessageRecordsService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月21日 上午11:56:36 
 */
public interface MessageRecordsService extends BaseService<MessageRecords> {

	/**
	 * 查询最新20条推送消息
	 * @return AjaxMsg
	 */
	public AjaxMsg queryNewMsgRecord();
}

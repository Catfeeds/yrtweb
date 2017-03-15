package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.MessageRecords;
import com.yt.framework.service.MessageRecordsService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: MessageRecordsServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月21日 下午2:06:15 
 */
@Service(value="messageRecordsService")
public class MessageRecordsServiceImpl extends BaseServiceImpl<MessageRecords> implements MessageRecordsService{
	
	protected static Logger logger = LogManager.getLogger(MessageRecordsServiceImpl.class);

	@Override
	public AjaxMsg queryNewMsgRecord() {
		List<Map<String,Object>> records = messageRecordsMapper.queryNewMsgRecord();
		return AjaxMsg.newSuccess().addData("records", records);
	}

}

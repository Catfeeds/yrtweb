package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.MessageRecords;

/**
 * @Title: MessageRecordsMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月21日 上午11:55:44 
 */
public interface MessageRecordsMapper extends BaseMapper<MessageRecords>{

	public List<Map<String, Object>> queryNewMsgRecord();

}

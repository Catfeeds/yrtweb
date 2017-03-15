package com.yt.framework.service.Impl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.service.EventRecordService;
import com.yt.framework.service.MessageResourceService;

/**
 * @Title: PlayerInfoServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="eventRecordService")
public class EventRecordServiceImpl extends BaseServiceImpl<EventRecord> implements EventRecordService{
	static Logger logger = LogManager.getLogger(EventRecordServiceImpl.class.getName());
	
	@Autowired
	private MessageResourceService messageResourceService;
		

}

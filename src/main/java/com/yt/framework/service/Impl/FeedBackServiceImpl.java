package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.FeedBack;
import com.yt.framework.service.FeedBackService;

/**
 *一键反馈
 *@autor bo.xie
 *@date2015-8-19下午4:56:32
 */
@Transactional
@Service("feedBackService")
public class FeedBackServiceImpl extends BaseServiceImpl<FeedBack> implements FeedBackService{
	
	protected static Logger logger = LogManager.getLogger(FeedBackServiceImpl.class);

}

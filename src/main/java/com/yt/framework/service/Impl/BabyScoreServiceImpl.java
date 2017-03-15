package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.BabyScore;
import com.yt.framework.service.BabyScoreService;

/**
 * @Title: BabyInServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年9月24日 下午3:58:34 
 */
@Service(value="babyScoreService")
public class BabyScoreServiceImpl extends BaseServiceImpl<BabyScore> implements BabyScoreService{
	
	protected static Logger logger = LogManager.getLogger(BabyScoreServiceImpl.class);

	@Override
	public BabyScore getBabyScoreByIds(String user_id, String p_user_id) {
		return babyScoreMapper.getBabyScoreByIds(user_id, p_user_id);
	}

	@Override
	public double getBabyScoreAveByBabyUserID(String user_id) {
		return babyScoreMapper.getBabyScoreAveByBabyUserID(user_id);
	}


}

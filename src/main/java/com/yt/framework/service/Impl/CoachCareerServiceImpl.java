package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.CoachCareer;
import com.yt.framework.service.CoachCareerService;

/**
 *教练任职经历
 *@autor bo.xie
 *@date2015-8-7下午5:08:39
 */
@Transactional
@Service("coachCareerServer")
public class CoachCareerServiceImpl extends BaseServiceImpl<CoachCareer> implements
		CoachCareerService {
	
	protected static Logger logger = LogManager.getLogger(CoachCareerServiceImpl.class);

	@Override
	public List<CoachCareer> getCoachCareerListByUserId(String user_id) {
		return coachCareerMapper.getCoachCareerListByUserId(user_id);
	}

	
	

}

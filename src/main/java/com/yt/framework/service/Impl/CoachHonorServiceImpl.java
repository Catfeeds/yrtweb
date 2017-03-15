package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.CoachHonor;
import com.yt.framework.service.CoachHonorService;
/**
 *
 *@autor bo.xie
 *@date2015-8-7下午3:28:01
 */
@Transactional
@Service("coacheHonorServer")
public class CoachHonorServiceImpl extends BaseServiceImpl<CoachHonor> implements
		CoachHonorService {
	
	protected static Logger logger = LogManager.getLogger(CoachHonorServiceImpl.class);

	@Override
	public List<CoachHonor> getCoachHonorsByUserId(String user_id) {
		
		return coachHonorMapper.getCoachHonorsByUserId(user_id);
		
	}

}

package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.LeagueCost;
import com.yt.framework.service.LeagueCostService;

@Service("leagueCostService")
public class LeagueCostServiceImpl extends BaseServiceImpl<LeagueCost> implements LeagueCostService{
	
	protected static Logger logger = LogManager.getLogger(LeagueCostServiceImpl.class);

	@Override
	public LeagueCost getLeagueCostByUserId(String user_id, String league_id) {
		return leagueCostMapper.getLeagueCostByUserId(user_id, league_id);
	}

	@Override
	public LeagueCost getLeagueCostByOrderNo(String order_no) {
		return leagueCostMapper.getLeagueCostByOrderNo(order_no);
	}

}

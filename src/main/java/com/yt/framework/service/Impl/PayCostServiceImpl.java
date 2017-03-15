package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.service.PayCostService;

/**
 *消费记录
 *@autor bo.xie
 *@date2015-8-10下午3:27:31
 */
@Service("payCostService")
public class PayCostServiceImpl extends BaseServiceImpl<PayCost> implements PayCostService{
	
	protected static Logger logger = LogManager.getLogger(NewsServiceImpl.class);
	
	@Override
	public List<PayCost> getPayCostByUserId(String user_id) {
		return payCostMapper.getPayCostByUserId(user_id);
		
	}

}

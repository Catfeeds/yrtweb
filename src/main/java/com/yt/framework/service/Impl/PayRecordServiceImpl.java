package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PayRecord;
import com.yt.framework.service.PayRecordService;

/**
 *
 *@autor bo.xie
 *@date2015-8-10下午3:27:31
 */
@Service("payRecordService")
public class PayRecordServiceImpl extends BaseServiceImpl<PayRecord> implements PayRecordService{
	
	protected static Logger logger = LogManager.getLogger(PayRecordServiceImpl.class);

	@Override
	public List<PayRecord> getPayRecordByUserId(String user_id) {
		return payRecordMapper.getPayRecordByUserId(user_id);
		
	}

	@Override
	public PayRecord getPayRecordByOrderNo(String order_no) {
		return payRecordMapper.getPayRecordByOrderNo(order_no);
		
	}

}

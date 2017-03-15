package com.yt.framework.service;

import java.util.List;
import com.yt.framework.persistent.entity.PayRecord;

/**
 *
 *@autor bo.xie
 *@date2015-8-10下午3:26:09
 */
public interface PayRecordService extends BaseService<PayRecord>{
	
	/**
	 * 查询该用户所有充值记录
	 *@param user_id 用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午3:43:59
	 */
	List<PayRecord> getPayRecordByUserId(String user_id);
	
	/**
	 * 根据订单号获取充值记录
	 *@param order_no
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-11下午5:47:18
	 */
	PayRecord getPayRecordByOrderNo(String order_no);
	
	
}

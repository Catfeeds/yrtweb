package com.yt.framework.service;

import java.util.List;

import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PayRecord;

/**
 *
 *@autor bo.xie
 *@date2015-8-10下午3:26:09
 */
public interface PayCostService extends BaseService<PayCost> {

	/**
	 * 查询该用户所有充值记录
	 *@param user_id 用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午3:43:59
	 */
	List<PayCost> getPayCostByUserId(String user_id);
}

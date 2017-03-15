package com.yt.framework.service;

import com.yt.framework.persistent.entity.LeagueCost;

/**
 * 联赛报名费用记录
 * @author bo.xie
 *
 */
public interface LeagueCostService extends BaseService<LeagueCost> {
	/**
	 * 通过用户id获取
	 * @param user_id
	 * @return
	 */
	public LeagueCost getLeagueCostByUserId(String user_id,String league_id);
	
	public LeagueCost getLeagueCostByOrderNo(String order_no);
}

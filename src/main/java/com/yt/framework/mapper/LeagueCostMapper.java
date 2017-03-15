package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.LeagueCost;

/**
 * 报名费用
 * @author bo.xie
 *
 */
public interface LeagueCostMapper extends BaseMapper<LeagueCost> {

	/**
	 * 根据订单编号回去报名费用记录
	 * @param order_no
	 * @return
	 */
	public LeagueCost getLeagueCostByOrderNo(@Param(value="order_no")String order_no);
	
	/**
	 * 根据用户id获取记录
	 * @param order_no
	 * @return
	 */
	public LeagueCost getLeagueCostByUserId(@Param(value="user_id")String user_id, @Param(value="league_id")String league_id);
}

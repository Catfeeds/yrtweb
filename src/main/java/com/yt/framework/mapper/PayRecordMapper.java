package com.yt.framework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.PayRecord;

/**
 *充值记录
 *@autor bo.xie
 *@date2015-8-10下午2:39:10
 */
public interface PayRecordMapper extends BaseMapper<PayRecord> {

	/**
	 * 获取该用户所有的充值记录
	 *@param user_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午2:45:19
	 */
	List<PayRecord> getPayRecordByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 根据订单号获取充值记录
	 *@param order_no
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-11下午5:45:21
	 */
	PayRecord getPayRecordByOrderNo(@Param(value="order_no")String order_no);
}

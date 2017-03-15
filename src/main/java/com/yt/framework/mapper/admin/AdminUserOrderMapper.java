package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserOrder;

/**
 * @author ylt
 *
 */
public interface AdminUserOrderMapper extends BaseMapper<UserOrder> {

	public Map<String, Object> getOrderById(@Param(value="order_id")String order_id);

	public void addOrderNumData(OrderNumData orderNumData);

	public int queryOrderNumsCount(Map<String, Object> params);

	public List<Map<String, Object>> queryOrderNums(Map<String, Object> params);

	public List<Map<String, Object>> getOrderMaps(Map<String, Object> params);
	
}

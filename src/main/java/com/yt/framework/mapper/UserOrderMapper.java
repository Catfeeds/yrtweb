package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserAddress;
import com.yt.framework.persistent.entity.UserOrder;

/**
 * @author ylt
 *
 */
public interface UserOrderMapper extends BaseMapper<UserOrder> {

	public Map<String, Object> getOrderById(@Param(value="order_id")String order_id);

	public List<UserAddress> getUserAddress(@Param(value="user_id")String user_id);

	public void saveUserAddress(UserAddress userAddress);

	public void updateUserAddress(UserAddress userAddress);

	public void delUserAddress(@Param(value="address_id")String address_id);

	public Map<String, Object> getOrderBySn(@Param(value="order_sn")String order_sn);

	public UserOrder getOrderEntityBySn(@Param(value="order_sn")String order_sn);

	public UserAddress getDefaultUserAddress(@Param(value="user_id")String user_id);

	public void updateDefaultBatch(@Param(value="user_id")String user_id);

	public UserAddress getUserAddressById(@Param(value="address_id")String address_id);

	public void addOrderNumData(OrderNumData orderNumData);

}

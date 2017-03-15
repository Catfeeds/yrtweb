package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.UserAddress;
import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.utils.AjaxMsg;

/**
 * 订单管理
 * @author ylt
 * @date 2016年10月12日11:14:57
 */
public interface UserOrderService extends BaseService<UserOrder>{
	
	/**
	 * 获取订单
	 * @param order_id
	 * @return
	 */
	public Map<String,Object> getOrderById(String order_id);
	
	/**
	 * 保存或者编辑用户地址
	 * @param userAddress
	 * @return
	 * @throws Exception
	 */
	
	public AjaxMsg saveUserAddress(UserAddress userAddress)throws Exception;
	
	/**
	 * 获取用户地址列表
	 * @param user_id
	 * @return
	 */
	public List<UserAddress> getUserAddress(String user_id);
	
	/**
	 * 获取默认列表
	 * @param user_id
	 * @return
	 */
	public UserAddress getDefaultUserAddress(String user_id);
	
	/**
	 * 删除用户地址
	 * @param userAddress
	 * @return
	 */
	public AjaxMsg delUserAddress(String address_id)throws Exception ;
	
	/**
	 * 获取地址
	 * @param order_sn
	 * @return
	 */
	public UserAddress getUserAddressById(String address_id);
	
	/**
	 * 获取订单
	 * @param order_sn
	 * @return
	 */
	public Map<String,Object> getOrderBySn(String order_sn);
	
	/**
	 * 获取订单
	 * @param order_sn
	 * @return
	 */
	public UserOrder getOrderEntityBySn(String order_sn);
	
	/**
	 * 订单支付
	 * @param data_id 
	 * @param order_count
	 * @return
	 */
	public AjaxMsg pay(UserOrder userOrder)throws Exception;
	
	/**
	 * 保存队列订单
	 * @param order 
	 * @return
	 */
	public AjaxMsg saveQueueUserOrder(UserOrder order)throws Exception;
	
}

package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.service.BaseService;

/**
 * 订单管理
 * @author ylt
 * @date 2016年10月12日11:14:57
 */
public interface AdminUserOrderService extends BaseService<UserOrder>{

	public Map<String,Object> getOrderById(String order_id);
	
	public List<Map<String,Object>> getOrderMaps(Map<String,Object> params);
	
}

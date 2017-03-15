package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminUserOrderService;

@Service(value="adminUserOrderService")
public class AdminUserOrderServiceImpl extends BaseAdminServiceImpl<UserOrder> implements AdminUserOrderService {
	
	protected static Logger logger = LogManager.getLogger(AdminUserOrderServiceImpl.class);
	@Autowired
	MessageResourceService messageResourceService;
	
	@Override
	public Map<String,Object> getOrderById(String order_id) {
		return userOrderMapper.getOrderById(order_id);
	}

	@Override
	public List<Map<String, Object>> getOrderMaps(Map<String, Object> params) {
		return userOrderMapper.getOrderMaps(params);
	}
	
	
}

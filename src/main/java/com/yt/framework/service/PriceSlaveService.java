package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

public interface PriceSlaveService extends BaseService<PriceSlave>{

	/**
	 * 获取对应用户的当前身价
	 * @param user_id 用户ID
	 * @param role_type 角色类型
	 * @param status 身价状态
	 * @return
	 */
	public PriceSlave getPriceSlaveByUserAndType(String user_id,String role_type);
	
	/**
	 * 球员单次最高身价
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadPriceSlaveSingle(Map<String,Object> maps,PageModel pageModel);
}

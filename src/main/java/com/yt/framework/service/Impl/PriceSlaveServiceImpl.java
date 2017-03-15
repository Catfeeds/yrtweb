package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.service.PriceSlaveService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("priceSlaveService")
public class PriceSlaveServiceImpl extends BaseServiceImpl<PriceSlave>implements PriceSlaveService {
	
	protected static Logger logger = LogManager.getLogger(PriceSlaveServiceImpl.class);

	@Override
	public PriceSlave getPriceSlaveByUserAndType(String user_id, String role_type) {
		
		return priceSlaveMapper.getPriceSlaveByUserAndType(user_id, role_type);
	}

	@Override
	public AjaxMsg loadPriceSlaveSingle(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = priceSlaveMapper.loadPriceSlaveSingleCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> items = priceSlaveMapper.loadPriceSlaveSingle(maps);
		pageModel.setItems(items);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

}

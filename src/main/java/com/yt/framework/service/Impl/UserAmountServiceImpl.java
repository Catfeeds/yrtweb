package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserFreezeAmount;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.utils.AjaxMsg;

/**
 *充值金额处理
 *@autor ylt
 *@date2015-8-11下午5:01:15
 */
@Transactional
@Service("userAmountService")
public class UserAmountServiceImpl extends BaseServiceImpl<UserAmount> implements UserAmountService{
	
	protected static Logger logger = LogManager.getLogger(UserAmountServiceImpl.class);
	
	@Autowired
	MessageResourceService messageResourceService;
	
	@Override
	public AjaxMsg saveUserFreezeAmount(UserFreezeAmount userFreezeAmount)throws Exception{
		userAmountMapper.saveUserFreezeAmount(userFreezeAmount);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public UserFreezeAmount getFreezeAmountById(String id) {
		return userAmountMapper.getFreezeAmountById(id);
	}

	@Override
	public AjaxMsg updateFreezeAmount(UserFreezeAmount userFreezeAmount)throws Exception {
		userAmountMapper.updateFreezeAmount(userFreezeAmount);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")); 
	}

	@Override
	public UserAmount getUserAmountByUserId(String userId) {
		return userAmountMapper.getByUserId(userId);
	}

	@Override
	public UserAmount getUserAmountByTeamInfoID(String teaminfo_id) {
		return userAmountMapper.getUserAmountByTeaminfoID(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadAmountDetail(Map<String, Object> maps) {
		maps.put("firstNum", 0);
		maps.put("pageSize", 10);
		List<Map<String, Object>> re = userAmountMapper.loadAmountDetail(maps);
		return re;
	}
	
	@Override
	public void updateShow(String user_id, Integer show)throws Exception{
		userAmountMapper.updateShow(user_id,show);
	}
}

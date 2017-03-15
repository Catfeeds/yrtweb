package com.yt.framework.service;


import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserFreezeAmount;
import com.yt.framework.utils.AjaxMsg;
/**
 * 用户资金Service
 * @author gl
 */
public interface UserAmountService extends BaseService<UserAmount>{
	/**
	 * 保存冻结资金
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg saveUserFreezeAmount(UserFreezeAmount userFreezeAmount)throws Exception;
	
	/**
	 * 获取冻结资金
	 * @param f_id
	 */
	public UserFreezeAmount getFreezeAmountById(String id);
	
	/**
	 * 更新冻结资金
	 * @param f_id
	 */
	public AjaxMsg updateFreezeAmount(UserFreezeAmount userFreezeAmount)throws Exception;
	
	public UserAmount getUserAmountByUserId(String userId);
	
	public UserAmount getUserAmountByTeamInfoID(String teaminfo_id);
	
	/**
	 * 获取充值绑定数据
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAmountDetail(Map<String,Object> maps);
	
	public void updateShow(String user_id, Integer show)throws Exception;
}

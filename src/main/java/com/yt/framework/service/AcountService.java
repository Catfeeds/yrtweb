package com.yt.framework.service;

import java.util.Map;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.utils.AjaxMsg;

/**
 *
 *@autor bo.xie
 *@date2015-8-11下午4:54:58
 */
public interface AcountService extends BaseService<UserAmount>{

	/**
	 * 充值数据处理
	 *@param osn 订单号
	 *@param payAccount 付款帐号
	 *@param tsn 交易流水号
	 *@param payProvider  支付接口商 支付宝：ZHIFUBAO
	 *@param cashAccount 收款帐号
	 *@param acount_money 交易金额
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-11下午4:55:31
	 */
	public AjaxMsg paySuccess(String osn, String payAccount, String tsn,
			String payProvider, String cashAccount, String acount_money);
	
	/**
	 * 获取用户资金
	 * @param user_id
	 * @return
	 */
	public UserAmount getUserAmountByUserId(String user_id);
	
	/**
	 * 购买装扮
	 * @param params
	 * @return
	 */
	public AjaxMsg buyDress(Map<String,Object> params);
	
	/**
	 * 我的装扮 永久购买
	 * @param params
	 * @return
	 */
	public AjaxMsg reBuyDress(Map<String,Object> params);
}

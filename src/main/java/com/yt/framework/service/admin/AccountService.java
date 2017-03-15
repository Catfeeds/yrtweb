package com.yt.framework.service.admin;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor bo.xie
 *@date2015-8-27下午1:57:10
 */
public interface AccountService {

	/**
	 * 获取平台用户充值记录
	 *@param params
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午1:58:29
	 */
	public AjaxMsg loadPayRecords(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 获取平台充值总金额
	 *@param status 为空时，默认1，查询充值成功总金额
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午3:51:06
	 */
	public BigDecimal getPayRecordSum(String status);
	
	/**
	 * 获取平台消费记录
	 *@param params
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午1:58:29
	 */
	public AjaxMsg loadCostRecord(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 平台注册用户资金信息
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg loadUserAmountDatas(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 更新用户资金
	 * @param userAmount
	 */
	public void updateUserAmount(UserAmount userAmount);
	
	/**
	 * 获取用户资金
	 * @param id
	 * @return
	 */
	public UserAmount getUserAmount(String id);
	
	/**
	 * 平台资金汇总
	 * @param maps
	 * @return
	 */
	public Map<String,Object> loadTotalAmount(Map<String,Object> maps);
	
	/**
	 * 资金充值汇总
	 * @param maps
	 * @return
	 */
	public Map<String,Object> loadTotalRecord(Map<String,Object> maps);
}

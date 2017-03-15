package com.yt.framework.mapper.admin;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.UserAmount;

/**
 *后台充值记录
 *@autor bo.xie
 *@date2015-8-27上午11:50:59
 */
public interface AccountMapper {

	/**
	 * 获取充值记录
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27上午11:52:46
	 */
	public List<Map<String,Object>> loadPayRecords(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取充值记录总条数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午2:25:00
	 */
	public int getPayRecordsCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取平台充值总金额
	 *@param status
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午3:51:06
	 */
	public BigDecimal getPayRecordSum(@Param("status")String status);
	
	/**
	 * 获取平台用户消费记录
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午5:01:59
	 */
	public List<Map<String,Object>> loadCostRecord(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取平台用户消费记录总条数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午2:25:00
	 */
	public int getPayCostCount(@Param(value="maps")Map<String,Object> maps);
	
	/**|
	 * 保存用户资金
	 * @param userAmount
	 */
	public void saveUserAmount(UserAmount userAmount);
	
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
	public UserAmount getUserAmount(@Param(value="id")String id);
	
	/**
	 * 获取用户资金
	 * @param user_id
	 * @return
	 */
	public UserAmount getUserAmountByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 获取用户的资金账户信息
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadUserAmountDatas(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 资金用户总数
	 * @param maps
	 * @return
	 */
	public int loadUserAmountDatasCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 平台资金汇总
	 * @param maps
	 * @return
	 */
	public Map<String,Object> loadTotalAmount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 资金充值汇总
	 * @param maps
	 * @return
	 */
	public Map<String,Object> loadTotalRecord(@Param(value="maps")Map<String,Object> maps);
}

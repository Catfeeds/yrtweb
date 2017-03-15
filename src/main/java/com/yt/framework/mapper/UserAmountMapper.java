package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.AmountDetail;
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserFreezeAmount;

/**
 *用户资金账户
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface UserAmountMapper extends BaseMapper<UserAmount> {
	
	public UserAmount getUserAmountByTeaminfoID(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 保存资金冻结账户
	 * @param userFreezeAmount
	 * @return
	 * @throws Exception
	 * @author ylt
	 */
	public void saveUserFreezeAmount(UserFreezeAmount userFreezeAmount)throws Exception;
	
	/**
	 * 获取资金冻结账户
	 * @param id
	 * @return
	 * @throws Exception
	 * @author ylt
	 */
	public UserFreezeAmount getFreezeAmountById(@Param(value="id")String id); 
	/**
	 * 更新冻结资金
	 * @param f_id
	 */
	public void updateFreezeAmount(UserFreezeAmount userFreezeAmount);
	
	/**
	 * 保存手续费
	 * @param fee
	 */
	public void saveFee(Fee fee);	
	
	public UserAmount getByUserId(@Param(value="userId")String userId);
	
	/**
	 * 保存贡献榜数据
	 * @param amountDetail
	 */
	public void saveTeamAmountDetail(AmountDetail amountDetail);
	
	/**
	 * 获取充值榜数据
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAmountDetail(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 更新用户资金
	 * @param userAmount
	 */
	public void updateShow(@Param(value="user_id")String user_id, @Param(value="show")Integer show);

}

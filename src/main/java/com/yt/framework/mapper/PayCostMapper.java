package com.yt.framework.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.persistent.entity.PayCost;

/**
 *充值记录
 *@autor bo.xie
 *@date2015-8-10下午2:39:10
 */
public interface PayCostMapper extends BaseMapper<PayCost> {

	/**
	 * 获取该用户所有的充值记录
	 *@param user_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午2:45:19
	 */
	List<PayCost> getPayCostByUserId(@Param(value="user_id")String user_id);
}

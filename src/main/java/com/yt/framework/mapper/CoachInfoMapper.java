package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.CoachInfo;

/**
 *教练
 *@autor bo.xie
 *@date2015-8-6下午5:28:17
 */
public interface CoachInfoMapper extends BaseMapper<CoachInfo> {

	/**
	 * 获取教练信息
	 *@param user_id 教练用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6下午5:53:35
	 */
	public CoachInfo getCoachInfoByUserId(@Param(value="user_id")String user_id);
}

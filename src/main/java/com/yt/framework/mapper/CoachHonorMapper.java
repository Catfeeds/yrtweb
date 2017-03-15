package com.yt.framework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.CoachHonor;

/**
 *教练人荣誉
 *@autor bo.xie
 *@date2015-8-7下午12:15:43
 */
public interface CoachHonorMapper extends BaseMapper<CoachHonor>{

	/**
	 * 获取该教练的所有荣誉
	 *@param user_id 教练用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7下午12:17:37
	 */
	public List<CoachHonor> getCoachHonorsByUserId(@Param(value="user_id")String user_id);
}

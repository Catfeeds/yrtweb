package com.yt.framework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.CoachCareer;

/**
 *教练任职经历
 *@autor bo.xie
 *@date2015-8-7下午4:55:32
 */
public interface CoachCareerMapper extends BaseMapper<CoachCareer> {

	/**
	 * 获取该教练的所有任职记录
	 *@param user_id 教练用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7下午4:56:40
	 */
	public List<CoachCareer> getCoachCareerListByUserId(@Param(value="user_id")String user_id);
}

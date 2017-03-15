package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyScore;

public interface BabyScoreMapper extends BaseMapper<BabyScore> {

	/**
	 * 获取评分记录
	 * @param user_id 宝贝用户ID
	 * @param p_user_id 评价用户ID
	 * @return
	 */
	public BabyScore getBabyScoreByIds(@Param(value="user_id")String user_id,@Param(value="p_user_id")String p_user_id);
	
	/**
	 * 获取评分宝贝平均分数
	 * @param user_id
	 * @return
	 */
	public double getBabyScoreAveByBabyUserID(@Param(value="user_id")String user_id);
}

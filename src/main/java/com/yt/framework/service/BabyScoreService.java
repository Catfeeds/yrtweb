package com.yt.framework.service;
import com.yt.framework.persistent.entity.BabyScore;

/**
 * 宝贝评分
 * @autor ylt
 * @date2015-8-4上午10:59:16
 */
public interface BabyScoreService extends BaseService<BabyScore> {
	/**
	 * 获取评价记录
	 * @param user_id 宝贝用户ID
	 * @param p_user_id 评价用户ID
	 * @return
	 */
	public BabyScore getBabyScoreByIds(String user_id,String p_user_id);
	
	/**
	 * 获取评分宝贝平均分
	 * @param user_id 宝贝用户ID
	 * @return
	 */
	public double getBabyScoreAveByBabyUserID(String user_id);
}

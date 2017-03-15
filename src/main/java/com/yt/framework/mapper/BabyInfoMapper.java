package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.ImageVideoBaby;
import com.yt.framework.persistent.entity.TeamInfo;


/**
 *足球宝贝
 *@autor bo.xie
 *@date2015-7-21下午2:08:53
 */
public interface BabyInfoMapper extends BaseMapper<BabyInfo>{


	public void saveImgOrVideos(ImageVideoBaby imageVideoBaby);

	public Map<String,Object> getBabyUser(String baby_id);
	
	/**
	 * 获取宝贝上传的所有视频
	 * @param user_id 用户ID
	 * @param type 类型 1：图片 2：视频
	 * @return
	 */
	public List<Map<String,Object>> loadAllBabyImageByUserId(@Param(value="user_id")String user_id,@Param(value="role_type")String role_type);
	
	/**
	 * 获取宝贝上传的所有图片
	 * @param user_id 用户ID
	 * @param type 类型 1：图片 2：视频
	 * @return
	 */
	public List<Map<String,Object>> loadAllBabyVideoByUserId(@Param(value="user_id")String user_id,@Param(value="role_type")String role_type);
	
	/**
	 * 获取宝贝已助威比赛场数跟已代言俱乐部个数
	 * @param user_id
	 * @return
	 */
	public Map<String,Object> getInviteAndCheerCount(@Param(value="user_id")String user_id);

	public int babyImgCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryBabyImages(@Param(value="maps")Map<String, Object> params);

	public int deleteBabyImg(String id);
	
	/**
	 * 获取推荐宝贝的第一张图片
	 * @return
	 */
	public List<Map<String,Object>> loadRecommendBabyImages(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取宝贝已代言俱乐部信息
	 * @param baby_user_id
	 * @return
	 */
	public TeamInfo getTeamInfoByUserId(@Param(value="baby_user_id")String baby_user_id);
}

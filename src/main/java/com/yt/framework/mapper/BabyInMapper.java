package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyIn;
import com.yt.framework.persistent.entity.BabyTeam;

public interface BabyInMapper extends BaseMapper<BabyIn> {

	/**
	 * 保存宝贝已要入驻的俱乐部信息
	 *@param babyTeam
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-26上午11:11:18
	 */
	public void saveBabyTeam(BabyTeam babyTeam);
	
	/**
	 * 更新宝贝已入驻俱乐部信息
	 *@param babyTeam
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-26上午11:15:28
	 */
	public void updateBabyTeam(BabyTeam babyTeam);
	
	/**
	 * 获取入驻俱乐部信息
	 *@param id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-26上午11:21:43
	 */
	public BabyTeam getBabyTeamById(@Param(value="id")String id);
	
	/**
	 * 获取已邀请入驻足球宝贝信息
	 * @param user_id 宝贝用户ID
	 * @param teaminfo_id 俱乐部ID
	 * @param status 入驻状态
	 * @return
	 */
	public BabyIn getBabyInInfo(@Param(value="user_id")String user_id,@Param(value="teaminfo_id")String teaminfo_id,@Param(value="status")String status);
	
	/**
	 * 宝贝入住信息分页查询，返回Map
	 * @param map
	 * @autor ylt
	 * @return
	 */
	public List<Map<String, Object>> queryBabyTeamForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 宝贝入住信息查询总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @autor ylt
	 * @return
	 */
	public int countBabyTeam(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取时间到期的已代言足球宝贝
	 * @param date_str 时间字符串 yyyy-MM-dd
	 * @return
	 */
	public List<BabyTeam> loadCurretDateBabyTeams(@Param(value="date_str")String date_str);
	
	/**
	 * 批量更新已代言俱乐部状态为失效状态
	 * @param babyTeam
	 */
	public void updateBabyTeamStatus(List<BabyTeam> babyTeam);
	
	/**
	 * 获取宝贝代言俱乐部个数
	 * @param baby_id 足球宝贝user_id
	 * @return
	 */
	public int joinTeamCount(@Param(value="baby_user_id")String baby_user_id);
	
	/**
	 * 解散所有俱乐部入住宝贝
	 * @param baby_id 足球宝贝user_id
	 * @return
	 */
	public void dissolveAllBabyTeam(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 俱乐部宝贝入住总数
	 * @param teaminfo_id 足球宝贝teaminfo_id
	 * @return
	 */
	public int teamBabyCount(@Param(value="teaminfo_id")String teaminfo_id);
}

package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyIn;
import com.yt.framework.persistent.entity.BabyTeam;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 宝贝入住
 * @autor ylt
 * @date2015-8-4上午10:59:16
 */
public interface BabyInService extends BaseService<BabyIn> {
	
	/**
	 * 更新入驻表信息，若同意入驻，并添加一条已入驻俱乐部信息
	 *@param babyIn
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-26上午11:04:04
	 */
	public AjaxMsg updateInfo(BabyIn babyIn)throws Exception;
	
	/**
	 * 获取已邀请入驻足球宝贝信息
	 * @param user_id 宝贝用户ID
	 * @param teaminfo_id 俱乐部ID
	 * @param status 入驻状态
	 * @return
	 */
	public BabyIn getBabyInInfo(String user_id,String teaminfo_id,String status);
	
	/**
	 * 获取已邀请入驻信息
	 * @param map 查询条件
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryBabyTeamForMap(Map<String, Object> map, PageModel pageModel);

	/**
	 * 获取已邀请入驻信息总数
	 * @param map 查询条件
	 * @return
	 */
	public int countBabyTeam(Map<String, Object> map);
	
	/**
	 * 宝贝主动退出俱乐部入住
	 * @param login_user_id 宝贝id
	 * @return
	 */
	public AjaxMsg quitTeamIn(String login_user_id, String id)throws Exception;
	
	/**
	 * 俱乐部剔除宝贝俱乐部入住
	 * @param login_user_id 队长id
	 * @return
	 */
	public AjaxMsg kickTeamIn(String login_user_id, String id)throws Exception;
	
	/**
	 * 宝贝退出俱乐部入住确认
	 * @param map 查询条件
	 * @return
	 */
	public AjaxMsg updateTeamInStatusByMsg(String user_id,String s_user_id, String id, Integer status)throws Exception;
	
	/**
	 * 获取时间到期的已代言足球宝贝
	 * @param date_str 时间字符串 yyyy-MM-dd
	 * @return
	 */
	public List<BabyTeam> loadCurretDateBabyTeams(String date_str);
	
	/**
	 * 更新宝贝已入驻俱乐部状态
	 *@param babyTeam
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-26上午11:15:28
	 */
	public void updateBabyTeam(BabyTeam babyTeam);
	
	/**
	 * 批量更新已代言俱乐部状态
	 * @param babyTeam
	 */
	public void updateBabyTeamStatus(List<BabyTeam> babyTeam);

	/**
	 * 解散所有俱乐部入住宝贝
	 * @param teaminfo_id 已解散的俱乐部
	 * @return
	 */
	public void dissolveAllBabyTeam(String teaminfo_id)throws Exception;
	
	/**
	 * 俱乐部入住宝贝总数
	 * @param teaminfo_id 已俱乐部
	 * @return
	 */
	public int teamBabyCount(String teaminfo_id);
}

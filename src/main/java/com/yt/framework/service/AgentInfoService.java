package com.yt.framework.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 经纪人
 * 
 * @autor bo.xie
 * @date2015-8-4上午10:59:16
 */
public interface AgentInfoService extends BaseService<AgentInfo> {

	/**
	 * 保存经济人信息后增加经纪人权限
	 * 
	 * @param ai
	 * @param request
	 * @return AjaxMsg
	 */
	public AjaxMsg saveAgent(AgentInfo ai, HttpServletRequest request) throws Exception;

	/**
	 * 获取经纪人信息
	 * 
	 * @param user_id
	 * @return AgentInfo
	 * @autor bo.xie
	 * @date2015-8-4上午10:57:27
	 */
	public AjaxMsg getAgentInfoByUserId(String user_id);

	/**
	 * 经纪人解约球员
	 * 
	 * @param agent_id
	 * @param player_id
	 * @param status 状态 0:无 1：同意 2：拒绝
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-4下午2:34:33
	 */
	public AjaxMsg breakPlayer(String agent_id, String player_id, Integer status)throws Exception;

	/**
	 * 查询经纪人已签约球员用户信息 status=1<br>
	 * 查询申请经纪人的球员用户信息(球员签约申请) status=0
	 * 
	 * @param maps
	 * @param pageModel
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-5上午10:57:54
	 */
	public AjaxMsg queryAgentPlayerForPage(Map<String, Object> maps, PageModel<Map<String, Object>> pageModel);

	/**
	 * 获取球员当前签约经纪人
	 * 
	 * @param player_id
	 *            球员用户ID
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-4下午2:40:22
	 */
	public AgentInfo currentSignPlayer(String player_id);

	/**
	 * 经纪人申请解约
	 * 
	 * @param username
	 *            用户姓名
	 * @param user_id
	 *            经纪人用户ID
	 * @param p_user_id
	 *            球员用户ID
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-28下午4:03:24
	 */
	//public AjaxMsg applyBreakPlayer(String username, String user_id, String p_user_id);

	/**
	 * 申请签约 (经纪人申请或者球员申请)
	 * 
	 * @param user_id
	 *            经纪人用户ID
	 * @param p_user_id
	 *            球员用户ID
	 * @param sendFlag
	 *            申请标志 PTAQ：球员 申请签约 ATPQ：经纪人申请签约
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-16下午4:03:24
	 */
	public AjaxMsg applySignPlayer(String user_id, String p_user_id, String sendFlag)throws Exception;
	
	/**
	 * 申请解约 (经纪人申请或者球员申请)
	 * 
	 * @param user_id
	 *            经纪人用户ID
	 * @param p_user_id
	 *            球员用户ID
	 * @param sendFlag
	 *            申请标志 PTAQ：球员 申请签约 ATPQ：经纪人申请签约
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-16下午4:03:24
	 */
	public AjaxMsg applyBreakPlayer(String agent_id, String player_id, String sendFlag)throws Exception;
	
	/**
	 * 经纪人签约球员
	 * 
	 * @param agent_id
	 * @param player_id
	 * @param status 状态 0:无 1：同意 2：拒绝
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-4下午2:34:33
	 */
	public AjaxMsg signPlayer(String agent_id, String player_id, Integer status)throws Exception;

}

package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.AgentPlayer;
import com.yt.framework.persistent.entity.AgentPlayerSign;
import com.yt.framework.persistent.entity.User;

/**
 *经纪人
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface AgentInfoMapper extends BaseMapper<AgentInfo> {

	/**
	 * 获取经纪人信息
	 *@param user_id
	 *@return AgentInfo
	 *@autor bo.xie
	 *@date2015-8-4上午10:57:27
	 */
	public AgentInfo getAgentInfoByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 判断球员是否已签约经纪人
	 *@param player_id 球员用户ID (球员在平台用户user表 id)
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午2:40:22
	 */
	public int isSignPlayer(@Param(value="player_id")String player_id);
	
	/**
	 * 保存签约球员
	 *@param agent_id 经纪人用户ID (经纪人在平台用户user表 id)
	 *@param player_id 球员用户ID (球员在平台用户user表 id)
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午2:11:26
	 */
	public void saveAgentPlayer(AgentPlayer agentPlayer);
	
	/**
	 * 解约球员
	 *@param agent_id 经纪人用户ID (经纪人在平台用户user表 id)
	 *@param player_id 球员用户ID (球员在平台用户user表 id)
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午2:39:39
	 */
	public void deleteSignPlayer(@Param(value="agent_id")String agent_id,@Param(value="player_id")String player_id);
	
	/**
	 * 经纪人代理球员退出俱乐部
	 *@param teaminfo_id 俱乐部ID
	 *@param player_id 球员用户ID
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午3:08:14
	 */
	public void outTeam(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="player_id")String player_id);
	
	/**
	 * 查询经纪人已签约球员用户信息 status=1<br>
	 * 查询申请经纪人的球员用户信息 status=0
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-5上午10:54:08
	 */
	public List<Map<String,Object>> queryAgentPlayerForPage(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询经纪人已签约球员总数status=1
	 * 查询申请经纪人的球员总数 status=0
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-5上午11:12:05
	 */
	public int getAgentPlayerCount(@Param(value="maps")Map<String,Object> maps);
	
	
	/**
	 * 获取球员当前签约经纪人
	 *@param player_id 球员用户ID
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-4下午2:40:22
	 */
	public AgentInfo currentSignPlayer(@Param(value="player_id")String player_id);
	
	/**
	 * 获取AgentPlayer信息
	 *@param user_id
	 *@param p_user_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-28下午4:09:14
	 */
	public AgentPlayer getAgentPlayerByIds(@Param("user_id")String user_id,@Param("p_user_id")String p_user_id);
	
	/**
	 * 更新AgentPlayer状态
	 *@param id
	 *@param status
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-28下午4:15:35
	 */
	public void updateAgentPlayerStatus(@Param(value="id")String id,@Param(value="status")int status);
	
	/**
	 * 更新AgentPlayer实体类
	 *@param agentPlayer
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public void updateAgentPlayer(AgentPlayer agentPlayer);
	
	/**
	 * 判断球员与经纪人之间是否发送过申请
	 *@param agent_id player_id applying 0:无 1:签约申请 2:解约申请
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public AgentPlayerSign ifSendAgentPlayer(@Param(value="agent_id")String agent_id, @Param(value="player_id")String player_id, @Param(value="applying")Integer applying);
	
	/**
	 * 保存申请记录
	 *@param AgentPlayerSign aps
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public void saveAgentPlayerSign(AgentPlayerSign aps);
	
	/**
	 * 查询申请记录
	 * @param applying 
	 *@param String agent_id, String player_id
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public AgentPlayerSign getAgentPlayerSign(@Param(value="agent_id")String agent_id, @Param(value="player_id")String player_id, @Param(value="applying")Long applying);
	
	/**
	 * 更新申请记录
	 *@param agentPlayerSign
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public void updateAgentPlayerSign(AgentPlayerSign agentPlayerSign);
	
	/**
	 * 更新申请记录all
	 *@param agentPlayerSign
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public void updateAgentPlayerAllSign(@Param(value="agent_id")String agent_id, @Param(value="player_id")String player_id);
	
	
	/**
	 * 保存成功签约记录(存储过程)
	 * 1.更新当前申请记录申请表状态为成功
	 * 2.更新其他经纪人发送和球员发送的申请记录表状态为失败
	 * 3.保存签约记录到记录表中
	 *@param agentPlayerSign
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-16下午12:41:10
	 */
	public void saveAgentPlayerByProcedure(AgentPlayerSign agentPlayerSign);
}

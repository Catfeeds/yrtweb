package com.yt.framework.service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.AgentPlayer;
import com.yt.framework.persistent.entity.AgentPlayerSign;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.AutoInfoMationService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 *经纪人
 *@autor bo.xie
 *@date2015-8-4上午11:02:07
 */
@Transactional
@Service("agentInfoService")
public class AgentInfoServiceImpl extends BaseServiceImpl<AgentInfo> implements AgentInfoService {
	protected static Logger logger = LogManager.getLogger(AgentInfoServiceImpl.class);

	@Autowired
	private AutoInfoMationService autoInfoMationService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Override
	public AjaxMsg saveAgent(AgentInfo ai, HttpServletRequest request) throws Exception{
		ai.setId(UUIDGenerator.getUUID());
		AjaxMsg msg = save(ai);
		if(msg.isSuccess()){
			User user = userMapper.getEntityById(ai.getUser_id());
			msg = securityService.saveUserRole(user,"4",request);
			if(msg.isError()){
				throw new RuntimeException();
			}
		}
		return msg;
	}
	
	
	@Override
	public AjaxMsg getAgentInfoByUserId(String user_id) {
		try {
			AgentInfo agentInfo = agentInfoMapper.getAgentInfoByUserId(user_id);
			return AjaxMsg.newSuccess().addData("data", agentInfo);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
	}

	@Override
	public AjaxMsg applySignPlayer(String agent_id, String player_id ,String sendFlag)throws Exception {
		if(StringUtils.isBlank(agent_id)||StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			//判断球员是否已经签约、是否已经发送签约申请
			AgentPlayerSign agentPlayerSign = agentInfoMapper.ifSendAgentPlayer(agent_id,player_id,new Integer(1));
			User agent = userMapper.getEntityById(agent_id);
			User player = userMapper.getEntityById(player_id);
			if(agentPlayerSign != null){
				if(agentPlayerSign.getSendFlag().equals(SYSTYPE.ATPQ.toString())){ 
					return AjaxMsg.newError().addMessage(agent.getUsernick()+"经纪人已发送申请,请不要重复发送!");
				}else if(agentPlayerSign.getSendFlag().equals(SYSTYPE.PTAQ.toString())){
					return AjaxMsg.newError().addMessage(player.getUsernick()+"球员已发送申请,请不要重复发送!");
				}
			}
			AjaxMsg msg = AjaxMsg.newSuccess();
			//保存发送申请记录 begin
			AgentPlayerSign aps = new AgentPlayerSign();
			aps.setId(UUIDGenerator.getUUID());
			aps.setUser_id(agent_id);
			aps.setP_user_id(player_id);
			aps.setSendFlag(sendFlag);
			aps.setApplying(new Integer(1)); //1:签约申请
			aps.setApply_time(new Date());
			agentInfoMapper.saveAgentPlayerSign(aps);
			
			//判断发送申请角色
			if(SYSTYPE.ATPQ.toString().equals(sendFlag)){
				//经纪人发送申请
				/*messageResourceService.saveMessage(new Object[]{agent.getUsernick()}, SYSTYPE.ATPQ.toString(), 
						"user.agent.asksign", player_id, agent_id, aps.getId());*/
				//msg = autoInfoMationService.sendInfo(player_id, agent_id,MSGTYPE.USER.toString(), SYSTYPE.ATPQ.toString(), agent.getUsernick()+"申请与您签约！");
			}else if(SYSTYPE.PTAQ.toString().equals(sendFlag)){
				//球员发送申请
				//msg = autoInfoMationService.sendInfo(agent_id, player_id,MSGTYPE.USER.toString(), SYSTYPE.PTAQ.toString(), player.getUsernick()+"申请与您签约！");
				/*messageResourceService.saveMessage(new Object[]{player.getUsernick()}, SYSTYPE.PTAQ.toString(), 
						"user.player.asksign", player_id, agent_id, aps.getId());*/
			}
			//保存发送申请记录 end
			return msg;
	}

	@Override
	public AjaxMsg applyBreakPlayer(String agent_id,String player_id,String sendFlag)throws Exception {
		if(StringUtils.isBlank(agent_id)||StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			//判断球员是否已经解约、是否已经发送解约申请
			AgentPlayerSign agentPlayerSign = agentInfoMapper.ifSendAgentPlayer(agent_id,player_id,new Integer(2));
			User agent = userMapper.getEntityById(agent_id);
			User player = userMapper.getEntityById(player_id);
			if(agentPlayerSign != null){
				if(agentPlayerSign.getSendFlag().equals(SYSTYPE.PTAJ.toString())){ 
					return AjaxMsg.newError().addMessage(player.getUsernick()+"球员已发送申请,请不要重复发送!");
				}else if(agentPlayerSign.getSendFlag().equals(SYSTYPE.ATPJ.toString())){
					return AjaxMsg.newError().addMessage(agent.getUsernick()+"经纪人已发送申请,请不要重复发送!");
				}
			}
			AjaxMsg msg = AjaxMsg.newSuccess();
			//保存发送申请记录 begin
			AgentPlayerSign aps = new AgentPlayerSign();
			aps.setId(UUIDGenerator.getUUID());
			aps.setUser_id(agent_id);
			aps.setP_user_id(player_id);
			aps.setSendFlag(sendFlag);
			aps.setApplying(new Integer(2)); //2:解约申请
			aps.setApply_time(new Date());
			agentInfoMapper.saveAgentPlayerSign(aps);
			AgentPlayer agentPlayer = agentInfoMapper.getAgentPlayerByIds(agent_id, player_id);
			if(agentPlayer == null) return AjaxMsg.newError().addMessage("签约关系不存在");
			agentPlayer.setApplying(new Integer(2)); // 2:解约申请中
			agentInfoMapper.updateAgentPlayer(agentPlayer);
			//判断发送解约
			if(SYSTYPE.PTAJ.toString().equals(sendFlag)){
				//球员发送申请	
				/*messageResourceService.saveMessage(new Object[]{player.getUsernick()}, sendFlag, "user.player.surrender", agent.getId(), player.getId() , aps.getId());
				*///msg = autoInfoMationService.sendInfo(agent_id, player_id,MSGTYPE.USER.toString(), sendFlag, player.getUsernick()+"申请与您解约！");
			}else if(sendFlag.equals(SYSTYPE.ATPJ.toString())){
				//经纪人发送申请
				/*messageResourceService.saveMessage(new Object[]{player.getUsernick()}, sendFlag, "user.agent.surrender", player.getId() , agent.getId() , aps.getId());
				*///msg = autoInfoMationService.sendInfo(player_id, agent_id,MSGTYPE.USER.toString(), sendFlag, agent.getUsernick()+"申请与您解约！");
			}
			//保存发送申请记录 end
			return msg;
	}
	
	@Override
	public AjaxMsg signPlayer(String agent_id, String player_id, Integer status)throws Exception{
		if(StringUtils.isBlank(agent_id)||StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			//更新球员消息记录表
			AgentPlayerSign agentPlayerSign = agentInfoMapper.getAgentPlayerSign(agent_id,player_id,new Long(1));
			agentPlayerSign.setApply_sure_time(new Date());
			agentPlayerSign.setStatus(status);
			User user = userMapper.getEntityById(agent_id);
			//同意签约
			if(status.intValue() == 1){
				//存储过程中insert a_agent_player关系表id必须手动写入uuid，经纪人功能开发后需修改此功能接口
				agentInfoMapper.saveAgentPlayerByProcedure(agentPlayerSign);
				//获取球员信息
				PlayerInfo pi = playerInfoMapper.getByUserId(player_id);
				//更新球员签约状态
				pi.setIs_sign(1);
				playerInfoMapper.update(pi);
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.agent.agreesign", player_id, agent_id,1);
			}else{
			//拒绝
				agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.agent.refusesign", player_id, agent_id,1);
			}
			return AjaxMsg.newSuccess();
	}

	
	@Override
	public AjaxMsg breakPlayer(String agent_id, String player_id, Integer status)throws Exception{
		if(StringUtils.isBlank(agent_id)||StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			//更新球员消息记录表
			AgentPlayerSign agentPlayerSign = agentInfoMapper.getAgentPlayerSign(agent_id,player_id,new Long(2));
			agentPlayerSign.setBreak_sure_time(new Date());
			agentPlayerSign.setStatus(status);
			//同意解约
			User user = userMapper.getEntityById(agent_id);
			AgentPlayer agentPlayer = agentInfoMapper.getAgentPlayerByIds(agent_id,player_id);
			if(status.intValue() == 1){
				agentPlayer.setStatus(new Integer(0));
				agentPlayer.setBreak_time(new Date());
				agentPlayer.setApplying(new Integer(0));
				agentInfoMapper.updateAgentPlayer(agentPlayer);
				agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
				//获取球员信息
				PlayerInfo pi = playerInfoMapper.getByUserId(player_id);
				//更新球员签约状态
				pi.setIs_sign(0);
				playerInfoMapper.update(pi);
				//经纪人同意解约
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.agent.agreesurrender", player_id, agent_id,1);
			}else{
			//拒绝
				agentPlayer.setApplying(new Integer(0));
				agentInfoMapper.updateAgentPlayer(agentPlayer);
				agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.agent.resurrender", player_id, agent_id,1);
			}
			return AjaxMsg.newSuccess();
		
	}
	
	@Override
	public AjaxMsg queryAgentPlayerForPage(Map<String, Object> maps,
			PageModel<Map<String,Object>> pageModel) {
		if(maps!=null){
			if(pageModel!=null){
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
				List<Map<String,Object>> pis = agentInfoMapper.queryAgentPlayerForPage(maps);
				int count = agentInfoMapper.getAgentPlayerCount(maps);
				pageModel.setItems(pis);
				pageModel.setTotalCount(count);
				return AjaxMsg.newSuccess().addData("page", pageModel);
			}
			
		}
		return AjaxMsg.newError();
		
	}

	@Override
	public AgentInfo currentSignPlayer(String player_id) {
		return agentInfoMapper.currentSignPlayer(player_id);
	}

/*	@Override
	public AjaxMsg applyBreakPlayer(String username,String user_id,String p_user_id) {
		if(StringUtils.isBlank(agent_id)||StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			//获取球员信息
			PlayerInfo pi = playerInfoMapper.getByUserId(p_user_id);
			if(pi==null)return AjaxMsg.newError().addMessage("球员不存在");
			//更新经纪人签约球员表信息
			AgentPlayer agentPlayer = agentInfoMapper.getAgentPlayerByIds(user_id, p_user_id);
			
			AjaxMsg msg = autoInfoMationService.sendInfo(p_user_id, user_id,MSGTYPE.USER.toString(), SYSTYPE.ATPJ.toString(), username+"申请与您解约！");
			if(msg.isSuccess()){
				//更新AgentPlayer状态
				agentPlayer.setBreak_time(new Date());
				agentPlayer.setApplying(2);
				agentInfoMapper.updateAgentPlayer(agentPlayer);
			}
			
		return msg;
	}*/
	
	
}
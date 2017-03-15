package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.MessageService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service(value="messageService")
public class MessageServiceImpl extends BaseServiceImpl<Message> implements MessageService{
	
	protected static Logger logger = LogManager.getLogger(MessageServiceImpl.class);

	@Autowired
	private AgentInfoService agentInfoService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@Override
	public AjaxMsg modifySystemMsg(Message msg, String submit) throws Exception {
		AjaxMsg errorMsg = AjaxMsg.newSuccess();
		String type = msg.getType();
		msg = getEntityById(msg.getId());
		if("yes".equals(submit)){
			if(type.equals(SystemEnum.SYSTYPE.PTAQ.toString())){
				//球员申请与经纪人签约,经纪人确认
				errorMsg = agentInfoService.signPlayer(msg.getUser_id(), msg.getS_user_id(), new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.PTAJ.toString())){
				//球员申请与经纪人解约,经纪人确认
				errorMsg = agentInfoService.breakPlayer(msg.getUser_id(), msg.getS_user_id(), new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.ATPQ.toString())){
				//经纪人申请与球员签约,球员确认
				errorMsg = playerInfoService.signAgent(msg.getS_user_id(), msg.getUser_id(), new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.ATPJ.toString())){
				//经纪人申请与球员解约,球员确认
				errorMsg = playerInfoService.breakAgent(msg.getS_user_id(), msg.getUser_id(), new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.TTPA.toString())){
				//俱乐部邀请用户加入,用户确认
				errorMsg = teamInfoService.agreeTeamApply(msg.getRelate_id(), msg.getUser_id(), "1");
				//errorMsg = teamInfoService.joinTeam(msg.getRelate_id(), msg.getUser_id());
			}else if(type.equals(SystemEnum.SYSTYPE.LEADER.toString())){
				//用户被指派为队长/副队长
				//仅提示消息
				errorMsg = AjaxMsg.newSuccess();
			}else if(type.equals(SystemEnum.SYSTYPE.TRIAL.toString())){
				//邀请试训确认
				errorMsg =  playerInfoService.updateTrial(msg.getRelate_id(),  new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.IPK.toString())){
				//俱乐部邀请对战确认
				errorMsg = teamInviteService.updateInviteByMsg(msg.getRelate_id(), new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.TASCORE.toString())){
				//俱乐部上传比分确认
				TeamInfo teaminfo = teamInfoService.getTeamInfoByUserId(msg.getUser_id());
				errorMsg = teamInviteService.checkResult(msg.getRelate_id(),teaminfo.getId(),new Integer(1));
			}else if(type.equals(SystemEnum.SYSTYPE.BBOUT.toString())){
				errorMsg = babyInService.updateTeamInStatusByMsg(msg.getS_user_id(),msg.getUser_id(), msg.getRelate_id(), new Integer(0));
			}
			msg.setOper_status(1);//已同意
		}else if("no".equals(submit)){
			if(type.equals(SystemEnum.SYSTYPE.TRIAL.toString())){
				//邀请试训确认 
				errorMsg = playerInfoService.updateTrial(msg.getRelate_id(), new Integer(0));
			}else if(type.equals(SystemEnum.SYSTYPE.IPK.toString())){
				//俱乐部邀请对战确认拒绝
				errorMsg = teamInviteService.updateInviteByMsg(msg.getRelate_id(), new Integer(0));
			}else if(type.equals(SystemEnum.SYSTYPE.TASCORE.toString())){
				//俱乐部上传比分确认
				TeamInfo teaminfo = teamInfoService.getTeamInfoByUserId(msg.getUser_id());
				errorMsg = teamInviteService.checkResult(msg.getRelate_id(),teaminfo.getId(),new Integer(0));
			}else if(type.equals(SystemEnum.SYSTYPE.PTAQ.toString())){
				//球员申请与经纪人签约,经纪人拒绝
				errorMsg = agentInfoService.signPlayer(msg.getUser_id(), msg.getS_user_id(), new Integer(2));
			}else if(type.equals(SystemEnum.SYSTYPE.PTAJ.toString())){
				//球员申请与经纪人解约,经纪人拒绝
				errorMsg = agentInfoService.breakPlayer(msg.getUser_id(), msg.getS_user_id(), new Integer(2));
			}else if(type.equals(SystemEnum.SYSTYPE.ATPQ.toString())){
				//经纪人申请与球员签约,球员拒绝
				errorMsg = playerInfoService.signAgent(msg.getS_user_id(), msg.getUser_id(), new Integer(2));
			}else if(type.equals(SystemEnum.SYSTYPE.ATPJ.toString())){
				//经纪人申请与球员解约,球员拒绝
				errorMsg = playerInfoService.breakAgent(msg.getS_user_id(), msg.getUser_id(), new Integer(2));
			}else if(type.equals(SystemEnum.SYSTYPE.BBOUT.toString())){
				babyInService.updateTeamInStatusByMsg(msg.getS_user_id(),msg.getUser_id(), msg.getRelate_id(), new Integer(1));
				errorMsg = AjaxMsg.newSuccess();
			}else if(type.equals(SystemEnum.SYSTYPE.TTPA.toString())){
				//俱乐部邀请用户加入,用户确认
				errorMsg = teamInfoService.agreeTeamApply(msg.getRelate_id(), msg.getUser_id(), "2");
				//errorMsg = teamInfoService.joinTeam(msg.getRelate_id(), msg.getUser_id());
			}
			msg.setOper_status(2);//已拒绝
		}
		if(errorMsg.isError()){
			//errorMsg.addMessage(messageResourceService.getMessage("system.error"));
			return errorMsg;
		}
		msg.setStatus(1);
		errorMsg = update(msg);
		return errorMsg;
	}
	
	@Override
	public AjaxMsg queryMsgUser(String userId) {
		if(StringUtils.isNotBlank(userId)){
			List<Map<String, Object>> users = messageMapper.queryMsgUser(userId);
			return AjaxMsg.newSuccess().addData("data", users);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryNotReadMsg(String userId) {
		if(StringUtils.isNotBlank(userId)){
			int msg_num = messageMapper.queryNotReadMsg(userId);
			if(msg_num>0){
				return AjaxMsg.newSuccess().addData("msg_num", msg_num);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg updateMsgState(String userId,String s_user_id, int state) {
		messageMapper.updateMsgState(userId,s_user_id,state);
		return AjaxMsg.newSuccess();
	}

	@Override
	public List<Message> queryPointToPointMsg(String user_id, String s_user_id, String type) {
		return messageMapper.queryPointToPointMsg(user_id, s_user_id, type);
	}

	@Override
	public AjaxMsg loadAllSysMsgList(Map<String, Object> maps,PageModel pageModel) {
		List<Map<String,Object>> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = loadAllSysMsgCount(maps);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = messageMapper.loadAllSysMsgList(maps);
			if(pageModel == null){
				PageModel page = new PageModel();
				page.setTotalCount(datas.size());
				page.setItems(datas);
				return AjaxMsg.newSuccess().addData("page", page);
			}else{
				pageModel.setTotalCount(count);
				pageModel.setItems(datas);
			}
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public int loadAllSysMsgCount(Map<String, Object> maps) {
		return messageMapper.loadSysMsgCount(maps);
	}

	
}

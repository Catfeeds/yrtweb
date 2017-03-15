package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 
 * @author ylt
 * 
 *         2015年11月10日
 */
@Service(value = "adminEventRecordService")
public class AdminEventRecordServiceImpl extends
		BaseServiceImpl<AdminEventRecord> implements
		AdminEventRecordService {
	
	protected static Logger logger = LogManager.getLogger(AdminEventRecordServiceImpl.class);
	@Autowired
	AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInviteService teamInviteService;
	
	
	@Override
	public AjaxMsg queryEventRecordByLeague(Map<String, Object> params) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		List<Map<String,Object>> list = adminEventRecordMapper.queryEventRecordByLeague(params);
		List<LeagueGroup> listGroup = adminLeagueGroupService.getGroupsByLid(BeanUtils.nullToString(params.get("league_id")));
		return msg.addData("listGroup", listGroup).addData("events", list);
		
	}
	@Override
	public AjaxMsg updateEventRecord(AdminEventRecord aef)throws Exception{
		adminEventRecordMapper.update(aef);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AdminEventRecord getEventRecordByTidAndVid(Map<String, Object> params) {
		return adminEventRecordMapper.getEventRecordByTidAndVid(params);
	}
	@Override
	public AjaxMsg saveGameByRecordId(String id)throws Exception{
		AdminEventRecord event = adminEventRecordMapper.getEntityById(id);
		if(null == event.getG_score() || null == event.getM_score()){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noscore"));
		}
		TeamInfo m_team  = teamInfoService.getEntityById(event.getM_teaminfo_id());
		TeamInfo g_team  = teamInfoService.getEntityById(event.getG_teaminfo_id());
		String idd = UUIDGenerator.getUUID();
		//保存球队历史记录
		TeamGame teamGame = new TeamGame();
		teamGame.setId(idd);
		teamGame.setInitiate_teaminfo_id(event.getM_teaminfo_id());
		teamGame.setT_name(m_team.getName());
		teamGame.setT_logo(m_team.getLogo());
		teamGame.setInitiate_score(event.getM_score());
		teamGame.setInitiate_sure(1);
		teamGame.setGame_time(event.getPlay_time());
		teamGame.setBall_format(event.getBall_format());
		teamGame.setPosition(event.getPosition());
		teamGame.setRespond_teaminfo_id(event.getG_teaminfo_id());
		teamGame.setR_name(g_team.getName());
		teamGame.setR_logo(g_team.getLogo());
		teamGame.setRespond_score(event.getG_score());
		teamGame.setRespond_sure(1);
		teamGame.setStatus(4); //联赛比赛
		if(event.getG_score() == event.getM_score()){
			teamGame.setInitiate_win(2);
			m_team.setDraw_count(m_team.getDraw_count()+1);
			g_team.setDraw_count(g_team.getDraw_count()+1);
			m_team.setSumballs(m_team.getSumballs()+event.getM_score());
			g_team.setSumballs(g_team.getSumballs()+event.getG_score());
			m_team.setCombat(m_team.getCombat()-100);
			g_team.setCombat(g_team.getCombat()-100);
			messageResourceService.saveMessageNoReply(new Object[]{m_team.getName(),g_team.getName(),
					event.getM_score(),event.getG_score(),100}, 
					"team.league.result", m_team.getUser_id(), m_team.getId(),1);
			messageResourceService.saveMessageNoReply(new Object[]{g_team.getName(),m_team.getName(),
					event.getG_score(),event.getM_score(),100}, 
					"team.league.result", g_team.getUser_id(), g_team.getId(),1);
		}else if(event.getG_score() > event.getM_score()){
			teamGame.setInitiate_win(0);
			m_team.setLoss_count(m_team.getLoss_count()+1);
			g_team.setWin_count(g_team.getWin_count()+1);
			m_team.setSumballs(m_team.getSumballs()+event.getM_score());
			g_team.setSumballs(g_team.getSumballs()+event.getG_score());
			m_team.setCombat(m_team.getCombat()-400);
			g_team.setCombat(g_team.getCombat()+300);
			messageResourceService.saveMessageNoReply(new Object[]{g_team.getName(),m_team.getName(),
					event.getG_score(),event.getM_score(),300}, 
					"team.league.winresult", m_team.getUser_id(), m_team.getId(),1);
			messageResourceService.saveMessageNoReply(new Object[]{m_team.getName(),g_team.getName(),
					event.getM_score(),event.getG_score(),400}, 
					"team.league.loseresult", g_team.getUser_id(), g_team.getId(),1);
		}else if(event.getG_score() < event.getM_score()){
			teamGame.setInitiate_win(1);
			m_team.setWin_count(m_team.getWin_count()+1);
			g_team.setLoss_count(g_team.getLoss_count()+1);
			m_team.setSumballs(m_team.getSumballs()+event.getM_score());
			g_team.setSumballs(g_team.getSumballs()+event.getG_score());
			m_team.setCombat(m_team.getCombat()+300);
			g_team.setCombat(g_team.getCombat()-400);
			messageResourceService.saveMessageNoReply(new Object[]{m_team.getName(),g_team.getName(),
					event.getM_score(),event.getG_score(),300}, 
					"team.league.winresult", m_team.getUser_id(), m_team.getId(),1);
			messageResourceService.saveMessageNoReply(new Object[]{g_team.getName(),m_team.getName(),
					event.getG_score(),event.getM_score(),400}, 
					"team.league.loseresult", g_team.getUser_id(), g_team.getId(),1);
		}
		event.setGame_id(idd);
		teamInfoService.update(m_team);
		teamInfoService.update(g_team);
		teamInviteService.saveTeamGame(teamGame);
		adminEventRecordMapper.update(event);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg delGameByRecordId(String id)throws Exception {
		AdminEventRecord event = adminEventRecordMapper.getEntityById(id);
		if(StringUtils.isBlank(event.getGame_id())){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noscore"));
		}
		TeamInfo m_team = teamInfoService.getEntityById(event.getM_teaminfo_id());
		TeamInfo g_team = teamInfoService.getEntityById(event.getG_teaminfo_id());
		String game_id = event.getGame_id();
		event.setGame_id("");
		if(event.getG_score() == event.getM_score()){
			m_team.setDraw_count(m_team.getDraw_count()-1);
			g_team.setDraw_count(g_team.getDraw_count()-1);
			m_team.setSumballs(m_team.getSumballs()-event.getM_score());
			g_team.setSumballs(g_team.getSumballs()-event.getG_score());
			m_team.setCombat(m_team.getCombat()+100);
			g_team.setCombat(g_team.getCombat()+100);
		}else if(event.getG_score() > event.getM_score()){
			m_team.setLoss_count(m_team.getLoss_count()-1);
			g_team.setWin_count(g_team.getWin_count()-1);
			m_team.setSumballs(m_team.getSumballs()-event.getM_score());
			g_team.setSumballs(g_team.getSumballs()-event.getG_score());
			m_team.setCombat(m_team.getCombat()+400);
			g_team.setCombat(g_team.getCombat()-300);
		}else if(event.getG_score() < event.getM_score()){
			m_team.setWin_count(m_team.getWin_count()-1);
			g_team.setLoss_count(g_team.getLoss_count()-1);
			m_team.setSumballs(m_team.getSumballs()-event.getM_score());
			g_team.setSumballs(g_team.getSumballs()-event.getG_score());
			m_team.setCombat(m_team.getCombat()-300);
			g_team.setCombat(g_team.getCombat()+400);
		}
		teamInfoService.update(m_team);
		teamInfoService.update(g_team);
		teamInviteService.delTeamGame(game_id);
		adminEventRecordMapper.update(event);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
}

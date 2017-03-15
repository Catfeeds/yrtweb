package com.yt.framework.service.schedule;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.entity.BabyTeam;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.utils.Common;

/**
 * 时间到期，宝贝已代言俱乐部自动失效
 * @author bo.xie
 * 2015年10月9日15:49:53
 */
public class TeamResultSchedule {

	private static Logger logger = LogManager.getLogger(TeamResultSchedule.class.getName());
	
	private static TeamResultSchedule teamResultSchedule;
	@Resource
	private TeamInviteService teamInviteService;
	
	@PostConstruct
	public TeamResultSchedule getInstance(){
		if(teamResultSchedule==null){
			teamResultSchedule = new TeamResultSchedule();
		}
		return teamResultSchedule;
	}
	
	/**
	 * 比赛开始七天若双方都没有确认比分，则比赛作废
	 * 若有一方确认，则以确认一方的比分，作为比赛结果
	 */
	@SuppressWarnings("unused")
	private synchronized void autorTeamGameResult(){
		Calendar c =Calendar.getInstance();
		c.add(Calendar.DAY_OF_YEAR, -7);
		List<TeamGame> tgs = teamInviteService.getAllTeamGameByDate(c.getTime());
		if(tgs.size()>0){
			for (TeamGame tg : tgs) {
				int respond_sure = tg.getRespond_sure();
				int initiate_sure = tg.getInitiate_sure();
				if(respond_sure==0 && initiate_sure==0){//双方都未确认，说明没有上传比分，则比赛作废
					tg.setStatus(2);
					teamInviteService.updateTeamGame(tg);
				}else if(respond_sure==1 || initiate_sure==1){//只要有一方确认，比赛结果以确认方为准，
					tg.setStatus(1);
					tg.setRespond_sure(1);
					tg.setInitiate_sure(1);
					teamInviteService.updateTeamGame(tg);
				}
			}
		}
	}
}

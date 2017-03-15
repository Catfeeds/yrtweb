package com.yt.framework.service.schedule;

import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.entity.BabyTeam;
import com.yt.framework.service.BabyInService;
import com.yt.framework.utils.Common;

/**
 * 时间到期，宝贝已代言俱乐部自动失效
 * @author bo.xie
 * 2015年10月9日15:49:53
 */
public class BabyTeamSchedule {

	private static Logger logger = LogManager.getLogger(BabyTeamSchedule.class.getName());
	
	private static BabyTeamSchedule babyTeamSchedule;
	@Resource
	private BabyInService babyInService;
	
	@PostConstruct
	public BabyTeamSchedule getInstance(){
		if(babyTeamSchedule==null){
			babyTeamSchedule = new BabyTeamSchedule();
		}
		return babyTeamSchedule;
	}
	
	@SuppressWarnings("unused")
	private synchronized void autorBabyteam(){
		String date_str = Common.formatDate(new Date(), "yyyy-MM-dd");
		List<BabyTeam> bts = babyInService.loadCurretDateBabyTeams(date_str);
		if(bts.size()>0){
			babyInService.updateBabyTeamStatus(bts);
		}
		/*for (BabyTeam bt : bts) {
			bt.setStatus(0);
			babyInService.updateBabyTeam(bt);
		}*/
	}
}

package com.yt.framework.service.schedule;

import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.yt.framework.persistent.entity.ScheduleSms;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.ScheduleSmsService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *
 *@autor bo.xie
 *@date2015-9-19下午3:49:00
 */
public class TeamScoreSchedule {

	private static Logger logger = LogManager.getLogger(TeamScoreSchedule.class.getName());
	
	@Resource
	private TeamInviteService teamInviteService;
	@Resource
	private UserService userService;
	@Resource
	private ScheduleSmsService scheduleSmsService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	private static TeamScoreSchedule teamScoreSchedule;
	
	
	@PostConstruct
	public TeamScoreSchedule getInstance(){
		if(teamScoreSchedule==null){
			teamScoreSchedule = new TeamScoreSchedule();
		}
		return teamScoreSchedule;
	}
	
	//发送短信通知相关用户
	@SuppressWarnings("unused")
	private synchronized void sendSMS(){
		List<ScheduleSms> datas = scheduleSmsService.loadScheduleDatas(new Date());
		if(datas.size()>0){
			for (ScheduleSms sms : datas) {
				String phone = sms.getPhone();
				User user = userService.getUserByPhoneOrEmail(phone);
				String user_id = user.getId();
				TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
				if(teamInfo!=null && teamInfo.getIs_exist()==0){//俱乐部已解散，不发送短信通知
					//更新计划任务中短信状态
					sms.setStatus(1);
					sms.setSend_result(1);
					scheduleSmsService.update(sms);
				}else if(teamInfo!=null && teamInfo.getIs_exist()==1){//俱乐部存在，向俱乐部队长发送短信通知
					if(StringUtils.isNotBlank(phone)&&sms.getReceive_sms()==1){
						AjaxMsg msg = SendMsg.getInstance().sendSMS(phone, "@1@="+sms.getParams(), sms.getModel_id());
						if(msg.isSuccess()){
							sms.setStatus(1);
							sms.setSend_result(1);
							scheduleSmsService.update(sms);
						}else{
							logger.error(phone+sms.getContent()+"通知短信发送失败！");
						}
					}
				}
				
			}
		}
		
	}
	
}

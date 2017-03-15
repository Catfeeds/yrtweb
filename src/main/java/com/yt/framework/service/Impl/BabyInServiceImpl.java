package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.BabyIn;
import com.yt.framework.persistent.entity.BabyTeam;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: BabyInServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年9月24日 下午3:58:34 
 */
@Service(value="babyInService")
@Transactional
public class BabyInServiceImpl extends BaseServiceImpl<BabyIn> implements BabyInService{
	
	protected static Logger logger = LogManager.getLogger(BabyInServiceImpl.class);
	
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	UserService userService;
	@Autowired
	TeamInfoService teamInfoService;
	
	@Override
	public AjaxMsg updateInfo(BabyIn babyIn)throws Exception{
		//added by bo.xie 判断该宝贝是否已经代言俱乐部，若代言，则不能再代言其他俱乐部，一个宝贝只能代言一个俱乐部 start
		if(babyIn.getStatus().equals(1)){
			String baby_user_id = babyIn.getUser_id();
			int counts = babyInMapper.joinTeamCount(baby_user_id);
			if(counts>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.isJoinTeam"));
		}
		//added by bo.xie 判断该宝贝是否已经代言俱乐部，若代言，则不能再代言其他俱乐部，一个宝贝只能代言一个俱乐部 end
		//更新邀请入驻表记录状态
		babyInMapper.update(babyIn);
		if(babyIn.getStatus().equals(1)){//同意入驻，添加已入驻信息
			BabyTeam bt = new BabyTeam();
				Calendar c = Calendar.getInstance();
				bt.setUser_id(babyIn.getUser_id());
				bt.setJoin_date(c.getTime());
				bt.setDays(babyIn.getDays());
				bt.setTeaminfo_id(babyIn.getTeaminfo_id());
				bt.setStatus(1);
				c.add(Calendar.DAY_OF_YEAR, babyIn.getDays()-1);
				bt.setEnd_date(c.getTime());
				bt.setId(UUIDGenerator.getUUID());
			babyInMapper.saveBabyTeam(bt);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public BabyIn getBabyInInfo(String user_id, String teaminfo_id, String status) {
		return babyInMapper.getBabyInInfo(user_id, teaminfo_id, status);
	}

	
	@Override
	public AjaxMsg queryBabyTeamForMap(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = countBabyTeam(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = babyInMapper.queryBabyTeamForMap(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public int countBabyTeam(Map<String, Object> params) {
		return babyInMapper.countBabyTeam(params);
	}

	@Override
	public AjaxMsg quitTeamIn(String login_user_id, String id)throws Exception{
		BabyTeam babyTeam = babyInMapper.getBabyTeamById(id);
		if(babyTeam!=null){
			if(babyTeam.getStatus() == 1){
				babyTeam.setStatus(2);
				babyInMapper.updateBabyTeam(babyTeam);
				String teaminfo_id = babyTeam.getTeaminfo_id();
				TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
				User baby = userService.getEntityById(babyTeam.getUser_id());
				//宝贝给队长发送解约申请
				messageResourceService.saveMessage(new Object[]{baby.getUsernick()}, 
						SystemEnum.SYSTYPE.BBOUT.toString(), "user.baby.outteamin", teamInfo.getUser_id(), login_user_id, id,2);
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.noerr"));
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.noerr"));
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg kickTeamIn(String login_user_id, String id)throws Exception{
		BabyTeam babyTeam = babyInMapper.getBabyTeamById(id);
		if(babyTeam!=null){
			if(babyTeam.getStatus() == 1){
				String teaminfo_id = babyTeam.getTeaminfo_id();
				TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
				babyTeam.setStatus(0);
				babyInMapper.updateBabyTeam(babyTeam);
				messageResourceService.saveMessageNoReply(new Object[]{teamInfo.getName()}, 
						"user.baby.kickteamin", babyTeam.getUser_id(), teamInfo.getId(),3);
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.noerr"));
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.noerr"));
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}	
	
	@Override
	public AjaxMsg updateTeamInStatusByMsg(String user_id,String s_user_id, String id,Integer status)throws Exception {
		User user = userService.getEntityById(s_user_id);
		if(status.intValue() == 1){
			messageResourceService.saveMessageNoReply(new Object[]{user.getUsername()}, "user.baby.refused", user_id, s_user_id,1);
		}else{
			BabyTeam babyTeam = babyInMapper.getBabyTeamById(id);
			babyTeam.setStatus(status);
			babyInMapper.updateBabyTeam(babyTeam);
			messageResourceService.saveMessageNoReply(new Object[]{user.getUsername()}, "user.baby.agree", user_id, s_user_id,1);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public List<BabyTeam> loadCurretDateBabyTeams(String date_str) {
		return babyInMapper.loadCurretDateBabyTeams(date_str);
	}

	@Override
	public void updateBabyTeam(BabyTeam babyTeam) {
		babyInMapper.updateBabyTeam(babyTeam);
	}

	@Override
	public void updateBabyTeamStatus(List<BabyTeam> babyTeam) {
		babyInMapper.updateBabyTeamStatus(babyTeam);		
	}

	@Override
	public void dissolveAllBabyTeam(String teaminfo_id)throws Exception {
		babyInMapper.dissolveAllBabyTeam(teaminfo_id);
	}

	@Override
	public int teamBabyCount(String teaminfo_id) {
		return babyInMapper.teamBabyCount(teaminfo_id);
	}

}

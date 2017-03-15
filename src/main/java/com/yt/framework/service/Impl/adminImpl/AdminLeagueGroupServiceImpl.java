package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueGroupEvent;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

@Service(value="adminLeagueGroupService")
public class AdminLeagueGroupServiceImpl extends BaseAdminServiceImpl<LeagueGroup> implements AdminLeagueGroupService {
	
	protected static Logger logger = LogManager.getLogger(AdminLeagueGroupServiceImpl.class);
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private LeagueService leagueService;
	
	@Override
	public List<League> getLeagues() {
		return leagueGroupMapper.getLeagues();
	}

	@Override
	public List<LeagueGroup> getGroupsByLid(String league_id) {
		return leagueGroupMapper.getGroupsByLid(league_id);
	}

	@Override
	public AjaxMsg saveOrUpdateGroup(String teaminfo_id, String group_id, String league_id)throws Exception {
		LeagueGroupEvent leagueGroupEvent = leagueGroupMapper.getGroupEvent(league_id,teaminfo_id);
		if(null ==  leagueGroupEvent){
			leagueGroupEvent = new LeagueGroupEvent();
			leagueGroupEvent.setGroup_id(group_id);
			leagueGroupEvent.setTeaminfo_id(teaminfo_id);
			leagueGroupEvent.setId(UUIDGenerator.getUUID());
			leagueGroupMapper.saveGroupEvent(leagueGroupEvent);
		}else{
			leagueGroupEvent.setGroup_id(group_id);
			leagueGroupMapper.updateGroupEvent(leagueGroupEvent);
		}
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg deleteGroup(String id)throws Exception {
		LeagueGroup leagueGroup = leagueGroupMapper.getEntityById(id);
		List<LeagueGroupEvent> listGroup = leagueGroupMapper.getGroupEventByGroupId(id);
		if(!listGroup.isEmpty()){
			for (LeagueGroupEvent leagueGroupEvent : listGroup) {
				leagueGroupMapper.deleteGroupEvent(leagueGroupEvent.getId());
			}
		}
		leagueGroupMapper.delete(leagueGroup.getId());
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg saveSalaryMsg(SalaryMsg salarys) throws Exception {
		if(null!=salarys){
				leagueGroupMapper.saveSalaryMsg(salarys);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadAllSalaryMsgList(Map<String, Object> maps, PageModel pageModel) {
		maps.put("firstNum", pageModel.getFirstNum());
		maps.put("pageSize", pageModel.getPageSize());
		int totalCount = leagueGroupMapper.loadAllSalaryMsgListCount(maps);
		List<Map<String,Object>> salaryRecords = leagueGroupMapper.loadAllSalaryMsgList(maps);
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(salaryRecords);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg saveSalaryRecord(SalaryRecord salaryRecords) throws Exception {
		if(null!=salaryRecords){
				leagueGroupMapper.saveSalaryRecord(salaryRecords);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg saveLeagueSalaryInfoByParams(List<String> teaminfo_ids,String league_id,String rounds) throws Exception {
		if(null==teaminfo_ids || StringUtils.isBlank(league_id) || StringUtils.isBlank(rounds)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}else{
			League league = leagueService.getEntityById(league_id);
			if(null!=teaminfo_ids && teaminfo_ids.size()>0){
				for (String teaminfo_id : teaminfo_ids) {
					if(null != teaminfo_id){
						String []ids = 	teaminfo_id.split(",");
							//生成球员工资表信息
						List<TeamPlayer> tps = teamInfoService.getTeamPlayersByTeamInfoId(ids[0]);
						if(null!=tps && tps.size()>0){
							int is_send = 0;
							//判断工资信息通知表是否已保存
							SalaryMsg sm = null;
							Map<String,Object>maps = Maps.newHashMap();
							maps.put("league_id", league_id);
							maps.put("event_id", ids[1]);
							maps.put("turn_num", rounds);
							maps.put("teaminfo_id", ids[0]);
							sm= leagueGroupMapper.getSalaryMsgByParams(maps);
							if(null==sm){
								sm = new SalaryMsg();
								String sm_id = UUIDGenerator.getUUID();
								sm.setId(sm_id);
								sm.setLeague_id(league_id);
								sm.setIs_send(is_send);
								sm.setTeaminfo_id(ids[0]);
								sm.setTurn_num(rounds);
								sm.setEvent_id(ids[1]);
								//保存发送信息
								this.saveSalaryMsg(sm);
							}
							for (TeamPlayer tp : tps) {
								//判断工资清单是否已保存
								SalaryRecord sr = new SalaryRecord();
								//sr = leagueGroupMapper.getSalaryRecordByParams(maps);
								sr.setId(UUIDGenerator.getUUID32());
								sr.setLeague_id(league_id);
								sr.setSalary(league.getSalary());
								sr.setTeaminfo_id(ids[0]);
								sr.setTurn_num(rounds);
								sr.setUser_id(tp.getUser_id());
								sr.setSrmsg_id(sm.getId());
								sr.setEvent_id(ids[1]);
								//保存球员工资明细
								this.saveSalaryRecord(sr);
							}
						}
					}
				}
			}
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadAllSalaryTable(Map<String, Object> params,PageModel pageModel) {
		params.put("firstNum", pageModel.getFirstNum());
		params.put("pageSize", pageModel.getPageSize());
		int totalCount = leagueGroupMapper.loadAllSalaryTableCount(params);
		List<Map<String,Object>> datas = leagueGroupMapper.loadAllSalaryTable(params);
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg deleteSalaryTableByParasm(Map<String, Object> maps) throws Exception {
		if(null==maps)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		leagueGroupMapper.deleteSalaryMsgRecord(maps);
		leagueGroupMapper.deleteSalaryTableByParasm(maps);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadLeagueTurnDetail(Map<String, Object> maps, PageModel pageModel) {
		maps.put("firstNum", pageModel.getFirstNum());
		maps.put("pageSize", pageModel.getPageSize());
		int totalCount = leagueGroupMapper.loadLeagueTurnDetailCount(maps);
		List<Map<String,Object>> datas = leagueGroupMapper.loadLeagueTurnDetail(maps);
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg updateSalarySend(Map<String, Object> maps) {
		if(null==maps)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		leagueGroupMapper.updateSalarySend(maps);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
}

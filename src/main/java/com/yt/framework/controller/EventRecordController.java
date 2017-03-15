package com.yt.framework.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.InviteMsg;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.EventRecordService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;

/**
 * 联赛
 * 
 * @autor ylt
 * @date2015-10-14下午2:46:36
 */
@Controller
@RequestMapping(value = "/record/")
public class EventRecordController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(EventRecordController.class);
	@Autowired
	private EventRecordService eventRecordService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	
	/** 
	 * 赛事展现
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value = "eventRecords")
	public String eventRecords(HttpServletRequest request) {
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		String s_id = BeanUtils.nullToString(request.getParameter("s_id"));
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date nowDate = new Date();
		Date beginDate = new Date();
		Date endDate = new Date();
		Calendar b_calendar = Calendar.getInstance();
		Calendar e_calendar = Calendar.getInstance();
		b_calendar.setTime(nowDate);
		e_calendar.setTime(nowDate);
		b_calendar.add(Calendar.DAY_OF_MONTH, -3);
		e_calendar.add(Calendar.DAY_OF_MONTH, 4);
		beginDate = b_calendar.getTime();
		endDate = e_calendar.getTime();
		Map<String,Object> params = Maps.newHashMap();
		params.put("s_id", s_id);
		params.put("begin_time", sf.format(beginDate));
		params.put("end_time",  sf.format(endDate));
		params.put("league_id", league_id);
		AjaxMsg msg = eventRecordService.queryForPageForMap(params, null);
		request.setAttribute("records", msg.getData("page"));
		return "league/record/event_record";
	}
	
	/**
	 * 赛数据展示
	 * @author ylt
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toRecord")
	public String recordPage(HttpServletRequest request){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		League league = new League();
		
		List<League> leagues = leagueService.getLeaguesByCondition(Maps.newHashMap());
		if(StringUtils.isBlank(league_id)){
			if(!leagues.isEmpty()){
				league = leagues.get(0);
			}
		}else{
			league = leagueService.getEntityById(league_id);
			request.setAttribute("league", league);
		}
		List<LeagueGroup> groups = leagueService.loadLeagueGroups(league.getId());
		request.setAttribute("groups", groups);
		request.setAttribute("league", league);
		request.setAttribute("leagues", leagues);
		return "league/record/league_event_record";	
	}
}
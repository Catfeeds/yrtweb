package com.yt.framework.controller.admin;

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

import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueScorer;
import com.yt.framework.persistent.entity.LeagueStatistics;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.service.admin.AdminLeagueStatisticsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 联赛个人数据统计
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/leagueStatistics")
public class AdminLeagueStatisticsController {

	private static Logger logger = LogManager.getLogger(AdminLeagueStatisticsController.class);
	
	@Autowired
	private AdminLeagueStatisticsService adminLeagueStatisticsService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String username = request.getParameter("username");
		String league_id = request.getParameter("league_id");
		String chart = request.getParameter("chart");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		if(StringUtils.isNotBlank(chart)) params.put("chart", chart);
		AjaxMsg msg = adminLeagueStatisticsService.queryForPageForMap(params, pageModel);
		//List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		request.setAttribute("league_id",league_id);
		return "admin/leaguestatistics/leaguestatistics"; 
	}
	
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		LeagueStatistics statistics = new LeagueStatistics();
		User user = new User();
		if(StringUtils.isNotBlank(id)){
			statistics = adminLeagueStatisticsService.getEntityById(id);
			user = userService.getEntityById(statistics.getUser_id());
		}
		List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("statistics", statistics);
		request.setAttribute("leagues", leagues);
		request.setAttribute("user", user);
		return "admin/leaguestatistics/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,LeagueStatistics ls){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(ls.getId())){
			LeagueStatistics s = adminLeagueStatisticsService.getEntityById(ls.getId());
			s.setZg_sort(ls.getZg_sort());
			s.setHop_sort(ls.getHop_sort());
			s.setHup_sort(ls.getHup_sort());
			s.setShup_sort(ls.getShup_sort());
			msg = adminLeagueStatisticsService.update(s);
		}
		return msg.toJson();
	}
	
	/**
	 * 更新
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateStatistics")
	@ResponseBody
	public String updateStatistics(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		try {
			AjaxMsg msg = adminLeagueStatisticsService.updateStatistics(league_id);
			return msg.toJson();
		} catch (Exception e) {
			logger.error(e);
			return AjaxMsg.newError().toJson();
		}
	}
}

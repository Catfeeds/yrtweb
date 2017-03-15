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

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueScorer;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.service.admin.AdminLeagueScorerService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 联赛射手榜
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/leagueScorer")
public class AdminLeagueScorerController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminLeagueScorerController.class);

	@Autowired
	private AdminLeagueScorerService adminLeagueScorerService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String username = request.getParameter("username");
		String league_id = request.getParameter("league_id");
		String group_id = request.getParameter("group_id");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(group_id)) params.put("group_id", group_id);
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		AjaxMsg msg = adminLeagueScorerService.queryForPageForMap(params, pageModel);
		//List<League> leagues = adminLeagueGroupService.getLeagues();
		List<LeagueGroup> groups = adminLeagueGroupService.getGroupsByLid(league_id);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		request.setAttribute("league_id",league_id);
		request.setAttribute("groups",groups);
		return "admin/leaguescorer/leaguescorer"; 
	}
	
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		LeagueScorer scorer = new LeagueScorer();
		User user = new User();
		if(StringUtils.isNotBlank(id)){
			scorer = adminLeagueScorerService.getEntityById(id);
			user = userService.getEntityById(scorer.getUser_id());
		}
		List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("scorer", scorer);
		request.setAttribute("leagues", leagues);
		request.setAttribute("user", user);
		return "admin/leaguescorer/form"; 
	}
	
	@RequestMapping(value="/queryLeagueGroups")
	@ResponseBody
	public String queryLeagueGroups(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		List<LeagueGroup> groups = adminLeagueGroupService.getGroupsByLid(league_id);
		return AjaxMsg.newSuccess().addData("groups", groups).toJson();
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,LeagueScorer scorer){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(scorer.getId())){
			LeagueScorer s = adminLeagueScorerService.getEntityById(scorer.getId());
			s.setS_sort(scorer.getS_sort());
			msg = adminLeagueScorerService.update(s);
		}else{
			scorer.setId(UUIDGenerator.getUUID());	
			msg = adminLeagueScorerService.save(scorer);
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = adminLeagueScorerService.delete(id);
		return msg.toJson();
	}
	
	@RequestMapping(value="/userDialog")
	public String userDialog(HttpServletRequest request){
		return "admin/leaguescorer/user_dialog";
	}
	@RequestMapping(value="/recordDialog")
	public String recordDialog(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		request.setAttribute("league_id", league_id);
		return "admin/leaguescorer/record_dialog";
	}
	
	/**
	 * 更新射手榜
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateScorer")
	@ResponseBody
	public String updateScorer(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		try {
			AjaxMsg msg = adminLeagueScorerService.updateScorer(league_id);
			return msg.toJson();
		} catch (Exception e) {
			logger.error(e);
			return AjaxMsg.newError().toJson();
		}
	}
}

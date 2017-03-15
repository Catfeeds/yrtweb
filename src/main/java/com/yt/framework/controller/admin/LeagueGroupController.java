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

import com.google.common.collect.Lists;
import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 首页轮播图管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/leagueGroup")
public class LeagueGroupController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(LeagueGroupController.class);
	
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		AjaxMsg msg = adminLeagueGroupService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		request.setAttribute("league_id",league_id);
		return "admin/leaguegroup/leaguegroup"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		LeagueGroup groups = new LeagueGroup();
		if(StringUtils.isNotBlank(id)){
			groups = adminLeagueGroupService.getEntityById(id);
		}
		List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("groups", groups);
		request.setAttribute("leagues", leagues);
		return "admin/leaguegroup/form"; 
	}
	
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,LeagueGroup groups){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(groups.getId())){
			msg = adminLeagueGroupService.update(groups);
		}else{
			groups.setId(UUIDGenerator.getUUID());	
			msg = adminLeagueGroupService.save(groups);
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = adminLeagueGroupService.deleteGroup(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	@RequestMapping(value="/queryGroupByLid")
	@ResponseBody
	public String queryGroupByLid(HttpServletRequest request){
		String lid = request.getParameter("lid");
		List<LeagueGroup> groups = adminLeagueGroupService.getGroupsByLid(lid);
		return AjaxMsg.newSuccess().addData("groups", groups).toJson();
	}
	
	/**
	 * 进入分组编辑
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/toEditGroup")
	public String toEditGroup(HttpServletRequest request){
		String league_id = request.getParameter("id");
		League league = new League();
		List<Map<String, Object>> tList = Lists.newArrayList();
		List<LeagueGroup> gList = Lists.newArrayList();
		if(StringUtils.isNotBlank(league_id)){
			gList = adminLeagueGroupService.getGroupsByLid(league_id);
			league = leagueService.getEntityById(league_id);
			tList = leagueService.getTeamLeagueByLeague(league_id);
		}
		request.setAttribute("gList", gList);
		request.setAttribute("league", league);
		request.setAttribute("tList", tList);
		return "admin/leaguegroup/editGroup"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/editGroup")
	@ResponseBody
	public String editGroup(HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String group_id = request.getParameter("group_id");
		String league_id = request.getParameter("league_id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = adminLeagueGroupService.saveOrUpdateGroup(teaminfo_id,group_id,league_id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	
}

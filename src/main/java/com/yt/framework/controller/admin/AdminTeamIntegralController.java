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
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.service.admin.AdminTeamIntegralService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 联赛俱乐部积分
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/teamIntegral")
public class AdminTeamIntegralController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminTeamIntegralController.class);

	@Autowired
	private AdminTeamIntegralService adminTeamIntegralService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	
	@Autowired
	private TeamInfoService teamInfoService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String tname = request.getParameter("tname");
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(tname)) params.put("tname", tname);
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		AjaxMsg msg = adminTeamIntegralService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		request.setAttribute("league_id", league_id);
		return "admin/teamintegral/teamintegral"; 
	}
	
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		TeamIntegral integral = new TeamIntegral();
		TeamInfo teamInfo = new TeamInfo();
		if(StringUtils.isNotBlank(id)){
			integral = adminTeamIntegralService.getEntityById(id);
			teamInfo = teamInfoService.getEntityById(integral.getTeaminfo_id());
			if(null != integral){
				//编辑页面不可修改联赛、分组信息
				request.setAttribute("flag", "true");
			}
		}
		List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("integral", integral);
		request.setAttribute("leagues", leagues);
		request.setAttribute("teamInfo", teamInfo);
		return "admin/teamintegral/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,TeamIntegral integral){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(integral.getId())){
			msg = adminTeamIntegralService.update(integral);
		}else{
			integral.setId(UUIDGenerator.getUUID());	
			msg = adminTeamIntegralService.save(integral);
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = adminTeamIntegralService.delete(id);
		return msg.toJson();
	}
	
	@RequestMapping(value="/dialog")
	public String dialog(HttpServletRequest request){
		String dom_id = request.getParameter("dom_id");
		String dom_name = request.getParameter("dom_name");
		String group_id = request.getParameter("group_id");
		String league_id = request.getParameter("league_id");
		request.setAttribute("dom_id", BeanUtils.nullToString(dom_id));
		request.setAttribute("dom_name", BeanUtils.nullToString(dom_name));
		request.setAttribute("group_id", BeanUtils.nullToString(group_id));
		request.setAttribute("league_id", BeanUtils.nullToString(league_id));
		return "admin/leagueteam/dialog";
	}
}

package com.yt.framework.controller.admin;

import java.util.HashMap;
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
import com.yt.framework.service.admin.AdminTeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台俱乐部管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/teamInfo")
public class AdminTeamInfoController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminTeamInfoController.class);

	@Autowired
	private AdminTeamInfoService adminTeamInfoService;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		String is_exist = request.getParameter("is_exist");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(is_exist)) params.put("is_exist", is_exist);
		AjaxMsg msg = adminTeamInfoService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/teaminfo/teaminfo"; 
	}
	
	@RequestMapping(value="/selectTeam")
	public String dialog(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		String is_exist = request.getParameter("is_exist");
		String type = request.getParameter("type");
		String not_exists = request.getParameter("not_exists");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(is_exist)) params.put("is_exist", is_exist);
		if(StringUtils.isNotBlank(not_exists)) params.put("not_exists", not_exists);
		AjaxMsg msg = adminTeamInfoService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		params.put("type", type);
		request.setAttribute("params",params);
		return "admin/teaminfo/select_team"; 
	}
	
	@RequestMapping(value="/selectLeagueTeam")
	public String selectLeagueTeam(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		String is_exist = request.getParameter("is_exist");
		String group_id = request.getParameter("group_id");
		String league_id = request.getParameter("league_id");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		if(StringUtils.isNotBlank(is_exist)) params.put("is_exist", is_exist);
		if(StringUtils.isNotBlank(group_id)) params.put("group_id", group_id);
		if(StringUtils.isNotBlank(group_id)) params.put("league_id", league_id);
		AjaxMsg msg = adminTeamInfoService.queryTeamLeagueForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		params.put("type", type);
		request.setAttribute("params",params);
		return "admin/leagueteam/select_league_team"; 
	}
	
	/**
	 * 俱乐部列表 推荐俱乐部
	 * @return
	 */
	@RequestMapping(value="/recommendation")
	public String recommendation(HttpServletRequest request,PageModel pageModel){
		String name = request.getParameter("name");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(name)) params.put("name", name);
		AjaxMsg msg = adminTeamInfoService.queryRecommendation(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/teaminfo/recommend"; 
	}
	
	@RequestMapping(value="/saveRecommendation")
	@ResponseBody
	public String saveRecommendation(HttpServletRequest request,String teamIds){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(teamIds)){
			msg = adminTeamInfoService.saveRecommendation(teamIds, getUserId());
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/updateRecommendation")
	@ResponseBody
	public String updateRecommendation(HttpServletRequest request){
		String id = request.getParameter("id");
		String sort = request.getParameter("re_sort");
		Map<String, Object> maps = new HashMap<String,Object>();
		maps.put("id", id);
		maps.put("re_sort", sort);
		maps.put("user_id", getUserId());
		AjaxMsg msg = adminTeamInfoService.updateRecommendation(maps);
		return msg.toJson();
	}
	
	@RequestMapping(value="/deleteRecommendation")
	@ResponseBody
	public String deleteRecommendation(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = adminTeamInfoService.deleteRecommendation(id);
		return msg.toJson();
	}
	
	@RequestMapping(value="/recDialog")
	public String recDialog(HttpServletRequest request){
		return "admin/teaminfo/rec_dialog";
	}
	
}

package com.yt.framework.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.persistent.enums.TeamEnum.ROLETYPE;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.EventForecastService;
import com.yt.framework.service.ImageVideoLeagueService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.NewsService;
import com.yt.framework.service.PkRecordService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 我的联赛
 * @author 
 * @date 2015年11月9日11:45:02
 */
@Controller
@RequestMapping(value="/myleague/")
public class MyLeagueController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(MyLeagueController.class);

	@Autowired
	private LeagueService leagueService;
	@Autowired
	private PkRecordService pkRecordService;
	@Autowired
	private EventForecastService eventForecastService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private ImageVideoLeagueService imageVideoLeagueService;
	@Autowired
	private DynamicService dynamicService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	/**
	 * 我的联赛页面
	 * @param model
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="index")
	public String myleague(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		String league_id = request.getParameter("league_id");
		TeamInfo ti = teamInfoService.getTeamInfoByPUserID(user_id);
		//获取用户最近一场联赛预告
		Map<String,Object> data = eventForecastService.getEventForecastLastByUserId(ti.getId(), league_id);
		//获取用户俱乐部最新七条数据
		PageModel pageModel = new PageModel();
		pageModel.setPageSize(6);
		Map<String,Object> map = Maps.newHashMap();
		map.put("teaminfo_id", ti.getId());
		map.put("league_id", league_id);
		AjaxMsg reMsg = newsService.queryForPageForMap(map, pageModel);
		if(reMsg.isSuccess()){
			model.addAttribute("news", reMsg.getData("page"));
		}
		//俱乐部最新动态信息10条
		AjaxMsg dyMsg = dynamicService.queryNewTeamDynamic(map, null);
		if(dyMsg.isSuccess()){
			model.addAttribute("dynamics", dyMsg.getData("page"));
		}
		//获取俱乐部相关信息
		//Map<String,Object> teamMap = pkRecordService.teamInfoLeague(map);
		//teamMap.put("teaminfo", ti);
		model.addAttribute("teamMap", ti);
		model.addAttribute("data", data);
		//add gl
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		//add
		//获取联赛俱乐部联赛积分
		TeamIntegral teamIntegral = leagueService.getTeamIntegralByID(ti.getId(), league_id);
		model.addAttribute("teamIntegral", teamIntegral);
		model.addAttribute("league_id", league_id);
		return "league/myleague";
	}
	
	/**
	 * 赛事视频
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="ivs")
	public String videos(Model model,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		String league_id=request.getParameter("league_id");
		TeamInfo ti = teamInfoService.getTeamInfoByPUserID(user_id);
		Map<String,Object> map = Maps.newHashMap();
		map.put("league_id", league_id);
		map.put("teaminfo_id", ti.getId());
		map.put("type", "2");
		pageModel.setPageSize(7);
		AjaxMsg msg = imageVideoLeagueService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("ivs", msg.getData("page"));
		}
		return "league/league_video";
	}
	
	/**
	 * 精彩图片
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="images")
	public String images(Model model,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		String league_id = request.getParameter("league_id");
		TeamInfo ti = teamInfoService.getTeamInfoByPUserID(user_id);
		Map<String,Object> map = Maps.newHashMap();
		map.put("league_id", league_id);
		map.put("teaminfo_id", ti.getId());
		map.put("type", "1");
		pageModel.setPageSize(7);
		AjaxMsg msg = imageVideoLeagueService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("images", msg.getData("page"));
		}
		return "league/league_image";
	}
	
	/**
	 * 我的赛程
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="history")
	public String histotyPage(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		String league_id = request.getParameter("league_id");
		TeamInfo ti = teamInfoService.getTeamInfoByPUserID(user_id);
		Map<String,Object> map = Maps.newHashMap();
		map.put("teaminfo_id", ti.getId());
		map.put("league_id", league_id);
		AjaxMsg msg = pkRecordService.queryForPageForMap(map, null);
		if(msg.isSuccess()){
			model.addAttribute("datas",msg.getData("page"));
		}
		return "league/league_history";
	}
	
	/**
	 * 俱乐部成员信息
	 * @param page
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="teamInfo/{page}")
	public String teamInfo(@PathVariable("page") String page,Model model,HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(page))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		List<Map<String,Object>> data = Lists.newArrayList();
		if(page.equals(ROLETYPE.SHOOTER.toString())){
			data = leagueService.loadScorerDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.STAGE.toString())){
			data = leagueService.loadHisDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.BABY.toString())){
			data = leagueService.loadBabyDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.BACK.toString())){
			data = leagueService.loadBackDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.FRONT.toString())){
			data = leagueService.loadFrontDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.GATE.toString())){
			data = leagueService.loadGatekeeperDatas(teaminfo_id);
		}else if(page.equals(ROLETYPE.MIDFIELD.toString())){
			data = leagueService.loadMidfieldDatas(teaminfo_id);
		}
		model.addAttribute("data", data);
		return "league/team/"+page;
	}
}

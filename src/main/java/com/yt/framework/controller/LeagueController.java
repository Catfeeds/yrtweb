package com.yt.framework.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.InviteMsg;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueCost;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QScoreInfo;
import com.yt.framework.persistent.entity.QSummaryInfo;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.CertificationEnum.CerType;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.ImageVideoLeagueService;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueCostService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.NewsService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.PriceSlaveService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.ActiveCodeService;
import com.yt.framework.service.admin.AdminSysAreaService;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.SpringContextUtil;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.ImageUtils;
import com.yt.framework.utils.gson.JSONUtils;

/**
 * 联赛
 * 
 * @autor ylt
 * @date2015-10-14下午2:46:36
 */
@Controller
@RequestMapping(value = "/league")
public class LeagueController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(LeagueController.class);
	@Autowired
	private CertificaService certificaService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private ActiveCodeService activeCodeService;
	@Autowired
	private LeagueCostService leagueCostService;
	@Autowired
	private ImageVideoLeagueService imageVideoLeagueService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private PriceSlaveService priceSlaveService;
	@Autowired
	private LeagueAuctionService leagueAuctionService;
	@Autowired
	private QuanLeagueService quanLeagueService;
	@Autowired
	private UserService userService;
	/** 
	 * 联赛首页跳转
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value = "old_index")
	public String old_index(Model model, HttpServletRequest request) {
		String league_id = "";
		League league = leagueService.getEntityById(league_id);
		List<Map<String,Object>> groups = leagueService.loadLeagueGroup(league_id);
		request.setAttribute("league_id", league_id);
		request.setAttribute("league", league);
		request.setAttribute("groups", groups);
		List<League> leagueList = leagueService.getLeagues();
		request.setAttribute("leagueList", leagueList);
		return "league/index/old_index";
	}
	/**
	 * @autor gl
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "index")
	public String index(HttpServletRequest request) {
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		request.setAttribute("now_league_id", league_id);
		List<League> leagueList = leagueService.getLeagues();
		if(league_id.equals("")){
			if(!leagueList.isEmpty()){
				League league = leagueList.get(0);
				league_id = league.getId();
				request.setAttribute("league", league);
			}
			request.setAttribute("indexFlag", true);
			List<LeagueCfg> leagueCfgList = leagueService.getLeaugeCfgList();
			request.setAttribute("leagueCfgList", leagueCfgList);
		}else{
			request.setAttribute("indexFlag", false);
			League league = leagueService.getEntityById(league_id);
			request.setAttribute("league", league);
		}
		/*List<Map<String,Object>> groups = leagueService.loadLeagueGroup(league_id);
		request.setAttribute("groups", groups);*/
		request.setAttribute("league_id", league_id);
		request.setAttribute("leagueList", leagueList);
		return "league/index/league_index";
	}
	
	/**
	 * 联赛预告数据
	 * @autor gl
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryEventForecast")
	@ResponseBody
	public String queryEventForecast(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		//查询联赛预告
		Map<String, Object> forecasts = leagueService.queryEventForecast(league_id);
		if(forecasts!=null&&forecasts.size()>0){
			return AjaxMsg.newSuccess().addData("forecasts", forecasts).toJson(); 
		}else{
			return AjaxMsg.newSuccess().addMessage("暂无数据...").toJson();
		}
	}
	
	/**
	 * 联赛赛程列表
	 * @autor gl
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "eventRecords")
	public String eventRecords(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		if(StringUtils.isNotBlank(league_id)){
			League league = leagueService.getEntityById(league_id);
			if(league!=null){
				List<Map<String,Object>> groups = leagueService.loadLeagueGroup(league_id);
				request.setAttribute("league", league);
				request.setAttribute("groups", groups);
				return "league/league_event_record";
			}
		}
		return "";
	}
	
	@RequestMapping(value = "queryEventRecords")
	public String queryEventRecords(HttpServletRequest request,PageModel pageModel){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		String group_id = BeanUtils.nullToString(request.getParameter("group_id"));
		String round_id = BeanUtils.nullToString(request.getParameter("round_id"));
		String tname = BeanUtils.nullToString(request.getParameter("tname"));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("league_id", league_id);
		params.put("group_id", group_id);
		params.put("rounds", round_id);
		params.put("tname", tname);
		AjaxMsg msg = leagueService.queryEventRecords(params,pageModel);
		request.setAttribute("records", msg.getData("page"));
		request.setAttribute("params", params);
		return "league/record/event_record_datas";
	}
	
	
	/**
	 * 联赛协议
	 * @return
	 */
	@RequestMapping(value = "agreement")
	public String  agreement(HttpServletRequest request){
		String cfgid = request.getParameter("cfgid");
		String type = request.getParameter("type");
		request.setAttribute("cfgid", cfgid);
		request.setAttribute("type", type);
		return "league/agreement";
	}
	
	@RequestMapping(value="event")
	public String eventRecord(Model model,HttpServletRequest request){
		String play_time = request.getParameter("play_time");//比赛时间
		Map<String,Object> maps = Maps.newHashMap();
		String league_id = request.getParameter("league_id");//联赛ID
		//获取联赛分组
		List<Map<String,Object>> groups = leagueService.loadLeagueGroup(league_id);
		//获取联赛赛程
		maps.put("league_id", league_id);
		maps.put("play_time", play_time);
		List<Map<String,Object>> e_records = leagueService.loadEventRecord(maps);
		model.addAttribute("groups", groups);
		model.addAttribute("e_records", e_records);
		return "league/event_record";
	}
	
	/**
	 * 联赛图片
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="images")
	public String leagueImages(Model model,HttpServletRequest request,PageModel pageModel){
		pageModel.setPageSize(5);
		Map<String,Object> maps = Maps.newHashMap();
		String league_id = request.getParameter("league_id");
		String if_show = request.getParameter("if_show");
		maps.put("league_id", league_id);
		maps.put("type", "1");
		maps.put("if_show", if_show);
		AjaxMsg msg = imageVideoLeagueService.loadAllLeaguePhotosVideos(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("photos", msg.getData("page"));
		}
		return "league/league_photos";
	}
	
	/**
	 * 联赛视频
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="ivs")
	public String LeagueVideos(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String league_id = request.getParameter("league_id");
		String if_show = request.getParameter("if_show");
		String type = request.getParameter("type");
		maps.put("league_id", league_id);
		maps.put("type", type);
		maps.put("if_show", if_show);
		AjaxMsg msg = imageVideoLeagueService.loadAllLeaguePhotosVideos(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("ivs", msg.getData("page"));
		}
		if("2".equals(type)){
			String user_img = "headImg/headimg.png";
			if(getUser()!=null){
				user_img = getUser().getHead_icon();
			}
			request.setAttribute("user_img", user_img);
			return "league/ivs/league_videos";
		}else if("1".equals(type)){
			return "league/ivs/league_images";
		}
		return "";
		//return "league/league_tvs";
	}
	
	/**
	 * 新闻
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="news")
	public String news(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		Map<String,Object> maps = Maps.newHashMap();
		if(StringUtils.isNotBlank(league_id)){
			maps.put("model_id", league_id);
		}
		maps.put("type", 1);//查询新闻
		AjaxMsg msg = newsService.loadAllNews(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("news",  msg.getData("page"));
		}
		return "league/league_news";
	}
	
	/**
	 * 积分榜数据
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="integral")
	public String integral(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));//联赛ID
		List<Map<String,Object>> groups = leagueService.loadLeagueGroup(league_id);
		String group_id = BeanUtils.nullToString(request.getParameter("group_id"));//分组ID
		if(group_id.equals("")){
			if(!groups.isEmpty()){
				Map<String,Object> gMap = groups.get(0);
				group_id = BeanUtils.nullToString(gMap.get("id"));
			}
		}
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("group_id", group_id);
		maps.put("league_id", league_id);
		AjaxMsg msg = leagueService.loadIntegral(maps, pageModel);
		model.addAttribute("intes", msg.getData("page"));
		model.addAttribute("groups", groups);
		model.addAttribute("group_id", group_id);
		return "league/integral/league_integral";
	}
	
	/**
	 * 射手榜信息
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="scorer")
	public String scorers(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", league_id);
		AjaxMsg msg = leagueService.loadLeagueScorer(maps, pageModel);
		model.addAttribute("scorers", msg.getData("page"));
		return "league/league_scorer";
	}
	
	/**
	 * 宝贝榜信息
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="baby")
	public String footballBaby(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("role_type", 6);
		AjaxMsg msg = leagueService.getFootBabyCharm(maps, pageModel);
		model.addAttribute("babys", msg.getData("page"));
		return "league/league_baby";
	}
	
	/**
	 * 红黄榜信息页面
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="toCard")
	public String toCard(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		request.setAttribute("league_id", league_id);
		League league = leagueService.getEntityById(league_id);
		List<League> leagueList = leagueService.getLeaguesByCondition(Maps.newHashMap());
		request.setAttribute("league", league);
		request.setAttribute("leagues", leagueList);
		return "league/card/league_card";
	}
	
	/**
	 * 红黄榜信息
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="userCard")
	public String userCard(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		maps.put("league_id", league_id);
		AjaxMsg msg = quanLeagueService.getQUserDataCardStatics(maps,pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "league/card/result_card";
	}
	
	/**
	 * 红黄榜信息
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="cardList")
	public String cardList(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		maps.put("league_id", league_id);
		AjaxMsg msg = quanLeagueService.getQUserDataCardStatics(maps,pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "league/card/card_list";
	}
	
	/**
	 * 选择赛区
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "selectArea")
	public String selectArea(HttpServletRequest request){
		//查询进行中赛区联赛
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("status", "1");
		params.put("if_show", "1");
		List<Map<String, Object>> areas = leagueService.queryLeagueArea(params);
		request.setAttribute("leagueAreas", areas);
		return "league/league_area";
	}
	
	/**
	 * 选择报名身份
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "identity")
	public String identity(HttpServletRequest request){
		//String league_id = request.getParameter("league_id");
		String cfg_id = request.getParameter("cfg_id");
		String userId = getUserId();
		
		if(StringUtils.isNotBlank(cfg_id)){
			LeagueSign sign = leagueService.getSignByLeague(userId,cfg_id);
			if(sign!=null&&cfg_id.equals(sign.getS_id())){
				return "redirect:/league/toSign?cfg_id="+cfg_id;
			}
			
			TeamInfo team = teamInfoService.getTeamInfoByUserId(userId);
			if(team!=null){
				//检测是否处理参赛确认信息状态
				InviteMsg imsg = leagueService.getBeGood4InviteMsg(team.getId());
				if(imsg!=null){
					return "redirect:/league/selectArea";
				}
				
				TeamLeague teamLeague = leagueService.getTeamSignByLeague(team.getId(),null);
				if(teamLeague!=null){
					return "redirect:/league/teamSign?cfg_id="+cfg_id;
				}
			}
			LeagueCfg cfg = leagueService.getLeagueCfgById(cfg_id);
			if(cfg!=null&&cfg.getStatus()!=2){
				request.setAttribute("cfg", cfg);
				return "league/identity";
			}
		}
		return "";
	}
	
	/**
	 * 联赛申请报名
	 * @autor ylt gl
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="applySign")
	@ResponseBody
	public String applySign(HttpServletRequest request,LeagueSign leagueSign,Certification certification,PlayerInfo playerInfo,@RequestParam("p_position[]")String[] p_position) {
//		String league_id = request.getParameter("league_id");
		String cfg_id = request.getParameter("cfg_id");
		if(StringUtils.isBlank(cfg_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.no")).toJson(); 
		String login_user_id = super.getUserId();
		if(null == login_user_id) return AjaxMsg.newError().addMessage("system.warn.login").toJson(); 
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			//检测报名时间
//			League league = leagueService.getEntityById(league_id);
			LeagueCfg cig = leagueService.getLeagueCfgById(cfg_id);
			if(cig==null){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
//			LeagueSign oldSign = leagueService.getLeagueSign(login_user_id,league_id);
			LeagueSign oldSign = leagueService.getSignByLeague(login_user_id, cfg_id);
			if(oldSign!=null&&oldSign.getStatus()==1){//已报名成功后刷新页面
				return AjaxMsg.newError().addData("l_status", 1).toJson();
			}
			long nowtime = new Date().getTime();
			long sstime = cig.getS_starttime().getTime();
			long setime = cig.getS_endtime().getTime();
			if(nowtime<sstime||nowtime>setime){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.signtime")).toJson();
			}
			Certification cert = certificaService.getCertificationByUserId(login_user_id, CerType.IDCARD.toString());
			if(certification.getStatus()!=1){
				certification.setType(CerType.IDCARD.toString());
				certification.setStatus(2);
				certification.setUser_id(login_user_id);
				certification.setDescripe("用户身份证认证");
				if(cert!=null){
					certification.setStatus(cert.getStatus());
					certification.setId(cert.getId());
					msg = certificaService.updateCertification(certification);
				}else{
					certification.setId(UUIDGenerator.getUUID());
					//updated bo.xie 存入数据时需要校验该身份证号是否已被认证成功或者正在认证当中 start
					msg = certificaService.saveCertification(certification);
					if(msg.isError())return msg.toJson();
						//msg = certificaService.save(certification);
					//updated bo.xie 存入数据时需要校验该身份证号是否已被认证成功或者正在认证当中 end
				}
			}
			if(msg.isError()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
			PlayerInfo player = playerInfoService.getPlayerInfoByUserId(login_user_id);
			String positions = "";
			if(p_position!=null&&p_position.length>0){
				for (String position : p_position) {
					positions+=position+",";
				}
				positions = positions.substring(0,positions.lastIndexOf(","));
			}
			if(player==null){
				//player = new PlayerInfo();
				playerInfo.setUser_id(login_user_id);
				String heigth = String.valueOf(leagueSign.getHeight());
				if(heigth!=null&&heigth.indexOf(".")>0){
					heigth = heigth.substring(0,heigth.indexOf("."));
				}
				playerInfo.setHeight(Integer.parseInt(heigth));
				playerInfo.setWeight(leagueSign.getWeight());
				playerInfo.setPosition(leagueSign.getPosition());
				playerInfo.setCfoot(leagueSign.getCfoot());
				playerInfo.setPosition(positions);
				playerInfo.setPro_status(0);
				playerInfo.setBall_format(7);
				playerInfo.setInvitat_team(0);
				playerInfo.setLove_num(leagueSign.getLove_num());
				msg = playerInfoService.savePlayerInfo(playerInfo,request);
			}else{
				player.setUser_id(login_user_id);
				String heigth = String.valueOf(leagueSign.getHeight());
				if(heigth!=null&&heigth.indexOf(".")>0){
					heigth = heigth.substring(0,heigth.indexOf("."));
				}
				player.setHeight(Integer.parseInt(heigth));
				player.setWeight(leagueSign.getWeight());
				player.setPosition(leagueSign.getPosition());
				player.setCfoot(leagueSign.getCfoot());
				player.setPosition(positions);
				player.setLove_num(leagueSign.getLove_num());
				msg = playerInfoService.updatePlayerInfo(updatePlayerInfo(playerInfo,player));
			}
			if(msg.isError()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
			
			TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(login_user_id);
			if(teamPlayer != null){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
			}
			
//			leagueSign.setLeagues_id(league_id);
			leagueSign.setS_id(cfg_id);
			leagueSign.setUser_id(login_user_id);
			leagueSign.setStatus(2);
			leagueSign.setPosition(positions);
			leagueSign.setIdCard(certification.getId_card());
			//是否填写邀请码
			String active_code = leagueSign.getActive_code();
			if(StringUtils.isNotBlank(active_code)){
				//验证邀请码是否有效
				msg = leagueService.updatePlayerCode(login_user_id,cfg_id,active_code);
				if(msg.isError())return msg.toJson();
			}
			if(oldSign!=null){
				leagueSign.setId(oldSign.getId());
				if(StringUtils.isNotBlank(oldSign.getActive_code())){
					leagueSign.setActive_code(oldSign.getActive_code());
				}
				msg = leagueService.updateQLeagueSign(leagueSign);
			}else{
				leagueSign.setId(UUIDGenerator.getUUID());
				msg = leagueService.saveLeagueSign(leagueSign);
			} 
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 取消使用邀请码
	 * @return
	 */
	@RequestMapping(value="deleteActiveCode")
	@ResponseBody
	public String cancelActiveCode(HttpServletRequest request,String cfg_id){
		try {
//			League league = leagueService.getEntityById(league_id);
			LeagueCfg cig = leagueService.getLeagueCfgById(cfg_id);
			if(cig==null){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			LeagueSign leagueSign = leagueService.getSignByLeague(getUserId(), cfg_id);
			if(leagueSign!=null&&leagueSign.getStatus()==1){//已报名成功后刷新页面
				return AjaxMsg.newError().addData("l_status", 1).toJson();
			}
			AjaxMsg msg = leagueService.updateActiveCode(leagueSign);
			return msg.toJson();
		} catch (Exception e) {
			logger.error(e);
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
	}
	
	
	private PlayerInfo updatePlayerInfo(PlayerInfo playerInfo,PlayerInfo info) {
		info.setTack_ability(playerInfo.getTack_ability());
		info.setPass_ability(playerInfo.getPass_ability());
		info.setRespond_ability(playerInfo.getRespond_ability());
		info.setBall_ability(playerInfo.getBall_ability());
		info.setExplosive(playerInfo.getExplosive());
		info.setId(playerInfo.getId());
		info.setShot(playerInfo.getShot());
		info.setBalance(playerInfo.getBalance());
		//info.setAttack(playerInfo.getAttack());
		info.setInsight(playerInfo.getInsight());
		info.setHeader(playerInfo.getHeader());
		info.setFree_kick(playerInfo.getFree_kick());
		info.setFill(playerInfo.getFill());
		info.setPhysical(playerInfo.getPhysical());
		info.setSpeed(playerInfo.getSpeed());
		info.setPower(playerInfo.getPower());
		info.setGoal(playerInfo.getGoal());
		return info;
	}

	/**
	 * 联赛报名页面
	 * @autor ylt gl
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="toSign")
	public String toSign(Model model,HttpServletRequest request) {
		String login_user_id = super.getUserId();
		//String league_id = request.getParameter("league_id");
		String cfg_id = request.getParameter("cfg_id");
		String tag = request.getParameter("tag");
		int ifCer = 0; // 0：未认证  1：已认证  2：认证中  3：认证失败
		int ifPlayer = 0; //是否激活球员 0:否    1：是
		int ifTeamPlayer = 0;//是否激活球员 0:否   1:是
		boolean playerFlag = false;
		try {
			LeagueCfg cig = leagueService.getLeagueCfgById(cfg_id);
			if(cig==null){
				return "";
			}
			if(StringUtils.isNotBlank(tag)&&!"repeat".equals(tag)){
				return "";
			}
			model.addAttribute("cfg_id", cfg_id);
			//获取报名信息
			LeagueSign leagueSign = leagueService.getSignByLeague(login_user_id, cfg_id);
			
			if(leagueSign!=null){
				//审核通过
				if(leagueSign.getEntry_mode()!=null&&(leagueSign.getEntry_mode()==1||leagueSign.getEntry_mode()==2)){
					model.addAttribute("entryMode", leagueSign.getEntry_mode());
					return "league/sign_success";
				}
				if(leagueSign.getStatus()==1){
					/*LeagueCost cost = leagueCostService.getLeagueCostByUserId(login_user_id, league_id);
					//判断是否支付成功
					if(cost!=null&&cost.getStatus()==1){
						return "league/entry_mode";
					}else{
						return "league/league_pay"; 
					}*/
					return "league/entry_mode";
				}
				if(!StringUtils.isNotBlank(tag)){
					String position = BeanUtils.nullToString(leagueSign.getPosition());
					String[] pos = position.split(",");
					String posStr = "";
					for (String str : pos) {
						posStr+=ParamMap.getParam("p_position", str)+" , ";
					}
					posStr = posStr.substring(0,posStr.lastIndexOf(","));
					leagueSign.setPosition(posStr);
					playerFlag = true;
				}
			}
			
			User user = userService.getEntityById(login_user_id);
			String headImg = user.getHead_icon();
			if(StringUtils.isNotBlank(headImg)&&!"headImg/headimg.png".equals(headImg)&&!"headImg/headimg.jpg".equals(headImg)){
				model.addAttribute("head_icon",headImg);
			}
			//判断球员是否实名认证
			Certification certification = certificaService.getCertificationByUserId(login_user_id, "idcard");
			if(certification!=null){	
				model.addAttribute("certification",certification);
				ifCer = certification.getStatus();
			}
			//判断球员是否激活球员
			AjaxMsg msg = playerInfoService.getPlayerInfoByUserId(login_user_id,playerFlag);
			Map<String, Object> playerInfo = (Map<String, Object>) msg.getData("data");
			if(playerInfo!=null){	
				model.addAttribute("playerInfo",playerInfo);
				ifPlayer = 1;
			}
			//球员是否已加入俱乐部
			TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(login_user_id);
			if(teamPlayer != null){
				model.addAttribute("teamPlayer", teamPlayer);
				ifTeamPlayer = 1;
			}
			request.setAttribute("paramMap", ParamMap.getMap());
			model.addAttribute("ifCer", ifCer);
			model.addAttribute("ifPlayer", ifPlayer);
			model.addAttribute("ifTeamPlayer", ifTeamPlayer);
			model.addAttribute("leagueSign", leagueSign);
			if(leagueSign!=null&&!StringUtils.isNotBlank(tag)){
				return "league/league_sign";
			}else{
				return "league/league_sign_edit";
			}
			
		} catch (Exception e) {
			return "";
		}
	}
	
	/**
	 * 俱乐部报名
	 * @return
	 */
	@RequestMapping(value="applyTeamSign")
	@ResponseBody
	public String applyTeamSign(HttpServletRequest request,TeamLeague tleague){
		String code_str = request.getParameter("code_str");
		String logo = request.getParameter("logo");
		String logoType = request.getParameter("logoType");
		String name = request.getParameter("name");
		String sim_name = request.getParameter("sim_name");
		
		//检测激活码是否可用
		ActiveCode code = activeCodeService.getActiveCode(code_str);
		if(code!=null){
			Date endDate = code.getEnd_time();
			int bday = Common.getBetweenDay(new Date(), endDate);
			if(bday<0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codetimeout")).toJson(); 
			}
			if(code.getStatus()==2){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenouser")).toJson();
			}
			code.setUser_id(getUserId());
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codeerr")).toJson(); 
		}
		//查询联赛获取sid
		League league = leagueService.getEntityById(code.getLeague_id());
		if(league.getStatus()==2){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.ended")).toJson();
		}
		tleague.setS_id(league.getS_id());//设置赛季Id
		//检测报名时间
		LeagueCfg cig = leagueService.getLeagueCfgById(tleague.getS_id());
		if(cig==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		long nowtime = new Date().getTime();
		long sstime = cig.getS_starttime().getTime();
		long setime = cig.getS_endtime().getTime();
		if(nowtime<sstime||nowtime>setime){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.signtime")).toJson();
		}
		//检测是否已经报过名
		//TeamLeague teamLeague = leagueService.getTeamLeague(tleague.getLeague_id(),tleague.getTeaminfo_id());
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(tleague.getTeaminfo_id(),null);
		if(teamLeague==null){
			//检测报名人是否队长
			TeamInfo tinfo = null;
			TeamInfo team = teamInfoService.getTeamInfoByUserId(getUserId());
			if(team!=null){
				tinfo = team;
				tinfo.setSim_name(sim_name);
				code.setTeaminfo_id(team.getId());//设置使用邀请码的俱乐部
				if(code.getP_status() == 0){
					//检测球队是否有其他成员
					Map<String, Object> maps = Maps.newHashMap();
					maps.put("teaminfo_id", team.getId());
					AjaxMsg plist = teamInfoService.getTeamPlayerList(maps, new PageModel());
					PageModel pmodel = (PageModel) plist.getData("page");
					List<Map<String, Object>> teamPlayerList = (List<Map<String, Object>>) pmodel.getItems();
					if(teamPlayerList!=null&&teamPlayerList.size()>1){
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.players")).addData("havaPlayers", 1).toJson(); 
					}
				}
			}else{
				PlayerInfo pi = playerInfoService.getPlayerInfoByUserId(getUserId());
				if(pi==null){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noplayer")).toJson(); 
				}
				Map<String,Object> map = Maps.newHashMap();
				map.put("name", name);
				int count = teamInfoService.count(map);
				if(count>0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.names")).toJson();	
				tinfo = new TeamInfo();
				tinfo.setUser_id(getUserId());
				tinfo.setName(name);
				if(!"1".equals(logoType)){
					tinfo.setLogo(ImageUtils.subResouceUrl(logo, "resources"));
				}else{
					//added by bo.xie 插入上传俱乐部icon
					tinfo.setLogo(logo);
				}
				tinfo.setScore(13);
				tinfo.setImage_count(5);
				tinfo.setVideo_count(2);
				tinfo.setBall_format(7);
				tinfo.setPlay_time(1);
				tinfo.setIs_pk(0);
				tinfo.setAllow(0);
				tinfo.setProvince("四川省");
				tinfo.setCity("成都市");
				tinfo.setSim_name(sim_name);
			}
			
			//检测俱乐部简称是否重复
			AjaxMsg msg =  teamInfoService.checkSimNameAgain(sim_name,tinfo.getId());
			if(msg.isError()){return msg.toJson(); }
			try {
				AjaxMsg tmsg = leagueService.saveTeamLeague(tleague,tinfo,code,request);
				return tmsg.toJson();
			} catch (Exception e) {
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
	}
	
	@RequestMapping(value="teamSign")
	public String teamSign(HttpServletRequest request){
		String cfg_id = request.getParameter("cfg_id");
		try {
			request.setAttribute("cfg_id", cfg_id);
			//LeagueSign leagueSign = leagueService.getLeagueSign(getUserId(),league_id);
			LeagueSign leagueSign = leagueService.getSignByLeague(getUserId(), cfg_id);
			if(leagueSign!=null){
				return "redirect:/league/identity?cfg_id="+cfg_id; 
			}
			TeamInfo team = teamInfoService.getTeamInfoByUserId(getUserId());
			if(team!=null){
				//检测是否处理参赛确认信息状态
				InviteMsg imsg = leagueService.getBeGood4InviteMsg(team.getId());
				if(imsg!=null){
					return "redirect:/league/selectArea";
				}
				//检测是否实名认证
				//检测用户是否实名认证
				Certification certification =  certificaService.getCertificationByUserId(getUserId(), "idcard");
				if(certification == null || certification.getStatus()!= 1){
					return "redirect:/league/identity?cfg_id="+cfg_id; 
				}
				//TeamLeague tleague = leagueService.getTeamLeague(league_id,team.get("id").toString());
				TeamLeague teamLeague = leagueService.getTeamSignByLeague(team.getId(),null);
				if(teamLeague!=null){
					/*if(!cfg_id.equals(teamLeague.getS_id())){
						return "redirect:/league/identity?cfg_id="+cfg_id; 
					}*/
					return "league/team_sign_success";
				}
				int havaPlayers = 0;
				/*if(team.getP_status()==null || team.getP_status()!=1){
					//检测球队是否有其他成员
					Map<String, Object> maps = Maps.newHashMap();
					maps.put("teaminfo_id", team.getId());
					AjaxMsg plist = teamInfoService.getTeamPlayerList(maps, new PageModel());
					PageModel pmodel = (PageModel) plist.getData("page");
					List<Map<String, Object>> teamPlayerList = (List<Map<String, Object>>) pmodel.getItems();
					//List<Map<String, Object>> teamPlayerList = (List<Map<String, Object>>) plist.getData("page.items");
					if(teamPlayerList!=null&&teamPlayerList.size()>1){
						havaPlayers = 1;
					}
				}*/
				request.setAttribute("team", team);
				request.setAttribute("havaPlayers", havaPlayers);
				return "league/league_team_sign";
			}else{
				return "league/league_team_sign_edit";
			}
		} catch (Exception e) {
			return "";
		}
	}
	
	/**
	 * 删除球队所有球员
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteAllPlayers")
	@ResponseBody
	public String deleteAllPlayers(HttpServletRequest request){
		//检测报名人是否队长
		AjaxMsg msg = playerInfoService.getTeamByUserId(getUserId());
		if(msg.isSuccess()){
			Map<String, Object> team = (Map<String, Object>) msg.getData("data");
			String type = team.get("type").toString();
			if(!"1".equals(type)){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.teamsign")).toJson(); 
			}
			return teamInfoService.deleteAllPlayers(team.get("id").toString()).toJson();
		}
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
	}
	
	
	/**
	 * 检测用户是否已经报名其他区联赛
	 * @autor gl
	 * @param request
	 * @return
	 */
	@RequestMapping(value="checkAgainSign")
	@ResponseBody
	public String checkAgainSign(HttpServletRequest request){
		String userId = getUserId();//当前登录用户ID
		String cfgId = request.getParameter("cfg_id");//当前区域ID
		
		//判断用户是否俱乐部主席
		AjaxMsg msg = playerInfoService.getTeamByUserId(userId);
		if(msg.isSuccess()){
			Map<String, Object> team = (Map<String, Object>) msg.getData("data");
			String type = team.get("type").toString();
			String teamId = team.get("id").toString();
			if("1".equals(type)){//是主席
				//检测俱乐部是否已经报名
				TeamLeague teamLeague = leagueService.getTeamSignByLeague(teamId,null);
				if(teamLeague!=null){
					//检测是否在当前选中区域报名
					if(!cfgId.equals(teamLeague.getS_id())){
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.teamsignagain")).toJson();
					}
				}
			}
		}
		LeagueSign leagueSign = leagueService.getSignByLeague(userId,null);
		if(leagueSign!=null){
			//检测是否在当前选中区域报名
			if(!cfgId.equals(leagueSign.getS_id())){
				LeagueCfg cfg = leagueService.getLeagueCfgById(leagueSign.getS_id());
				AdminSysAreaService adminSysAreaService = (AdminSysAreaService) SpringContextUtil.getBean("adminSysAreaService");
		    	String name = adminSysAreaService.id2Name(cfg.getArea_code());
				return AjaxMsg.newSuccess().addData("sign_again", "1").addData("area", name).toJson();
			}
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 检测用户有没有报名权限
	 * @autor gl
	 * @parameter *
	 * @date2015-11-2 11:00:45
	 */
	@RequestMapping(value="checkAuth")
	@ResponseBody
	public String checkAuth(HttpServletRequest request){
//		String league_id = request.getParameter("league_id");
		String cfgId = request.getParameter("cfg_id");
		String rtype = request.getParameter("rtype");
		String userId = getUserId();
		//检测报名是否结束
//		League league = leagueService.getEntityById(league_id);
		LeagueCfg cig = leagueService.getLeagueCfgById(cfgId);
		if(cig==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		LeagueSign leagueSign = leagueService.getSignByLeague(userId,null);
		if(leagueSign!=null&&!cfgId.equals(leagueSign.getS_id())){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.signagain")).toJson();
		}
		long nowtime = new Date().getTime();
		long sstime = cig.getS_starttime().getTime();
		long setime = cig.getS_endtime().getTime();
		if(nowtime<sstime||nowtime>setime){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.signtime")).toJson();
		}
		
		//以俱乐部管理者身份报名检测是否已在球员身份处报名
		if("team".equals(rtype)){
			if(leagueSign!=null){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.repeatpsign")).toJson();
			}
			//检测用户是否实名认证
			Certification certification =  certificaService.getCertificationByUserId(getUserId(), "idcard");
			if(certification == null || certification.getStatus()!= 1){
				return AjaxMsg.newError().addData("user_cert", "1").toJson();
			}
		}
		//检测报名人是否队长
		AjaxMsg msg = playerInfoService.getTeamByUserId(userId);
		if(msg.isSuccess()){
			Map<String, Object> team = (Map<String, Object>) msg.getData("data");
			String type = team.get("type").toString();
			if("team".equals(rtype)){
				if(!"1".equals(type)){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.teamsign")).addData("team", team).toJson(); 
				}else{
					//检测俱乐部是否已经报名
					TeamLeague teamLeague = leagueService.getTeamSignByLeague(team.get("id").toString(),null);
					if(teamLeague!=null){
						//检测是否在当前选中区域报名
						if(!cfgId.equals(teamLeague.getS_id())){
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.teamsignagain")).toJson();
						}
					}
				}
			}else{
				if(!"1".equals(type)){
					team.put("type", "staff");
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersign")).addData("team", team).toJson(); 
				}else{
					team.put("type", "leader");
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersignleader")).addData("team", team).toJson(); 
				}
			}
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 联赛俱乐部激活跳转
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="toActiveCode")
	public String toActiveCode(HttpServletRequest request) {
		/*String league_id = request.getParameter("league_id");
		if(StringUtils.isBlank(league_id)) return "error/404";
		League league = leagueService.getEntityById(Long.valueOf(league_id));*/
		League league = leagueService.getLeague();
		request.setAttribute("league", league);
		return "league/activeCode";
	}
	
	/**
	 * 激活验证码
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="updateCode")
	@ResponseBody
	public String updateCode(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		String code = request.getParameter("code");
		String teaminfo_id = request.getParameter("teaminfo_id");
		League league = leagueService.getLeague();
		String login_user_id = this.getUserId();
		if(StringUtils.isBlank(login_user_id)) return AjaxMsg.newError().addMessage("").toJson();
		//0：未开始 1：进行中  2：已结束 3:已作废
		if(null == league) return AjaxMsg.newError().addMessage("").toJson();
		//联赛未开始
		if(league.getStatus() == 0) return AjaxMsg.newError().addMessage("system.error.league.nostart").toJson();
		//联赛已结束
		if(league.getStatus() == 2) return AjaxMsg.newError().addMessage("system.error.league.ended").toJson();
		//联赛已作废
		if(league.getStatus() == 3) return AjaxMsg.newError().addMessage("system.error.league.disabled").toJson();
		
		ActiveCode activeCode = activeCodeService.getActiveCodeByCode(code);
		//判断验证码是否存在
		if(null == activeCode) return AjaxMsg.newError().addMessage("system.error.league.codenoexist").toJson();
		//判断验证码是否可用
		if(activeCode.getStatus() == 2) return AjaxMsg.newError().addMessage("system.error.league.codenouser").toJson();
		
		if(!activeCode.getCode_str().equals(code)){
			return AjaxMsg.newError().addMessage("system.error.league.codeerr").toJson();
		}else{
			activeCode.setTeaminfo_id(teaminfo_id);
			activeCode.setUser_id(login_user_id);
			activeCode.setStatus(2);
			try {
				activeCodeService.updateCode(activeCode);
			} catch (Exception e) {
				return AjaxMsg.newError().addMessage("system.error.league.codeactiveerr").toJson();
			}
		}
		return msg.toJson();
	}
	
	/**
	 * 激活联赛球员验证码
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="activePlayerCode")
	@ResponseBody
	public String activePlayerCode(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		String code_str = request.getParameter("code_str");
		if(StringUtils.isBlank(code_str)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codeno")).toJson();
		String login_user_id = this.getUserId();
		if(StringUtils.isBlank(login_user_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		//检测是否加入俱乐部
		msg = playerInfoService.getTeamByUserId(login_user_id);
		if(msg.isSuccess()){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersign")).toJson(); 
		}
		try {
			msg = leagueService.updatePlayerCode(login_user_id,code_str);
		} catch (Exception e) {
			 return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 根据邀请码获取俱乐部信息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="activeCodeForTeam")
	@ResponseBody
	public String activeCodeForTeam(HttpServletRequest request){
		String code_str = request.getParameter("code_str");
		TeamActiveCode teamActiveCode = teamInfoService.getTeamActiveCode(code_str);
		if(null == teamActiveCode || StringUtils.isBlank(teamActiveCode.getId()) || teamActiveCode.getStatus()==2){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenoexist")).toJson();
		}
		if(teamActiveCode.getIf_use() == 2){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codeused")).toJson();
		}
		String teamId = teamActiveCode.getTeaminfo_id();
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(teamId,null);
		LeagueCfg cfg = leagueService.getLeagueCfgById(teamLeague.getS_id());
		LeagueAuction auction = leagueAuctionService.getAucPlayer(teamLeague.getS_id(),getUserId());
		if(auction!=null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.auctionchecked")).toJson();
		}
		TeamInfo teamInfo = teamInfoService.getEntityById(teamLeague.getTeaminfo_id());
		AdminSysAreaService adminSysAreaService = (AdminSysAreaService) SpringContextUtil.getBean("adminSysAreaService");
    	String name = adminSysAreaService.id2Name(cfg.getArea_code());
		Map<String, Object> data = new HashMap<String,Object>();
		data.put("cfg", cfg);
		data.put("area", name);
		data.put("team", teamInfo);
		return AjaxMsg.newSuccess().addData("data", data).toJson();
	}
	
	/**
	 * 单飞球员加入联赛
	 * @param request
	 * @return
	 */
	@RequestMapping(value="singlePlayer")
	@ResponseBody
	public String singlePlayer(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String userId = getUserId();
		LeagueSign leagueSign = leagueService.getLeagueSign(userId,league_id);
		AjaxMsg msg = AjaxMsg.newError();
		try {
			if(leagueSign!=null){
				LeagueAuction la = new LeagueAuction();
				la.setUser_id(userId);
				la.setLeague_id(league_id);
				la.setStatus(0);
				la.setIf_up(0);
				la.setIf_sold(0);
				msg = leagueService.saveLeagueAuction(la);
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		
	}
	
	/**
	 * 5、支付报名费
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	/*@RequestMapping(value="toPayPage")
	public String toPayPage(HttpServletRequest request) {
		String league_id = request.getParameter("league_id");
		League league = leagueService.getEntityById(league_id);
		if(null == league) return "";
		request.setAttribute("league_id", league_id);
		return "league/league_pay";
	}*/
	
	@RequestMapping(value="checkPayCost")
	@ResponseBody
	public String checkPayCost(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		LeagueCost cost = leagueCostService.getLeagueCostByUserId(getUserId(), league_id);
		//判断是否支付成功
		if(cost!=null&&cost.getStatus()==1){
			return AjaxMsg.newSuccess().toJson();
		}
		return AjaxMsg.newError().toJson();
	}
	
	/**
	 * 6.报名完成
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="toSignResult")
	public String toSignResult(Model model,HttpServletRequest request) {
		String user_id = this.getUserId();
		String league_id = request.getParameter("league_id");
		if(StringUtils.isBlank(league_id)) return "";
		LeagueSign l = leagueService.getLeagueSign(user_id, league_id);
		Certification c = certificaService.getCertificationByUserId(user_id, "idcard");
		PlayerInfo p = playerInfoService.getPlayerInfoByUserId(user_id);
		//LeagueCost g =  leagueCostService.getLeagueCostByUserId(user_id,league_id);
		model.addAttribute("leagueSign",l);
		model.addAttribute("certification",c);
		model.addAttribute("playerInfo",p);
		//model.addAttribute("leagueCost",g);
		League league = leagueService.getLeague();
		request.setAttribute("league_id", league.getId());
		return "league/league_result";
	}
	
	@RequestMapping(value="quitLeagueSign")
	@ResponseBody
	public String quitLeagueSign(HttpServletRequest request){
		String user_id = this.getUserId();
		String sign_id = request.getParameter("id");
		try {
			//获取报名信息
			LeagueSign sign = null;
			if(StringUtils.isNotBlank(sign_id)){
				sign = leagueService.getLeagueSignById(sign_id);
			}else{
				sign = leagueService.getSignByLeague(user_id, null);
			}
			if(sign==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			if(sign.getStatus()==1){
				//是否已经加入球队
				AjaxMsg msg = playerInfoService.getTeamByUserId(user_id);
				if(msg.isSuccess()){
					return AjaxMsg.newError().addMessage("已经加入球队，不能取消报名").toJson();
				}
				//是否在竞拍市场中选中
				LeagueAuction auction = leagueAuctionService.getAuctionPlayer(user_id,sign.getS_id());
				if(auction!=null&&StringUtils.isNotBlank(auction.getBidder())){
					return AjaxMsg.newError().addMessage("已经在竞拍市场中选中，不能取消报名").toJson();
				}
			}
			AjaxMsg msg = leagueService.deleteLeagueSign(sign);
			return msg.toJson();
		} catch (Exception e) {
			logger.error(e);
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
	}
	
	/**
	 * <p>Description:获取到积分榜列表信息 </p>
	 * @Author zhangwei
	 * @Date 2015年11月20日 下午12:14:52
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="integralList")
	public String integralList(Model model,HttpServletRequest request){
		Map<String,Object> maps = Maps.newHashMap();
		/**获取俱乐部分组列表 */
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		List<LeagueGroup> loadLeagueGroups = leagueService.loadLeagueGroups(league_id);
		List<League> leagueList = leagueService.getLeaguesByCondition(maps);
		if(loadLeagueGroups.size() > 0){
			String groupId = loadLeagueGroups.get(0).getId();
			maps.put("gid", groupId);
			List<Map<String,Object>> e_records  = leagueService.loadLeagueIntegralRecord(maps); 
			model.addAttribute("firstLeagueIntegral", e_records);
		}
		League league = leagueService.getEntityById(league_id);
		model.addAttribute("loadLeagueGroups", loadLeagueGroups);
		model.addAttribute("league_id", league_id);
		model.addAttribute("league", league);
		model.addAttribute("leagues", leagueList);
		return "league/integral/integral_list";
	}
	
	/**
	 * 联赛球员累计最高身价
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="slaveAdd")
	public String leaguePlayerSlaveAdd(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", request.getParameter("league_id"));
		AjaxMsg msg = priceSlaveService.queryForPageForMap(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("pages", msg.getData("page"));
		}
		return "league/league_slave";
	}
	/**
	 * 联赛球员单次最高身价
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="slaveSingle")
	public String leaguePlayerSlaveSingle(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", BeanUtils.nullToString(request.getParameter("league_id")));
		AjaxMsg msg = priceSlaveService.loadPriceSlaveSingle(maps, pageModel);
		if(msg.isSuccess()){
			request.setAttribute("pages", msg.getData("page"));
		}
		return "league/price/league_price";
	}
	
	/**
	 * 联赛球员单次最高身价
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="toPrice")
	public String toPrice(HttpServletRequest request,PageModel pageModel){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		League league = leagueService.getEntityById(league_id);
		List<League> leagueList =  leagueService.getLeaguesByCondition(Maps.newHashMap());
		request.setAttribute("league", league);
		request.setAttribute("leagues", leagueList);
		return "league/price/price_list";
	}
	
	/**
	 * 联赛球员单次最高身价
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="priceListData")
	public String leaguePriceListData(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", BeanUtils.nullToString(request.getParameter("league_id")));
		AjaxMsg msg = priceSlaveService.loadPriceSlaveSingle(maps, pageModel);
			request.setAttribute("rf", msg.getData("page"));
		return "league/price/price_list_data";
	}
	
	/**
	 * <p>Description:根据分组id获取联赛积分榜列表信息 </p>
	 * @Author zhangwei
	 * @Date 2015年11月20日 下午3:59:05
	 * @param request
	 * @return
	 */
	@RequestMapping(value="integralListByGroupId")
	@ResponseBody
	public String integralListByGroupId(HttpServletRequest request){
		Map<String,Object> maps = Maps.newHashMap();
		String gid = request.getParameter("gid");
		maps.put("gid", gid);
		List<Map<String,Object>> integralList = leagueService.loadLeagueIntegralRecord(maps);
		AjaxMsg msg = AjaxMsg.newSuccess();
		msg.addData("data", integralList);
		if(integralList.size() ==0 ){
			msg = AjaxMsg.newError();
			return msg.addMessage("该分组下还没有联赛积分记录").toJson();
		}
		return msg.toJson();
	}
	
	
	/**
	 * 检测是否联赛人员
	 * @return
	 */
	@RequestMapping(value="checkIsLeague")
	@ResponseBody
	public String checkIsLeague(HttpServletRequest request){
		String userId = request.getParameter("id");
		String flag = "0";//否
		//是否俱乐部队长
		AjaxMsg msg = playerInfoService.getTeamByUserId(userId);
		if(msg.isSuccess()){
			Map<String, Object> team = (Map<String, Object>) msg.getData("data");
			String team_id = team.get("id").toString();
			TeamLeague teamLeague = leagueService.getTeamLeague(team_id);
			if(null != teamLeague && StringUtils.isNotBlank(teamLeague.getId())){
				flag = "1";
			}
		}else{
			LeagueSign leagueSign = leagueService.getLeagueSignInvalid(userId);
			if(leagueSign!=null){
				flag = "1";
			}
		}
		return AjaxMsg.newSuccess().addData("flag", flag).toJson();
	}
	/**
	 * <p>Description: </p>
	 * @Author lenovo
	 * @Date 2015年11月25日 下午2:22:12
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="scorerRank")
	public String scorerRank(Model model,HttpServletRequest request){
		/**获取俱乐部分组列表 */
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		List<LeagueGroup> loadLeagueGroups = leagueService.loadLeagueGroups(league_id);
		List<League> leagueList =  leagueService.getLeaguesByCondition(Maps.newHashMap());
		League league = leagueService.getEntityById(league_id);
		model.addAttribute("groups", loadLeagueGroups);
		model.addAttribute("league_id", league_id);
		model.addAttribute("league", league);
		model.addAttribute("leagues", leagueList);
		return "league/integral/league_scorer_list";
	}
	
	@RequestMapping(value="scorerList")
	public String scorerList(HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		String group_id = request.getParameter("group_id");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		if(StringUtils.isNotBlank(group_id)) params.put("group_id", group_id);
		AjaxMsg msg =  leagueService.loadLeagueScorerRecord(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "league/integral/league_scorer_page";
	}
	
	/**
	 * 助攻排行榜
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="assistsRank")
	public String assistsRank(Model model,HttpServletRequest request){
		/**获取俱乐部分组列表 */
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		List<League> leagueList =  leagueService.getLeaguesByCondition(Maps.newHashMap());
		League league = leagueService.getEntityById(league_id);
		model.addAttribute("league_id", league_id);
		model.addAttribute("league", league);
		model.addAttribute("leagues", leagueList);
		return "league/assists/league_assists_list";
	}
	
	@RequestMapping(value="assistsList")
	public String assistsList(HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		AjaxMsg msg =  leagueService.loadLeagueAssists(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "league/assists/league_assists_page";
	}
	
	/**
	 * 检测竞拍市场权限
	 * @return
	 */
	@RequestMapping(value="checkAuction")
	@ResponseBody
	public String checkAuction(HttpServletRequest request){
		String user_id = this.getUserId();
		String league_id = request.getParameter("league_id");
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionService.getCurrentAuction(league_id);
		if(null == leagueAuctionCfg){
			if(StringUtils.isNotBlank(user_id)){
				TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
				if(null == teamInfo){
					//否：请报名联赛并成为联赛俱乐部管理者，联赛俱乐部管理者可进入球员交易市场购买球员。
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noteamleader")).toJson();
				}else{
					//是：球员交易将于“开放时间（竞拍或转会市场开放时间，如两个市场开放时间不一致则显示最近的时间）”开放，敬请期待
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noauction")).toJson();
				}
			}else{
				//否：请报名联赛并成为联赛俱乐部管理者，联赛俱乐部管理者可进入球员交易市场购买球员。
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noteamleader")).toJson();
			}
		}
		return AjaxMsg.newSuccess().addMessage("").toJson();
	}
	
	/**
	 * 市场选择页面
	 * @return
	 */
	@RequestMapping(value="choosePage")
	public String choosePage(HttpServletRequest request){
		//String league_id = request.getParameter("league_id");
		//request.setAttribute("league_id", league_id);
		return "league/choose_market";
	}
	
	@RequestMapping(value="statistics")
	public String statistics(Model model,HttpServletRequest request){
		try{
		String r_id = request.getParameter("id");
		EventRecord eventRecord = leagueService.getEventRecordById(r_id);
		if(null == eventRecord){
			request.setAttribute("info", messageResourceService.getMessage("system.error.league.nostatics"));
			return "/error/info";
		}
		QMatchInfo qMathInfo = quanLeagueService.getMatchInfoByRecordId(r_id);
		if(null == qMathInfo){
			request.setAttribute("info", messageResourceService.getMessage("system.error.league.nostatics"));	
			return "/error/info";
		}
		
		TeamInfo h_team = teamInfoService.getEntityById(eventRecord.getM_teaminfo_id());
		TeamInfo v_team = teamInfoService.getEntityById(eventRecord.getG_teaminfo_id());
		//获取比赛数据
		List<QSummaryInfo> qSlist = quanLeagueService.getQSummaryListByQmatchId(qMathInfo.getId(),"");
		for (QSummaryInfo qSummaryInfo : qSlist) {
			if(qSummaryInfo.getTeam_status() == 1){
				//添加乌龙球球员	
				request.setAttribute("h_Qsummary", qSummaryInfo);
				if(null != qSummaryInfo.getWulong_num() && !qSummaryInfo.getWulong_num().equals("0")){
					List<QScoreInfo> h_wulongData = quanLeagueService.getWulongData(qSummaryInfo.getQ_match_id(),qSummaryInfo.getTeaminfo_id());
					if(!h_wulongData.isEmpty()){
						request.setAttribute("h_wulongData", h_wulongData);
					}
				}
			}else{
				request.setAttribute("v_Qsummary", qSummaryInfo);
				if(null != qSummaryInfo.getWulong_num() && !qSummaryInfo.getWulong_num().equals("0")){
					List<QScoreInfo> v_wulongData = quanLeagueService.getWulongData(qSummaryInfo.getQ_match_id(),qSummaryInfo.getTeaminfo_id());
					if(!v_wulongData.isEmpty()){
						request.setAttribute("v_wulongData", v_wulongData);
					}
				}
			}
		}
		List<QScoreInfo> h_ScoreInfo = quanLeagueService.getScoreInfoListByQmatchId(qMathInfo.getId(), null, qMathInfo.getH_team_id());
		List<QScoreInfo> v_ScoreInfo = quanLeagueService.getScoreInfoListByQmatchId(qMathInfo.getId(), null, qMathInfo.getV_team_id());
		List<QScoreInfo> h_list = Lists.newArrayList();
		Map<String,Object> h_map = Maps.newLinkedHashMap();
		
		String h_id = "";
		if(!h_ScoreInfo.isEmpty()){
			for(QScoreInfo qScoreInfo : h_ScoreInfo) {
				if(StringUtils.isNotBlank(qScoreInfo.getUser_id())){
					if(!qScoreInfo.getUser_id().equals(h_id)){
						h_id = qScoreInfo.getUser_id();
						h_list = Lists.newArrayList();
					}
					h_list.add(qScoreInfo);
					h_map.put(qScoreInfo.getUser_id()+","+BeanUtils.nullToString(qScoreInfo.getNumber()), h_list);
				}
			}
		}
		
		List<QScoreInfo> v_list = Lists.newArrayList();
		Map<String,Object> v_map = Maps.newLinkedHashMap();
		String v_id = "";
		if(!v_ScoreInfo.isEmpty()){
			for(QScoreInfo qScoreInfo : v_ScoreInfo) {
				if(StringUtils.isNotBlank(qScoreInfo.getUser_id())){
					if(!qScoreInfo.getUser_id().equals(v_id)){
						v_id = qScoreInfo.getUser_id();
						v_list = Lists.newArrayList();;
					}
					v_list.add(qScoreInfo);
					v_map.put(qScoreInfo.getUser_id()+","+BeanUtils.nullToString(qScoreInfo.getNumber()), v_list);
				}
			}
		}
		request.setAttribute("h_map", h_map);
		request.setAttribute("v_map", v_map);
		request.setAttribute("eventRecord", eventRecord);
		request.setAttribute("h_team", h_team);
		request.setAttribute("v_team", v_team);
		request.setAttribute("qMathInfo", qMathInfo);
		request.setAttribute("league_id", eventRecord.getLeague_id());
		}catch(Exception e){
			e.printStackTrace();
		}
		//request.setAttribute("h_ScoreInfo", h_ScoreInfo);
		//request.setAttribute("v_ScoreInfo", v_ScoreInfo);
		return "league/statistics/event_record_statistics"; 
	}
	/**
	 * <p>Description: 到球员列表详情页</p>
	 * @Author zhangwei
	 * @Date 2015年12月26日 下午6:25:59
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toleaguePage")
	public String toleaguePage(HttpServletRequest request){
		String q_match_id = request.getParameter("q_match_id");
		QMatchInfo matchInfo = quanLeagueService.getMatchInfoById(q_match_id);
		EventRecord eventRecord = leagueService.getEventRecordById(matchInfo.getRecord_id());
		TeamInfo h_team = teamInfoService.getEntityById(matchInfo.getH_team_id());
		TeamInfo v_team = teamInfoService.getEntityById(matchInfo.getV_team_id());
		request.setAttribute("h_team_id", matchInfo.getH_team_id());
		request.setAttribute("v_team_id", matchInfo.getV_team_id());
		request.setAttribute("h_team", h_team);
		request.setAttribute("v_team", v_team);
		request.setAttribute("matchInfo", matchInfo);
		request.setAttribute("eventRecord", eventRecord);
		return "league/statistics/league_players";
	}
	/**
	 * <p>Description: 网站联赛页-统计-球队球员数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月26日 下午5:09:03
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/leaguePlayers")
	public String league_count(HttpServletRequest request){
		
		Map<String, Object> params = new HashMap<String, Object>();
		String q_match_id = request.getParameter("q_match_id");
		params.put("q_match_id", q_match_id);
		params.put("teaminfo_id", request.getParameter("teaminfo_id"));
		params.put("team_status", request.getParameter("team_status"));
		QMatchInfo matchInfo = quanLeagueService.getMatchInfoById(q_match_id);
		List<Map<String, Object>> players = quanLeagueService.queryQplayers(params);
		request.setAttribute("matchInfo", matchInfo);
		request.setAttribute("players", players);
		request.setAttribute("params", params);
		return "league/statistics/player_datas"; 
	}
	
	/**
	 * @Author ylt
	 * @Date 2016年03月09日 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="leagues")
	@ResponseBody
	public String leagues(HttpServletRequest request){
		List<League> list = leagueService.getLeagues();
		return JSONUtils.bean2json(list);
	}
	
	/**
	 * @Author ylt
	 * @Date 2016年03月09日 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="leagueCfgs")
	@ResponseBody
	public String leagueCfgs(HttpServletRequest request){
		List<Map<String,Object>> listCfg = leagueService.getLeagueCfgMap();
		return JSONUtils.bean2json(listCfg);
	}
	
	/**
	 * 转会市场赛季选择页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="turnTeamChoose")
	public String turnTeamPage(Model model,HttpServletRequest request){
		//查询进行中赛区联赛
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("status", "1");
		params.put("if_show", "1");
		List<Map<String, Object>> areas = leagueService.queryLeagueArea(params);
		request.setAttribute("leagueAreas", areas);
		return "league/choose/turn_team";
	}
	
	/**
	 * 转会市场赛季选择页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toAuction")
	public String toAuction(HttpServletRequest request){
		//查询进行中赛区联赛
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("status", "1");
		params.put("if_show", "1");
		List<Map<String, Object>> areas = leagueService.queryLeagueArea(params);
		request.setAttribute("leagueAreas", areas);
		return "league/choose/league_auction";
	}
	
	/**
	 * 联赛选择页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toLeague")
	public String toLeague(HttpServletRequest request){
		//查询进行中赛区联赛
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("status", "1");
		params.put("if_show", "1");
		List<League> leagueList = leagueService.getLeagues();
		request.setAttribute("leagueList", leagueList);
		return "league/choose/league_list";
	}
	
	
	/**
	 * 检测用户俱乐部参赛确认信息
	 * @return
	 */
	@RequestMapping(value="checkInviteMsg")
	@ResponseBody
	public String checkInviteMsg(HttpServletRequest request){
		String userId = getUserId();
		if(StringUtils.isNotBlank(userId)){
			TeamInfo team = teamInfoService.getTeamInfoByUserId(userId);
			if(team!=null){
				InviteMsg imsg = leagueService.getBeGood4InviteMsg(team.getId());
				if(imsg!=null){
					if(new Date().getTime()>imsg.getEnd_time().getTime()){
						return AjaxMsg.newError().addData("timeout", "1").addMessage(messageResourceService.getMessage("system.error.league.invitemsgtimeout")).toJson();
					}
					return AjaxMsg.newSuccess().toJson();
				}
			}
		}
		return AjaxMsg.newError().toJson();
	}
	
	/**
	 * 修改俱乐部参赛确认信息状态
	 * @author gl
	 * @param imsg
	 * @return
	 */
	@RequestMapping(value="updateInviteMsg")
	@ResponseBody
	public String updateInviteMsg(HttpServletRequest request){
		String flag = request.getParameter("flag");
		String userId = getUserId();
		try {
			TeamInfo team = teamInfoService.getTeamInfoByUserId(userId);
			if(team!=null){
				InviteMsg imsg = leagueService.getBeGood4InviteMsg(team.getId());
				if(imsg!=null){
					AjaxMsg msg = leagueService.updateInviteMsg(imsg,flag);
					return msg.toJson();
				}
			}
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
	}
	
	
}
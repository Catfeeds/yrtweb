package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QScoreInfo;
import com.yt.framework.persistent.entity.QScoreInfoList;
import com.yt.framework.persistent.entity.QSummaryInfo;
import com.yt.framework.persistent.entity.QSummaryList;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.QUserDataList;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;


@Controller
@RequestMapping(value="/admin/interface")
public class InterfaceController {
	private static Logger logger = LogManager.getLogger(IndexModelController.class);
	
	@Autowired
	private QuanLeagueService quanLeagueService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private AdminEventRecordService adminEventRecordService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	/**
	 * 全网接口 联赛统计
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/leagueCount")
	public String league_count(HttpServletRequest request,PageModel pageModel,Model model){
		Map<String, Object> maps = Maps.newHashMap();
		String homeName = request.getParameter("homeName");
		String visitName = request.getParameter("visitName");
		String matchId = request.getParameter("matchId");
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		maps.put("home_name", homeName);
		maps.put("visit_name", visitName);
		maps.put("match_id", matchId);
		maps.put("league_id", league_id);
		AjaxMsg ajaxMsg = quanLeagueService.getQMatchInfoList(maps, pageModel);
		if(ajaxMsg.isSuccess()){
			model.addAttribute("page", ajaxMsg.getData("page"));
			model.addAttribute("params", maps);
		}
		List<League> leagueList = leagueService.getLeagues();
		request.setAttribute("leagueList", leagueList);
		request.setAttribute("league_id", league_id);
		return "admin/interface/league_count"; 
	}
	
	@RequestMapping(value="/leaguePlayers")
	public String league_count(HttpServletRequest request){
		String lid = request.getParameter("league_id");
		League league = leagueService.getEntityById(lid);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("q_match_id", request.getParameter("q_match_id"));
		params.put("teaminfo_id", request.getParameter("teaminfo_id"));
		params.put("team_status", request.getParameter("team_status"));
		List<Map<String, Object>> players = quanLeagueService.queryQplayers(params);
		request.setAttribute("players", players);
		request.setAttribute("params", params);
		request.setAttribute("league", league);
		return "admin/interface/league_players"; 
	}
	
	@RequestMapping(value="/queryPlayerDatas")
	public String queryPlayerDatas(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String cfg_id = request.getParameter("cfg_id");
		String ps_id = request.getParameter("ps_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		String usernick = request.getParameter("usernick");
		String username =request.getParameter("username");
		String phone = request.getParameter("phone");
		String if_loan = request.getParameter("if_loan");
		if(StringUtils.isNotBlank(cfg_id)) maps.put("cfg_id", cfg_id);
		if(StringUtils.isNotBlank(ps_id)) maps.put("ps_id", ps_id);
		if(StringUtils.isNotBlank(teaminfo_id)) maps.put("teaminfo_id", teaminfo_id);
		if(StringUtils.isNotBlank(usernick)) maps.put("usernick", usernick);
		if(StringUtils.isNotBlank(username)) maps.put("username", username);
		if(StringUtils.isNotBlank(phone)) maps.put("phone", phone);
		if(StringUtils.isNotBlank(if_loan)) maps.put("if_loan", if_loan);
		AjaxMsg msg = quanLeagueService.queryPlayerDatas(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/interface/team_players";
	}
	
	@RequestMapping(value="/queryPlayersByJson")
	@ResponseBody
	public String queryPlayersByJson(HttpServletRequest request,PageModel pageModel){
		pageModel.setPageSize(Integer.MAX_VALUE);
		Map<String,Object> maps = Maps.newHashMap();
		String cfg_id = request.getParameter("cfg_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isNotBlank(cfg_id)) maps.put("cfg_id", cfg_id);
		if(StringUtils.isNotBlank(teaminfo_id)) maps.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = quanLeagueService.queryPlayerDatas(maps, pageModel);
		return msg.toJson(); 
	}
	
	@RequestMapping(value="/updateUserData")
	@ResponseBody
	public String updateUserData(HttpServletRequest request,QUserDataList list){
		AjaxMsg msg = AjaxMsg.newError();
		if(list!=null&&list.getPlayers()!=null&&list.getPlayers().size()>0){
			List<QUserData> userDatas = list.getPlayers();
			msg = quanLeagueService.updateAllQUserData(userDatas);
		}
		return msg.toJson();
	}
	
	/**
	 * 球员进球详情
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/scoreDialog")
	public String scoreDialog(HttpServletRequest request){
		String pid = request.getParameter("pid");
		String mid = request.getParameter("mid");
		request.setAttribute("pid", pid);
		request.setAttribute("mid", mid);
		return "admin/interface/score_dialog";
	}
	
	@RequestMapping(value="/queryPlayerScore")
	public String queryPlayerScore(HttpServletRequest request){
		String mid = request.getParameter("mid");
		String pid = request.getParameter("pid");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("q_match_id", mid);
		params.put("q_user_id", pid);
		List<Map<String, Object>> scores = quanLeagueService.queryPlayerScore(params);
		request.setAttribute("scores", scores);
		request.setAttribute("params", params);
		return "admin/interface/player_scores";
	}
	
	@RequestMapping(value="/updateScores")
	@ResponseBody
	public String updateScores(HttpServletRequest request,QScoreInfoList list){
		AjaxMsg msg = AjaxMsg.newError();
		if(list!=null&&list.getScores()!=null&&list.getScores().size()>0){
			List<QScoreInfo> scores = list.getScores();
			msg = quanLeagueService.saveOrUpdateQUserData(scores);
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/deleteScore")
	@ResponseBody
	public String deleteScore(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = quanLeagueService.deleteScore(id);
		return msg.toJson();
	}
	
	/**
	 * 主客队数据页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/matchForm")
	public String matchForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		//String id = "r7QYeetLvSqTEYyDigG";
		QMatchInfo qMatchInfo = quanLeagueService.getMatchInfoById(id);
		String h_team_id = BeanUtils.nullToString(qMatchInfo.getH_team_id());//系统主队ID
		String v_team_id = BeanUtils.nullToString(qMatchInfo.getV_team_id());//系统客队ID
		//获取球队数据
		if(StringUtils.isNotBlank(h_team_id)){
			TeamInfo h_team = teamInfoService.getEntityById(h_team_id);
			request.setAttribute("h_team", h_team);
		}
		if(StringUtils.isNotBlank(v_team_id)){
			TeamInfo v_team = teamInfoService.getEntityById(v_team_id);
			request.setAttribute("v_team", v_team);
		}
		//获取比赛数据
		List<QSummaryInfo> qSlist = quanLeagueService.getQSummaryListByQmatchId(id,"");
		for (QSummaryInfo qSummaryInfo : qSlist) {
			if(qSummaryInfo.getTeam_status() == 1){
				request.setAttribute("h_qSummary", qSummaryInfo);
			}else{
				request.setAttribute("v_qSummary", qSummaryInfo);
			}
		}
		List<QUserData> h_qUList = quanLeagueService.getQUserDataListByQmatchId(id, qMatchInfo.getHome_id());
		List<QUserData> v_qUList = quanLeagueService.getQUserDataListByQmatchId(id, qMatchInfo.getVisit_id());
		
		//获取进球球员信息
		List<QScoreInfo> scoreList = quanLeagueService.getScoreInfoListByQmatchId(qMatchInfo.getId(),null,"");
		
		request.setAttribute("scoreList", scoreList);
		request.setAttribute("h_qUList", h_qUList);
		request.setAttribute("v_qUList", v_qUList);
		request.setAttribute("qMatchInfo", qMatchInfo);
		return "admin/interface/league_matchInfo"; 
	}
	
	/**
	 * 俱乐部选择界面
	 * @param request
	 * @return
	 */
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
		return "admin/teaminfo/dialog";
	}
	
	/**
	 * 保存球队
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateMatchInfo")
	@ResponseBody
	public String updateMatchInfo(HttpServletRequest request,QMatchInfo qMatchInfo,QSummaryList list){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			quanLeagueService.updateMatchInfo(qMatchInfo,list);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 通过接口赛事id查询相关赛事信息并进行添加及匹配</p>
	 * @Author zhangwei
	 * @Date 2015年12月25日 下午4:34:53
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getMatchInfoAndToAddByMatchId")
	@ResponseBody
	public String getMatchInfoAndToAddByMatchId(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String gameId = request.getParameter("matchId");
		String urlAddress = "http://www.uhisports.com/index.php/Api/Match";//接口获取数据地址
		String key = "yrtDataKey";//双方约定秘钥值
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		if(StringUtils.isNotBlank(gameId)&&StringUtils.isNotBlank(urlAddress)&&StringUtils.isNotBlank(key)){
			msg = quanLeagueService.modifyQMatchInfos(urlAddress, gameId, key, league_id);
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/playerJinQiu")
	public String playerJinQiuDialog(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String rel_palyer_id = request.getParameter("rel_palyer_id");
		request.setAttribute("league_id", league_id);
		request.setAttribute("rel_palyer_id", rel_palyer_id);
		return "admin/interface/player_list_dialog";
	}
	/**
	 * 保存球队信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateQSummary")
	@ResponseBody
	public String updateQSummary(HttpServletRequest request,QSummaryList list){
		AjaxMsg msg = AjaxMsg.newError();
		String matchId =  BeanUtils.nullToString(request.getParameter("matchId"));
		QMatchInfo matchInfo = quanLeagueService.getMatchInfoById(matchId);
		for (QSummaryInfo info : list.getSummarys()) {
			//QSummaryInfo dataInfo = quanLeagueService.getQSummaryInfoById(info.getId());
			if(info.getTeam_status() == 1){
				info.setTeaminfo_id(BeanUtils.nullToString(matchInfo.getH_team_id()));
			}else{
				info.setTeaminfo_id(BeanUtils.nullToString(matchInfo.getV_team_id()));
			}
			try {
				msg = quanLeagueService.updateQSummaryInfo(info);
			} catch (Exception e) {
				e.printStackTrace();
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		}
		
		return msg.toJson();
	}
	
	/**
	 * 球员进球详情
	 * gl
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/queryPlayerJinQiu")
	public String queryPlayerJinQiu(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String rel_palyer_id = request.getParameter("rel_palyer_id");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("league_id", league_id);
		params.put("rel_palyer_id", rel_palyer_id);
		List<Map<String, Object>> list = quanLeagueService.queryPlayerJinQiu(params);
		request.setAttribute("list", list);
		return "admin/interface/player_list";
	}
	
	/**
	 * <p>Description:删除接口赛事数据 </p>
	 * @Author zhangwei
	 * @Date 2015年12月26日 下午3:27:12
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteQMatchInfo")
	@ResponseBody
	public String deleteQMatchInfo(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = BeanUtils.nullToString(request.getParameter("id"));;
		QMatchInfo qmatchInfo = quanLeagueService.getMatchInfoById(id);
		if(qmatchInfo != null){
			msg = quanLeagueService.deleteMatchsByInfos(qmatchInfo);
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 发布接口赛事数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月28日 上午10:33:12
	 * @return
	 */
	@RequestMapping(value="/publishQMatchInfo")
	@ResponseBody
	public String publishQMatchInfo(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = BeanUtils.nullToString(request.getParameter("id"));
		QMatchInfo qmatchInfo = quanLeagueService.getMatchInfoById(id);
		if(qmatchInfo != null){
			if(qmatchInfo.getReview_status() == 2){//未审核通过
				qmatchInfo.setStatus(2);//已发布
				msg = quanLeagueService.updateQMatchInfo(qmatchInfo);
			}else{
				msg = msg.addMessage("该数据还未审核通过，不可以发布");
			}
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 审核接口赛事数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月28日 上午10:33:12
	 * @return
	 */
	@RequestMapping(value="/reviewQMatchInfo")
	@ResponseBody
	public String reviewQMatchInfo(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		try{
			String id = BeanUtils.nullToString(request.getParameter("id"));
			QMatchInfo qmatchInfo = quanLeagueService.getMatchInfoById(id);
			if(qmatchInfo != null){
				if(StringUtils.isNotBlank(qmatchInfo.getRecord_id()) 
						&& StringUtils.isNotBlank(qmatchInfo.getH_team_id()) 
						    && StringUtils.isNotBlank(qmatchInfo.getV_team_id())){
					qmatchInfo.setReview_status(2);//已审核
					msg = quanLeagueService.updateQMatchInfo(qmatchInfo);
					//保存联赛结果
					List<QSummaryInfo> qSlist = quanLeagueService.getQSummaryListByQmatchId(id,"");
					AdminEventRecord adminEventRecord = adminEventRecordService.getEntityById(qmatchInfo.getRecord_id());
					if(adminEventRecord.getStatus() != 2){
						for (QSummaryInfo qSummaryInfo : qSlist) {
							if(qSummaryInfo.getTeam_status() == 1){
								//获取主队数据
								adminEventRecord.setM_score(new Integer(qSummaryInfo.getScore()));
							}else{
								//获取客队数据
								adminEventRecord.setG_score(new Integer(qSummaryInfo.getScore()));
							}
						}
						adminEventRecord.setStatus(1);
						msg = adminEventRecordService.updateEventRecord(adminEventRecord);
					}else{
						return AjaxMsg.newError().addMessage("联赛历史赛程数据已确定不能重复审核").toJson();
					}
				}else{
					msg = msg.addMessage("联赛数据还未匹配结束，不可以审核");
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return msg.toJson();
	}
}

package com.yt.framework.controller.admin;

import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeaminfoIds;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.ActiveCodeService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.service.admin.AdminSysAreaService;
import com.yt.framework.service.admin.SysDictService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * 后台联赛管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/league/")
public class AdminLeagueController {
	
	private static Logger logger = LogManager.getLogger(AdminLeagueController.class);
	
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private ActiveCodeService activeCodeService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	/**
	 * 保存联赛
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveLeague")
	@ResponseBody
	public String saveLeague(HttpServletRequest request,League league) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(league.getId())){	
			league.setId(UUIDGenerator.getUUID());
			int imgge_src = OSSClientFactory.uploadFile(league.getImage_src(), new File(fileRepository.getRealPath(league.getImage_src())));
			if(imgge_src == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(league.getImage_src()));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			int banner_src = OSSClientFactory.uploadFile(league.getBanner_src(), new File(fileRepository.getRealPath(league.getBanner_src())));
			if(banner_src == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(league.getBanner_src()));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			int backgroud_src = OSSClientFactory.uploadFile(league.getBackgroud_src(), new File(fileRepository.getRealPath(league.getBackgroud_src())));
			if(backgroud_src == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(league.getBackgroud_src()));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			msg = leagueService.save(league);
		}else{
			League old = leagueService.getEntityById(league.getId());
			String old_img = BeanUtils.nullToString(old.getImage_src());
			String new_img = BeanUtils.nullToString(league.getImage_src());
			if(!old_img.equals(new_img)){
				int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_img));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
				}
				OSSClientFactory.deleteFile(old_img);
			}
			String old_banner = BeanUtils.nullToString(old.getBanner_src());
			String new_banner = BeanUtils.nullToString(league.getBanner_src());
			if(!old_banner.equals(new_banner)){
				int result = OSSClientFactory.uploadFile(new_banner, new File(fileRepository.getRealPath(new_banner)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_banner));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
				}
				OSSClientFactory.deleteFile(old_banner);
			}
			String old_backgroud = BeanUtils.nullToString(old.getBackgroud_src());
			String new_backgroud = BeanUtils.nullToString(league.getBackgroud_src());
			if(!old_backgroud.equals(new_backgroud)){
				int result = OSSClientFactory.uploadFile(new_backgroud, new File(fileRepository.getRealPath(new_backgroud)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_backgroud));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
				}
				OSSClientFactory.deleteFile(old_backgroud);
			}
			msg = leagueService.update(league);
		}
		return msg.toJson();
	}
	
	/**
	 * 联赛列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listLeague")
	public String listLeague(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> map = Maps.newHashMap();
		map.put("name", BeanUtils.nullToString(request.getParameter("name")));
		map.put("s_id", BeanUtils.nullToString(request.getParameter("s_id")));
		map.put("status", BeanUtils.nullToString(request.getParameter("status")));
		AjaxMsg msg = leagueService.queryForPage(map, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("param", map);
		return "admin/league/listLeague"; 
	}

	/**
	 * 激活码列表
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="listCodes")
	public String listActiveCodes(Model model,HttpServletRequest request,PageModel pageModel) {
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", league_id);
		maps.put("name", request.getParameter("name"));
		maps.put("status", request.getParameter("status"));
		
		AjaxMsg msg = activeCodeService.loadActiveCodes(maps, pageModel);
		model.addAttribute("datas", msg.getData("datas"));
		model.addAttribute("page", msg.getData("page"));
		model.addAttribute("params", maps);
		request.setAttribute("league_id", league_id);
		return "admin/league/activeList"; 
	}
	/**
	 * 创建激活码
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="saveCodeActive")
	@ResponseBody
	public String saveCodeActive(HttpServletRequest request,ActiveCode activeCode) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			String code_num = BeanUtils.nullToString(request.getParameter("code_num"));
			String key_id = BeanUtils.nullToString(request.getParameter("key_id"));
			for(int i=0;i<Integer.valueOf(code_num);i++){
				ActiveCode t_activeCode = new ActiveCode();
				StringBuilder sb = new StringBuilder(key_id);
				int a = Common.getRandomNum6();
				String b = Common.formatDate(new Date(), "yyyy");
				String code_str = sb.append(a).append(b).append(Common.getRandomNum4()).toString();
				org.springframework.beans.BeanUtils.copyProperties(activeCode, t_activeCode);
				t_activeCode.setId(UUIDGenerator.getUUID());
				t_activeCode.setCode_str(code_str);
				activeCodeService.saveActiveCode(t_activeCode);
			}
		} catch (Exception e) {
			e.getStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 跳转编辑激活码页面
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="toActiveCodePage")
	public String toActiveCodePage(HttpServletRequest request) {
		String id = BeanUtils.nullToString(request.getParameter("id"));
		ActiveCode activeCode = activeCodeService.getEntityById(id);
		request.setAttribute("activeCode", activeCode);
		return "admin/league/editActiveForm"; 
	}
	
	/**
	 * 更新激活码
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="updateActiveCode")
	@ResponseBody
	public String updateActiveCode(HttpServletRequest request,ActiveCode activeCode) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			ActiveCode activeCodeDB = activeCodeService.getEntityById(activeCode.getId());
			if(null != activeCodeDB){
				activeCodeDB.setIf_loan(activeCode.getIf_loan());
				activeCodeDB.setIf_transfer(activeCode.getIf_transfer());
				activeCodeDB.setInit_price(activeCode.getInit_price());
				activeCodeDB.setInit_capital(activeCode.getInit_capital());
				activeCodeDB.setEnd_time(activeCode.getEnd_time());
				activeCodeDB.setStatus(activeCode.getStatus());
				activeCodeDB.setP_status(activeCode.getP_status());
				msg = activeCodeService.updateCode(activeCodeDB);
			}
		} catch (Exception e) {
			e.getStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	
	/**
	 * 联赛报名列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listSign")
	public String listSign(HttpServletRequest request,PageModel pageModel) {
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		Map<String,Object> params = Maps.newHashMap();
		params.put("s_id", s_id);
		params.put("username", request.getParameter("username"));
		params.put("usernick", request.getParameter("usernick"));
		params.put("status", request.getParameter("status"));
		AjaxMsg msg = leagueService.queryForPageSign(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("leagueCfg",leagueCfg);
		return "admin/league/listSign"; 
	}
	
	/**
	 * 批量生成激活码页面
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="activeForm")
	public String activeForm(HttpServletRequest request) {
		request.setAttribute("league_id", BeanUtils.nullToString(request.getParameter("league_id")));
		return "admin/league/activeForm"; 
	}
	
	
	/**
	 * 更新联赛报名
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="updateSign")
	@ResponseBody
	public String updateSign(HttpServletRequest request,LeagueSign leagueSign) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			LeagueSign LeagueSign_old = leagueService.getLeagueSignById(leagueSign.getId());
			if (null != LeagueSign_old) {
				LeagueSign_old.setStatus(leagueSign.getStatus());
				LeagueSign_old.setReason(leagueSign.getReason());
			}
			msg = leagueService.updateLeagueSign(LeagueSign_old);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	} 
	
	/**
	 * 球员联赛批量审核通过
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="batchUpdateSign")
	@ResponseBody
	public String batchUpdateSign(HttpServletRequest request){
		String ids = BeanUtils.nullToString(request.getParameter("ids"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			if(StringUtils.isBlank(ids)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
			String []id = ids.split(",");
			int s_count = 0; //成功更新条数
			int e_count = 0; //错误更新条数
			for (String i : id) {
				LeagueSign LeagueSign_old = leagueService.getLeagueSignById(i);
				if (null != LeagueSign_old) {
					if(LeagueSign_old.getStatus() == 1){
						continue;
					}
					LeagueSign_old.setStatus(1);
					LeagueSign_old.setReason("");
				}
				AjaxMsg tmp_msg = leagueService.updateLeagueSign(LeagueSign_old);
				if(tmp_msg.isSuccess() == true){
					s_count = s_count + 1;
				}else{
					e_count = e_count + 1;
				}
			}
			msg.addData("err_count", e_count);
			msg.addData("ok_count", s_count);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 联赛创建页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="leagueForm")
	public String leagueForm(HttpServletRequest request){
		String id = request.getParameter("id");
		League league = leagueService.getEntityById(id);
		List<LeagueCfg>cfgList = leagueService.getLeaugeCfgList();
		request.setAttribute("leagueForm", league);
		request.setAttribute("cfgList", cfgList);
		return "admin/league/leagueForm"; 
	}
	
	/**
	 * 联赛报名页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="signForm")
	public String signForm(HttpServletRequest request){
		String id = request.getParameter("id");
		Map<String, Object> maps = Maps.newHashMap(); 
		maps = leagueService.getLeagueSignByIdMap(id);
		String s_id = BeanUtils.nullToString(maps.get("s_id"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);	
		request.setAttribute("leagueCfg",leagueCfg);
		request.setAttribute("signForm", maps);
		return "admin/league/leagueSignForm"; 
	}
	
	/**
	 * 联赛信息管理页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="leagueOpt")
	public String leagueOpt(HttpServletRequest request){
		String id = request.getParameter("id");
		League league = leagueService.getEntityById(id);
		request.setAttribute("league", league);
		return "admin/league/leagueOption"; 
	}
	
	/**
	 * 跳转禁赛编辑页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="toSuspend")
	public String toSuspend(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		if(StringUtils.isNotBlank(id)){
			SuspendPlayer suspendPlayer =  leagueService.getSuspendById(id);
			request.setAttribute("suspendForm", suspendPlayer);
		}
		request.setAttribute("league_id", league_id);
		return "admin/league/suspendForm"; 
	}
	
	/**
	 * 保存和更新禁赛对象
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="saveOrUpdateSuspend")
	@ResponseBody
	public String saveOrUpdateSuspend(HttpServletRequest request,SuspendPlayer suspendPlayer){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = leagueService.saveOrUpdateSuspend(suspendPlayer);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	/** 禁赛列表
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="listSuspend")
	public String listSuspend(HttpServletRequest request,PageModel pageModel){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		League league = leagueService.getEntityById(league_id);
		Map<String,Object> params = Maps.newHashMap();
		params.put("league_id", league_id);
		params.put("username", request.getParameter("username"));
		params.put("usernick", request.getParameter("usernick"));
		AjaxMsg msg = leagueService.queryForPageSuspend(params, pageModel);
		request.setAttribute("league", league);
		request.setAttribute("league_id", league_id);
		request.setAttribute("page", msg.getData("page"));
		return "admin/league/listSuspend"; 
	}
	
	/** 删除禁赛
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="deleteSuspend")
	@ResponseBody
	public String deleteSuspend(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = leagueService.deleteSuspend(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	@RequestMapping(value="/userDialog")
	public String userDialog(HttpServletRequest request){
		return "admin/league/user_dialog";
	}
	
	/**
	 * 联赛工资发送信息
	 */
	@RequestMapping(value="salaryMsg")
	public String leagueSalaryMessageSend(Model model,HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		League league = leagueService.getEntityById(league_id);
		//查询该联赛一共有多少轮
		//int maxRounds = leagueService.getMaxRounds(league_id);
		model.addAttribute("league", league);
		model.addAttribute("maxRounds", league.getRounds());
		return "admin/league/sendSalaryForm";
	}
	
	/**
	 * 保存联赛工资发送信息
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="saveSalaryMsg")
	public @ResponseBody String saveLeagueSalaryMessage(HttpServletRequest request,TeaminfoIds teaminfoIds) throws Exception{
		String league_id = request.getParameter("league_id");//联赛ID
		String rounds = request.getParameter("rounds");//轮次
		//String event_id = request.getParameter("event_id");//赛程ID
		List<String> teaminfo_ids = teaminfoIds.getTeaminfoids();//俱乐部ids
		AjaxMsg msg = adminLeagueGroupService.saveLeagueSalaryInfoByParams(teaminfo_ids, league_id, rounds);
		return msg.toJson();
	}
	
	/**
	 * 根据联赛Id,轮次 查询俱乐部
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="teams")
	public String leagueTeamsByParams(Model model,HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String rounds = request.getParameter("rounds");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", league_id);
		maps.put("rounds", rounds);
		List<Map<String,Object>> teams_league = leagueService.loadAllLeagueTeam(maps);
		/*if(null!=teams_league && teams_league.size()>0){
			Map<String,Object> map = teams_league.get(0);
			model.addAttribute("event_id", map.get("event_id"));
		}*/
		model.addAttribute("teams_league", teams_league);
		return "admin/league/league_teams";
	}
	
	/**
	 * 联赛工资发送信息记录表
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="salaryMsgRecord")
	public String salaryMsgRecordList(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object>params = Maps.newHashMap();
		String league_id = request.getParameter("league_id");
		String rounds = request.getParameter("rounds");
		params.put("league_id", league_id);
		params.put("rounds", rounds);
		AjaxMsg msg = adminLeagueGroupService.loadAllSalaryMsgList(params, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("page", msg.getData("page"));
		}
		model.addAttribute("params", params);
		return "admin/league/league_salary_list";
	}
	
	/**
	 * 工资管理
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="salaryManage")
	public String salaryManage(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		League league = leagueService.getEntityById(league_id);
		
		Map<String,Object>params = Maps.newHashMap();
		params.put("league_id", league_id);
		AjaxMsg msg = adminLeagueGroupService.loadAllSalaryTable(params, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("page", msg.getData("page"));
		}
		model.addAttribute("league", league);
		return "admin/league/league_salary_manage";
	}
	
	@RequestMapping(value="deleteSalaryTable")
	public @ResponseBody String deleteSalaryTable(HttpServletRequest request) throws Exception{
		String league_id = request.getParameter("league_id");
		String turn_num = request.getParameter("turn_num");
		String event_id = request.getParameter("event_id");
		Map<String,Object> map = Maps.newHashMap();
		if(StringUtils.isNotBlank(league_id)&&StringUtils.isNotBlank(turn_num)){
			map.put("league_id", league_id);
			map.put("turn_num", turn_num);
			map.put("event_id", event_id);
		}
		AjaxMsg msg = adminLeagueGroupService.deleteSalaryTableByParasm(map);
		return msg.toJson();
	}
	
	/**
	 * 轮次详情
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="turnDetail")
	public String leagueSalaryTurnDetail(Model model,HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		String turn_num = request.getParameter("turn_num");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", league_id);
		maps.put("turn_num", turn_num);
		AjaxMsg msg = adminLeagueGroupService.loadLeagueTurnDetail(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("page", msg.getData("page"));
		}
		model.addAttribute("league_id", league_id);
		return "admin/league/league_salary_detail";
	}
	
	/**
	 * 更新发送信息记录表发送状态
	 * @param request
	 * @return
	 */
	@RequestMapping(value="updateSend")
	public @ResponseBody String updateSalaryMsgSend(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String turn_num = request.getParameter("turn_num");
		Map<String,Object> maps = Maps.newHashMap();
		if(StringUtils.isNotBlank(turn_num) && StringUtils.isNotBlank(league_id)){
			maps.put("turn_num", turn_num);
			maps.put("league_id", league_id);
		}
		AjaxMsg msg = adminLeagueGroupService.updateSalarySend(maps);
		return msg.toJson();
	}
	
	
	/**
	 * 催促俱乐部管理员发送工资
	 * @param request
	 * @return
	 */
	@RequestMapping(value="pressManager")
	public @ResponseBody String pressManager(HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String league_id = request.getParameter("league_id");
		String turn_num = request.getParameter("turn_num");
		League league = leagueService.getEntityById(league_id);
	//发送短信
	AjaxMsg userMsg = teamInfoService.getCaption(teaminfo_id);
		if(userMsg.isSuccess()){
			User user = (User) userMsg.getData("user");
			if(null!=user && StringUtils.isNotBlank(user.getPhone())){
				StringBuilder sb = new StringBuilder();
					sb.append("@1@=").append(league.getName()).append(",@2@=").append(turn_num);
				AjaxMsg msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880040.toString());
				return msg.toJson();
			}
		}
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
	}
	
	/**
	 * 设置联赛基本工资
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="setSalaryBalance")
	public String settingLeagueSalaryBalance(Model model,HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		model.addAttribute("league_id", league_id);
		return "admin/league/league_salary_balance";
	}
	
	/**
	 * 保存联赛基本工资
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveSalaryBalance")
	public @ResponseBody String saveSalaryBalance(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		String salary = request.getParameter("salary");
		League league = leagueService.getEntityById(league_id);
		league.setSalary(new BigDecimal(salary));
		return leagueService.update(league).toJson();
	}
	
	/**
	 * 联赛分类
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="cfgList")
	public String cfgList(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		map.put("year", request.getParameter("year"));
		map.put("area_code", request.getParameter("area_code"));
		AjaxMsg msg = leagueService.queryLeagueCfgList(map, pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/league/listLeagueCfg";
	}
	
	/**
	 * 联赛分类
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveLeagueCfg")
	@ResponseBody
	public String saveLeagueCfg(HttpServletRequest request,LeagueCfg leagueCfg){
	 AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = leagueService.saveOrUpdateLeagueCfg(leagueCfg);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 联赛分类
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="cfgForm")
	public String cfgForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(id);
		request.setAttribute("leagueCfgForm", leagueCfg);
		return "admin/league/leagueCfgForm"; 
	}
	
	/**
	 * 赛季信息管理页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="leagueCfgOpt")
	public String leagueCfgOpt(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(id);	
		request.setAttribute("leagueCfg",leagueCfg);
		return "admin/league/leagueCfgOption"; 
	}
	
	/**
	 * 赛季球员结算
	 * @param request
	 * @param 
	 * @return msg
	 */
	
	@RequestMapping(value="balanceSeason")
	@ResponseBody
	public String balanceSeason(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String s_id = BeanUtils.nullToString(request.getParameter("id"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);	
		if(leagueCfg.getStatus() != 2){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.unend")).toJson(); 
		}
		try {
			msg = leagueService.balanceSeason(s_id);
		} catch (Exception e) {
			logger.error("batch balanceSeason error=============");
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	/**
	 * 下届联赛俱乐部结算处理
	 * @param request
	 * @param 
	 * @return msg
	 */
	
	@RequestMapping(value="balanceLeagueMsg")
	@ResponseBody
	public String balanceLeagueMsg(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String league_id = BeanUtils.nullToString(request.getParameter("id"));
		try {
			League league = leagueService.getEntityById(league_id);
			if(league.getStatus() != 2){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.unended")).toJson();
			}
			msg = leagueService.balanceLeagueMsg(league_id);
		} catch (Exception e) {
			logger.error("batch balanceLeagueMsg error=============");
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 联赛邀请信息发送
	 * @throws Exception 
	 */
	@RequestMapping(value="sendInvite")
	public @ResponseBody String inviteMsg(HttpServletRequest request) throws Exception{
		String league_id = request.getParameter("league_id");//联赛ID
		String end_time = request.getParameter("end_time");//截止时间
		AjaxMsg msg = leagueService.saveLeagueInviteMsg(league_id,end_time);
		return msg.toJson();
	}
	
	/**
	 * 联赛信息管理页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="inviteRecord")
	public String inviteRecord(Model model,HttpServletRequest request,PageModel pageModel){
		String id = request.getParameter("id");//联赛ID
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("league_id", id);
		AjaxMsg msg = leagueService.loadAllInviteMsg(maps, pageModel);
		model.addAttribute("page", msg.getData("page"));
		model.addAttribute("league_id", id);
		return "admin/league/listinvteRecord"; 
	}
	
	@RequestMapping(value="dateCheck")
	public String dateCheck(Model model,HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		model.addAttribute("league_id", league_id);
		return "admin/league/dateCheck"; 
	}
}

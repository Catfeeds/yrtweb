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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminLeagueStatisticsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ObjectExcelView;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 后台竞拍市场管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/auction/")
public class AdminAuctionController {
	
	private static Logger logger = LogManager.getLogger(AdminAuctionController.class);
	
	@Autowired
	private LeagueAuctionService leagueAuctionService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private UserService userService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private AdminLeagueStatisticsService adminLeagueStatisticsService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   }  
	/**
	 * 保存配置
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveAuctionCfg")
	@ResponseBody
	public String saveAuctionCfg(HttpServletRequest request,LeagueAuctionCfg leagueAuctionCfg) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			String s_id = BeanUtils.nullToString(leagueAuctionCfg.getS_id());
			if(StringUtils.isNotBlank(s_id)){
				if(leagueAuctionCfg.getStatus() == 1){
					LeagueAuctionCfg cfg = leagueAuctionService.getCurrentAuction(s_id);
					if(null != cfg){
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.isopen")).toJson();
					}
				}
			}
			if(StringUtils.isBlank(leagueAuctionCfg.getId())){	
				leagueAuctionCfg.setId(UUIDGenerator.getUUID());
				msg = leagueAuctionService.saveAuctionCfg(leagueAuctionCfg);
			}else{
				msg = leagueAuctionService.updateAuctionCfg(leagueAuctionCfg);
			}
		}catch(Exception e){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 竞拍市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listCfg")
	public String auctionCfgList(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		String cfg_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		maps.put("s_id", cfg_id);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(cfg_id);
		AjaxMsg msg = leagueAuctionService.queryCfgForMap(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/auction/list"; 
	}
	
	/**	
	 * 竞拍市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="queryCfgs")
	@ResponseBody
	public String queryCfgs(HttpServletRequest request) {
		String s_id =  request.getParameter("cfg_id");
		String turn_num =   request.getParameter("turn_num");
		String user_id =   request.getParameter("user_id");
		PlayerInfo player = playerInfoService.getPlayerInfoByUserId(user_id);
		LeagueAuctionCfg cfg =  leagueAuctionService.queryCfg(s_id, Integer.valueOf(turn_num));
		if(cfg.getY_init_price() != null){	
			if(player.getLevel() != null && player.getLevel() != 0){
				return AjaxMsg.newSuccess()
						.addData("init_price", cfg.getY_init_price())
						.addData("add_price", cfg.getAdd_price())
						.addData("end_time", cfg.getEnd_time())
						.toJson(); 
			}
		}
			
		return AjaxMsg.newSuccess()
				.addData("init_price", cfg.getInit_price())
				.addData("add_price", cfg.getAdd_price())
				.addData("end_time", cfg.getEnd_time())
				.toJson(); 
	}
	
	
	/**
	 * 市场配置创建页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="cfgForm")
	public String leagueForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String s_id = "";
		LeagueCfg leagueCfg = new LeagueCfg();
		LeagueAuctionCfg lcfg = leagueAuctionService.getCfgById(id);
		if(lcfg == null){
			s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		}else{
			s_id = lcfg.getS_id();
		}
		leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("auctionCfgForm", lcfg);
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/auction/cfgForm"; 
	}
	
	/**
	 * 保存球员配置
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveAuction")
	@ResponseBody
	public String saveAuction(HttpServletRequest request,LeagueAuction leagueAuction) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
			try{
				if(leagueAuction == null || StringUtils.isBlank(leagueAuction.getId())){	
					leagueAuction.setId(UUIDGenerator.getUUID());
					msg = leagueAuctionService.save(leagueAuction);
				}else{
					msg = leagueAuctionService.update(leagueAuction);
				}
			}catch(Exception e){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		return msg.toJson();
	}
	
	/**
	 * 竞拍球员列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listAuction")
	public String listAuction(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		maps.put("username", request.getParameter("username"));
		maps.put("usernick", request.getParameter("usernick"));
		maps.put("turn_num", request.getParameter("turn_num"));
		maps.put("if_up", request.getParameter("if_up"));
		maps.put("s_id", s_id);
		AjaxMsg msg = leagueAuctionService.queryForPageForMap(maps, pageModel);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		List<LeagueAuctionCfg> list = leagueAuctionService.getCfgByLeagueCfg(s_id);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		request.setAttribute("leagueCfg", leagueCfg);
		if(!list.isEmpty()){
			request.setAttribute("turn_count", list.size());
		}
		return "admin/auction/auctionList"; 
	}
	
	/**
	 * 球员创建页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="auctionForm")
	public String auctionForm(HttpServletRequest request){
		String id = request.getParameter("id");
		LeagueAuction auction = leagueAuctionService.getEntityById(id);
		User user = userService.getEntityById(auction.getUser_id());
		
		//List<LeagueAuctionCfg> cfgList = leagueAuctionService.getCfgByLeague(auction.getS_id());
		List<LeagueAuctionCfg> cfgList = leagueAuctionService.getCfgByLeagueCfg(auction.getS_id());
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(auction.getS_id());
		request.setAttribute("cfgList", cfgList);
		request.setAttribute("leagueCfg", leagueCfg);
		request.setAttribute("auctionForm", auction);
		request.setAttribute("player", user);
		return "admin/auction/auctionForm"; 
	}
	
	/**
	 * 删除市场配置
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		if(StringUtils.isBlank(id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		AjaxMsg msg;
		try {
			msg = leagueAuctionService.deleteCfg(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 竞拍统计页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="toStatistics")
	public String toStatistics(HttpServletRequest request){
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		Map<String,Object> map = Maps.newHashMap();
		map.put("s_id", s_id);
		List<League> list = leagueService.getLeaguesByCondition(map);
		List<Map<String,Object>> data_list = Lists.newArrayList();
		for(League league : list){
			Map<String, Object> data_map = Maps.newHashMap();
			List<Map<String, Object>> data = adminLeagueStatisticsService.getAuctionStatisticsData(s_id);
			data_map.put("league", league);
			data_map.put("data",data);
			data_list.add(data_map);
		}
		request.setAttribute("data_list", data_list);
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/auction/statistics_auction"; 
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		String s_id = BeanUtils.nullToString(request.getParameter("s_id"));
		String turn_num = BeanUtils.nullToString(request.getParameter("turn_num"));
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = Lists.newArrayList();
			titles.add("名称");
			titles.add("身份证");
			titles.add("电话");	
			titles.add("球队");
			dataMap.put("titles", titles);
			List<Map<String, Object>> list = leagueAuctionService.getAuctionDetailData(s_id,turn_num);
			List<Map<String,Object>> varList = Lists.newArrayList();
			for(int i=0;i<list.size();i++){
				Map<String,Object> auction = list.get(i);
				Map<String,Object> vpd = Maps.newHashMap();
				vpd.put("var1", auction.get("username"));	//1
				vpd.put("var2", auction.get("id_card") != null?auction.get("id_card"):"");	//2
				vpd.put("var3", auction.get("phone") != null?auction.get("phone"):"");	//3
				vpd.put("var4", auction.get("name") != null?auction.get("name"):"");	//3
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
}

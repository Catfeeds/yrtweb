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
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminLeagueStatisticsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ObjectExcelView;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 后台交易市场管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/market/")
public class AdminMarketController {
	private static Logger logger = LogManager.getLogger(AdminMarketController.class);
	@Autowired
	LeagueMarketService leagueMarketService;
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
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
	@RequestMapping(value="saveMarketCfg")
	@ResponseBody
	public String saveMarketCfg(HttpServletRequest request,MarketCfg marketCfg) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
		 String s_id = BeanUtils.nullToString(marketCfg.getS_id());
		 try{
			 if(StringUtils.isNotBlank(s_id)){
				 if(marketCfg.getIf_open() == 1){
					 MarketCfg cfg = leagueMarketService.getCurrentMarket(s_id);
					 if(null != cfg){
						 return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.isopen")).toJson();
					 }
				 }
			 }
			if(StringUtils.isBlank(marketCfg.getId())){	
				marketCfg.setId(UUIDGenerator.getUUID());
				msg = leagueMarketService.saveMarketCfg(marketCfg);
			}else{
				msg = leagueMarketService.updateMarketCfg(marketCfg);
			}
		}catch(Exception e){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 交易市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listCfg")
	public String marketCfgList(HttpServletRequest request,PageModel pageModel) {
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("s_id", s_id);
		AjaxMsg msg = leagueMarketService.queryCfgForMap(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/market/list"; 
	}
	
	/**	
	 * 交易市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="queryCfgs")
	@ResponseBody
	public String queryCfgs(HttpServletRequest request) {
		String s_id =  request.getParameter("s_id");
		String turn_num =   request.getParameter("turn_num");
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		MarketCfg marketCfg =  leagueMarketService.queryCfg(s_id, Integer.valueOf(turn_num));
		request.setAttribute("leagueCfg", leagueCfg);
		return AjaxMsg.newSuccess().addData("cfg", marketCfg).toJson(); 
	}
	
	/**
	 * 市场配置创建页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="cfgForm")
	public String cfgForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String s_id =  "";
		MarketCfg lcfg = leagueMarketService.getCfgById(id);
		LeagueCfg leagueCfg = new LeagueCfg();
		if(lcfg != null){
			s_id = lcfg.getS_id();
		}else{
			s_id =  BeanUtils.nullToString(request.getParameter("cfg_id"));
		}
		leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("leagueCfg", leagueCfg);
		request.setAttribute("marketCfgForm", lcfg);
		return "admin/market/cfgForm"; 
	}
	
	/**
	 * 保存球员配置
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveMarket")
	@ResponseBody
	public String saveMarket(HttpServletRequest request,LeagueMarket leagueMarket) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
			try{
				if(leagueMarket == null || StringUtils.isBlank(leagueMarket.getId())){	
					leagueMarket.setId(UUIDGenerator.getUUID());
					msg = leagueMarketService.save(leagueMarket);
				}else{
					msg = leagueMarketService.update(leagueMarket);
				}
			}catch(Exception e){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		return msg.toJson();
	}
	
	/**
	 * 交易球员列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="listMarket")
	public String listMarket(HttpServletRequest request,PageModel pageModel) {
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("username", request.getParameter("username"));
		maps.put("s_id", s_id);
		AjaxMsg msg = leagueMarketService.queryForPageForMap(maps, pageModel);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("leagueCfg", leagueCfg);		
		return "admin/market/marketList"; 
	}
	
	/**
	 * 市场球员页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="marketForm")
	public String MarketForm(HttpServletRequest request){
		String id = request.getParameter("id");
		LeagueMarket market = leagueMarketService.getEntityById(id);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(market.getS_id());
		request.setAttribute("leagueCfg", leagueCfg);		
		request.setAttribute("marketForm", market);
		return "admin/market/marketForm"; 
	}
	
	/**
	 * 删除市场配置
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="deleteCfg")
	@ResponseBody
	public String deleteCfg(HttpServletRequest request){
		String id = request.getParameter("id");
		if(StringUtils.isBlank(id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = leagueMarketService.deleteCfg(id);
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
			List<Map<String, Object>> data = adminLeagueStatisticsService.getMarketStatisticsData(s_id);
			data_map.put("league", league);
			data_map.put("data",data);
			data_list.add(data_map);
		}
		request.setAttribute("data_list", data_list);
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/market/statistics_market"; 
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
			titles.add("出售球队");
			titles.add("转会后球队");
			dataMap.put("titles", titles);
			List<Map<String, Object>> list = leagueMarketService.getMarketDetailData(s_id,turn_num);
			List<Map<String,Object>> varList = Lists.newArrayList();
			for(int i=0;i<list.size();i++){
				Map<String,Object> auction = list.get(i);
				Map<String,Object> vpd = Maps.newHashMap();
				vpd.put("var1", auction.get("username"));	//1
				vpd.put("var2", auction.get("id_card") != null?auction.get("id_card"):"");	//2
				vpd.put("var3", auction.get("phone") != null?auction.get("phone"):"");	//3
				vpd.put("var4", auction.get("old_name") != null?auction.get("old_name"):"");	//3
				vpd.put("var5", auction.get("name") != null?auction.get("name"):"");	//3
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

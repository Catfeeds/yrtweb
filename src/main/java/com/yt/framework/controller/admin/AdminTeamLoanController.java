package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.service.admin.AdminLeagueStatisticsService;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ObjectExcelView;

/**
 * 后台租借管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/teamloan/")
public class AdminTeamLoanController {
	private static Logger logger = LogManager.getLogger(AdminTeamLoanController.class);
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private AdminLeagueStatisticsService adminLeagueStatisticsService;
	@Autowired
	private TeamLoanPlayerService teamLoanPlayerService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   }  
	
	/**
	 * 租借统计页面
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
			List<Map<String, Object>> data = adminLeagueStatisticsService.getTeamLoanStatisticsData(s_id);
			data_map.put("league", league);
			data_map.put("data",data);
			data_list.add(data_map);
		}
		request.setAttribute("data_list", data_list);
		request.setAttribute("leagueCfg", leagueCfg);
		return "admin/league/teamloan/statistics_teamloan"; 
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
			titles.add("出租方球队");
			titles.add("租借方球队");
			titles.add("租借开始时间");
			titles.add("租借结束时间");
			dataMap.put("titles", titles);
			List<Map<String, Object>> list = teamLoanPlayerService.getTeamLoanDetailData(s_id,turn_num);
			List<Map<String,Object>> varList = Lists.newArrayList();
			for(int i=0;i<list.size();i++){
				Map<String,Object> auction = list.get(i);
				Map<String,Object> vpd = Maps.newHashMap();
				vpd.put("var1", auction.get("username"));	//1
				vpd.put("var2", auction.get("id_card") != null?auction.get("id_card"):"");	//2
				vpd.put("var3", auction.get("phone") != null?auction.get("phone"):"");	//3
				vpd.put("var4", auction.get("loan_name") != null?auction.get("loan_name"):"");	//4
				vpd.put("var5", auction.get("buy_name") != null?auction.get("buy_name"):"");	//5
				vpd.put("var6", auction.get("closing_time") != null?auction.get("closing_time"):"");	//6
				vpd.put("var7", auction.get("end_time") != null?auction.get("end_time"):"");	//7
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

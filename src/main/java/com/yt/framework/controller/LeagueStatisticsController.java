package com.yt.framework.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.LeagueStatisticsService;
import com.yt.framework.service.PriceSlaveService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 * 联赛
 * 
 * @autor ylt
 * @date2015-10-14下午2:46:36
 */
@Controller
@RequestMapping(value = "/statistics")
public class LeagueStatisticsController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(LeagueStatisticsController.class);
	@Autowired
	private LeagueStatisticsService leagueStatisticsService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private PriceSlaveService priceSlaveService;
	@Autowired
	private QuanLeagueService quanLeagueService;
	
	/**
	 * 数据总览
	 * @author ylt
	 * @return
	 */
	@RequestMapping(value="totalStatistics")
	public String totalStatistics(HttpServletRequest request){
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		League league = leagueService.getEntityById(league_id);
		PageModel spageModel = new PageModel();
		spageModel.setPageSize(3);
		Map<String,Object> smap = Maps.newHashMap();
		smap.put("league_id", league_id);
		List<League> leagueList = leagueService.getLeaguesByCondition(smap);
		//射手榜数据
		AjaxMsg shotMsg = leagueService.loadLeagueScorerRecord(smap,spageModel);
		//身价榜
		PageModel wpageModel = new PageModel();
		spageModel.setPageSize(3);
		AjaxMsg worthMsg = priceSlaveService.loadPriceSlaveSingle(smap, wpageModel);
		//助攻榜
		PageModel apageModel = new PageModel();
		spageModel.setPageSize(3);
		Map<String,Object> amap = Maps.newHashMap();
		amap.put("league_id", league_id);
		AjaxMsg assistMsg =  leagueService.loadLeagueAssists(amap,apageModel);
		//红黄牌榜
		PageModel cpageModel = new PageModel();
		spageModel.setPageSize(3);
		Map<String,Object> cmap = Maps.newHashMap();
		cmap.put("league_id", league_id);
		AjaxMsg cardMsg = quanLeagueService.getQUserDataCardStatics(cmap,cpageModel);
		request.setAttribute("league", league);
		request.setAttribute("leagues", leagueList);
		request.setAttribute("shotList", shotMsg.getData("page"));
		request.setAttribute("worthList", worthMsg.getData("page"));
		request.setAttribute("assistList", assistMsg.getData("page"));
		request.setAttribute("cardList", cardMsg.getData("page"));
		return "league/statistics/league_total_statistics";
	}
}
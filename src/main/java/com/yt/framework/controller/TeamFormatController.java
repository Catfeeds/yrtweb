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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.PlayerPosition;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;

/**
 * 球队阵型设置
 * @author bo.xie
 * @Date 2015年11月28日16:49:32
 */
@RequestMapping(value="/tformat/")
@Controller
public class TeamFormatController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(TeamFormatController.class);

	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 * 设置页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="setedPage")
	public String settingFormatPage(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		TeamInfo teaminfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(StringUtils.isNotBlank(teaminfo.getId())){
			model.addAttribute("teaminfo_id", teaminfo.getId());
		}
		return "team/format/index";
	}
	
	@RequestMapping(value="format")
	public String formatArea(Model model,HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		List<Map<String,Object>> tps_format = teamInfoService.getTeamPlayerByTeamInfoID(teaminfo_id);
		
		List<Map<String,Object>> tps = teamInfoService.getAllTPsTeamInfoID(teaminfo_id);
		model.addAttribute("tps", tps);
		model.addAttribute("tps_format", tps_format);
		return "team/format/format";
	}
	
	/**
	 * 保存球队阵型
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveFormat")
	public @ResponseBody String saveFormat(HttpServletRequest request,PlayerPosition pp){
		teamInfoService.updatePlayerPosition(pp.getPp());
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 阵容成员数据
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="datas")
	public @ResponseBody String teamFormatPlayer(Model model,HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		List<Map<String,Object>> tps = teamInfoService.getTeamPlayerByTeamInfoID(teaminfo_id);
		return AjaxMsg.newSuccess().addData("tps", tps).toJson();
	}
	
	
}

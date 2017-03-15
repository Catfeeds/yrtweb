package com.yt.framework.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyEval;
import com.yt.framework.service.BabyEvalService;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 宝贝助威评价
 *@autor ylt
 *@date2015-9-25下午6:17:38
 */
@Controller
@RequestMapping(value="/babyeval/")
public class BabyEvalController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BabyEvalController.class);
	
	@Autowired
	private BabyEvalService babyEvalService;
	@Autowired 
	private BabyService babyService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 * 助威评价页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="toEval/{baby_id}")
	@ResponseBody
	public String toEval(HttpServletRequest request,@PathVariable String baby_id){
		if(StringUtils.isBlank(baby_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.nobaby")).toJson();
		AjaxMsg msg = babyService.getBabyUser(baby_id);
		return msg.toJson();
	}
	
	/**
	 * 保存助威评价
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="saveBabyEval")
	@ResponseBody
	public String saveBabyEval(HttpServletRequest request,BabyEval babyEval){
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(babyEval.getId())){
			babyEval.setP_user_id(getUserId());
			babyEval.setId(UUIDGenerator.getUUID());
			msg = babyEvalService.save(babyEval);	
		}else{
			msg = babyEvalService.update(babyEval);	
		}
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}else{
			msg.addMessage(messageResourceService.getMessage("system.error"));
		}
		return msg.toJson();
	}
	
	
	/**
	 * 助威评价列表
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="searchBabyEval")
	@ResponseBody
	public String searchBabyEval(HttpServletRequest request,PageModel pageModel){
		String user_id = request.getParameter("user_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		Map<String,Object> map = Maps.newHashMap();
		map.put("user_id", user_id);
		if(StringUtils.isNotBlank(teaminfo_id)){
			map.put("teaminfo_id",teaminfo_id);
		}
		AjaxMsg msg = babyEvalService.queryForPage(map, pageModel);
		request.setAttribute("babyEvals", msg.getData("page"));
		return msg.toJson();
	}
	
	/**
	 * 宝贝详情页面评价列表
	 * @param model
	 * @param request
	 * @author bo.xie
	 * @date 2015年10月7日15:57:26
	 * @return
	 */
	@RequestMapping(value="pjList")
	public String babyInfoPjList(Model model,HttpServletRequest request,PageModel pageModel){
		//宝贝用户ID
		String user_id = request.getParameter("user_id");
		Map<String,Object> map = Maps.newHashMap();
		map.put("user_id", user_id);
		AjaxMsg msg = babyEvalService.queryForPageForMap(map, pageModel);
		model.addAttribute("rf", msg.getData("page"));
		return "baby/pjList";
	}
}

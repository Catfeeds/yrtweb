package com.yt.framework.controller.admin;

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

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminBabyInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台足球宝贝管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/fbaby/")
public class AdminFBabyController {
	
	private static Logger logger = LogManager.getLogger(AdminFBabyController.class);
	
	@Autowired
	private AdminBabyInfoService adminBabyInfoService;
	@Autowired
	private MessageResourceService messageResourceService;

	/**
	 * 足球宝贝列表
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="listdata")
	public String babyListPage(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("usernick", request.getParameter("usernick"));
		maps.put("phone", request.getParameter("phone"));
		
		List<Map<String,Object>> datas = adminBabyInfoService.loadBabyDataPage(maps, pageModel);
		pageModel.setItems(datas);
		
		model.addAttribute("page", pageModel);
		model.addAttribute("params", maps);
		return "admin/baby/babyList";
	}
	
	/**
	 * 更新宝贝信息
	 */
	@RequestMapping(value="updateBabyInfo")
	public @ResponseBody String updateBaseInfo(HttpServletRequest request){
		String baby_id = request.getParameter("baby_id");
		String is_index = request.getParameter("is_index");
		String show_num = request.getParameter("show_num");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(baby_id)) return msg.addMessage(messageResourceService.getMessage("system.error.baby.nobaby")).toJson(); 
		BabyInfo babyInfo = adminBabyInfoService.getBabyInfoById(baby_id);
		if(StringUtils.isNotBlank(is_index)){
			babyInfo.setIs_index(Integer.valueOf(is_index));
		}
		if(StringUtils.isNotBlank(show_num)){
			int count = adminBabyInfoService.isExistByShowNum(show_num);
			if(count>0)return msg.addMessage(messageResourceService.getMessage("user.baby.isShowNum")).toJson();
			babyInfo.setShow_num(Integer.valueOf(show_num));
		}
		adminBabyInfoService.updateBabyInfo(babyInfo);
		return msg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 更新宝贝信息
	 */
	@RequestMapping(value="setIfDel")
	public @ResponseBody String setIfDel(HttpServletRequest request){
		String id = request.getParameter("id");
		String if_del = request.getParameter("if_del");
		AjaxMsg msg = AjaxMsg.newSuccess();
		BabyInfo babyInfo = adminBabyInfoService.getBabyInfoById(id);
		if(StringUtils.isNotBlank(if_del)){
			babyInfo.setIf_del(Integer.parseInt(if_del));
		}
		adminBabyInfoService.updateBabyInfo(babyInfo);
		return msg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
}

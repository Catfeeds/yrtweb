package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AdminSign;
import com.yt.framework.persistent.entity.AdminSignCfg;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.security.WebUserDetails;
import com.yt.framework.service.AcountService;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminSignService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 * 后台联赛报名管理
 * @author bo.xie
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/sign/")
public class AdminSignController {
	private static Logger logger = LogManager.getLogger(AdminSignController.class);
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private AdminSignService adminSignService;
	@Autowired
	LeagueService leagueService;
	@Autowired
	CertificaService certificaService;
	@Autowired
	AcountService acountService;
	@Autowired
	UserService userService;
	@Autowired
	PlayerInfoService playerInfoService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	/**
	 * 保存联赛报名信息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveSign")
	@ResponseBody
	public String saveSign(HttpServletRequest request,AdminSign adminSign) {
		AjaxMsg msg  = AjaxMsg.newSuccess();
		try {
			msg = adminSignService.saveAllInfo(adminSign,null);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	/**
	 * 显示已录入信息列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="showSign")
	public String showSign(HttpServletRequest request,PageModel pageModel) {
		String mobile = request.getParameter("mobile");
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		String sign_id = BeanUtils.nullToString(request.getParameter("sign_id"));
		Map<String,Object> map = Maps.newHashMap();
		map.put("mobile", mobile);
		map.put("s_id", s_id);
		map.put("sign_id", sign_id);
		AjaxMsg msg = adminSignService.queryForPageForMap(map, pageModel);
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		AdminSignCfg adminSignCfg = adminSignService.getCfgById(sign_id);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("leagueCfg",leagueCfg);
		request.setAttribute("signCfg",adminSignCfg);
		return "admin/sign/list"; 
	}
	
	/**
	 * 后台录入页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="signForm")
	public String signForm(HttpServletRequest request){
		String id = request.getParameter("id");
		String s_id = BeanUtils.nullToString(request.getParameter("cfg_id"));
		if(StringUtils.isNotBlank(id)){
			AdminSign adminSign = adminSignService.getEntityById(id);
			User u = userService.getUserByPhoneOrEmail(adminSign.getMobile());
			if(null != u){
				LeagueSign l = leagueService.getLeagueSign(u.getId(),adminSign.getS_id());
				Certification c = certificaService.getCertificationByUserId(u.getId(), "idcard");
				PlayerInfo p = playerInfoService.getPlayerInfoByUserId(u.getId());
				request.setAttribute("p_user", u);
				request.setAttribute("leagueSign", l);
				request.setAttribute("certification", c);
				request.setAttribute("playerInfo", p);
			}
			request.setAttribute("adminSignForm", adminSign);
		}
		LeagueCfg leagueCfg = leagueService.getLeagueCfgById(s_id);
		request.setAttribute("leagueCfg",leagueCfg);
		return "admin/sign/adminSignForm"; 
	}
	
	/**
	 * 报名设置页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="signCfgForm")
	public String signCfgForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		List<LeagueCfg>cfgList = leagueService.getLeaugeCfgList();
		request.setAttribute("cfgList", cfgList);
		if(StringUtils.isNotBlank(id)){
			AdminSignCfg adminSignCfg = adminSignService.getCfgById(id);
			request.setAttribute("adminSignCfgForm", adminSignCfg);
		}
		return "admin/sign/signCfgForm"; 
	}
	
	/**
	 * 报名设置列表
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="signCfgList")
	public String signCfgList(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		AjaxMsg msg = adminSignService.queryCfgForPage(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/sign/signCfgList"; 
	}
	
	/**
	 * 保存报名设置
	 * @autor ylt
	 * @parameter *
	 * @date2016-10-14下午3:48:45
	 */
	@RequestMapping(value="saveSignCfg")
	@ResponseBody
	public String saveSignCfg(HttpServletRequest request,AdminSignCfg adminSignCfg) {
		AjaxMsg msg  = AjaxMsg.newSuccess();
		try {
			WebUserDetails user = (WebUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
			adminSignCfg.setUser_id(user.getUserId());
			msg = adminSignService.saveSignCfg(adminSignCfg);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	
	/**
	 * 保存报名设置
	 * @autor ylt
	 * @parameter *
	 * @date2016-10-14下午3:48:45
	 */
	@RequestMapping(value="delSignCfg")
	@ResponseBody
	public String delSignCfg(HttpServletRequest request) {
		AjaxMsg msg  = AjaxMsg.newSuccess();
		String id = BeanUtils.nullToString(request.getParameter("id"));
		try {
			msg = adminSignService.deleteAdminSignCfg(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	/**
	 * 关键字查询
	 * @autor ylt
	 * @parameter *
	 * @date2016-10-14下午3:48:45
	 */
	@RequestMapping(value="keyword")
	@ResponseBody
	public String keyword(HttpServletRequest request) {
		String keyword = BeanUtils.nullToString(request.getParameter("keyword"));
		int i = adminSignService.queryKeyword(keyword);
		if(i > 0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.sign.keyword")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
}

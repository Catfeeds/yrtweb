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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ActivitySign;
import com.yt.framework.persistent.entity.AdminSign;
import com.yt.framework.persistent.entity.AdminSignCfg;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.ActivitySignService;
import com.yt.framework.service.admin.AdminSignService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;

/**
 * 报名
 * @author ylt
 * 2016年9月3日12:00:19
 */
@Controller
@RequestMapping(value="/html5/")
public class Html5Controller extends BaseController{
	
	private static Logger logger = LogManager.getLogger(Html5Controller.class);
	
	@Autowired
	private AdminSignService adminSignService;
	@Autowired
	private ActivitySignService activitySignService;
	@Autowired
	private UserService userService;
	@Autowired
	private LeagueService leagueService;
	
	/**
	 * 报名引导页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="info/{keyword}")
	public String guidePage(HttpServletRequest request,@PathVariable("keyword")String keyword){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("keyword", keyword);
		maps.put("if_show", "1");
		List<AdminSignCfg> list = adminSignService.getCfgByMap(maps);
		if(list.isEmpty()){
			return "error";
		}else{
			AdminSignCfg adminSignCfg = list.get(0);
			request.setAttribute("adminSignCfg", adminSignCfg);	
		}
		return "html5/guide";
	}

	/**
	 * 信息录入页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="guide/{keyword}")
	public String writeInfoPage(HttpServletRequest request,@PathVariable("keyword")String keyword){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("keyword", keyword);
		maps.put("if_show", "1");
		List<AdminSignCfg> list = adminSignService.getCfgByMap(maps);
		if(list.isEmpty()){
			return "error";
		}else{
			AdminSignCfg adminSignCfg = list.get(0);
			request.setAttribute("adminSignCfg", adminSignCfg);	
		}
		return "html5/info";
	}
	
	@RequestMapping(value="registration")
	public String registration(Model model,HttpServletRequest request){
		
		return "html5/registration";
	}
	/**
	 * <p>Description:保存activitySign对象 </p>
	 * @Author zhangwei
	 * @Date 2015年11月18日 下午5:18:10
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="registration_save")
	@ResponseBody
	public String registration_save(ActivitySign activitySign,HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String phone = activitySign.getPhone();
		AjaxMsg msg_iau = activitySignService.getActivitySignByPhone(phone);
		//手机号码是否已经报过名
		if(msg_iau.isError()){
			return msg_iau.toJson();
		}
		try {
			msg = activitySignService.saveActivitySign(activitySign,request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}
	/**
	 * 校验该用户是否已报名
	 * @param request
	 * @return
	 */
	@RequestMapping(value="validSign")
	public @ResponseBody String validateSign(HttpServletRequest request){
		String phone = request.getParameter("phone");
		User user = userService.getUserByPhoneOrEmail(phone);
		if(user!=null){
			LeagueSign leagueSign = leagueService.getLeagueSign(user.getId(), "1");
			if(leagueSign!=null)return AjaxMsg.newError().addMessage("您已报名，详情请登录宇任拓官网查看").toJson();
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 联赛协议
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="agree")
	public String leagueAgree(Model model,HttpServletRequest request){
		String name = request.getParameter("name");//姓名
		String phone = request.getParameter("phone");//手机号
		String idcard = request.getParameter("idcard");//身份证
		String sign_id = request.getParameter("sign_id");//身份证
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		model.addAttribute("idcard", idcard);
		return "html5/agree";
	}
	
	/**
	 * 保存联赛报名用户信息
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="saveSignInfo")
	public @ResponseBody String saveSignInfo(Model model,HttpServletRequest request) throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		String name = BeanUtils.nullToString(request.getParameter("name"));//姓名
		String mobile = BeanUtils.nullToString(request.getParameter("mobile"));//手机号
		String sign_id = BeanUtils.nullToString(request.getParameter("sign_id"));//报名主题id
		String idcard = BeanUtils.nullToString(request.getParameter("idcard"));//身份证id
		AdminSign adminSign = new AdminSign();
		adminSign.setSign_id(sign_id);
		adminSign.setInput_type(1);
		adminSign.setMobile(mobile);
		adminSign.setUsername(name);
		adminSign.setIdcard(idcard);
		msg = adminSignService.saveAllInfoApp(adminSign, request);
		
		return msg.toJson();
	}
	
	/**
	 * 保存联赛报名用户信息
	 * @return
	 * @throws Exception 
	 *//*
	@RequestMapping(value="saveSignInfo")
	public @ResponseBody String saveSignInfo(Model model,HttpServletRequest request) throws Exception{
		String name = request.getParameter("name");//姓名
		String phone = request.getParameter("phone");//手机号
		String idcard = request.getParameter("idcard");//身份证
		AdminSign adminSign = new AdminSign();
		adminSign.setIdcard(idcard);
		adminSign.setInput_type(1);
		//adminSign.setLeagues_id("1");
		adminSign.setMobile(phone);
		adminSign.setUsername(name);
		AjaxMsg msg = adminSignService.saveAllInfoApp(adminSign, request);
		return msg.toJson();
	}*/
	/**
	 * 用户点击取消后跳转的页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="cancel")
	public String cancelPage(Model model,HttpServletRequest request){
		userService.getData();
		return "html5/cancelpage";
	}
	
	/**
	 * 报名缴费回调页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="signSuccess")
	public String signSucess(Model model,HttpServletRequest request){
		
		return "league/league_sign_paySuccess";
	}
	
	/**
	 * 同意联赛章程页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="result") 
	public String submitInfoPage(Model model,HttpServletRequest request){
		String flag = BeanUtils.nullToString(request.getParameter("flag"));
		String url = "submitSuccess";
		if("true".equals(flag)){
			url = "submitSidSuccess";
		}
		return "html5/"+url;
	}
	
	/**
	 * 登录查询数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="signSearch")
	public String loginForSearchData(HttpServletRequest request){
		return "html5/sign_searchData";
	}
	
	@RequestMapping(value="valid")
	public @ResponseBody String validataSignSearch(HttpServletRequest request){
		String pwd ="yrt2015";
		String host = request.getHeader("Host");
		/*if(!host.contains("11uniplay.com")){
			return AjaxMsg.newError().addMessage("非法访问！").toJson();
		}*/
		String r_pwd = request.getParameter("pwd");
		if(!pwd.equals(r_pwd)){
			return AjaxMsg.newError().addMessage("登录密码错误！").toJson();
		}
		Common.setSessionValue("html5Pwd", pwd);
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 平台数据查询
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="searchData")
	public String searchData(Model model,HttpServletRequest request){
		String pwd = String.valueOf(Common.getCurrentSessionValue(request, "html5Pwd"));
		if(StringUtils.isBlank(pwd)){
			return null;
		}
		model.addAttribute("map", userService.getData());
		return "html5/searchData";
	}
}

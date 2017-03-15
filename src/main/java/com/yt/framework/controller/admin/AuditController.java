package com.yt.framework.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.enums.CertificationEnum.CerType;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 * 审核管理
 * @author ylt
 * @date 2015年7月27日 上午10:25:03 
 */
@Controller
@RequestMapping(value="/admin/audit")
public class AuditController {
	
	private static Logger logger = LogManager.getLogger(AuditController.class);
	
	@Autowired
	private CertificaService certificaService;
	@Autowired 
	private UserService userService;
	@Autowired 
	private PlayerInfoService playerInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	/**
	 * 用户认证审核列表
	 * @param request
	 * @param pageModel status 审核状态  type 认证类型
	 * @return msg
	 */
	@RequestMapping(value="auditUserList")
	public String auditUserList(HttpServletRequest request,PageModel pageModel){
		String status = request.getParameter("status");
		String username = request.getParameter("username");
		String usernick = request.getParameter("usernick");
		Map<String,Object> params = Maps.newHashMap();
		if(StringUtils.isNotBlank(status)){
			params.put("status", Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(username)){
			params.put("username", username);
		}
		if(StringUtils.isNotBlank(usernick)){
			params.put("usernick", usernick);
		}
		params.put("type", CerType.IDCARD.toString());
		AjaxMsg msg = certificaService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/audit/auditlist"; 
	}
	
	/**
	 * 用户认证审核列表
	 * @param request
	 * @param pageModel status 审核状态  type 认证类型
	 * @return msg
	 */
	@RequestMapping(value="auditPlayerList")
	public String auditPlayerList(HttpServletRequest request,PageModel pageModel){
		String status = request.getParameter("status");
		String username = request.getParameter("username");
		String usernick = request.getParameter("usernick");
		Map<String,Object> params = Maps.newHashMap();
		if(StringUtils.isNotBlank(status)){
			params.put("status", Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(username)){
			params.put("username", username);
		}
		if(StringUtils.isNotBlank(usernick)){
			params.put("usernick", usernick);
		}
		params.put("type", CerType.PROFESSIONAL.toString());
		AjaxMsg msg = certificaService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/audit/auditlist"; 
	}
	
	/**
	 * 用户审核结果
	 * @param request
	 * @param certification
	 * @return msg
	 */
	@RequestMapping(value="playerAuditResult")
	@ResponseBody
	public String playerAuditResult(HttpServletRequest request,Certification certification){
		String type = request.getParameter("type");
		Certification certification_player = certificaService.getEntityById(certification.getId());
		if(certification_player == null) return AjaxMsg.newError().addMessage("认证记录不存在").toJson();
		if(certification_player.getStatus() == 1) return AjaxMsg.newError().addMessage("认证已通过,无需再次认证").toJson();
		int count = certificaService.getCertificationByIdCardCount(certification_player.getId_card(), "idcard",1);
		if(count >= 1){
			if(certification.getStatus() == 1){
				return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.cerexist")).toJson();
			}
		}
		certification_player.setAudit_time(new Date());
		certification_player.setStatus(certification.getStatus());
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = certificaService.playerAuditResult(certification_player);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	/**
	 * 球员审核页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="playerAudit")
	public String playerAudit(HttpServletRequest request){
		String id = request.getParameter("id");
		Certification player = certificaService.getEntityById(id);
		if(player == null) return AjaxMsg.newError().addMessage("认证记录不存在").toJson();
		if(player.getStatus() == 1){
			request.setAttribute("ifShow",true);
		}
		request.setAttribute("playerForm", player);
		return "admin/audit/playerForm"; 
	}
	
	/**
	 * 球员审核页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="userAuditById")
	public String playerAuditById(HttpServletRequest request){
		String user_id = request.getParameter("id");
		String type = request.getParameter("type");
		Certification user = certificaService.getCertificationByUserId(user_id, type);
		if(user == null) return "error";
		if(user.getStatus() == 1){
			request.setAttribute("ifShow",true);
		}
		request.setAttribute("userForm", user);
		request.setAttribute("type", type);
		return "admin/audit/userForm"; 
	}
	
	/**
	 * 球员审核页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="ifAudit")
	@ResponseBody
	public String ifAudit(HttpServletRequest request){
		String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
		Certification player = certificaService.getCertificationByUserId(user_id, "idcard");
		if(player == null) return AjaxMsg.newError().addMessage("认证记录不存在").toJson();
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 用户审核页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="userAudit")
	public String userAudit(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		Certification user = certificaService.getEntityById(id);
		if(user == null) return AjaxMsg.newError().addMessage("认证记录不存在").toJson();
		if(user.getStatus() == 1){
			request.setAttribute("ifShow",true);
		}
		request.setAttribute("userForm", user);
		request.setAttribute("type", type);
		return "admin/audit/userForm"; 
	}
	
	@RequestMapping(value="/recommendList")
	public String recommendList(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("usernick", BeanUtils.nullToString(request.getParameter("usernick")));
		AjaxMsg msg = playerInfoService.searchPlayerInfoByAdmin(maps,pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/audit/recommendList"; 
	}
	
	@RequestMapping(value="/userDialog")
	public String userDialog(HttpServletRequest request){
		return "admin/audit/user_dialog";
	}
	
	@RequestMapping(value="/savePlayerRecommendation")
	@ResponseBody
	public String savePlayerRecommendation(HttpServletRequest request,String userIds){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(userIds)){
			try {
				msg = playerInfoService.savePlayerRecommendation(userIds);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/updatePlayerRecommendation")
	@ResponseBody
	public String updatePlayerRecommendation(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String sort = BeanUtils.nullToString(request.getParameter("re_sort"));
		String if_up = BeanUtils.nullToString(request.getParameter("if_up"));
		Map<String, Object> maps = new HashMap<String,Object>();
		maps.put("id", id);
		maps.put("re_sort", sort);
		maps.put("if_up", if_up);
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = playerInfoService.updatePlayerRecommendation(maps);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/deletePlayerRecommendation")
	@ResponseBody
	public String deletePlayerRecommendation(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = playerInfoService.deletePlayerRecommendation(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
}

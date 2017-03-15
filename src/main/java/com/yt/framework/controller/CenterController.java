package com.yt.framework.controller;

import java.util.HashMap;
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

import com.yt.framework.persistent.entity.CoachInfo;
import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.Visitor;
import com.yt.framework.persistent.enums.VisitorEnum.VISTORTYPE;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.CoacheInfoService;
import com.yt.framework.service.DressResourcesService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.VisitorService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 个人中心
 * @author GL
 * @date 2015年8月3日 下午2:13:35 
 */
@Controller
@RequestMapping(value="/centerold")
public class CenterController extends BaseController{
	private static Logger logger = LogManager.getLogger(CenterController.class);
	
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private DressResourcesService dressResourcesService;
	@Autowired
	private VisitorService visitorService;
	@Autowired
	private AgentInfoService agentInfoService;
	@Autowired
	private CoacheInfoService coacheInfoService;
	@Autowired
	private PlayerInfoService playerInfoService;
	
	@RequestMapping("")
	public String center(HttpServletRequest request){
		request.setAttribute("oth_user_id", getUserId());
		return "center/center";
	}
				
	@RequestMapping("/{user_id}")
	public String center(HttpServletRequest request,@PathVariable String user_id){
		try {
			String session_user_id = this.getUserId();
			if(null != session_user_id && null != user_id ){
				if(!session_user_id.equals(user_id)){
					Visitor visitor = visitorService.getVisitor(session_user_id, user_id,"0");
					if(visitor == null){
						visitor = new Visitor();
						visitor.setId(UUIDGenerator.getUUID());
						visitor.setP_visitor_id(user_id);
						visitor.setVisitor_id(session_user_id);
						visitor.setVisit_url(VISTORTYPE.CENTER.toString());
						visitor.setVisit_type("0");
						visitor.setT_visit_count(1);
						visitor.setVisit_count(1);
						visitorService.save(visitor);
					}else{
						visitor.setT_visit_count(visitor.getT_visit_count()+1);
						visitor.setVisit_count(visitor.getVisit_count()+1);
						visitorService.update(visitor);
					}
				}
			}
			request.setAttribute("oth_user_id", user_id);
			return "center/center";
		} catch (Exception e) {
			e.printStackTrace();
			return "";  //update gl 2015/09/02  当user_id错误跳转404
		}
	}
	
	/**
	 * 更改头像
	 * @return String
	 */
	@RequestMapping(value="/changeHeadImg")
	public String changeHeadImg(){
		return "center/head_img";
	}
	
	/**
	 * 判断用户是否是经济人
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-2下午4:12:32
	 */
	@RequestMapping(value="/isAgent")
	public String isAgent(Model model,HttpServletRequest request){
		String session_user_id = this.getUserId();//当前登录用户ID
		String oth_user_id = request.getParameter("oth_user_id");//其他访问用户ID
		AjaxMsg agentMsg = agentInfoService.getAgentInfoByUserId(session_user_id);
		AjaxMsg oth_agentMsg = agentInfoService.getAgentInfoByUserId(oth_user_id);
		PlayerInfo playerInfo = playerInfoService.getPlayerInfoByUserId(session_user_id);
		
		if(agentMsg.isSuccess()){
			model.addAttribute("isAgent", agentMsg.getData("data"));
		}
		if(oth_agentMsg.isSuccess()){
			model.addAttribute("oth_isAgent", oth_agentMsg.getData("data"));
		}
		model.addAttribute("oth_user_id", oth_user_id);
		model.addAttribute("playerInfo", playerInfo);
		return "center/isAgentDiv";
	}
	
	/**
	 * 判断是否是经纪人
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-2下午4:16:14
	 */
	@RequestMapping(value="/isCoach")
	public String isCoach(Model model,HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		String session_user_id = this.getUserId();
		if(StringUtils.isNotBlank(oth_user_id)){
			session_user_id = oth_user_id;
		}
		CoachInfo coachInfo = coacheInfoService.getCoachInfoByUserId(session_user_id);
		model.addAttribute("oth_user_id", oth_user_id);
		model.addAttribute("isCoach", coachInfo);
		model.addAttribute("oth_user_id", oth_user_id);
		return "center/isCoachDiv";
	}
	
	/**
	 * 查询个人中心皮肤模版页面
	 * @param request
	 * @return  AjaxMsg
	 */
	@RequestMapping(value="/toDress")
	public String toDress(Model model,HttpServletRequest request){
		model.addAttribute("user", super.getUser());
		return "center/template/mytemplate"; 
	}
	
	/**
	 * 查询个人中心皮肤模版
	 * @param request
	 * @return  AjaxMsg
	 */
	@RequestMapping(value="/queryDressRes")
	public String queryDressRes(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", getUserId());
		pageModel.setPageSize(6);
		AjaxMsg msg = dressResourcesService.queryForPageForMap(params, pageModel);
		model.addAttribute("rf",msg.getData("page"));
		return "center/template/alllist";
	}
	/**
	 * 查询已经拥有皮肤
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/queryMyDressRes")
	public String queryMyDressRes(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", getUserId());
		pageModel.setPageSize(6);
		AjaxMsg msg = dressResourcesService.queryMyDressRes(params, pageModel);
		model.addAttribute("rt",msg.getData("page"));
		return "center/template/mylist";
	}
	
	/**
	 * 更换皮肤
	 * @param request
	 * @return String
	 */
	@RequestMapping(value="/changeDress")
	@ResponseBody
	public String changeDress(HttpServletRequest request){
		String dr_id = request.getParameter("dr_id");
		AjaxMsg msg = dressResourcesService.updateDress(getUserId(),dr_id);
		return msg.toJson();
	}
	
	
	/**
	 * 我的图片 视频
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:俱乐部；4：经纪人；5教练人
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午3:42:09
	 */
	@RequestMapping(value="/ownImageV")
	public @ResponseBody String loadMyOwnImageVideo(HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		String type = request.getParameter("type");
		String role_type = request.getParameter("role_type");
		if(StringUtils.isBlank(user_id) || StringUtils.isBlank(type)) return AjaxMsg.newError().addMessage("查询失败！").toJson();
		AjaxMsg msg = imageVideoService.getImageVideosByUserId(user_id, Integer.valueOf(type),Integer.valueOf(role_type),pageModel);
		return msg.toJson();
	}
	
	/**
	 * 购买装扮模板详情页面
	 * @param model
	 * @param request
	 * @param d_id 装扮Id 
	 * @return
	 */
	@RequestMapping(value="buyDress/{d_id}")
	public String buyTemplateDetail(Model model,HttpServletRequest request,@PathVariable("d_id")String d_id){
		DressResources dr = dressResourcesService.getEntityById(d_id);
		if(dr==null)return "error/404";
		String order_num = Common.createOrderOSN();
		model.addAttribute("dr", dr);
		model.addAttribute("order_num", order_num);
		return "center/template/templateOrder";
	}
	
}

package com.yt.framework.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.Comment;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 动态页面
 * @Title: DynamicController.java 
 * @Package com.yt.framework.controller
 * @author GL
 * @date 2015年8月10日 上午11:37:31 
 */
@Controller
@RequestMapping(value="/dynamic")
public class DynamicController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(DynamicController.class);
	
	@Autowired
	private DynamicService dynamicService;
	
	@Autowired
	private UserService userService;

	/**
	 * 动态主页
	 * @return dynamic.jsp
	 */
	@RequestMapping(value="")
	public String dynamic(HttpServletRequest request){
		User user = userService.getEntityById(getUserId());
		request.setAttribute("headimg", user.getHead_icon());
		return "dynamic/dynamic";
	}
	
	@RequestMapping(value="/me")
	public String myDynamic(HttpServletRequest request){
		User user = userService.getEntityById(getUserId());
		request.setAttribute("headimg", user.getHead_icon());
		return "dynamic/mydynamic";
	}
	
	@RequestMapping(value="new")
	public String bestNewDynamic(HttpServletRequest request){
		return "dynamic/newDynamic";
	}
	
	/**
	 * 动态列表
	 * @param request
	 * @param pageModel
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/datas")
	@ResponseBody
	public String datas(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("id", getUserId());
		params.put("meid", getUserId());
//		AjaxMsg msg = dynamicService.queryForPageForMap(params, pageModel);
		AjaxMsg msg = dynamicService.queryDynamics(params,pageModel);
		return msg.toJson();
	}
	
	/**
	 * 查询自己的动态
	 * @param request
	 * @param pageModel
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/myDatas")
	@ResponseBody
	public String myDatas(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("id", getUserId());
		AjaxMsg msg = dynamicService.queryMyDynamic(params, pageModel);
		return msg.toJson();
	}
	
	/**
	 * 查询访问球员动态
	 * @param request
	 * @param pageModel
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/toOtherDatas")
	public String toOtherDatas(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		String user_id = request.getParameter("user_id");
		params.put("id", user_id);
		AjaxMsg msg = dynamicService.queryMyDynamic(params, pageModel);
		request.setAttribute("dynCount", msg.getData("dynCount"));
		request.setAttribute("u_id", user_id);
		return "center/dynamic/dynamic";
	}
	
	/**
	 * 最新动态
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="newDatas")
	public @ResponseBody String newDatas(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("id", getUserId());
		AjaxMsg msg = dynamicService.queryNewDynamic(params, pageModel);
		return msg.toJson();
	}
	
	/**
	 * 统计关注人数，被关注人数，动态数
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/dynCount")
	@ResponseBody
	public String dynCount(HttpServletRequest request){
		AjaxMsg msg = dynamicService.dynCount(getUserId());
		return msg.toJson();
	}
	
	/**
	 * 保存动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveDyn")
	@ResponseBody
	public String saveDyn(HttpServletRequest request,Dynamic dynamic){
		dynamic.setUser_id(getUserId());
		dynamic.setType(0);//设置type为个人动态
		if(null == dynamic.getId() || "".equals(dynamic.getId())){
			dynamic.setId(UUIDGenerator.getUUID());
		}
		AjaxMsg msg = dynamicService.save(dynamic);
		return msg.toJson();
	}
	
	/**
	 * 删除动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/deleteDyn")
	@ResponseBody
	public String deleteDyn(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = dynamicService.deleteDynamic(id);
		return msg.toJson();
	}
	
	/**
	 * 查询动态评论
	 * @param request
	 * @param pageModel
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/queryComments")
	@ResponseBody
	public String queryComments(HttpServletRequest request,PageModel pageModel){
		String dynId = request.getParameter("dynId");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("dynId", dynId);
		AjaxMsg msg = dynamicService.queryComments(params,pageModel);
		return msg.toJson();
	}
	
	/**
	 * 回复动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/replyComment")
	@ResponseBody
	public String replyComment(HttpServletRequest request,Comment comment){
		comment.setUser_id(getUserId());
		AjaxMsg msg = dynamicService.replyComment(comment);
		return msg.toJson();
	}
	
	/**
	 * 对动态点赞
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/praiseDyn")
	@ResponseBody
	public String praiseDyn(HttpServletRequest request){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("dynamic_id", request.getParameter("dynamic_id"));
		params.put("ip_str", request.getRemoteAddr());
		params.put("user_id", getUserId());
		params.put("id", UUIDGenerator.getUUID());
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = dynamicService.savePraiseDyn(params);
		} catch (Exception e) {
		}
		return msg.toJson();
	}
}

package com.yt.framework.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.IvComment;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.CommonService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 公共
 * @Title: DynamicController.java 
 * @Package com.yt.framework.controller
 * @author GL
 * @date 2015年8月10日 上午11:37:31 
 */
@Controller
@RequestMapping(value="/common")
public class CommonController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(CommonController.class);
	
	@Autowired
	private CommonService commonService;

	/**
	 * 图片视频评论查询
	 * @param request
	 * @param pageModel
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/queryIvComments")
	@ResponseBody
	public String queryIvComments(HttpServletRequest request,PageModel pageModel){
		String ivId = request.getParameter("ivId");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("ivId", ivId);
		AjaxMsg msg = commonService.queryIvComments(params,pageModel);
		return msg.toJson();
	}
	
	/**
	 * 评论视屏图片
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/replyComment")
	@ResponseBody
	public String replyIvComment(HttpServletRequest request,IvComment comment){
		comment.setUser_id(getUserId());
		AjaxMsg msg = commonService.replyIvComment(comment);
		return msg.toJson();
	}
	
	/**
	 * 对图片或视频点赞
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/praiseIv")
	@ResponseBody
	public String praiseIv(HttpServletRequest request){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("iv_id", request.getParameter("iv_id"));
		params.put("ip_str", request.getRemoteAddr());
		params.put("user_id", getUserId());
		params.put("id", UUIDGenerator.getUUID());
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = commonService.savePraiseIv(params);
		} catch (Exception e) {
			return msg.newError().addMessage("system.error").toJson();
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/uploadHtml")
	public String uploadPImageHtml(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String type = request.getParameter("type");
		String role_type = request.getParameter("role_type");
		if("USER".equals(role_type)){
			UserRole userRole = getUser();
			Set<Role> roles = userRole.getRoles();
			List<Role> rs = new ArrayList<Role>();
			for (Role role : roles) {
				String str = role.getRole_str();
				if(!str.contains("ADMIN")&&!"ROLE_TEAM".equals(str)&&!"ROLE_USER".equals(str)){
					rs.add(role);
				}
			}
			if(rs.size()==1){
				String rstr = rs.get(0).getRole_str();
				if("ROLE_PLAYER".equals(rstr)){
					role_type = SystemEnum.IMAGE.PLAYER.toString();
				}else if("ROLE_BABY".equals(rstr)){
					role_type = SystemEnum.IMAGE.BABY.toString();
				}
				else if("ROLE_AGENT".equals(rstr)){
					role_type = SystemEnum.IMAGE.AGENT.toString();
				}
				else if("ROLE_COACH".equals(rstr)){
					role_type = SystemEnum.IMAGE.COACH.toString();
				}
				request.setAttribute("role_name", rs.get(0).getRole_name());
			}else{
				request.setAttribute("roles", rs);
			}
			
		}
		request.setAttribute("user_id", user_id);
		request.setAttribute("type", type);
		request.setAttribute("role_type", role_type);
		request.setAttribute("fpath", role_type.toLowerCase());
		if("video".equals(type)){
			return "common/team_upload_html";
		}else{
			return "common/upload_html";
		}
	}

	@RequestMapping(value="/teamUploadHtml")
	public String teamUploadHtml(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		String type = request.getParameter("type");
		request.setAttribute("team_id", team_id);
		request.setAttribute("type", type);
		return "common/team_upload_html";
	}
}

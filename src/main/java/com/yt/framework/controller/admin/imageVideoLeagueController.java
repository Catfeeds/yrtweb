package com.yt.framework.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.admin.AdminImageVideoLeagueService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 首页轮播图管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/ivleague")
public class imageVideoLeagueController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(imageVideoLeagueController.class);
	
	@Autowired
	private AdminImageVideoLeagueService adminImageVideoLeagueService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	@Autowired
	private ImageVideoService imageVideoService;

	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(title)) params.put("title", title);
		if(StringUtils.isNotBlank(type)) params.put("type", type);
		if(StringUtils.isNotBlank(league_id)) params.put("user_id", league_id);
		AjaxMsg msg = adminImageVideoLeagueService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		request.setAttribute("league_id",league_id);
		return "admin/imagevideo/imagevideo"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		ImageVideo imageVideo = new ImageVideo();
		String tids = "";
		String tnames = "";
		if(StringUtils.isNotBlank(id)){
			if("image".equals(type)){
				imageVideo = imageVideoService.getImageById(id);
				imageVideo.setType(type);
			}else if("video".equals(type)){
				imageVideo = imageVideoService.getVideoById(id);
				imageVideo.setType(type);
			}
			List<Map<String, Object>> ivteams = adminImageVideoLeagueService.queryTeamInfoByIvid(id);
			if(ivteams!=null&&ivteams.size()>0){
				for (Map<String, Object> map : ivteams) {
					String tid = map.get("teaminfo_id").toString();
					String tname = map.get("name").toString();
					tids += tid + ",";
					tnames += tname + ",";
				}
			}
		}
		if(StringUtils.isNotBlank(tids)) tids = tids.substring(0,tids.lastIndexOf(","));
		if(StringUtils.isNotBlank(tnames)) tnames = tnames.substring(0,tnames.lastIndexOf(","));
		List<League> leagues = adminLeagueGroupService.getLeagues();
		request.setAttribute("ivleagues", imageVideo);
		request.setAttribute("leagues", leagues);
		request.setAttribute("tids", tids);
		request.setAttribute("tnames", tnames);
		return "admin/imagevideo/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,ImageVideo ivleagues,String images,String teamIds){
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = adminImageVideoLeagueService.saveOrUpdateIv(ivleagues,images,teamIds);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		AjaxMsg msg = adminImageVideoLeagueService.deleteFile(id, type);
		return msg.toJson();
	}
	
	@RequestMapping(value="/dialog")
	public String dialog(HttpServletRequest request){
		return "admin/imagevideo/dialog";
	}
}

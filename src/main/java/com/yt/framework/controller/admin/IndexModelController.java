package com.yt.framework.controller.admin;

import java.io.File;
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
import com.yt.framework.persistent.entity.IndexBanner;
import com.yt.framework.persistent.entity.IndexModel;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.IndexService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;

/**
 * 首页轮播图管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin")
public class IndexModelController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(IndexModelController.class);
	
	@Autowired
	private IndexService indexService;
	@Autowired
	private ImageVideoService imageVideoService;

	
	@RequestMapping(value="/indexImgs")
	public String images(HttpServletRequest request){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "image");
		AjaxMsg msg = indexService.queryImageOrVideos(params, null);
		request.setAttribute("images", msg.getData("page"));
		return "admin/index/images"; 
	}
	@RequestMapping(value="/indexVdos")
	public String videos(HttpServletRequest request,PageModel pageModel){
		String title = request.getParameter("title");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "video");
		if(StringUtils.isNotBlank(title)) params.put("title", title);
		AjaxMsg msg = indexService.queryImageOrVideos(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/videos"; 
	}
	@RequestMapping(value="/indexPlayers")
	public String players(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "player");
		AjaxMsg msg = indexService.queryPlayers(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/players"; 
	}
	@RequestMapping(value="/indexBabys")
	public String babys(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "baby");
		AjaxMsg msg = indexService.queryBabys(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/babys"; 
	}
	
	/**
	 * 添加栏位
	 * type： image video player  baby
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/index/addField")
	@ResponseBody
	public String addField(HttpServletRequest request){
		String type = request.getParameter("type");
		AjaxMsg msg = indexService.saveField(type);
		return msg.toJson();
	}
	/**
	 * 删除栏位
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/index/deleteField")
	@ResponseBody
	public String deleteField(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = indexService.deleteField(id);
		return msg.toJson();
	}
	
	@RequestMapping(value="/index/addFieldValue")
	@ResponseBody
	public String addFieldValue(HttpServletRequest request,IndexModel index){
		index.setUser_id(getUserId());
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(index.getId())){
			msg = indexService.updateFieldValue(index);
		}else{
			index.setId(UUIDGenerator.getUUID());
			msg = indexService.saveFieldValue(index);
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="/index/dialog")
	public String dialog(HttpServletRequest request){
		String type = request.getParameter("type");
		String iid = request.getParameter("id");
		String tid = request.getParameter("tid");
		String lid = request.getParameter("lid");
		String gid = request.getParameter("gid");
		String sort = request.getParameter("sort");
		request.setAttribute("type", type);
		request.setAttribute("iid", iid);
		request.setAttribute("tid", tid);
		request.setAttribute("lid", lid);
		request.setAttribute("gid", gid);
		request.setAttribute("sort", sort);
		return "admin/index/dialog";
	}
	
	@RequestMapping(value="/index/queryImagesOrVideos")
	public String queryImagesOrVideos(HttpServletRequest request,ImageVideo imageVideo,PageModel pageModel){
		String stype = request.getParameter("stype");
		AjaxMsg ajaxMsg = imageVideoService.searchImageVideos(imageVideo, pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		try {
			Map<String, Object> params = BeanUtils.object2Map(imageVideo);
			request.setAttribute("params", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("stype", stype);
		return "admin/index/select_iv";
	}
	
	@RequestMapping(value="/index/queryBabys")
	public String queryBabys(HttpServletRequest request,PageModel pageModel){
		String usernick = request.getParameter("usernick");
		String phone = request.getParameter("phone");
		String stype = request.getParameter("stype");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(usernick)) params.put("usernick", usernick);
		if(StringUtils.isNotBlank(phone)) params.put("phone", phone);
		if(StringUtils.isNotBlank(stype)) params.put("stype", stype);
		AjaxMsg ajaxMsg = indexService.queryAllBabys(params,pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/select_baby"; 
	}
	
	@RequestMapping(value="/index/queryPlayers")
	public String queryPlayers(HttpServletRequest request,PageModel pageModel){
		String usernick = request.getParameter("usernick");
		String phone = request.getParameter("phone");
		String stype = request.getParameter("stype");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(usernick)) params.put("usernick", usernick);
		if(StringUtils.isNotBlank(phone)) params.put("phone", phone);
		if(StringUtils.isNotBlank(stype)) params.put("stype", stype);
		AjaxMsg ajaxMsg = indexService.queryAllPlayers(params,pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/select_player"; 
	}
	
	@RequestMapping(value="/index/queryTeamPlayers")
	public String queryTeamPlayers(HttpServletRequest request,PageModel pageModel){
		String username = request.getParameter("username");
		String usernick = request.getParameter("usernick");
		String phone = request.getParameter("phone");
		String stype = request.getParameter("stype");
		String tname = request.getParameter("tname");
		String tid = request.getParameter("tid");
		String lid = request.getParameter("lid");
		String gid = request.getParameter("gid");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(username)) params.put("username", username);
		if(StringUtils.isNotBlank(usernick)) params.put("usernick", usernick);
		if(StringUtils.isNotBlank(phone)) params.put("phone", phone);
		if(StringUtils.isNotBlank(stype)) params.put("stype", stype);
		if(StringUtils.isNotBlank(tname)) params.put("tname", tname);
		if(StringUtils.isNotBlank(tid)) params.put("tid", tid);
		if(StringUtils.isNotBlank(lid)) params.put("lid", lid);
		if(StringUtils.isNotBlank(gid)) params.put("gid", gid);
		AjaxMsg ajaxMsg = indexService.queryTeamPlayers(params,pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		request.setAttribute("params", params);
		return "admin/index/select_team_player"; 
	}
	
	@RequestMapping(value="/index/allTeamPlayers")
	@ResponseBody
	public String queryTeamPlayers(HttpServletRequest request){
		String tid = request.getParameter("tid");
		PageModel pageModel = new PageModel();
		pageModel.setPageSize(Integer.MAX_VALUE);
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(tid)) params.put("tid", tid);
		AjaxMsg ajaxMsg = indexService.queryTeamPlayers(params,pageModel);
		return ajaxMsg.toJson(); 
	}
	
	@RequestMapping(value="/indexBanner")
	public String banners(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		String if_use = request.getParameter("if_use");
		if(StringUtils.isNotBlank(if_use)) params.put("if_use", if_use);
		AjaxMsg msg = indexService.queryIndexBanners(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/index/banners"; 
	}
	@RequestMapping(value="/indexBannerFormJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		IndexBanner banner = new IndexBanner();
		if(StringUtils.isNotBlank(id)){
			banner = indexService.getIndexBannerById(id);
		}
		request.setAttribute("banner", banner);
		return "admin/index/banner_form"; 
	}
	@RequestMapping(value="/saveOrUpdateIndexBanner")
	@ResponseBody
	public String saveOrUpdateIndexBanner(HttpServletRequest request,IndexBanner banner){
		AjaxMsg msg = AjaxMsg.newError();
		try {
			if(StringUtils.isNotBlank(banner.getId())){
				msg = indexService.updateIndexBanner(banner);
			}else{
				banner.setId(UUIDGenerator.getUUID());
				msg = indexService.saveIndexBanner(banner);
			}
		} catch (Exception e) {} finally { 
		    return msg.toJson();
		} 
	}
	@RequestMapping(value="/deleteIndexBanner")
	@ResponseBody
	public String deleteIndexBanner(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = indexService.deleteIndexBanner(id);
		return msg.toJson();
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 *//*
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		IndexModel indm = new IndexModel();
		if(StringUtils.isNotBlank(id)){
			indm = indexModelService.getEntityById(id);
		}
		request.setAttribute("indm", indm);
		return "admin/index/form"; 
	}
	
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,IndexModel indm){
		indm.setUser_id(getUserId());
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(indm.getId())){
			msg = indexModelService.update(indm);
		}else{
			indm.setId(UUIDGenerator.getUUID());	
			msg = indexModelService.save(indm);
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String deleteRole(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = indexModelService.delete(id);
		return msg.toJson();
	}*/
}

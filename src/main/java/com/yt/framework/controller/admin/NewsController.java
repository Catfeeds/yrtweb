package com.yt.framework.controller.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminNewsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;

/**
 * 首页轮播图管理
 * @author gl
 *
 */
@Controller
@RequestMapping(value="/admin/news")
public class NewsController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(NewsController.class);
	
	@Autowired
	private AdminNewsService adminNewsService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@RequestMapping(value="")
	public String index(HttpServletRequest request,PageModel pageModel){
		String title = request.getParameter("title");
		String n_state = request.getParameter("n_state");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(title)) params.put("title", title);
		if(StringUtils.isNotBlank(n_state)) params.put("n_state", n_state);
		AjaxMsg msg = adminNewsService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params",params);
		return "admin/news/news"; 
	}
	
	/**
	 * 进入角色管理编辑页面
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value="/formJsp")
	public String formJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		News news = new News();
		String tids = "";
		String tnames = "";
		if(StringUtils.isNotBlank(id)){
			news = adminNewsService.getEntityById(id);
			List<Map<String, Object>> newsteams = adminNewsService.queryTeamInfoByNid(id);
			if(newsteams!=null&&newsteams.size()>0){
				for (Map<String, Object> map : newsteams) {
					String tid = map.get("teaminfo_id").toString();
					String tname = map.get("name").toString();
					tids += tid + ",";
					tnames += tname + ",";
				}
			}
		}
		if(StringUtils.isNotBlank(tids)) tids = tids.substring(0,tids.lastIndexOf(","));
		if(StringUtils.isNotBlank(tnames)) tnames = tnames.substring(0,tnames.lastIndexOf(","));
		List<League> list = leagueService.getLeagues();
		request.setAttribute("leagueList", list);
		request.setAttribute("news", news);
		request.setAttribute("tids", tids);
		request.setAttribute("tnames", tnames);
		return "admin/news/form"; 
	}
	@RequestMapping(value="/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,News news,String teamIds){
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(news.getId())){
			News old = adminNewsService.getEntityById(news.getId());
			String old_img = old.getCover_img();
			String new_img = news.getCover_img();
			if(StringUtils.isNotBlank(old_img)){
				if(!old_img.equals(new_img)){
					int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
					if(result == Global.SUCCESS){
						ImageKit.delFile(fileRepository.getRealPath(new_img));
					}else{
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
					}
					OSSClientFactory.deleteFile(old_img);
				}
			}else{
				if(StringUtils.isNotBlank(new_img)){
					int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
					if(result == Global.SUCCESS){
						ImageKit.delFile(fileRepository.getRealPath(new_img));
					}else{
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
					}
				}
			}
			msg = adminNewsService.update(news);
		}else{
			news.setId(UUIDGenerator.getUUID());	
			String cover_img = news.getCover_img();
			if(StringUtils.isNotBlank(cover_img)){
				int result = OSSClientFactory.uploadFile(cover_img, new File(fileRepository.getRealPath(cover_img)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(cover_img));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
				}
			}
			msg = adminNewsService.save(news);
		}
		if(msg.isSuccess()&&StringUtils.isNotBlank(teamIds)){
			String tids[] = teamIds.split(",");
			if(tids!=null&&tids.length>0){
				List<Map<String, Object>> newsteams = new ArrayList<Map<String,Object>>();
				for (String tid : tids) {
					Map<String, Object> newsteam = new HashMap<String,Object>();
					newsteam.put("id", UUIDGenerator.getUUID());
					newsteam.put("news_id", news.getId());
					newsteam.put("teaminfo_id", tid);
					newsteams.add(newsteam);
				}
				adminNewsService.saveNewsTeam(news.getId(), newsteams);
			}
			
		}
		return msg.toJson();
	}
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = adminNewsService.delete(id);
		return msg.toJson();
	}
	
	@RequestMapping(value="/dialog")
	public String dialog(HttpServletRequest request){
		return "admin/news/dialog";
	}
	
	@RequestMapping(value="/editState")
	@ResponseBody
	private String editState(HttpServletRequest request){
		String id = request.getParameter("id");
		String n_state = request.getParameter("n_state");
		News news = adminNewsService.getEntityById(id);
		news.setN_state(Integer.parseInt(n_state));
		AjaxMsg msg = adminNewsService.update(news);
		return msg.toJson();
	}
}

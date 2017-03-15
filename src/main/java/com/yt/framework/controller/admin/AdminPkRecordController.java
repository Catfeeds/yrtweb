package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.AdminPkRecord;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.service.admin.AdminLeagueGroupService;
import com.yt.framework.service.admin.AdminPkRecordService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 
 * @author YJH
 *
 * 2015年11月10日
 */
@Controller
@RequestMapping(value = "/admin/pkRecord")
public class AdminPkRecordController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminPkRecordController.class);

	@Autowired
	private AdminPkRecordService adminPkRecordService;
	@Autowired
	private AdminEventRecordService adminEventRecordService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private AdminLeagueGroupService adminLeagueGroupService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	@RequestMapping(value = "")
	public String index(HttpServletRequest request, PageModel pageModel) {
		String teaminfoName = request.getParameter("teaminfo_name");
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(teaminfoName))
			params.put("teaminfo_name", teaminfoName);
		AjaxMsg msg = adminPkRecordService.queryForPageForMap(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "admin/leaguepk/pkList";
	}

	/**
	 * 进入编辑页面
	 * 
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value = "/formJsp")
	public String formJsp(HttpServletRequest request) {
		String id = request.getParameter("id");
		AdminPkRecord apr = new AdminPkRecord();
		if (StringUtils.isNotBlank(id)) {
			apr = adminPkRecordService.getEntityById(id);
			if(apr!=null){
				League league = leagueService.getEntityById(apr.getLeague_id());
				LeagueGroup leagueGroup = adminLeagueGroupService.getEntityById(apr.getGroup_id());
				request.setAttribute("league", league);
				request.setAttribute("leagueGroup", leagueGroup);
			}
		}
		request.setAttribute("_item", apr);
		return "admin/leaguepk/form";
	}
	
	/**
	 * 进入编辑页面(根据球队和联赛)
	 * 
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value = "/formJspByTeam")
	public String formJspByTeam(HttpServletRequest request) {
		String league_id = request.getParameter("league_id");
		String g_teaminfo_id = request.getParameter("g_teaminfo_id");
		String m_teaminfo_id = request.getParameter("m_teaminfo_id");
		String id = request.getParameter("id"); 
		AdminEventRecord aef = new AdminEventRecord();
		AdminPkRecord apr = new AdminPkRecord();
		League league = new League();
		if (StringUtils.isNotBlank(id)) {
			aef = adminEventRecordService.getEntityById(id);
		}
		if (StringUtils.isNotBlank(league_id)) {
			apr = adminPkRecordService.getPkRecordByTeam(league_id,g_teaminfo_id,m_teaminfo_id);
			league = leagueService.getEntityById(league_id);
		}
		request.setAttribute("_item", aef);
		request.setAttribute("_item_i", apr);
		request.setAttribute("league", league);
		return "admin/leaguepk/form";
	}
	
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,
			AdminPkRecord apr) {
		AjaxMsg msg = AjaxMsg.newError();
		if(null != apr.getM_score() && null != apr.getG_score()){
			if(apr.getM_score() > apr.getG_score()){
				apr.setWin_teaminfo_id(apr.getM_teaminfo_id());
			}else if(apr.getM_score() == apr.getG_score()){
				apr.setWin_teaminfo_id("");
			}else if(apr.getM_score() < apr.getG_score()){
				apr.setWin_teaminfo_id(apr.getG_teaminfo_id());
			}
		}
		if (StringUtils.isNotBlank(apr.getId())) {
			msg = adminPkRecordService.update(apr);
		} else {
			apr.setId(UUIDGenerator.getUUID());
			msg = adminPkRecordService.save(apr);
		}
		return msg.toJson();
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public String deleteRole(HttpServletRequest request) {
		String id = request.getParameter("id");
		AjaxMsg msg = adminPkRecordService.delete(id);
		return msg.toJson();
	}
}

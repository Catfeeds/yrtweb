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
import com.yt.framework.persistent.entity.AdminEventForecast;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.admin.AdminEventForecastService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 
 * @author YJH
 *
 * 2015年11月10日
 */
@Controller
@RequestMapping(value = "/admin/eventForecast")
public class AdminEventForecastController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminEventForecastController.class);

	@Autowired
	private AdminEventForecastService adminEventForecastService;
	@Autowired
	private AdminEventRecordService adminEventRecordService;
	@Autowired
	private LeagueService leagueService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	@RequestMapping(value = "")
	public String index(HttpServletRequest request, PageModel pageModel) {
		String teaminfoName = request.getParameter("teaminfo_name");
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(teaminfoName)) params.put("teaminfo_name", teaminfoName);
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		AjaxMsg msg = adminEventForecastService.queryForPageForMap(params,
				pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		request.setAttribute("league_id", league_id);
		return "admin/eventforecast/eventforecast";
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
		AdminEventForecast aef = new AdminEventForecast();
		if (StringUtils.isNotBlank(id)) {
			aef = adminEventForecastService.getEntityById(id);
		}
		request.setAttribute("_item", aef);
		return "admin/eventforecast/form";
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
		String rounds = request.getParameter("rounds");
		String id = request.getParameter("id"); 
		AdminEventForecast aef = new AdminEventForecast();
		AdminEventRecord aer = new AdminEventRecord();
		League league = new League();
		if (StringUtils.isNotBlank(id)) {
			aer = adminEventRecordService.getEntityById(id);
		}
		if (StringUtils.isNotBlank(league_id)) {
			aef = adminEventForecastService.getForecastByTeam(league_id,g_teaminfo_id,m_teaminfo_id,Integer.valueOf(rounds));
			league = leagueService.getEntityById(league_id);
		}
		request.setAttribute("_item", aef);
		request.setAttribute("_item_i", aer);
		request.setAttribute("league", league);
		return "admin/eventforecast/form";
	}
	
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,
			AdminEventForecast aef) {
		AjaxMsg msg = AjaxMsg.newError();
		if (StringUtils.isNotBlank(aef.getId())) {
			msg = adminEventForecastService.update(aef);
		} else {
			aef.setId(UUIDGenerator.getUUID());
			msg = adminEventForecastService.save(aef);
		}
		return msg.toJson();
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public String deleteRole(HttpServletRequest request) {
		String id = request.getParameter("id");
		AjaxMsg msg = adminEventForecastService.delete(id);
		return msg.toJson();
	}
}

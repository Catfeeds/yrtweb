package com.yt.framework.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.ScheduleService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 *后台资金管理
 *@autor bo.xie
 *@date2015-8-27上午10:45:47
 */
@Controller
@RequestMapping(value="/admin/schedule/")
public class AdminScheduleController {
	
	private static Logger logger = LogManager.getLogger(AdminScheduleController.class);

	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	/**
	 * 任务列表页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-11-13 上午 10:56:11
	 */
	@RequestMapping(value="jobList")
	public String jobList(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("remark", request.getParameter("remark"));
		AjaxMsg msg = scheduleService.queryForPage(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/schedule/jobList";
	}
	
	/**
	 * 获取平台用户消费记录
	 *@param model
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午5:19:24
	 */
	@RequestMapping(value="saveOrUpdateJob")
	@ResponseBody
	public String saveOrUpdateJob(HttpServletRequest request,ScheduleJob scheduleJob){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			if(scheduleJob == null || StringUtils.isBlank(scheduleJob.getId())){	
				scheduleService.saveSchedule(scheduleJob);
			}else{
				scheduleService.updateSchedule(scheduleJob);
			}
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 跳转任务编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="jobForm")
	public String jobForm(HttpServletRequest request){
		String job_name = BeanUtils.nullToString(request.getParameter("job_name"));
		String id = request.getParameter("id");
		ScheduleJob scheduleJob = scheduleService.getEntityById(id);
		if(StringUtils.isNotBlank(job_name)){
			if(null == scheduleJob){
				scheduleJob = new ScheduleJob();
			}
			scheduleJob.setJob_name(job_name);
		}
		request.setAttribute("scheduleJob", scheduleJob);
		return "admin/schedule/jobForm"; 
	}
	
	/**
	 * 跳转任务编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toJob")
	public String toJob(HttpServletRequest request){
		String job_name = BeanUtils.nullToString(request.getParameter("job_name"));
		ScheduleJob scheduleJob = scheduleService.getScheduleJobByName(job_name);
		if(StringUtils.isNotBlank(job_name)){
			if(null == scheduleJob){
				scheduleJob = new ScheduleJob();
			}
			scheduleJob.setJob_name(job_name);
		}
		request.setAttribute("scheduleJob", scheduleJob);
		return "admin/schedule/jobForm"; 
	}
	
	/**
	 * 暂停任务
	 * @param request
	 * @return
	 */
	@RequestMapping(value="stopJobForm")
	@ResponseBody
	public String stopJobForm(HttpServletRequest request){
		String id = request.getParameter("id");
		ScheduleJob scheduleJob = scheduleService.getEntityById(id);
		try {
			scheduleService.stopSchedule(scheduleJob);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 恢复任务
	 * @param request
	 * @return
	 */
	@RequestMapping(value="resumeJobForm")
	@ResponseBody
	public String resumeJobForm(HttpServletRequest request){
		String id = request.getParameter("id");
		ScheduleJob scheduleJob = scheduleService.getEntityById(id);
		try {
			scheduleService.resumeSchedule(scheduleJob);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 更新用户资金状态
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteJobForm")
	@ResponseBody
	public String deleteJobForm(HttpServletRequest request){
		String id = request.getParameter("id");
		ScheduleJob scheduleJob = scheduleService.getEntityById(id);
		try {
			scheduleService.deleteSchedule(scheduleJob);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
}

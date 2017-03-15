package com.yt.framework.service;

import java.util.List;
import java.util.Map;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor ylt
 *@date2015-8-11下午4:54:58
 */
public interface ScheduleService{
	/**
	 * 获取计划中的任务
	 */
	public List<ScheduleJob> getPlanSchedule()throws Exception;
	
	/**
	 * 获取运行中的任务
	 */
	public List<ScheduleJob> getRunSchedule()throws Exception;
	
	/**
	 * 暂停任务
	 */
	public void stopSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 删除任务
	 */
	public void deleteSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 恢复任务
	 */
	public void resumeSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 执行任务（立刻执行一次）
	 */
	public void executeSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 更新任务
	 */
	public void updateSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 启动任务
	 */
	public void saveSchedule(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 获取数据库中配置信息
	 */
	public AjaxMsg queryForPage(Map<String,Object> params,PageModel pageModel);
	
	/**
	 * 获取配置总数
	 */
	public int count(Map<String,Object> params);
	
	/**
	 * 获取所有配置任务
	 */
	public List<ScheduleJob> getAllJob();

	/**
	 * 启动任务
	 */
	public void startJob(ScheduleJob scheduleJob)throws Exception;
	
	/**
	 * 获取任务
	 * @param id
	 * @return
	 */
	public ScheduleJob getEntityById(String id);
	
	/**
	 * 获取任务
	 * @param job_name job_group
	 * @return
	 */
	public ScheduleJob getScheduleJobByName(String job_name, String job_group);
	
	/**
	 * 获取任务
	 * @param job_name
	 * @return
	 */
	public ScheduleJob getScheduleJobByName(String job_name);
}

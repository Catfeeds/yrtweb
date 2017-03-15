package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.yt.framework.mapper.ScheduleMapper;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.ScheduleService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: ScheduleServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年11月12日 下午3:58:34 
 */
@Service(value="scheduleService")
public class ScheduleServiceImpl implements ScheduleService{
	
	protected static Logger logger = LogManager.getLogger(ScheduleServiceImpl.class);
	@Autowired
	SchedulerFactoryBean schedulerFactoryBean;
	@Autowired
	ScheduleMapper scheduleMapper;
	
	@Override
	public AjaxMsg queryForPage(Map<String, Object> params,PageModel pageModel){
		List<ScheduleJob> datas = new ArrayList<ScheduleJob>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = count(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = scheduleMapper.queryForPage(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int count(Map<String, Object> params) {
		return scheduleMapper.count(params);
	}
	
	@Override
	public List<ScheduleJob> getPlanSchedule()throws Exception {
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    GroupMatcher<JobKey> matcher = GroupMatcher.jobGroupEndsWith("");
	    Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
	    List<ScheduleJob> jobList = Lists.newArrayList();
	    for (JobKey jobKey : jobKeys) {
	        List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
	        for (Trigger trigger : triggers) {
	            ScheduleJob job = new ScheduleJob();
	            job.setJob_name(jobKey.getName());
	            job.setJob_group(jobKey.getGroup());
	            job.setRemark("触发器:" + trigger.getKey());
	            Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
	           // job.setJob_status(triggerState.name());
	            if (trigger instanceof CronTrigger) {
	                CronTrigger cronTrigger = (CronTrigger) trigger;
	                String cronExpression = cronTrigger.getCronExpression();
	                job.setCron_expression(cronExpression);
	            }
	            jobList.add(job);
	        }
	    }
		return jobList;
	}

	@Override
	public List<ScheduleJob> getRunSchedule()throws Exception{
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    List<JobExecutionContext> executingJobs = scheduler.getCurrentlyExecutingJobs();
	    List<ScheduleJob> jobList = new ArrayList<ScheduleJob>(executingJobs.size());
	    for (JobExecutionContext executingJob : executingJobs) {
	        ScheduleJob job = new ScheduleJob();
	        JobDetail jobDetail = executingJob.getJobDetail();
	        JobKey jobKey = jobDetail.getKey();
	        Trigger trigger = executingJob.getTrigger();
	        job.setJob_name(jobKey.getName());
	        job.setJob_group(jobKey.getGroup());
	        job.setRemark("触发器:" + trigger.getKey());
	        Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
	        //job.setJob_status(triggerState.name());
	        if (trigger instanceof CronTrigger) {
	            CronTrigger cronTrigger = (CronTrigger) trigger;
	            String cronExpression = cronTrigger.getCronExpression();
	            job.setCron_expression(cronExpression);
	        }
	        jobList.add(job);
	    }
	    return jobList;
	}

	@Override
	public void stopSchedule(ScheduleJob scheduleJob)throws Exception{
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    JobKey jobKey = JobKey.jobKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
	    scheduler.pauseJob(jobKey);
	    scheduleJob.setJob_status(0);
	    scheduleMapper.update(scheduleJob);
	}

	@Override
	public void deleteSchedule(ScheduleJob scheduleJob)throws Exception {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    JobKey jobKey = JobKey.jobKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
	    boolean flag = scheduler.deleteJob(jobKey);
	    scheduleMapper.delete(scheduleJob.getId());
	}

	@Override
	public void resumeSchedule(ScheduleJob scheduleJob)throws Exception {
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    JobKey jobKey = JobKey.jobKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
	    scheduler.resumeJob(jobKey);
	    scheduleJob.setJob_status(1);
	    scheduleMapper.update(scheduleJob);
	}

	@Override
	public void executeSchedule(ScheduleJob scheduleJob)throws Exception {
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    JobKey jobKey = JobKey.jobKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
	    scheduler.triggerJob(jobKey);
	}

	@Override
	public void updateSchedule(ScheduleJob scheduleJob)throws Exception {
		//保存数据库配置
		scheduleMapper.update(scheduleJob);
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
	    TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
	    //获取trigger，即在spring配置文件中定义的 bean id="myTrigger",若配置中无则从内存中获取
	    CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
	    if(trigger != null){
	    	//表达式调度构建器
	    	CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCron_expression());
	    	//按新的cronExpression表达式重新构建trigger
	    	trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
	    	//按新的trigger重新设置job执行
	    	scheduler.rescheduleJob(triggerKey, trigger);
	    }
	}

	@Override
	public void saveSchedule(ScheduleJob scheduleJob) throws Exception {
		if(StringUtils.isBlank(scheduleJob.getId())){
			scheduleJob.setId(UUIDGenerator.getUUID());
		}
		//scheduleJob.setJob_name(Common.getRandomNum6()+"");
		scheduleMapper.save(scheduleJob);
		if(scheduleJob.getJob_status() == 1){
			this.startJob(scheduleJob);
		}
	}

	@Override
	public List<ScheduleJob> getAllJob() {
		return scheduleMapper.getAllJob();
	}

	@Override
	public void startJob(ScheduleJob scheduleJob)throws Exception {
		//schedulerFactoryBean 由spring创建注入
	    Scheduler scheduler = schedulerFactoryBean.getScheduler();
    	TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJob_name(), scheduleJob.getJob_group());
    	//获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
    	CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
    	//不存在，创建一个
    	if (null == trigger) {
    		JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) Class.forName("com.yt.framework.service.schedule."+scheduleJob.getClass_name()))
    			.withIdentity(scheduleJob.getJob_name(), scheduleJob.getJob_group()).build();
    		jobDetail.getJobDataMap().put(scheduleJob.getId(), scheduleJob);
    		//表达式调度构建器
    		CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCron_expression());
    		//按新的cronExpression表达式构建一个新的trigger
    		trigger = TriggerBuilder.newTrigger().withIdentity(scheduleJob.getJob_name(), scheduleJob.getJob_group()).withSchedule(scheduleBuilder).build();
    		scheduler.scheduleJob(jobDetail, trigger);
    	} else {
    		// Trigger已存在，那么更新相应的定时设置
    		//表达式调度构建器
    		CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCron_expression());
    		//按新的cronExpression表达式重新构建trigger
    		trigger = trigger.getTriggerBuilder().withIdentity(triggerKey)
    			.withSchedule(scheduleBuilder).build();
    		//按新的trigger重新设置job执行
    		scheduler.rescheduleJob(triggerKey, trigger);
    	}
		
	}

	@Override
	public ScheduleJob getEntityById(String id) {
		return scheduleMapper.getEntityById(id);
	}

	@Override
	public ScheduleJob getScheduleJobByName(String job_name, String job_group) {
		return scheduleMapper.getScheduleJobByName(job_name,job_group);
	}

	@Override
	public ScheduleJob getScheduleJobByName(String job_name) {
		return scheduleMapper.getScheduleJobByNameSingle(job_name);
	}
	
}

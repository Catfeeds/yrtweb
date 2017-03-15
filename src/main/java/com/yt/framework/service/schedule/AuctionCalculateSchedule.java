package com.yt.framework.service.schedule;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.ScheduleService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.SpringContextUtil;

/**
 * 任务调度实现类
 * @author ylt
 *
 */
@DisallowConcurrentExecution
public class AuctionCalculateSchedule implements Job {
	/**
     * 1.获取当前联赛的竞拍轮数
     * 2.获取当前竞拍成功数据
     * 3.将竞拍成功球员加入到俱乐部，未竞拍的球员加入到第四轮
     * 4.将竞拍球员和竞拍纪录数据状态更新 
     */
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		LeagueAuctionService leagueAuctionService = (LeagueAuctionService)SpringContextUtil.getBean("leagueAuctionService");
		System.out.println("任务分组 = [group]"+context.getTrigger().getJobKey().getGroup());
		System.out.println("任务标志 = [name]"+context.getTrigger().getJobKey().getName());
		//ScheduleJob scheduleJob = (ScheduleJob)context.getMergedJobDataMap().get("scheduleJob");
		String job_name = context.getTrigger().getJobKey().getName();
		String job_group = context.getTrigger().getJobKey().getGroup();
		LeagueAuctionCfg cfg = leagueAuctionService.getCfgById(job_name);
		if(cfg != null){
			if(cfg.getStatus() == 1){
				cfg.setStatus(0);
				try {
					System.out.println("任务标志 = [status]:"+cfg.getStatus());	
					AjaxMsg msg = leagueAuctionService.modifyLeagueAuction(cfg);
					if(msg.isSuccess()){
						leagueAuctionService.sendCalculateMsg(cfg);
						ScheduleService scheduleService = (ScheduleService)SpringContextUtil.getBean("scheduleService");
						ScheduleJob job = scheduleService.getScheduleJobByName(job_name,job_group);
						if(null != job){
							scheduleService.deleteSchedule(job);
							//添加一条运行纪录
						}
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
}

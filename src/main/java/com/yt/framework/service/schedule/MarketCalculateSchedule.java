package com.yt.framework.service.schedule;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.ScheduleService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.SpringContextUtil;

/**
 * 任务调度实现类
 * @author ylt
 *
 */
@DisallowConcurrentExecution
public class MarketCalculateSchedule implements Job {
	/**
     * 1.获取当前联赛的转会轮数
     * 2.获取当前转会成功数据
     * 3.将转会成功球员加入到俱乐部，未转会成功的球员自动流拍
     * 4.将转会球员和转会纪录数据状态更新 
     */
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		LeagueMarketService leagueMarketService = (LeagueMarketService)SpringContextUtil.getBean("leagueMarketService");
		System.out.println("任务分组 = [group]"+context.getTrigger().getJobKey().getGroup());
		System.out.println("任务标志 = [name]"+context.getTrigger().getJobKey().getName());
		//ScheduleJob scheduleJob = (ScheduleJob)context.getMergedJobDataMap().get("scheduleJob");
		String job_name = context.getTrigger().getJobKey().getName();
		String job_group = context.getTrigger().getJobKey().getGroup();
		MarketCfg cfg = leagueMarketService.getCfgById(job_name);
		if(cfg != null){
			if(cfg.getIf_open() == 1){
				cfg.setIf_open(0);
				try {
					System.out.println("任务标志 = [if_open]:"+cfg.getIf_open());	
					AjaxMsg msg = leagueMarketService.modifyLeagueMarket(cfg);
					if(msg.isSuccess()){
						leagueMarketService.sendCalculateMsg(cfg);
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

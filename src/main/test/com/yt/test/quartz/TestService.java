package com.yt.test.quartz;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.core.util.UuidUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.ScheduleService;
/**
 * 测试
 * @Title: TestService.java 
 * @Package com.yt.test
 * @author GL
 * @date 2015年8月3日 下午4:34:16 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml","classpath:spring/applicationContext-quartz.xml",
		"classpath:spring/appServlet/spring-beans.xml","classpath:spring/appServlet/spring-security.xml"})
public class TestService extends AbstractJUnit4SpringContextTests {

	@Autowired
	ScheduleService scheduleService;
	@Autowired
	LeagueAuctionService leagueAuctionService;
	@Test
	public void t(){
		ScheduleJob job = new ScheduleJob();
		job.setId(UUIDGenerator.getUUID());
		job.setJob_group("job");
		job.setJob_name("QuartzJobFactory");
		job.setRemark("测试");
		job.setCron_expression("0/5 * * * * ?");
		job.setJob_status(1);
		job.setClass_name("com.yt.framework.service.schedule.QuartzJobFactory");
		try {
			scheduleService.saveSchedule(job);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void t1(){
		leagueAuctionService.getByUserId("1");
		System.out.println(11);
	}
	
}	

package com.yt.framework.service.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;


/**
 *
 *@autor bo.xie
 *@date2015-8-17下午3:55:35
 */
public class DemoSchedule extends QuartzJobBean{

		private int timeout;

	    /**
	     * Setter called after the ExampleJob is instantiated
	     * with the value from the JobDetailFactoryBean (5)
	     */
	    public void setTimeout(int timeout) {
	        this.timeout = timeout;
	    }
//	private static DemoSchedule demoSchedule;
//	
//	public DemoSchedule getInstance(){
//		if(demoSchedule==null){
//			demoSchedule = new DemoSchedule();
//		}
//		return demoSchedule;
//	}
//	
//	public synchronized void demoTest(){
//		System.out.println(11111);
//	}

		@Override
		protected void executeInternal(JobExecutionContext job)
				throws JobExecutionException {
			try {
				Thread.sleep(20000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("123123");
			System.out.println(timeout);
		}
	
}

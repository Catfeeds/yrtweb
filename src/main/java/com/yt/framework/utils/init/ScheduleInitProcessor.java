package com.yt.framework.utils.init;

import java.util.List;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import com.yt.framework.persistent.entity.ScheduleJob;
import com.yt.framework.service.ScheduleService;

public class ScheduleInitProcessor implements BeanPostProcessor {

	@Override
	public Object postProcessAfterInitialization(Object obj, String arg1) throws BeansException {
		
            if(obj instanceof ScheduleService) {    
            	List<ScheduleJob> list = ((ScheduleService)obj).getAllJob();//加载定时任务
            	if(!list.isEmpty()){
            		for (ScheduleJob scheduleJob : list) {
            			try{  
            				((ScheduleService)obj).startJob(scheduleJob);
            			 } catch (Exception e) {  
            				 try {
								((ScheduleService) obj).deleteSchedule(scheduleJob);
							} catch (Exception e1) {
								e1.printStackTrace();
							}
            	             e.printStackTrace();
            	             
            	        }  
					}
            	}
            	
            }
        
		return obj;   	
	}

	@Override
	public Object postProcessBeforeInitialization(Object arg0, String arg1) throws BeansException {
		return arg0;
	}

}

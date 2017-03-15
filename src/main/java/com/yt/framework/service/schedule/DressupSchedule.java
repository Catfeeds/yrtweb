package com.yt.framework.service.schedule;

import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.entity.Dressup;
import com.yt.framework.service.DressupService;

/**
 * 时间到期，宝贝已代言俱乐部自动失效
 * @author bo.xie
 * 2015年10月9日15:49:53
 */
public class DressupSchedule {

	private static Logger logger = LogManager.getLogger(DressupSchedule.class.getName());
	
	private static DressupSchedule dressupSchedule;
	@Resource
	private DressupService dressupService;
	
	@PostConstruct
	public DressupSchedule getInstance(){
		if(dressupSchedule==null){
			dressupSchedule = new DressupSchedule();
		}
		return dressupSchedule;
	}
	
	/**
	 * 自动更新用户购买装扮状态
	 */
	@SuppressWarnings("unused")
	private synchronized void autorUpdateEnable(){
		List<Dressup> ds = dressupService.getDressupsByDate(new Date());
		if(ds.size()>0){
			dressupService.updateDressupEnable(ds);
		}
	}
}

package com.yt.framework.service;

import java.util.Date;
import java.util.List;

import com.yt.framework.persistent.entity.Dressup;

/**
 * @Title: DressupService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月17日 下午3:33:42 
 */
public interface DressupService extends BaseService<Dressup>{

	public Dressup getDressup(String userId,String drId);
	
	/**
	 * 批量更新用户购买装扮为已到期状态
	 * @param dressups
	 */
	public void updateDressupEnable(List<Dressup> dressups);
	
	/**
	 * 获取当前日期所有用户购买的装扮
	 * @param date
	 * @return
	 */
	public List<Dressup> getDressupsByDate(Date date);
}

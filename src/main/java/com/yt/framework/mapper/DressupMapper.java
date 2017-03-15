package com.yt.framework.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Dressup;

/**
 * @Title: DressupMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月17日 下午3:33:51 
 */
public interface DressupMapper extends BaseMapper<Dressup>{

	public Dressup getDressup(@Param(value="userId")String userId,@Param(value="drId") String drId);

	public void updateDressupStatusOff(@Param(value="userId")String userId);

	public void updateDressupStatusOn(@Param(value="userId")String userId,@Param(value="drId") String drId);
	
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
	public List<Dressup> getDressupsByDate(@Param(value="date")Date date);

}

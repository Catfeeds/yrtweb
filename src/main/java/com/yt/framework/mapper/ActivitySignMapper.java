package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ActivitySign;

/**
 * 
 * @author YJH
 *
 * 2015年11月18日
 */
public interface ActivitySignMapper extends BaseMapper<ActivitySign>{


	/**
	 * 通过手机号码获取用户信息
	 *@param phone
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20上午10:58:36
	 */
	ActivitySign getActivitySignByPhone(@Param(value="phone")String phone);
}

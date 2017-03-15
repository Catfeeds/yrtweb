package com.yt.framework.service;

import java.math.BigDecimal;

import com.yt.framework.persistent.entity.Space;
import com.yt.framework.utils.AjaxMsg;

/**
 *存储空间
 *@autor bo.xie
 *@date2015-9-2上午11:26:17
 */
public interface SpaceService extends BaseService<Space>{

	/**
	 * 存储空间计算
	 *@param id 用户或俱乐部ID
	 *@param roleType 用户 俱乐部  ROLETYPE  默认为用户
	 *@param fileSize 传入文件大小 单位M
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-2上午11:28:57
	 */
	public AjaxMsg calculateSpace(String id,String roleType,BigDecimal fileSize);
}

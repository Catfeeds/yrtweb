package com.yt.framework.service;

import javax.servlet.http.HttpServletRequest;

import com.yt.framework.persistent.entity.CoachInfo;
import com.yt.framework.utils.AjaxMsg;

/**
 *教练
 *@autor bo.xie
 *@date2015-8-6下午5:57:20
 */
public interface CoacheInfoService extends BaseService<CoachInfo>{

	/**
	 * 获取教练信息
	 *@param user_id 教练用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6下午6:01:43
	 */
	public CoachInfo getCoachInfoByUserId(String user_id);

	/**
	 * @param coachInfo
	 * @param request
	 * @autor gl
	 * @return
	 */
	public AjaxMsg saveCoache(CoachInfo coachInfo, HttpServletRequest request) throws Exception;
}

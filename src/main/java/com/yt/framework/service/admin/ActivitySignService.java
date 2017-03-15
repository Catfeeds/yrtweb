package com.yt.framework.service.admin;

import javax.servlet.http.HttpServletRequest;

import com.yt.framework.persistent.entity.ActivitySign;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * 
 * @author YJH
 *
 * 2015年11月18日
 */
public interface ActivitySignService  extends BaseService<ActivitySign>{

	/**
	 * <p>Description:保存ActivitySign对象 </p>
	 * @Author zhangwei
	 * @Date 2015年11月18日 下午5:22:45
	 * @param as
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg saveActivitySign(ActivitySign as, HttpServletRequest request) throws Exception;
	
	/**
	 * <p>Description:通过邮箱或者手机号码获取用户信息 </p>
	 * @Author zhangwei
	 * @Date 2015年11月18日 下午5:59:19
	 * @param str
	 * @return
	 */
	public AjaxMsg getActivitySignByPhone(String phone);
}

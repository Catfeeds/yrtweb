package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.Visitor;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 登陆访问用户操作
 *@autor ylt
 *@date2015-8-31下午2:09:06
 */
public interface VisitorService extends BaseService<Visitor>{
	/**
	 * 获取访客记录
	 *@param params
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午2:35:35
	 */
	public AjaxMsg queryForPageList(Map<String, Object> params, PageModel pageModel);
	
	
	/**
	 * 获取访客记录
	 *@param  visitor_id  访问者
	 *@param  p_visitor_id 被访问者
	 *@return
	 *@autor ylt
	 *@parameter * 
	 *@date2015-9-1下午2:35:35
	 */
	public Visitor getVisitor(String visitor_id,String p_visitor_id,String visit_type);
	
}

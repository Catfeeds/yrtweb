package com.yt.framework.service.admin;

import java.util.Map;

import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *一键反馈
 *@autor bo.xie
 *@date2015-8-19下午4:53:50
 */
public interface FeedBackBsService {

	/**
	 * 分页查询，返回Map
	 * @param map
	 * @return
	 */
	public AjaxMsg queryForPageForMap(Map<String, Object> map,PageModel pageModel);
	
	/**
	 * 查询当前关键字的总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @return
	 */
	public int count(Map<String, Object> map);

	/**
	 * 改变反馈信息状态为已经处理
	 * @param id
	 * @return
	 */
	public AjaxMsg changeStatus(String id);
}

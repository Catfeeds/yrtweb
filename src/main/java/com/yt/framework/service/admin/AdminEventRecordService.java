package com.yt.framework.service.admin;

import java.util.Map;

import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * 
 * @author YJH
 * 
 *         2015年11月10日
 */
public interface AdminEventRecordService extends
		BaseService<AdminEventRecord> {
	/**
	 * 查询联赛分组赛事信息
	 * @param params
	 * @return
	 */
	public AjaxMsg queryEventRecordByLeague(Map<String, Object> params);
	
	/**
	 * 更新纪录
	 * @param params
	 * @return
	 */
	public AjaxMsg updateEventRecord(AdminEventRecord aef)throws Exception;
	
	/**
	 * 查询联赛赛事信息根据主队id和客队id
	 * @param params
	 * @return
	 */	
	public AdminEventRecord getEventRecordByTidAndVid(Map<String, Object> params);
	
	/**
	 * 根据赛事纪录保存球队历史记录
	 * @param params
	 * @return
	 */	
	public AjaxMsg saveGameByRecordId(String id)throws Exception;
	
	/**
	 * 根据赛事纪录删除球队历史纪录
	 * @param params
	 * @return
	 */	
	public AjaxMsg delGameByRecordId(String id)throws Exception;
	
}

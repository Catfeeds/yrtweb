package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.AdminEventRecord;

/**
 * 
 * @author ylt
 * 
 *         2015年11月10日
 */
public interface AdminEventRecordMapper extends BaseMapper<AdminEventRecord> {
	/**
	 * 查询联赛分组赛事信息
	 * @param params
	 * @return
	 */	
	public List<Map<String, Object>> queryEventRecordByLeague(@Param(value="maps") Map<String, Object> maps);
	
	/**
	 * 查询联赛赛事信息根据主队id和客队id
	 * @param params
	 * @return
	 */	
	public AdminEventRecord getEventRecordByTidAndVid(@Param(value="maps")Map<String, Object> params);
	
}

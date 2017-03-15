package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

/**
 *一键反馈
 *@autor bo.xie
 *@date2015-8-19下午4:30:32
 */
public interface FeedBackBsMapper {
	
	/**
	 * 分页查询，返回Map
	 * @param map
	 * @autor GL
	 * @return
	 */
	public List<Map<String, Object>> queryForPageForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询当前关键字的总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @autor GL
	 * @return
	 */
	public int count(@Param(value="maps")Map<String,Object> maps);

	public void changeStatus(@Param(value="id")String id);

}

package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.DressResources;

/**
 * @Title: DressResourcesMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月17日 下午3:33:55 
 */
public interface DressResourcesMapper extends BaseMapper<DressResources>{

	/**
	 * 查询已拥有皮肤
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public List<Map<String, Object>> queryMyDressRes(@Param(value="maps")Map<String, Object> maps);
	/**
	 * 查询已拥有皮肤条数
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public int dresCount(@Param(value="maps")Map<String, Object> maps);
	public int queryCount(@Param(value="maps")Map<String, Object> maps);
	public List<Map<String, Object>> queryResources(@Param(value="maps")Map<String, Object> maps);

}

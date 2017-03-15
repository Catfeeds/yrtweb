package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Resources;

/**
 * @author gl
 *
 */
public interface ResourcesMapper {
	
	public List<Map<String, Object>> queryResources(Map<String, Object> params);
	
	public int queryResourcesCount(Map<String, Object> params);
	
	public int save(Resources resources);
	
	public int update(Resources resources);
	
	public int delete(String id);
	
	public List<Resources> queryParents();
	
	public Resources getResources(String id);

	public Resources getLastRes(@Param(value="pval")String pval);

}

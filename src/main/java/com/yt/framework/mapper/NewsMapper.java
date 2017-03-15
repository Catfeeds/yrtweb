package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.News;

public interface NewsMapper extends BaseMapper<News>{

	/**
	 * 获胜所有新闻
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllNews(@Param(value="maps")Map<String,Object> maps);
	/**
	 * 获胜所有新闻条数
	 * @param maps
	 * @return
	 */
	public int loadAllNewsCount(@Param(value="maps")Map<String,Object> maps);
}

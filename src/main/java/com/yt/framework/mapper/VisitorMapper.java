package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Visitor;

/**
 * 访客访问操作类
 *@autor ylt
 *@date2015-7-21下午2:08:53
 */
public interface VisitorMapper extends BaseMapper<Visitor>{
	/**
	 * 获取今日访问量和总访问量
	 *@param params
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午2:35:35
	 */
	public List<Integer> visitCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取访问用户数据
	 *@param params
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午2:35:35
	 */
	public Visitor getVisitor(@Param(value="maps")Map<String,Object> maps);
}

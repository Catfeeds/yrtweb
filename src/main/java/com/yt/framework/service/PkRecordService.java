package com.yt.framework.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.PkRecord;

/**
 * 联赛比赛记录
 * @author bo.xie
 * @Date 2015年11月10日11:48:18
 */
public interface PkRecordService extends BaseService<PkRecord>{

	/**
	 * 获取联赛俱乐部相关信息
	 * @param maps
	 * key num <br>
	 * 若num=teaminfo_id 查询获胜场数<br>
	 * 若num=-1 查询平局场数
	 * 若num为null 查询未开始比赛
	 * @return
	 */
	public Map<String,Object> teamInfoLeague(Map<String,Object> maps);
}

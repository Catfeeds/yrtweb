package com.yt.framework.service.Impl;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.PkRecord;
import com.yt.framework.service.PkRecordService;

@Service("pkRecordService")
public class PkRecordServiceImpl extends BaseServiceImpl<PkRecord>implements PkRecordService {
	
	protected static Logger logger = LogManager.getLogger(PkRecordServiceImpl.class);

	@Override
	public Map<String,Object> teamInfoLeague(Map<String, Object> maps) {
		Map<String,Object> reMap = Maps.newHashMap();
		//获取俱乐部信息
		reMap.put("teaminfo", maps.get("teaminfo_id"));
		int totalCount = pkRecordMapper.teamLeagueCount(maps);//总场数
		reMap.put("totalCount", totalCount);
		maps.put("num", maps.get("teaminfo_id"));
		int win = pkRecordMapper.teamLeagueWinCount(maps);//胜利场数
		reMap.put("win", win);
		maps.put("num", "-1");
		int flat = pkRecordMapper.teamLeagueWinCount(maps);//打平场数
		reMap.put("flat", flat);
		maps.put("num", null);
		int unbg = pkRecordMapper.teamLeagueWinCount(maps);//未开始场数
		reMap.put("unbg", unbg);
		int lose = totalCount-win-flat-unbg;
		reMap.put("lose", lose);
		return reMap;
	}
}

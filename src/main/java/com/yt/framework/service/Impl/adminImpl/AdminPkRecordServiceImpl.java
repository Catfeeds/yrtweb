package com.yt.framework.service.Impl.adminImpl;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AdminPkRecord;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.AdminPkRecordService;

@Service("adminPkRecordService")
public class AdminPkRecordServiceImpl extends BaseServiceImpl<AdminPkRecord> implements AdminPkRecordService {
	
	protected static Logger logger = LogManager.getLogger(AdminPkRecordServiceImpl.class);

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

	@Override
	public AdminPkRecord getPkRecordByTeam(String league_id, String g_teaminfo_id, String m_teaminfo_id) {
		return adminPkRecordMapper.getPkRecordByTeam(league_id,g_teaminfo_id,m_teaminfo_id);
	}
}

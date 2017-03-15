package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import com.yt.framework.persistent.entity.LeagueStatistics;
import com.yt.framework.service.LeagueStatisticsService;

/**
 * @Title: PlayerInfoServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="leagueStatisticsService")
public class LeagueStatisticsServiceImpl extends BaseServiceImpl<LeagueStatistics> implements LeagueStatisticsService{
	static Logger logger = LogManager.getLogger(LeagueStatisticsServiceImpl.class.getName());
}

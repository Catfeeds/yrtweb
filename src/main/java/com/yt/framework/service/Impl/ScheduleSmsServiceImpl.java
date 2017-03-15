package com.yt.framework.service.Impl;

import java.util.Date;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.ScheduleSms;
import com.yt.framework.service.ScheduleSmsService;

/**
 *
 *@autor bo.xie
 *@date2015-9-21上午11:40:25
 */
@Service("scheduleSmsService")
public class ScheduleSmsServiceImpl extends BaseServiceImpl<ScheduleSms> implements ScheduleSmsService {
	
	protected static Logger logger = LogManager.getLogger(ScheduleSmsServiceImpl.class);

	@Override
	public List<ScheduleSms> loadScheduleDatas(Date date) {
		
		return scheduleSmsMapper.loadScheduleSmsdatas(date);
	}

	@Override
	public void deleteScheduleSmsByTeamGameId(String teamGame_id) {
		scheduleSmsMapper.deleteScheduleSms(teamGame_id);
	}

}

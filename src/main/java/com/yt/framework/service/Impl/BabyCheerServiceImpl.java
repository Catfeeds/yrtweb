package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyCheer;
import com.yt.framework.service.BabyCheerService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: BabyInServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年9月24日 下午3:58:34 
 */
@Service(value="babyCheerService")
public class BabyCheerServiceImpl extends BaseServiceImpl<BabyCheer> implements BabyCheerService{
	
	protected static Logger logger = LogManager.getLogger(BabyCheerServiceImpl.class);
	@Autowired
	private MessageResourceService messageResourceService;
	@Override
	public AjaxMsg getByBabyByGame(String game_id,String teaminfo_id) {
		List<Map<String,Object>> babys = babyCheerMapper.getByBabyByGame(game_id,teaminfo_id);
		return AjaxMsg.newSuccess().addData("babys", babys);
	}

	@Override
	public int babyCheerCount(String teaminfo_id, String teamgame_id) {
		return babyCheerMapper.babyCheerCount(teaminfo_id, teamgame_id);
	}

	@Override
	public AjaxMsg saveCheerBatch(List<BabyCheer> listCheer) throws Exception {
		int j = 0;
		if(listCheer.isEmpty()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.nocheer"));
			for (BabyCheer babyCheer : listCheer) {
				Map<String,Object> map = Maps.newHashMap();
				map.put("temagame_id", babyCheer.getTeamgame_id());
				map.put("teaminfo_id", babyCheer.getTeaminfo_id());
				map.put("user_id", babyCheer.getUser_id());
				map.put("status", "0");
				j = count(map);
				if(j>0) throw new RuntimeException();
				if(StringUtils.isBlank(babyCheer.getId())){
					babyCheer.setId(UUIDGenerator.getUUID());
				}
				babyCheerMapper.save(babyCheer);
			}
		return AjaxMsg.newSuccess();
	}
	
}

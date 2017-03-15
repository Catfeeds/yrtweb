package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PlayerCareer;
import com.yt.framework.service.PlayerCareerService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: PlayerCareerServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="playerCareerService")
public class PlayerCareerServiceImpl extends BaseServiceImpl<PlayerCareer> implements PlayerCareerService{
	
	protected static Logger logger = LogManager.getLogger(PlayerCareerServiceImpl.class);

	@Override
	public AjaxMsg queryByUserId(String userId) {
		if(StringUtils.isNotBlank(userId)){
			List<PlayerCareer> careers = playerCareerMapper.queryByUserId(userId);
			return AjaxMsg.newSuccess().addData("data", careers);
		}
		return AjaxMsg.newError();
	}

}

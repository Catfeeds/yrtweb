package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PlayerHobby;
import com.yt.framework.service.PlayerHobbyService;

/**
 * @Title: PlayerHobbyService.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="playerHobbyService")
public class PlayerHobbyServiceImpl extends BaseServiceImpl<PlayerHobby> implements PlayerHobbyService{
	
	protected static Logger logger = LogManager.getLogger(PlayerHobbyServiceImpl.class);


}

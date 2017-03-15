package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PlayerOther;
import com.yt.framework.service.PlayerOtherService;

/**
 * @Title: PlayerOtherService.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="playerOtherService")
public class PlayerOtherServiceImpl extends BaseServiceImpl<PlayerOther> implements PlayerOtherService{
	
	protected static Logger logger = LogManager.getLogger(PlayerOtherServiceImpl.class);

}

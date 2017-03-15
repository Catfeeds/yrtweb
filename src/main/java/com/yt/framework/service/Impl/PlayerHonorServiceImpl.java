package com.yt.framework.service.Impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.PlayerHonor;
import com.yt.framework.service.PlayerHonorService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: PlayerHonorServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="playerHonorService")
public class PlayerHonorServiceImpl extends BaseServiceImpl<PlayerHonor> implements PlayerHonorService{
	
	protected static Logger logger = LogManager.getLogger(PlayerHonorServiceImpl.class);

	@Override
	public AjaxMsg queryByUserId(String userId) {
		if(StringUtils.isNotBlank(userId)){
			List<PlayerHonor> honors = playerHonorMapper.queryByUserId(userId);
			if(honors!=null&&honors.size()>0){
				return AjaxMsg.newSuccess().addData("data", honors);
			}
		}
		return AjaxMsg.newError();
	}

}

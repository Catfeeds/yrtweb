package com.yt.framework.service.Impl;

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Space;
import com.yt.framework.persistent.enums.UserEnum.ROLETYPE;
import com.yt.framework.service.SpaceService;
import com.yt.framework.utils.AjaxMsg;

/**
 *存储空间大小计算
 *@autor bo.xie
 *@date2015-9-2上午11:26:55
 */
@Service("spaceService")
public class SpaceServiceImpl extends BaseServiceImpl<Space> implements SpaceService{
	
	protected static Logger logger = LogManager.getLogger(SpaceServiceImpl.class);

	@Override
	public AjaxMsg calculateSpace(String id, String roleType, BigDecimal fileSize) {
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(roleType) || StringUtils.isBlank(id)) msg.addMessage("存储空间大小计算错误！");
		Space space = new Space();
		BigDecimal oldSize = new BigDecimal(0);//剩余空间大小
		if(StringUtils.isBlank(roleType)||roleType.equals(ROLETYPE.USER.toString())){
			space = spaceMapper.getByUserId(id);
			oldSize = space.getSpace_size();
		}else if(roleType.equals(ROLETYPE.TEAM.toString())){
			space = spaceMapper.getSpaceByTeamId(id);
			oldSize = space.getSpace_size();
		}
		BigDecimal size = oldSize.subtract(fileSize);//空间值差
		if(size.compareTo(new BigDecimal(0))<0)return msg.addMessage("存储空间不足，存储失败！");
		
		space.setSpace_size(size);
		msg = super.update(space);
		return msg;
		
	}
	
}

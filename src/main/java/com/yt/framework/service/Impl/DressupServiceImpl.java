package com.yt.framework.service.Impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Dressup;
import com.yt.framework.service.DressupService;

/**
 * @Title: DressupServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月17日 下午3:33:38 
 */
@Service(value="dressupService")
public class DressupServiceImpl extends BaseServiceImpl<Dressup> implements DressupService{
	
	protected static Logger logger = LogManager.getLogger(DressupServiceImpl.class);

	@Override
	public Dressup getDressup(String userId, String drId) {
		if(StringUtils.isNotBlank(userId)&&drId!=null){
			return dressupMapper.getDressup(userId,drId);
		}
		return null;
	}

	@Override
	public void updateDressupEnable(List<Dressup> dressups) {
		dressupMapper.updateDressupEnable(dressups);
	}

	@Override
	public List<Dressup> getDressupsByDate(Date date) {
		return dressupMapper.getDressupsByDate(date);
	}

}

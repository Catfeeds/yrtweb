package com.yt.framework.service.Impl;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.CoachInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.CoacheInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

/**
 *
 *@autor bo.xie
 *@date2015-8-6下午5:58:51
 */
@Transactional
@Service("coacheInfoServer")
public class CoacheInfoServiceImpl extends BaseServiceImpl<CoachInfo> implements CoacheInfoService {
	
	protected static Logger logger = LogManager.getLogger(CoacheInfoServiceImpl.class);

	@Override
	public CoachInfo getCoachInfoByUserId(String user_id) {
		
		return coachInfoMapper.getCoachInfoByUserId(user_id);
	}

	@Override
	public AjaxMsg saveCoache(CoachInfo coachInfo, HttpServletRequest request) throws Exception{
		if(null == coachInfo.getId() && "".equals(coachInfo.getId())){
			coachInfo.setId(UUIDGenerator.getUUID());
		}
		AjaxMsg msg = save(coachInfo);
		if(msg.isSuccess()){
			User user = userMapper.getEntityById(coachInfo.getUser_id());
			msg = securityService.saveUserRole(user,"5",request);
			if(msg.isError()){
				throw new RuntimeException();
			}
		}
		return msg;
	}

}

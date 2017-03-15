package com.yt.framework.service.Impl;


import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.ActivitySignMapper;
import com.yt.framework.persistent.entity.ActivitySign;
import com.yt.framework.service.admin.ActivitySignService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;
/**
 * 
 * @author YJH
 *
 * 2015年11月18日
 */
@Service(value="activitySignService")
public class ActivitySignServiceImpl extends BaseServiceImpl<ActivitySign> implements ActivitySignService{
	
	protected static Logger logger = LogManager.getLogger(ActivitySignServiceImpl.class);
	
	@Autowired
	private ActivitySignMapper activitySignMapper;

	@Override
	public AjaxMsg saveActivitySign(ActivitySign as, HttpServletRequest request) throws Exception {
		as.setId(UUIDGenerator.getUUID());
		AjaxMsg msg = save(as);
		if(msg.isSuccess()){
			if(msg.isError()){
				throw new RuntimeException();
			}
		}
		return msg;
	}

	@Override
	public AjaxMsg getActivitySignByPhone(String phone) {
		if(StringUtils.isBlank(phone)) return null;
		ActivitySign activitySign =  activitySignMapper.getActivitySignByPhone(phone);
		if(activitySign!=null){
			return AjaxMsg.newError().addMessage("您已经报过名了哦");
		}else{
			return AjaxMsg.newSuccess().addMessage("该用户名可以使用");
		}
	}


}


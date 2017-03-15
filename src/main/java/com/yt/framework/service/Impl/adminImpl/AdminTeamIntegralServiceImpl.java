package com.yt.framework.service.Impl.adminImpl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.service.admin.AdminTeamIntegralService;

@Service(value="adminTeamIntegralService")
public class AdminTeamIntegralServiceImpl extends BaseAdminServiceImpl<TeamIntegral> implements AdminTeamIntegralService {
	
	protected static Logger logger = LogManager.getLogger(AdminTeamIntegralServiceImpl.class);

}

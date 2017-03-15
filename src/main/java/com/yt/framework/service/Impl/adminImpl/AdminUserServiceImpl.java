package com.yt.framework.service.Impl.adminImpl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.admin.AdminUserService;
import com.yt.framework.utils.AjaxMsg;

@Service(value="adminUserService")
public class AdminUserServiceImpl extends BaseAdminServiceImpl<User> implements AdminUserService {
	
	protected static Logger logger = LogManager.getLogger(AdminUserServiceImpl.class);

	@Override
	public User getUserById(String id) {
		return userMapper.getUserById(id);
	}
	
	@Override
	public List<Role> queryBmsRoles() {
		return userMapper.queryBmsRoles();
	}

	@Override
	public List<Role> queryBUserRoles(String id) {
		return userMapper.queryBUserRoles(id);
	}

	@Override
	public AjaxMsg updateUserRole(String userId, String roles) {
		if(StringUtils.isNotBlank(userId)){
			userMapper.deleteBUserRole(userId);
			if(StringUtils.isNotBlank(roles)){
				String[] rolesIds = roles.split(",");
				if (rolesIds!=null&&rolesIds.length>0) {
					for (String rId : rolesIds) {
						if (StringUtils.isNotBlank(rId)) {
							userMapper.saveBUserRole(userId, rId);
						}
					}
				}
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

}

package com.yt.framework.service.admin;

import java.util.List;

import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @author gl
 *
 */
public interface AdminUserService extends BaseService<User>{
	
	public User getUserById(String id); 

	/**
	 * 查询后台角色
	 * @return
	 */
	public List<Role> queryBmsRoles();

	/**
	 * 查询用户拥有的后台权限
	 * @param id
	 * @return
	 */
	public List<Role> queryBUserRoles(String id);

	public AjaxMsg updateUserRole(String userId, String roles);

}

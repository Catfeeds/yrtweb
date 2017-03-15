package com.yt.framework.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;

/**
 * @author gl
 *
 */
public interface AdminUserMapper extends BaseMapper<TeamInfo> {
	
	public User getUserById(@Param(value="id")String id);

	public List<Role> queryBmsRoles();

	public List<Role> queryBUserRoles(@Param(value="userId")String userId);

	/**
	 * 删除用户后台所有权限
	 * @param userId
	 */
	public void deleteBUserRole(@Param(value="userId")String userId);

	/**
	 * 给用户添加后台权限
	 * @param userId
	 * @param rId
	 */
	public void saveBUserRole(@Param(value="userId")String userId,@Param(value="roleId") String roleId);

}

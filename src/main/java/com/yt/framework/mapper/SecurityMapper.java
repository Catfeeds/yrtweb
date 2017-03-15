package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.RoleResources;
import com.yt.framework.persistent.entity.UserRole;

/**
 * @Title: SecurityMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年7月23日 下午4:22:00 
 */
public interface SecurityMapper {

	public UserRole queryUserRole(@Param(value="type")String type,@Param(value="username")String username);

	public List<RoleResources> queryRoleResources();

	public List<Resources> queryAllResources();
	
	public List<Resources> queryResourcesByRoleId(@Param(value="roleId")String roleId);

	public List<Role> getRoleByUserId(@Param(value="userId")String userId);
	
	public Role getRoleById(@Param(value="roleId")String roleId);

	public int saveUserRole(@Param(value="userId")String userId, @Param(value="roleId")String roleId);
	
	public int saveRoleResources(@Param(value="roleId")String roleId, @Param(value="resId")String resId);

	public void deleteUserRole(@Param(value="userId")String userId, @Param(value="roleId")String roleId);
	
	public void deleteRoleResources(@Param(value="roleId")String roleId, @Param(value="resId")String resId);
	
	/**
	 * 查询角色
	 * @param params
	 * @return List<Role>
	 */
	public List<Role> findRoleByPage(Map<String, Object> params);
	
	public int roleCount(Map<String, Object> params);
	
	/**
	 * 添加角色
	 * @param role
	 * @return int  响应条数
	 */
	public int saveRole(Role role);
	/**
	 * 修改角色
	 * @param role
	 * @return int  响应条数
	 */
	public int updateRole(Role role);
	/**
	 * 删除角色
	 * @param role
	 * @return int  响应条数
	 */
	public int deleteRole(@Param(value="roleId")String roleId);
	/**
	 * 添加资源
	 * @param role
	 * @return int  响应条数
	 */
	public int saveResources(Resources res);
	/**
	 * 修改资源
	 * @param role
	 * @return int  响应条数
	 */
	public int updateResources(Resources res);
	/**
	 * 删除资源
	 * @param roleId
	 * @return int  响应条数
	 */
	public int deleteResources(@Param(value="resId")String resId);

	public void updateImageRole(@Param(value="userId")String id, @Param(value="role_type")String role_type);

	public void updateVideoRole(@Param(value="userId")String id, @Param(value="role_type")String role_type);

	
}

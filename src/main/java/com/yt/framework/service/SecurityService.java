package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.RoleResources;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: SecurityService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年7月23日 下午4:00:00 
 */
public interface SecurityService {

	/**
	 * 查询用户对应的角色
	 * @param username
	 * @return UserRole
	 */
	public UserRole queryUserRole(String username);

	/**
	 * 查询所有角色对应的资源
	 * @return List<RoleResources>
	 */
	public List<RoleResources> queryRoleResources();

	/**
	 * 查询所有资源
	 * @return List<Resources>
	 */
	public List<Resources> queryAllResources();
	/**
	 * 通过角色ID查询资源
	 * @return List<Resources>
	 */
	public List<Resources> queryResourcesByRoleId(String roleId);
	
	
	/**
	 * 通过用户ID查询角色
	 * @param userId
	 * @return Role
	 */
	public List<Role> getRoleByUserId(String userId);
	
	/**
	 * 通过角色ID查询角色
	 * @param userId
	 * @return Role
	 */
	public Role getRoleById(String roleId);
	
	/**
	 * 添加用户角色
	 * @param userId
	 * @param roleId
	 * @return AjaxMsg
	 */
	public AjaxMsg saveUserRole(User user, String roleId) throws Exception;

	/**
	 * 添加用户角色并刷新当前用户
	 * @param userId
	 * @param roleId
	 * @return AjaxMsg
	 */
	public AjaxMsg saveUserRole(User user, String roleId,HttpServletRequest request) throws Exception;
	
	/**
	 * 改变USER权限信息后重新加载User权限
	 * @param user
	 * @param request
	 * @return
	 */
	public AjaxMsg reloadUserRole(User user,HttpServletRequest request);
	
	/**
	 * 通过用户ID和角色ID删除用户角色
	 * @param userId
	 * @param roleId
	 * @return AjaxMsg
	 */
	public AjaxMsg deleteUserRole(String userId, String roleId);
	

	public AjaxMsg findRoleByPage(Map<String, Object> params,PageModel pageModel);
	
	public AjaxMsg saveRole(Role role);

	/**
	 * 添加或修改角色
	 * @param role
	 * @return AjaxMsg
	 */
	public AjaxMsg saveOrUpdate(Role role);

	/**
	 * 删除角色
	 * @param parseInt
	 * @return AjaxMsg
	 */
	public AjaxMsg deleteRole(String parseInt);

	/**
	 * 修改角色资源
	 * @param parseInt
	 * @param residsStr
	 * @return AjaxMsg
	 */
	public AjaxMsg saveRoleRes(String roleId, String residsStr);

}

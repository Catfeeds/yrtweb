package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.SecurityMapper;
import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.RoleResources;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.security.WebUserDetails;
import com.yt.framework.service.SecurityService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: SecurityServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年7月23日 下午4:22:05 
 */
@Service(value="securityService")
public class SecurityServiceImpl implements SecurityService{
	
	protected static Logger logger = LogManager.getLogger(SecurityServiceImpl.class);

	@Autowired
	private SecurityMapper securityMapper;
	
	@Autowired
	@Qualifier("webAuthenticationManager")
	private AuthenticationManager authenticationManager;
	
	@Override
	public UserRole queryUserRole(String username) {
		if (StringUtils.isNotBlank(username)) {
			String type = "phone";
			if(Common.isMobile(username)){
				return securityMapper.queryUserRole(type,username);
			}else{
				type = "email";
				return securityMapper.queryUserRole(type,username);
			}
		}
		return null;
	}

	@Override
	public List<RoleResources> queryRoleResources() {
		List<RoleResources> roleRes = securityMapper.queryRoleResources();
		return roleRes;
	}

	@Override
	public List<Resources> queryAllResources() {
		return securityMapper.queryAllResources();
	}
	
	@Override
	public List<Resources> queryResourcesByRoleId(String roleId) {
		return securityMapper.queryResourcesByRoleId(roleId);
	}

	@Override
	public List<Role> getRoleByUserId(String userId) {
		return securityMapper.getRoleByUserId(userId);
	}
	
	@Override
	public Role getRoleById(String roleId) {
		return securityMapper.getRoleById(roleId);
	}
	
	@Override
	public AjaxMsg saveUserRole(User user, String roleId) throws Exception{
		return saveUserRole(user,roleId,null);
	}
	
	@Override
	public AjaxMsg saveUserRole(User user, String roleId,HttpServletRequest request) throws Exception{
		deleteUserRole(user.getId(), roleId);
		int num = securityMapper.saveUserRole(user.getId(),roleId);
		if(num==1){
			if(request!=null){
				UserRole urole = getUser();
				if(urole!=null){
					Set<Role> roles = urole.getRoles();
					boolean flag = true;
					for (Role role : roles) {
						String str = role.getRole_str();
						if(!str.contains("ADMIN")&&!"ROLE_TEAM".equals(str)&&!"ROLE_USER".equals(str)){
							flag = false;
						}
					}
					if(flag){
						String role_type = "";
						if("3".equals(roleId)){
							role_type = SystemEnum.IMAGE.PLAYER.toString();
						}else if("4".equals(roleId)){
							role_type = SystemEnum.IMAGE.AGENT.toString();
						}else if("5".equals(roleId)){
							role_type = SystemEnum.IMAGE.COACH.toString();
						}else if("7".equals(roleId)){
							role_type = SystemEnum.IMAGE.BABY.toString();
						}
						if(StringUtils.isNotBlank(role_type)){
							securityMapper.updateImageRole(user.getId(),role_type);
							securityMapper.updateVideoRole(user.getId(),role_type);
						}
					}
				}
				return reloadUserRole(user,request);
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}
	
	private UserRole getUser(){
		try {
			WebUserDetails webUser = (WebUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserRole user = webUser.getUser();
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	
	@Override
	public AjaxMsg reloadUserRole(User user, HttpServletRequest request) {
		String username = StringUtils.isNotBlank(user.getPhone())?user.getPhone():user.getEmail();
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username,user.getPassword());
		try {
			token.setDetails(new WebAuthenticationDetails(request));
			Authentication authenticatedUser = authenticationManager
	                .authenticate(token);
	        SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
	        request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg deleteUserRole(String userId, String roleId) {
		securityMapper.deleteUserRole(userId, roleId);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg findRoleByPage(Map<String, Object> params, PageModel pageModel) {
		List<Role> roles = new ArrayList<Role>();
		int count = 0 ;
		if(pageModel!=null){
			count = securityMapper.roleCount(params);
			pageModel.setTotalCount(count);
			Integer startInt = (pageModel.getCurrentPage()-1<0?0:pageModel.getCurrentPage()-1)*(pageModel.getPageSize());
			params.put("start",startInt.toString());
			params.put("rows",String.valueOf(pageModel.getPageSize()));
		}
		roles = securityMapper.findRoleByPage(params);
		pageModel.setItems(roles);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg saveRole(Role role) {
		int num = securityMapper.saveRole(role);
		if(num==1){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveOrUpdate(Role role) {
		if(role!=null){
			String roleId = role.getRole_id();
			if(StringUtils.isNotBlank(roleId)){
				securityMapper.updateRole(role);
			}else{
				role.setRole_id(UUIDGenerator.getUUID());
				securityMapper.saveRole(role);
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg deleteRole(String roleId) {
		securityMapper.deleteRole(roleId);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg saveRoleRes(String roleId, String residsStr) {
		if (StringUtils.isNotBlank(roleId)) {
			securityMapper.deleteRoleResources(roleId,null);
		}
		if(StringUtils.isNotBlank(residsStr)){
			String[] resIds = residsStr.split(",");
			if (resIds!=null&&resIds.length>0) {
				for (String resId : resIds) {
					if (StringUtils.isNotBlank(resId)) {
						securityMapper.saveRoleResources(roleId, resId);
					}
				}
			}
		}
		return AjaxMsg.newSuccess();
	}

}

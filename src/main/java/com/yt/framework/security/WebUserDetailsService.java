package com.yt.framework.security;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.service.SecurityService;

/**
 * @author GL
 * @date 2015年7月23日 下午4:30:50 
 */
@Service("webUserDetailsService")
public class WebUserDetailsService implements UserDetailsService{
	
	@Autowired
	private SecurityService securityService;
	protected MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		UserRole user = securityService.queryUserRole(username);
		if (null == user) {
			throw new UsernameNotFoundException(
							messages.getMessage("User.notFound", new Object[] { username }, "Username {0} not found"));
		}
//		String userId = user.getId();
//		String password = user.getPassword();
		//读取当前用户有哪些角色权限
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			GrantedAuthority authority = new SimpleGrantedAuthority(role.getRole_str());
			authorities.add(authority);
		}
//		//如果是超级用户，则添加超级用户的授权
//		if(username.equals("admin")){
//			//ROLE_SUPER 这个权限名字也是自己定义的
//			authorities.add(new SimpleGrantedAuthority("ROLE_SUPER"));
//		}
		//创建 UserDetails 对象
		WebUserDetails webUserDetails = new WebUserDetails(user, true, authorities);
		return webUserDetails;
	}

}

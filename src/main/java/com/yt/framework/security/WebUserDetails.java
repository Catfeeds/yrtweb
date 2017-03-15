package com.yt.framework.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.yt.framework.persistent.entity.UserRole;

/**
 * @Title: WebUserDetails.java 
 * @Package com.yt.framework.security
 * @author GL
 * @date 2015年7月22日 下午6:36:45 
 */
public class WebUserDetails implements UserDetails{
	
	private String username;
	private String password;	
	private boolean userEnabled;
	private Collection<GrantedAuthority> authorities;
	private boolean accountNonExpired;
	private boolean accountNonLocked;
	private boolean credentialsNonExpired;
	
	//额外增加的属性
	private String userId;
	private UserRole user;
	
	public WebUserDetails(UserRole user, boolean userEnabled, Collection<GrantedAuthority> authorities) {
		this.username = user.getUsername();
		this.password = user.getPassword();
		this.userEnabled = userEnabled;		
		this.authorities = authorities;
		
		//这里先初始都为true，如果需要深度控制，可完善
		this.accountNonExpired = true;
		this.accountNonLocked = true;
		this.credentialsNonExpired = true;
		
		//
		this.userId = user.getId();
		this.user = user;
		
	}
	
	public WebUserDetails(String userId,String username, String password, boolean userEnabled, Collection<GrantedAuthority> authorities) {
		this.username = username;
		this.password = password;
		this.userEnabled = userEnabled;		
		this.authorities = authorities;
		
		//这里先初始都为true，如果需要深度控制，可完善
		this.accountNonExpired = true;
		this.accountNonLocked = true;
		this.credentialsNonExpired = true;
		
		//
		this.userId = userId;
		
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

	@Override
	public String getPassword() {
		return this.password;
	}

	@Override
	public String getUsername() {
		return this.username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return this.accountNonExpired;
	}

	@Override
	public boolean isAccountNonLocked() {
		return this.accountNonLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return this.credentialsNonExpired;
	}

	@Override
	public boolean isEnabled() {
		return this.userEnabled;
	}

	public String getUserId() {
		return userId;
	}

	public UserRole getUser() {
		return user;
	}
	
	

}

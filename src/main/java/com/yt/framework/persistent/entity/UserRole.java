package com.yt.framework.persistent.entity;

import java.util.Set;

/**
 * @Title: UserRole.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年7月23日 下午3:53:56 
 */
@SuppressWarnings("serial")
public class UserRole extends User {

	private Set<Role> roles;

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
}

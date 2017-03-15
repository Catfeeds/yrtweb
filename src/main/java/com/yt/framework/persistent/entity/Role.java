package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * @Title: Role.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年7月23日 下午3:53:42 
 */
public class Role implements Serializable{
	private static final long serialVersionUID = 8413243011862713603L;

	private String role_id;

	private String role_name;

	private String role_str;
	
	private String role_state;

	public String getRole_id() {
		return role_id;
	}

	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getRole_str() {
		return role_str;
	}

	public void setRole_str(String role_str) {
		this.role_str = role_str;
	}
	
	public String getRole_state() {
		return role_state;
	}

	public void setRole_state(String role_state) {
		this.role_state = role_state;
	}

	@Override
	public String toString() {
		return "Role [roleId=" + role_id + ", roleName=" + role_name + ", roleStr=" + role_str + "]";
	}
}
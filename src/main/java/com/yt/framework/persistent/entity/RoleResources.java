package com.yt.framework.persistent.entity;

import java.util.Set;

/**
 * @Title: RoleResources.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年7月23日 下午3:54:02 
 */
public class RoleResources extends Role{

	private Set<Resources> resources;

	public Set<Resources> getResources() {
		return resources;
	}

	public void setResources(Set<Resources> resources) {
		this.resources = resources;
	}
	
}

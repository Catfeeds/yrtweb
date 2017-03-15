	package com.yt.framework.persistent.entity;

import java.math.BigDecimal;

/**
 *存储空间
 *@autor bo.xie
 *@date2015-9-2上午11:16:34
 */
public class Space {

	private String id;
	private String user_id;//用户ID
	private String teaminfo_id;//俱乐部ID
	private BigDecimal space_size;//可用空间大小 单位M
	private BigDecimal sum_size;//总共存储空间 单位M
	
	public BigDecimal getSum_size() {
		return sum_size;
	}
	public void setSum_size(BigDecimal sum_size) {
		this.sum_size = sum_size;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public BigDecimal getSpace_size() {
		return space_size;
	}
	public void setSpace_size(BigDecimal space_size) {
		this.space_size = space_size;
	}
	
}

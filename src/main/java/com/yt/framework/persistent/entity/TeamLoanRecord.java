package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 球员转会记录表
 * @author ylt
 *
 */
public class TeamLoanRecord implements Serializable{

	private static final long serialVersionUID = 6019195997087735345L;

	private String id;
	
	private String user_id;
	/**
	 * 原俱乐部ID
	 */
	private String teaminfo_id;
	/**
	 * 新俱乐部ID
	 */
	private String new_teaminfo_id;
	
	private Date create_time;
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
	public String getNew_teaminfo_id() {
		return new_teaminfo_id;
	}
	public void setNew_teaminfo_id(String new_teaminfo_id) {
		this.new_teaminfo_id = new_teaminfo_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
}

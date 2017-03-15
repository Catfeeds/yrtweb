package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *黑名单
 *@autor ylt
 *@date2015-8-10下午5:06:46
 */
public class BlackPlayer implements Serializable{

	private static final long serialVersionUID = 3548436707256087675L;
	private String id;
	private String teaminfo_id;//球队ID
	private String user_id;//球员用户ID
	private Date create_time; //创建时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
}

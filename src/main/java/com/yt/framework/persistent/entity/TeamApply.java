package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 入队申请
 * @author bo.xie
 * @date 2015年12月1日15:51:29
 */
public class TeamApply {

	private String id;
	private String teaminfo_id;
	private String user_id;
	private Date create_time;
	private int status;//申请状态：1:申请成功，2：申请失败
	
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}

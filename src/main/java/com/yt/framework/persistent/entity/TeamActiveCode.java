package com.yt.framework.persistent.entity;

import java.util.Date;

public class TeamActiveCode {

	private String id;
	/**
	 * 俱乐部ID
	 */
	private String teaminfo_id;
	/**
	 * 使用者用户ID
	 */
	private String user_id;
	/**
	 * 激活码状态
	 */
	private String code_str;
	/**
	 * 是否可用 1：可用 2：不可用
	 */
	private int status;
	/**
	 * 使用时间
	 */
	private Date use_time;
	/**
	 * 创建时间
	 */
	private Date create_time;

	/**
	 * 截止时间
	 */
	private Date end_time;
	
	/**
	 * 是否使用 1：未使用 2：已使用
	 */
	private int if_use; 
	
	/**
	 * 联赛ID
	 */
	private String league_id;
	
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	
	public String getCode_str() {
		return code_str;
	}
	public void setCode_str(String code_str) {
		this.code_str = code_str;
	}
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getUse_time() {
		return use_time;
	}
	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public int getIf_use() {
		return if_use;
	}
	public void setIf_use(int if_use) {
		this.if_use = if_use;
	}
	
	
}

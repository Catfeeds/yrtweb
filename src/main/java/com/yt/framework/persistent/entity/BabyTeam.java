package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 *已加入俱乐部
 *@autor bo.xie
 *@date2015-9-24下午6:06:59
 */
public class BabyTeam {

	private String id;
	/**
	 * 足球宝贝用户ID
	 */
	private String user_id;
	/**
	 * 俱乐部ID
	 */
	private String teaminfo_id;
	
	/**
	 * 加入时间
	 */
	private Date join_date;
	/**
	 * 结束时间
	 */
	private Date end_date;
	/**
	 * 入驻天数
	 */
	private int days;
	/**
	 * 是否有效 0：无效 1：有效
	 */
	private int status;
	
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
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}

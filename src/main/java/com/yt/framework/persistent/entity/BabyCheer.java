package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 宝贝-助威
 * 
 * @Title: BabyCheer.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年9月24日 下午3:12:46
 */
public class BabyCheer implements Serializable {
	
	private static final long serialVersionUID = 5278732372410852216L;
	private String id;
	private String user_id; // 足球宝贝用户ID
	private String teaminfo_id; // 俱乐部ID
	private String team_name; // 俱乐部名称
	private String logo; // 俱乐部logo
	private String teamgame_id;// 比赛记录ID
	private String contact_phone; // 联系电话
	private Integer status = new Integer(0) ;// 是否同意 1：同意  2：不同意 
	private String contact_person ; //联系人
	private String cheer_address;//助威地点
	private Date cheer_time ;// 助威日期
	private String remark;// 备注	
	private Date create_time;// 创建时间
	
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
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getTeamgame_id() {
		return teamgame_id;
	}
	public void setTeamgame_id(String teamgame_id) {
		this.teamgame_id = teamgame_id;
	}
	public String getContact_phone() {
		return contact_phone;
	}
	public void setContact_phone(String contact_phone) {
		this.contact_phone = contact_phone;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getContact_person() {
		return contact_person;
	}
	public void setContact_person(String contact_person) {
		this.contact_person = contact_person;
	}
	public String getCheer_address() {
		return cheer_address;
	}
	public void setCheer_address(String cheer_address) {
		this.cheer_address = cheer_address;
	}
	public Date getCheer_time() {
		return cheer_time;
	}
	public void setCheer_time(Date cheer_time) {
		this.cheer_time = cheer_time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	
}

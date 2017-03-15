package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 宝贝-入住邀请
 * 
 * @Title: BabyIn.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年9月24日 下午3:12:46
 */
public class BabyIn implements Serializable {

	private static final long serialVersionUID = 1280519468301687476L;
	private String id;
	private String user_id; //足球宝贝用户ID
	private String teaminfo_id; //俱乐部ID
	private Integer days; //入驻天数
	private Integer status; //状态：1：同意入驻,2：不同意入驻,3:入驻邀请中
	private Date sure_time; //到期时间
	private String contact_person; //联系人
	private String contact_phone; //联系电话
	private String remark; //备注
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
	public Integer getDays() {
		return days;
	}
	public void setDays(Integer days) {
		this.days = days;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getSure_time() {
		return sure_time;
	}
	public void setSure_time(Date sure_time) {
		this.sure_time = sure_time;
	}
	public String getContact_person() {
		return contact_person;
	}
	public void setContact_person(String contact_person) {
		this.contact_person = contact_person;
	}
	public String getContact_phone() {
		return contact_phone;
	}
	public void setContact_phone(String contact_phone) {
		this.contact_phone = contact_phone;
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
	
	
}

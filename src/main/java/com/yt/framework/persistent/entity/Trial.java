package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 试训记录
 * 
 * @Title: Trial.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月12日 下午2:28:59
 */
public class Trial implements Serializable {
	private static final long serialVersionUID = 8085483270816706037L;
	private String id;
	private String user_id;
	private String s_user_id;
	private Date trail_date;
	private String trail_position;
	private String trail_other;
	private Integer status; //试训是否同意 0 不同意，1同意
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
	
	public String getS_user_id() {
		return s_user_id;
	}

	public void setS_user_id(String s_user_id) {
		this.s_user_id = s_user_id;
	}

	public Date getTrail_date() {
		return trail_date;
	}

	public void setTrail_date(Date trail_date) {
		this.trail_date = trail_date;
	}

	public String getTrail_position() {
		return trail_position;
	}

	public void setTrail_position(String trail_position) {
		this.trail_position = trail_position;
	}

	public String getTrail_other() {
		return trail_other;
	}

	public void setTrail_other(String trail_other) {
		this.trail_other = trail_other;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

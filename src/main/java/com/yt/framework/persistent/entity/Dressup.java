package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户拥有皮肤
 * @Title: Dressup.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月17日 下午3:34:20 
 */
public class Dressup implements Serializable {
	private static final long serialVersionUID = -3122620908553404239L;
	private String id;
	private String user_id;
	private String dr_id;
	private Integer status;// 状态 0：未使用 1：正在使用
	private Integer period;// 购买多少个月
	private Integer is_per;// 是否永久有效 0：不是 1：永久有效
	private Date create_time;
	private int enable;//是否到期 0：已到期  1：未到期
	private Date end_time;//到期时间
	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
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

	public String getDr_id() {
		return dr_id;
	}

	public void setDr_id(String dr_id) {
		this.dr_id = dr_id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getPeriod() {
		return period;
	}

	public void setPeriod(Integer period) {
		this.period = period;
	}

	public Integer getIs_per() {
		return is_per;
	}

	public void setIs_per(Integer is_per) {
		this.is_per = is_per;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}

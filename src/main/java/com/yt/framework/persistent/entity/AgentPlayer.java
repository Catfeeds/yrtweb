package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *经纪人签约球员
 *@autor bo.xie
 *@date2015-8-4下午6:11:26
 */
public class AgentPlayer implements Serializable{

	private static final long serialVersionUID = 795413975648608575L;
	private String id;
	private String user_id;//经纪人用户ID
	private String p_user_id;//球员用户ID
	private Integer status;//状态 0：已解约 1：已签约 
	private Date apply_time;//发起签约时间
	private Date create_time;//签约时间
	private Integer applying; //申请状态: 0:无 1:签约申请 2:解约申请
	private Date apply_sure_time;//发起签约确认时间
	private Date break_sure_time;//发起解约确认时间
	private Date break_time;//发起解约时间
	
	public Date getApply_sure_time() {
		return apply_sure_time;
	}
	public void setApply_sure_time(Date apply_sure_time) {
		this.apply_sure_time = apply_sure_time;
	}
	public Date getBreak_sure_time() {
		return break_sure_time;
	}
	public void setBreak_sure_time(Date break_sure_time) {
		this.break_sure_time = break_sure_time;
	}
	public Date getBreak_time() {
		return break_time;
	}
	public void setBreak_time(Date break_time) {
		this.break_time = break_time;
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
	public String getP_user_id() {
		return p_user_id;
	}
	public void setP_user_id(String p_user_id) {
		this.p_user_id = p_user_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getApply_time() {
		return apply_time;
	}
	public void setApply_time(Date apply_time) {
		this.apply_time = apply_time;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getApplying() {
		return applying;
	}
	public void setApplying(Integer applying) {
		this.applying = applying;
	}
	
	
}

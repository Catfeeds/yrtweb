package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *经纪人签约球员申请记录
 *@autor ylt
 *@date2015-8-16下午6:11:26
 */
public class AgentPlayerSign implements Serializable{

	private static final long serialVersionUID = 6884121680534246907L;
	private String id;
	private String user_id;//经济人用户ID
	private String p_user_id;//球员用户ID
	private Integer status;//状态 0:无 1：同意 2：拒绝
	private Date apply_time;//发起签约时间                                                                                                                                                                                                                                             
	private Date create_time;//创建时间
	private Integer applying; //申请状态: 0:无 1:签约申请 2:解约申请
	private Date apply_sure_time;//发起签约确认时间
	private Date break_sure_time;//发起解约确认时间
	private Date break_time;//发起解约时间
	private String sendFlag;//发送申请方标志
	
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
	public String getSendFlag() {
		return sendFlag;
	}
	public void setSendFlag(String sendFlag) {
		this.sendFlag = sendFlag;
	}
	
	
}

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 我的消息记录
 * 
 * @Title: Message.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月11日 下午4:31:54
 */
public class Message implements Serializable {
	private static final long serialVersionUID = -6320070876157818200L;
	private String id;
	private String user_id;
	private String s_user_id;
	private String content;
	private String type;
	private Integer status; //状态 0：未读 1：已读
	private Date create_time;
	private String relate_id; //关联信息对象id 例如：比赛上传结果、试训通知、邀战申请等
	private Integer m_style; //0:私人消息 1：系统消息
	private Integer sys_type;//1：系统消息 2：个人消息 3：俱乐部消息
	private Integer oper_status;//1:同意 2：拒绝

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getRelate_id() {
		return relate_id;
	}

	public void setRelate_id(String relate_id) {
		this.relate_id = relate_id;
	}

	public Integer getM_style() {
		return m_style;
	}

	public void setM_style(Integer m_style) {
		this.m_style = m_style;
	}

	public Integer getSys_type() {
		return sys_type;
	}

	public void setSys_type(Integer sys_type) {
		this.sys_type = sys_type;
	}

	public Integer getOper_status() {
		return oper_status;
	}

	public void setOper_status(Integer oper_status) {
		this.oper_status = oper_status;
	}

	
}

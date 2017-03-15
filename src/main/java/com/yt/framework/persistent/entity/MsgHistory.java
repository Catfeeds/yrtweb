package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 短信和右键发送信息记录
 * @author gl
 *
 */
public class MsgHistory implements Serializable {
	private static final long serialVersionUID = 2102595487146136291L;
	private String id;
	private String phone;
	private String email;
	private String result;//短信、邮件发送返回结果
	private String content;//发送类容
	private Integer type;//类型 1：短信 2：邮件
	private Date create_time;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

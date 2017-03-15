package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 邀请用户短信发送通知记录
 * @author bo.xie
 *
 */
public class UserInvitesms {

	private String id;
	private String f_user_id;//发起用户ID
	private String user_id;//邀请用户ID
	private int type;//1:邀请上传精彩瞬间 2：邀请录入足球生涯
	private Date create_time;//发起邀请时间
	
	public String getF_user_id() {
		return f_user_id;
	}
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
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
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}

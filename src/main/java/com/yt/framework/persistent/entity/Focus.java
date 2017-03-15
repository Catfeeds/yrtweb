package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 *
 *@autor bo.xie
 *@date2015-8-12下午2:23:37
 */
public class Focus {
	
	private String id;
	private String user_id;
	private String f_user_id; //被关注用户
	private String f_teaminfo_id;//被关注俱乐部ID
	/**
	 * 0:非俱乐部，1 俱乐部
	 */
	private int f_type;
	/**
	 * 是否屏蔽关注者动态 0：不屏蔽 1：屏蔽
	 */
	private int status;
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
	public String getF_user_id() {
		return f_user_id;
	}
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
	}
	public int getF_type() {
		return f_type;
	}
	public void setF_type(int f_type) {
		this.f_type = f_type;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getF_teaminfo_id() {
		return f_teaminfo_id;
	}
	public void setF_teaminfo_id(String f_teaminfo_id) {
		this.f_teaminfo_id = f_teaminfo_id;
	}
	
	
	
}

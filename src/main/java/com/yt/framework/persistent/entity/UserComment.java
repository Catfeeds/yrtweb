package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

public class UserComment implements Serializable {

	private static final long serialVersionUID = 9054614671860534468L;
	private String id;
	private String user_id; //评论人ID
	private String s_user_id;//被评论ID
	private String c_user_id;//评论所在个人中心的用户Id
	private String parent_id;//被评论的评论ID
	private String content; //内容
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
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getC_user_id() {
		return c_user_id;
	}
	public void setC_user_id(String c_user_id) {
		this.c_user_id = c_user_id;
	}
}

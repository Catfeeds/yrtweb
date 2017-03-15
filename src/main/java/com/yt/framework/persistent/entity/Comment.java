package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 评论
 * 
 * @Title: Comment.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月11日 上午10:16:47
 */
public class Comment implements Serializable {

	private static final long serialVersionUID = -8036062133308378988L;
	private String id;
	private String user_id;
	private String dynamic_id;
	private String content;
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

	public String getDynamic_id() {
		return dynamic_id;
	}

	public void setDynamic_id(String dynamic_id) {
		this.dynamic_id = dynamic_id;
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

}

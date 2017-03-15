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
public class IvComment implements Serializable {

	private static final long serialVersionUID = -8036062133308378988L;
	private String id;
	private String user_id;
	private String iv_id;
	private String content;
	private Integer level;
	private Integer is_show;
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

	public String getIv_id() {
		return iv_id;
	}

	public void setIv_id(String iv_id) {
		this.iv_id = iv_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getIs_show() {
		return is_show;
	}

	public void setIs_show(Integer is_show) {
		this.is_show = is_show;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}

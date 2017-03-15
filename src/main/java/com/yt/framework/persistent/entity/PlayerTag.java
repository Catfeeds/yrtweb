package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 球员评价
 * 
 * @Title: PlayerTag.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年8月3日 下午3:16:20
 */
public class PlayerTag implements Serializable {
	private static final long serialVersionUID = 7346158998337493237L;
	private String id;
	private String user_id;// '被评价球员信息ID',
	private Date create_time;//创建时间
	private String s_user_id;//评价用户
	private String tag;
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
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getS_user_id() {
		return s_user_id;
	}
	public void setS_user_id(String s_user_id) {
		this.s_user_id = s_user_id;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	

}

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *图片、视频分组
 *@autor bo.xie
 *@date2015-8-14下午2:10:31
 */
public class Group implements Serializable {

	private static final long serialVersionUID = 4030551774775343540L;

	private String id;
	private String user_id;
	private String name;
	private String describle;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

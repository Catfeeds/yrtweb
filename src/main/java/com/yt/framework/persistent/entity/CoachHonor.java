package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *教练荣誉Entity
 *@autor bo.xie
 *@date2015-8-6下午5:17:32
 */
public class CoachHonor implements Serializable{
	
	private static final long serialVersionUID = 683462205560754515L;

	private String id;
	private String user_id;//用户ID
	private String name;//荣誉名称
	private String describle;//描述
	private String images_url;//图片
	private Date create_time;
	
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
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
	public String getImages_url() {
		return images_url;
	}
	public void setImages_url(String images_url) {
		this.images_url = images_url;
	}
	
}

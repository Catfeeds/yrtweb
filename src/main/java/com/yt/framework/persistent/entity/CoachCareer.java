package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *教练职业生涯
 *@autor bo.xie
 *@date2015-8-6下午5:19:38
 */
public class CoachCareer implements Serializable {

	private static final long serialVersionUID = 1358091269661466431L;
	
	private String id;
	private String user_id;//用户ID
	private String name;//名称
	private String describle;//描述
	private Date bg_time;//任职开始时间
	private Date ed_time;//任职结束时间
	private Date create_time;//创建时间
	
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
	public Date getBg_time() {
		return bg_time;
	}
	public void setBg_time(Date bg_time) {
		this.bg_time = bg_time;
	}
	public Date getEd_time() {
		return ed_time;
	}
	public void setEd_time(Date ed_time) {
		this.ed_time = ed_time;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	

}

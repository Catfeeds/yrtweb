package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 后台管理员报名主题设置
 * 
 * @Title: AdminSignCfg.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年11月3日 下午3:12:46
 */
public class AdminSignCfg implements Serializable {
	
	private static final long serialVersionUID = 2218075822910340329L;
	private String id;
	private String title; //title
	private String images; //images
	private String description; //报名主题描述
	private Date create_time;
	private Date start_time;
	private Date end_time;
	private String if_show;
	private String keyword;//报名参数
	private String user_id;
	private String s_id;// 是否赛季报名
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public String getIf_show() {
		return if_show;
	}
	public void setIf_show(String if_show) {
		this.if_show = if_show;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	
	
}

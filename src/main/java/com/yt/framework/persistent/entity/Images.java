package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

public class Images implements Serializable {
	private static final long serialVersionUID = -2989604662461529034L;
	private String id;
	private String user_id; //上传者ID
	private String title; //标题
	private String describle;//描述
	private String f_size;//大小
	private Integer f_status;//是否可用 0：不可用 1:可用
	private String f_src;//上传路径
	private Integer click_count;//点击量
	private Integer praise_count;//赞
	private Integer unpraise_count;//踩
	private String role_type;//角色类型 USER球迷；PLAYER:球员；TEAM:球队；BABY：宝贝
	private Integer if_show;//是否在首页展示 1：展示 0：不展示
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public String getF_size() {
		return f_size;
	}
	public void setF_size(String f_size) {
		this.f_size = f_size;
	}
	public Integer getF_status() {
		return f_status;
	}
	public void setF_status(Integer f_status) {
		this.f_status = f_status;
	}
	public String getF_src() {
		return f_src;
	}
	public void setF_src(String f_src) {
		this.f_src = f_src;
	}
	public Integer getClick_count() {
		return click_count;
	}
	public void setClick_count(Integer click_count) {
		this.click_count = click_count;
	}
	public Integer getPraise_count() {
		return praise_count;
	}
	public void setPraise_count(Integer praise_count) {
		this.praise_count = praise_count;
	}
	public Integer getUnpraise_count() {
		return unpraise_count;
	}
	public void setUnpraise_count(Integer unpraise_count) {
		this.unpraise_count = unpraise_count;
	}
	public String getRole_type() {
		return role_type;
	}
	public void setRole_type(String role_type) {
		this.role_type = role_type;
	}
	public Integer getIf_show() {
		return if_show;
	}
	public void setIf_show(Integer if_show) {
		this.if_show = if_show;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

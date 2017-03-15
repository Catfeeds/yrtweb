package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *首页轮播图实体
 *@autor gl
 *@date2015-9-23下午5:59:46
 */
public class IndexModel implements Serializable{
	private static final long serialVersionUID = 8961345981972434854L;
	private String id;
	private String oth_id;
	private String oth_type;
	private Integer sort;
	private String type;
	private String user_id;
	private Date create_time;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOth_id() {
		return oth_id;
	}
	public void setOth_id(String oth_id) {
		this.oth_id = oth_id;
	}
	public String getOth_type() {
		return oth_type;
	}
	public void setOth_type(String oth_type) {
		this.oth_type = oth_type;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	
	
}

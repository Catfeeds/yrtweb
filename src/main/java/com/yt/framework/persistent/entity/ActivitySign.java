package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * @author YJH
 *
 * 2015年11月18日
 */
public class ActivitySign implements Serializable {
	
	private static final long serialVersionUID = 7906876145576574795L;
	private String id;
	private String name; // 手机号
	private String phone; //用户姓名
	private String activity_name;
	private Date createTime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getActivity_name() {
		return activity_name;
	}
	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}

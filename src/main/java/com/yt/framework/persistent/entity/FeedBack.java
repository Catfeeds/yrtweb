package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *一键反馈信息
 *@autor bo.xie
 *@date2015-8-19下午4:20:54
 */
public class FeedBack implements Serializable {

	private static final long serialVersionUID = 5520710362082137663L;

	private String id;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 联系电话
	 */
	private String phone;
	/**
	 * 邮箱地址
	 */
	private String email;
	/**
	 * 反馈内容
	 */
	private String content;
	/**
	 * ip地址
	 */
	private String ip_str;
	/**
	 * 图片地址
	 */
	private String image_url;
	private Date create_time;
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp_str() {
		return ip_str;
	}
	public void setIp_str(String ip_str) {
		this.ip_str = ip_str;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
}

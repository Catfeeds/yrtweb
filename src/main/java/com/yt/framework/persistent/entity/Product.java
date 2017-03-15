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
public class Product implements Serializable {
	private String id;
	private Integer p_type;
	private String p_code;
	private String p_name;
	private String image_src;
	private String image_src_max;
	private String status;
	private Integer charm_value;
	private Integer p_price;
	private Date create_time;
	
	
	public Integer getP_type() {
		return p_type;
	}
	public void setP_type(Integer p_type) {
		this.p_type = p_type;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getImage_src() {
		return image_src;
	}
	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}
	public String getImage_src_max() {
		return image_src_max;
	}
	public void setImage_src_max(String image_src_max) {
		this.image_src_max = image_src_max;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getCharm_value() {
		return charm_value;
	}
	public void setCharm_value(Integer charm_value) {
		this.charm_value = charm_value;
	}
	public Integer getP_price() {
		return p_price;
	}
	public void setP_price(Integer p_price) {
		this.p_price = p_price;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	

}

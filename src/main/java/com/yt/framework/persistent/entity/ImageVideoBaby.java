package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *俱乐部图片视频Entity
 *@autor gl
 *@date2015-8-14下午2:03:18
 */
public class ImageVideoBaby implements Serializable {

	private static final long serialVersionUID = 227118202870892475L;

	private String id;
	
	/**
	 * 上传路径
	 */
	private String src; 
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 类型 1：图片 2：视频
	 */
	private Integer type;
	/**
	 * 视频描述
	 */
	private String describle;
	/**
	 * 上传用户id
	 */
	private String user_id;
	
	private String babyinfo_id;
	
	/**
	 * 图片状态 
	 */
	private Integer status;
	
	/**
	 * 视频封面地址
	 */
	private String v_cover;
	
	/**
	 * 是否在首页展示 1:展示 2:不展示
	 * @return
	 */
	private Integer if_show;
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getDescrible() {
		return describle;
	}

	public void setDescrible(String describle) {
		this.describle = describle;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getV_cover() {
		return v_cover;
	}

	public void setV_cover(String v_cover) {
		this.v_cover = v_cover;
	}

	public Integer getIf_show() {
		return if_show;
	}

	public void setIf_show(Integer if_show) {
		this.if_show = if_show;
	}

	public String getBabyinfo_id() {
		return babyinfo_id;
	}

	public void setBabyinfo_id(String babyinfo_id) {
		this.babyinfo_id = babyinfo_id;
	}
	
}

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 球员荣誉
 * 
 * @Title: PlayerHonor.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月3日 下午3:13:57
 */
public class PlayerHonor implements Serializable {

	/**
	* 
	*/
	private static final long serialVersionUID = -4722588370710211117L;
	private String id;// '荣誉ID',
	private String user_id;// '球员信息ID',
	private String name;// '荣誉名称',
	private String describle;// '荣誉描述',
	private String image_src;// '荣誉证书图片',
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

	public String getImage_src() {
		return image_src;
	}

	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	
}

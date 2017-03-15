package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import com.yt.framework.utils.Common;

/**
 * 动态
 * 
 * @Title: Dynamic.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月10日 上午11:58:09
 */
public class Dynamic implements Serializable {
	 private static final long serialVersionUID = -1023365982066299692L;

	private String id;
	private String user_id;
	private String user_name;
	private String user_type;
	private String head_icon;
	private String text; //内容
	private String image;//图片
	private String video;//视频
	private Date create_time;//创建时间
	private String create_time_format;//创建时间
	
	private Integer praise_count;//赞数
	private Integer type;//类型
	private Integer top_count;//置顶总次数
	private Date set_top_time;//设置置顶时间
	private Integer is_top;//是否置顶 0：未置顶 1：置顶

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCreate_time_format() {
		return create_time_format;
	}

	public void setCreate_time_format(String create_time_format) {
		this.create_time_format = create_time_format;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getHead_icon() {
		return head_icon;
	}

	public void setHead_icon(String head_icon) {
		this.head_icon = head_icon;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
		this.create_time_format = Common.formatDate24H(create_time);
	}

	public Integer getPraise_count() {
		return praise_count;
	}

	public void setPraise_count(Integer praise_count) {
		this.praise_count = praise_count;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getTop_count() {
		return top_count;
	}

	public void setTop_count(Integer top_count) {
		this.top_count = top_count;
	}


	public Date getSet_top_time() {
		return set_top_time;
	}

	public void setSet_top_time(Date set_top_time) {
		this.set_top_time = set_top_time;
	}

	public Integer getIs_top() {
		return is_top;
	}

	public void setIs_top(Integer is_top) {
		this.is_top = is_top;
	}

}

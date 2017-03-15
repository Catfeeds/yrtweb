package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 动态
 * 
 * @Title: TeamDynamic.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月10日 上午11:58:09
 */
public class TeamDynamic implements Serializable {
	 private static final long serialVersionUID = -1023365982066299692L;

	private String id;
	private String teaminfo_id; //发布用户id
	private String text; //内容
	private String image;//图片
	private String video;//视频
	private Date create_time;//创建时间
	private Integer praise_count;//赞数
	private Integer type;//类型 1：球迷；2:球员；3:球队；4：经纪人;5:教练
   
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTeaminfo_id() {
		return teaminfo_id;
	}

	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
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

}

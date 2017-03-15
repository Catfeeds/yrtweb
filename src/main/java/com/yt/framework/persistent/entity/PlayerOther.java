package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 球员其他属性
 * 
 * @Title: PlayerOther.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月3日 下午3:16:20
 */
public class PlayerOther implements Serializable {

	private static final long serialVersionUID = -9062511396687709207L;
	private String id;
	private String user_id;// '球员信息ID',
	private String vision;// '球员视力',
	private String level;// '球员颜值',
	private String shoe;// '球员鞋码',
	private Integer fans_count;// '球员粉丝数量',
	private Integer marriage;// '婚姻状况0：未婚 1：已婚',
	private String language;// '语言',
	private String idcard;// '身份证',
	private String national;// '国籍',

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

	public String getVision() {
		return vision;
	}

	public void setVision(String vision) {
		this.vision = vision;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getShoe() {
		return shoe;
	}

	public void setShoe(String shoe) {
		this.shoe = shoe;
	}

	public Integer getFans_count() {
		return fans_count;
	}

	public void setFans_count(Integer fans_count) {
		this.fans_count = fans_count;
	}

	public Integer getMarriage() {
		return marriage;
	}

	public void setMarriage(Integer marriage) {
		this.marriage = marriage;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getNational() {
		return national;
	}

	public void setNational(String national) {
		this.national = national;
	}

}

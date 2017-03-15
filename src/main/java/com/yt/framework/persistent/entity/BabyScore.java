package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 宝贝评分记录
 * @author bo.xie
 * 
 */
public class BabyScore {

	private String id;
	/**
	 * 宝贝用户ID
	 */
	private String user_id;
	/**
	 * 评分用户ID
	 */
	private String p_user_id;
	/**
	 * 评分
	 */
	private double score;
	private Date create_time;
	private String remark;
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
	public String getP_user_id() {
		return p_user_id;
	}
	public void setP_user_id(String p_user_id) {
		this.p_user_id = p_user_id;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}

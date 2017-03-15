package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 球员-职业生涯
 * 
 * @Title: PlayerCareer.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月3日 下午3:12:46
 */
public class PlayerCareer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5278732372410852216L;
	private String id;
	private String user_id;
	private String start_date;//开始年份
	private String end_date;//结束年份
	private String played_team;// '曾效力球队',
	private String play_team;// '现役球队',
	private Integer played_count;// '参赛场数',
	private Integer goal_count;// '进球场数',
	private Integer yellow_card;// '黄牌数',
	private Integer red_card;// '红牌数',
	private Integer assists_count;// '助攻数',
	private String honor_desc;//所获荣誉
	private String injured_area;//受伤部位

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

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getPlayed_team() {
		return played_team;
	}

	public void setPlayed_team(String played_team) {
		this.played_team = played_team;
	}

	public String getPlay_team() {
		return play_team;
	}

	public void setPlay_team(String play_team) {
		this.play_team = play_team;
	}

	public Integer getPlayed_count() {
		return played_count;
	}

	public void setPlayed_count(Integer played_count) {
		this.played_count = played_count;
	}

	public Integer getGoal_count() {
		return goal_count;
	}

	public void setGoal_count(Integer goal_count) {
		this.goal_count = goal_count;
	}

	public Integer getYellow_card() {
		return yellow_card;
	}

	public void setYellow_card(Integer yellow_card) {
		this.yellow_card = yellow_card;
	}

	public Integer getRed_card() {
		return red_card;
	}

	public void setRed_card(Integer red_card) {
		this.red_card = red_card;
	}

	public Integer getAssists_count() {
		return assists_count;
	}

	public void setAssists_count(Integer assists_count) {
		this.assists_count = assists_count;
	}

	public String getHonor_desc() {
		return honor_desc;
	}

	public void setHonor_desc(String honor_desc) {
		this.honor_desc = honor_desc;
	}

	public String getInjured_area() {
		return injured_area;
	}

	public void setInjured_area(String injured_area) {
		this.injured_area = injured_area;
	}
	

}

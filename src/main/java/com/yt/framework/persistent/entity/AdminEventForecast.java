package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 
 * @author lenovo
 * 
 */
public class AdminEventForecast implements Serializable {
	private static final long serialVersionUID = 1528267308498014386L;
	private String id;
	private String league_id;
	private String m_teaminfo_id; //主场俱乐部ID
	private String m_team_name;
	private String g_teaminfo_id; //客队俱乐部ID
	private String g_team_name;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date play_time;
	private Integer ball_format;
	private Integer rounds;
	private String group_id; //分组
	private String position;
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getLeague_id() {
		return league_id;
	}

	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}

	public String getM_teaminfo_id() {
		return m_teaminfo_id;
	}

	public void setM_teaminfo_id(String m_teaminfo_id) {
		this.m_teaminfo_id = m_teaminfo_id;
	}

	public String getM_team_name() {
		return m_team_name;
	}

	public void setM_team_name(String m_team_name) {
		this.m_team_name = m_team_name;
	}

	public String getG_teaminfo_id() {
		return g_teaminfo_id;
	}

	public void setG_teaminfo_id(String g_teaminfo_id) {
		this.g_teaminfo_id = g_teaminfo_id;
	}

	public String getG_team_name() {
		return g_team_name;
	}

	public void setG_team_name(String g_team_name) {
		this.g_team_name = g_team_name;
	}

	public Date getPlay_time() {
		return play_time;
	}

	public void setPlay_time(Date play_time) {
		this.play_time = play_time;
	}

	public Integer getBall_format() {
		return ball_format;
	}

	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}

	public Integer getRounds() {
		return rounds;
	}

	public void setRounds(Integer rounds) {
		this.rounds = rounds;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

}

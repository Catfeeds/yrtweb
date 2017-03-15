package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 联赛赛程记录
 * @author bo.xie
 * @Date 2015年11月10日11:02:33
 */
public class EventRecord {

	private String id;
	private String league_id;//联赛ID
	private String game_id;//历史比赛ID
	private String m_teaminfo_id;//主场俱乐部ID
	private String m_team_name;//主队名称
	private String g_teaminfo_id;//客场俱乐部ID
	private String g_team_name;//客队名称
	private Date play_time;//比赛时间
	private int ball_format;//比赛赛制
	private String position;//比赛地址
	private String group_id;//分组ID 
	private int rounds;//第几轮
	private Integer m_score;//主场队伍得分
	private String win_teaminfo_id;//胜利方俱乐部ID,若为空平局
	private Integer g_score;//客场队伍得分
	private int status; //比赛状态 1：进行中 2：已结束 0：未开始  
	
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public int getBall_format() {
		return ball_format;
	}
	public void setBall_format(int ball_format) {
		this.ball_format = ball_format;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getRounds() {
		return rounds;
	}
	public void setRounds(int rounds) {
		this.rounds = rounds;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public Integer getM_score() {
		return m_score;
	}
	public void setM_score(Integer m_score) {
		this.m_score = m_score;
	}
	public String getWin_teaminfo_id() {
		return win_teaminfo_id;
	}
	public void setWin_teaminfo_id(String win_teaminfo_id) {
		this.win_teaminfo_id = win_teaminfo_id;
	}
	public Integer getG_score() {
		return g_score;
	}
	public void setG_score(Integer g_score) {
		this.g_score = g_score;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getGame_id() {
		return game_id;
	}
	public void setGame_id(String game_id) {
		this.game_id = game_id;
	}
	
	
}

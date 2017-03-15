package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * 联赛射手榜
 * @author gl
 *
 */
public class LeagueScorer implements Serializable {
	private static final long serialVersionUID = -6996455470848904718L;
	private String id;
	private String league_id;//联赛ID
	private String group_id;
	private String user_id;//球员用户ID
	private Integer goal;//单场进球数
	private Integer s_sort;
	private Date create_time;
	private String team_id;//俱乐部ID
	private Integer shemen_num;//射门次数
	private Integer shezheng_num;//射正次数
	private Integer shangchang_num;//上场次数
	
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
	public Integer getS_sort() {
		return s_sort;
	}
	
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public void setS_sort(Integer s_sort) {
		this.s_sort = s_sort;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getGoal() {
		return goal;
	}
	public void setGoal(Integer goal) {
		this.goal = goal;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public Integer getShemen_num() {
		return shemen_num;
	}
	public void setShemen_num(Integer shemen_num) {
		this.shemen_num = shemen_num;
	}
	public Integer getShezheng_num() {
		return shezheng_num;
	}
	public void setShezheng_num(Integer shezheng_num) {
		this.shezheng_num = shezheng_num;
	}
	public Integer getShangchang_num() {
		return shangchang_num;
	}
	public void setShangchang_num(Integer shangchang_num) {
		this.shangchang_num = shangchang_num;
	}
	
}

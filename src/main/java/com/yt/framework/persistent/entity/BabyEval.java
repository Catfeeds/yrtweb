package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 宝贝助威评价
 * 
 * @Title: BabyEval.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年9月24日 下午3:12:46
 */
public class BabyEval implements Serializable {
	
	private static final long serialVersionUID = 1468613428420089951L;
	private String id;
	private String teamgame_id; // 比赛ID
	private String teaminfo_id;  //俱乐部ID
	private String content; //评价内容
	private String team_name; //俱乐部名称
	private String user_id; //评价用户id
	private String p_user_id ; //宝贝用户id 
	private Date create_time; //评价时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getTeamgame_id() {
		return teamgame_id;
	}
	public void setTeamgame_id(String teamgame_id) {
		this.teamgame_id = teamgame_id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getP_user_id() {
		return p_user_id;
	}
	public void setP_user_id(String p_user_id) {
		this.p_user_id = p_user_id;
	}
	
}

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 联赛俱乐部关系表
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class TeamLeague implements Serializable{

	private static final long serialVersionUID = 6112464918608459521L;
	private String id;
	private String league_id; //联赛id
	private String teaminfo_id; // 俱乐部id
	private int status; //是否激活 1：已激活 2：未激活 
	private Date create_time; //创建时间
	private String s_id;//赛季标志id
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
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	
}

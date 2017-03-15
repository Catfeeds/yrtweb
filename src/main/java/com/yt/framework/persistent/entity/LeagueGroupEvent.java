package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 联赛分组
 * @author gl
 *
 */
public class LeagueGroupEvent implements Serializable {
	private static final long serialVersionUID = 3164841999378811768L;
	private String id;
	private String teaminfo_id;//俱乐部id
	private String group_id;//分组id
	
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
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	
}

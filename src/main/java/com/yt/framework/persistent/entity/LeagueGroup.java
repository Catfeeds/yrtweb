package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 联赛分组
 * @author gl
 *
 */
public class LeagueGroup implements Serializable {
	private static final long serialVersionUID = 2863649211246002507L;
	private String id;
	private String league_id;//联赛ID
	private String name;//小组名称
	private int sort;//排序
	private Date create_time;//创建时间
	
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *俱乐部公告
 *@autor ylt
 *@date2015-8-3下午2:47:25
 */
public class TeamNotice implements Serializable{
	
	private static final long serialVersionUID = 5576612402797563943L;
	private String id;
	private String teaminfo_id;
	/**
	 * 标题
	 */
	private String name;
	/**
	 * 公告描述
	 */
	private String describle;
	/**
	 * 点击量
	 */
	private int check_count;
	
	private Date create_time; 
	/**
	 * 平局场数
	 */
	private int sort;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public int getCheck_count() {
		return check_count;
	}
	public void setCheck_count(int check_count) {
		this.check_count = check_count;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	
}	

package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 俱乐部租借成员
 * @autor ylt
 * @date2016-6-4 下午5:06:46
 */
public class TeamLoanPlayer implements Serializable{

	private static final long serialVersionUID = 6172014759753250993L;
	
	private String id;
	private String teaminfo_id;//原球队ID
	private String new_teaminfo_id;//当前球队ID
	private String user_id;//球员用户ID
	private Date create_time;
	private String player_num; //球衣号码
	private String position; //场上位置 
	private BigDecimal salary;//当前薪资
	private Date end_time;//到期时间
		
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
	
	public String getPlayer_num() {
		return player_num;
	}
	public void setPlayer_num(String player_num) {
		this.player_num = player_num;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public BigDecimal getSalary() {
		return salary;
	}
	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public String getNew_teaminfo_id() {
		return new_teaminfo_id;
	}
	public void setNew_teaminfo_id(String new_teaminfo_id) {
		this.new_teaminfo_id = new_teaminfo_id;
	}
	
}

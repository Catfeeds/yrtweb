package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 工资表工资发送表
 * @author bo.xie
 */
public class SalaryRecord {

	private String id;
	private String srmsg_id;//发送信息记录表ID
	private String league_id;
	private String turn_num;
	private String teaminfo_id;
	private String user_id;//球员用户ID
	private BigDecimal bonus;//奖金
	private BigDecimal salary;//生成工资标准
	private BigDecimal real_salary;//实际发送工资
	private String event_id;//赛程ID
	
	public String getEvent_id() {
		return event_id;
	}
	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
	public String getSrmsg_id() {
		return srmsg_id;
	}
	public void setSrmsg_id(String srmsg_id) {
		this.srmsg_id = srmsg_id;
	}
	public BigDecimal getBonus() {
		return bonus;
	}
	public void setBonus(BigDecimal bonus) {
		this.bonus = bonus;
	}
	public BigDecimal getReal_salary() {
		return real_salary;
	}
	public void setReal_salary(BigDecimal real_salary) {
		this.real_salary = real_salary;
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
	public String getTurn_num() {
		return turn_num;
	}
	public void setTurn_num(String turn_num) {
		this.turn_num = turn_num;
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
	public BigDecimal getSalary() {
		return salary;
	}
	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}
}

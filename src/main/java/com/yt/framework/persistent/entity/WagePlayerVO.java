package com.yt.framework.persistent.entity;

import java.math.BigDecimal;

/**
 * 
 * @author YJH
 *
 */
public class WagePlayerVO {
	private String id;// ID
	private String player_id;// 球员ID
	private String uniform_number;// 球衣号码
	private String player_name;// 球员姓名
	private String playing_time;// 上场时间
	private String goal_number = "0";// 进球数
	private BigDecimal wages_should;// 应发工资
	private BigDecimal bonus_amount;// 奖金数额
	private Integer total_distribution;// 发放总额

	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPlayer_id() {
		return player_id;
	}

	public void setPlayer_id(String player_id) {
		this.player_id = player_id;
	}

	public String getUniform_number() {
		return uniform_number;
	}

	public void setUniform_number(String uniform_number) {
		this.uniform_number = uniform_number;
	}

	public String getPlayer_name() {
		return player_name;
	}

	public void setPlayer_name(String player_name) {
		this.player_name = player_name;
	}

	public String getPlaying_time() {
		return playing_time;
	}

	public void setPlaying_time(String playing_time) {
		this.playing_time = playing_time;
	}

	public String getGoal_number() {
		return goal_number;
	}

	public void setGoal_number(String goal_number) {
		this.goal_number = goal_number;
	}

	public BigDecimal getWages_should() {
		return wages_should;
	}

	public void setWages_should(BigDecimal wages_should) {
		this.wages_should = wages_should;
	}

	public BigDecimal getBonus_amount() {
		return bonus_amount;
	}

	public void setBonus_amount(BigDecimal bonus_amount) {
		this.bonus_amount = bonus_amount;
	}

	public Integer getTotal_distribution() {
		return total_distribution;
	}

	public void setTotal_distribution(Integer total_distribution) {
		this.total_distribution = total_distribution;
	}

}

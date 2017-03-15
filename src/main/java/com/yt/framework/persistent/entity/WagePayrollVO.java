package com.yt.framework.persistent.entity;
/**
 * 
 * @author YJH
 *
 */
public class WagePayrollVO {
	private String salary_msg_id;
	private String dynamic_id;
	private String player_count;
	private String league_match;//联赛
	private String division;//赛区
	private String season;//季赛
	private String round;//轮次
	private String home_team_name;//主队名称
	private String home_team_src;//主队图片
	private String home_team_score;//主队进球数
	private String home_team_id;//主队id
	private String visiting_team_id;
	private String visiting_team_name;
	private String visiting_team_src;
	private String visiting_team_score;
	private String wage_base_sum;//基本工资总和
	private String wage_bonus_sum;//奖励总和
	
	
	public String getSalary_msg_id() {
		return salary_msg_id;
	}
	public void setSalary_msg_id(String salary_msg_id) {
		this.salary_msg_id = salary_msg_id;
	}
	public String getWage_bonus_sum() {
		return wage_bonus_sum;
	}
	public void setWage_bonus_sum(String wage_bonus_sum) {
		this.wage_bonus_sum = wage_bonus_sum;
	}
	public String getWage_base_sum() {
		return wage_base_sum;
	}
	public void setWage_base_sum(String wage_base_sum) {
		this.wage_base_sum = wage_base_sum;
	}
	public String getPlayer_count() {
		return player_count;
	}
	public void setPlayer_count(String player_count) {
		this.player_count = player_count;
	}
	public String getDynamic_id() {
		return dynamic_id;
	}
	public void setDynamic_id(String dynamic_id) {
		this.dynamic_id = dynamic_id;
	}
	public String getLeague_match() {
		return league_match;
	}
	public void setLeague_match(String league_match) {
		this.league_match = league_match;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public String getRound() {
		return round;
	}
	public void setRound(String round) {
		this.round = round;
	}
	public String getHome_team_name() {
		return home_team_name;
	}
	public void setHome_team_name(String home_team_name) {
		this.home_team_name = home_team_name;
	}
	public String getHome_team_src() {
		return home_team_src;
	}
	public void setHome_team_src(String home_team_src) {
		this.home_team_src = home_team_src;
	}
	public String getHome_team_score() {
		return home_team_score;
	}
	public void setHome_team_score(String home_team_score) {
		this.home_team_score = home_team_score;
	}
	public String getHome_team_id() {
		return home_team_id;
	}
	public void setHome_team_id(String home_team_id) {
		this.home_team_id = home_team_id;
	}
	public String getVisiting_team_id() {
		return visiting_team_id;
	}
	public void setVisiting_team_id(String visiting_team_id) {
		this.visiting_team_id = visiting_team_id;
	}
	public String getVisiting_team_name() {
		return visiting_team_name;
	}
	public void setVisiting_team_name(String visiting_team_name) {
		this.visiting_team_name = visiting_team_name;
	}
	public String getVisiting_team_src() {
		return visiting_team_src;
	}
	public void setVisiting_team_src(String visiting_team_src) {
		this.visiting_team_src = visiting_team_src;
	}
	public String getVisiting_team_score() {
		return visiting_team_score;
	}
	public void setVisiting_team_score(String visiting_team_score) {
		this.visiting_team_score = visiting_team_score;
	}
	 
	
}

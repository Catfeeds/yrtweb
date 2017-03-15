package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 联赛俱乐部积分
 * @author gl
 *
 */
public class TeamIntegral implements Serializable {

	private static final long serialVersionUID = -3284277131140661901L;
	private String id;
	private String league_id;//联赛ID
	private String group_id;//分组ID
	private String teaminfo_id;//俱乐部ID
	private Integer games;//比赛场次总数
	private Integer win_games;//赢取场次
	private Integer lose_games;//输场次
	private Integer sum_integral;//总积分
	private Integer flat_games;//平场次
	private Integer lose_ball;//失球数
	private Integer in_ball;//进球数
	private int ranking;//排名
	
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	public Integer getLose_ball() {
		return lose_ball;
	}
	public void setLose_ball(Integer lose_ball) {
		this.lose_ball = lose_ball;
	}
	public Integer getIn_ball() {
		return in_ball;
	}
	public void setIn_ball(Integer in_ball) {
		this.in_ball = in_ball;
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
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public Integer getGames() {
		return games;
	}
	public void setGames(Integer games) {
		this.games = games;
	}
	public Integer getWin_games() {
		return win_games;
	}
	public void setWin_games(Integer win_games) {
		this.win_games = win_games;
	}
	public Integer getLose_games() {
		return lose_games;
	}
	public void setLose_games(Integer lose_games) {
		this.lose_games = lose_games;
	}
	public Integer getSum_integral() {
		return sum_integral;
	}
	public void setSum_integral(Integer sum_integral) {
		this.sum_integral = sum_integral;
	}
	public Integer getFlat_games() {
		return flat_games;
	}
	public void setFlat_games(Integer flat_games) {
		this.flat_games = flat_games;
	}
	
}

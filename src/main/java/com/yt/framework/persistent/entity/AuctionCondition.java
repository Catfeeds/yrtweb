package com.yt.framework.persistent.entity;

import java.io.Serializable;
/**
 * 球员竞拍市场表查询条件
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class AuctionCondition implements Serializable{
	private static final long serialVersionUID = 1605304375143825187L;
	private String id;//
	private String user_id ;
	private String age_sort;//年龄排序
	private String bid_sort;//得拍价排序
	private String score_sort;//能力排序
	private String user_name;//姓名
	private String position; //位置
	private Integer level; //类别
	private String league_id ;//联赛id
	private String turn_num; //竞拍轮数 
	private String teaminfo_id;//俱乐部ID
	private String s_id;//联赛分类id
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAge_sort() {
		return age_sort;
	}
	public void setAge_sort(String age_sort) {
		this.age_sort = age_sort;
	}
	public String getBid_sort() {
		return bid_sort;
	}
	public void setBid_sort(String bid_sort) {
		this.bid_sort = bid_sort;
	}
	public String getScore_sort() {
		return score_sort;
	}
	public void setScore_sort(String score_sort) {
		this.score_sort = score_sort;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
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
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	
}

package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 
 * <p>
 * 接口赛事进球数据统计对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2015年12月24日 下午5:10:15
 * @version
 */
public class QScoreInfo implements Serializable{

	private static final long serialVersionUID = 1L;
    private String id;
    private String q_match_id;//接口赛事id
    private String team_id;//接口球队id
    private String teaminfo_id;//关联球队id
    private String q_user_id;//接口球员id
    private String user_id;//用户id
    private String jinqiu_time;//进球时间
    private String number;//球员号码
    private String is_wulong;//是否乌龙球
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQ_match_id() {
		return q_match_id;
	}
	public void setQ_match_id(String q_match_id) {
		this.q_match_id = q_match_id;
	}
	public String getQ_user_id() {
		return q_user_id;
	}
	public void setQ_user_id(String q_user_id) {
		this.q_user_id = q_user_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getJinqiu_time() {
		return jinqiu_time;
	}
	public void setJinqiu_time(String jinqiu_time) {
		this.jinqiu_time = jinqiu_time;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getIs_wulong() {
		return is_wulong;
	}
	public void setIs_wulong(String is_wulong) {
		this.is_wulong = is_wulong;
	}
	
}

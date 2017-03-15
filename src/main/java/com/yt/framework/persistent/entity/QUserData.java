package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class QUserData implements Serializable{

	/**
	 * 接口球员比赛数据
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String player_id;//接口球员id
	private String q_match_id;//接口赛事id
	private String team_id;//接口球队id
	private String teaminfo_id;//关联球队id
	private String rel_palyer_id;//关联赛事id
	private String name;//接口球队姓名
	private String number;//接口球员号码
	private String durtime;//参赛时长
	private String position;
	private String shemen_num;//射门数
	private String shezheng_num;//射正数
	private String shepian_num;//射偏数
	private String jinqiu_num;//进球数
	private String zhugong_num;//助攻数
	private String pujiu_num;//扑救球
	private String lanjie_num;//拦截数
	private String qiangduan_num;//抢断球数
	private String jiewei_num;//解围数
	private String fangui_num;//犯规数
	private String hongpai_num;//红牌数
	private String huangpai_num;//黄牌数
	private String shuanghuang_num;//双黄牌数
	private Integer team_status;//是否主队 1,主队 2,客队
	private String wulong_num;//乌龙球
	
	
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
	
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getRel_palyer_id() {
		return rel_palyer_id;
	}
	public void setRel_palyer_id(String rel_palyer_id) {
		this.rel_palyer_id = rel_palyer_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDurtime() {
		return durtime;
	}
	public void setDurtime(String durtime) {
		this.durtime = durtime;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Integer getTeam_status() {
		return team_status;
	}
	public void setTeam_status(Integer team_status) {
		this.team_status = team_status;
	}
	public String getPlayer_id() {
		return player_id;
	}
	public void setPlayer_id(String player_id) {
		this.player_id = player_id;
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
	public String getShemen_num() {
		return shemen_num;
	}
	public void setShemen_num(String shemen_num) {
		this.shemen_num = shemen_num;
	}
	public String getShezheng_num() {
		return shezheng_num;
	}
	public void setShezheng_num(String shezheng_num) {
		this.shezheng_num = shezheng_num;
	}
	public String getShepian_num() {
		return shepian_num;
	}
	public void setShepian_num(String shepian_num) {
		this.shepian_num = shepian_num;
	}
	public String getJinqiu_num() {
		return jinqiu_num;
	}
	public void setJinqiu_num(String jinqiu_num) {
		this.jinqiu_num = jinqiu_num;
	}
	public String getZhugong_num() {
		return zhugong_num;
	}
	public void setZhugong_num(String zhugong_num) {
		this.zhugong_num = zhugong_num;
	}
	public String getPujiu_num() {
		return pujiu_num;
	}
	public void setPujiu_num(String pujiu_num) {
		this.pujiu_num = pujiu_num;
	}
	public String getLanjie_num() {
		return lanjie_num;
	}
	public void setLanjie_num(String lanjie_num) {
		this.lanjie_num = lanjie_num;
	}
	public String getQiangduan_num() {
		return qiangduan_num;
	}
	public void setQiangduan_num(String qiangduan_num) {
		this.qiangduan_num = qiangduan_num;
	}
	public String getJiewei_num() {
		return jiewei_num;
	}
	public void setJiewei_num(String jiewei_num) {
		this.jiewei_num = jiewei_num;
	}
	public String getFangui_num() {
		return fangui_num;
	}
	public void setFangui_num(String fangui_num) {
		this.fangui_num = fangui_num;
	}
	public String getHongpai_num() {
		return hongpai_num;
	}
	public void setHongpai_num(String hongpai_num) {
		this.hongpai_num = hongpai_num;
	}
	public String getHuangpai_num() {
		return huangpai_num;
	}
	public void setHuangpai_num(String huangpai_num) {
		this.huangpai_num = huangpai_num;
	}
	public String getWulong_num() {
		return wulong_num;
	}
	public void setWulong_num(String wulong_num) {
		this.wulong_num = wulong_num;
	}
	public String getShuanghuang_num() {
		return shuanghuang_num;
	}
	public void setShuanghuang_num(String shuanghuang_num) {
		this.shuanghuang_num = shuanghuang_num;
	}
	
}

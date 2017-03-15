package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 联赛个人数据统计
 * @author gl
 *
 */
public class LeagueStatistics implements Serializable{
	private static final long serialVersionUID = 704771158100393366L;
	private String id;
	private String user_id;//用户ID
	private String teaminfo_id;//关联球队id
	private String league_id;
	private Integer shemen_num;//射门数
	private Integer shezheng_num;//射正数
	private Integer shepian_num;//射偏数
	private Integer jinqiu_num;//进球数
	private Integer zhugong_num;//助攻数
	private Integer pujiu_num;//扑救球
	private Integer lanjie_num;//拦截数
	private Integer qiangduan_num;//抢断球数
	private Integer jiewei_num;//解围数
	private Integer fangui_num;//犯规数
	private Integer hongpai_num;//红牌数
	private Integer huangpai_num;//黄牌数
	private Integer shuanghuang_num;//双黄牌数
	private Integer wulong_num;//乌龙球
	private Integer zg_sort;//助攻排序
	private Integer hop_sort;//红牌排序
	private Integer hup_sort;//黄牌排序
	private Integer shup_sort;//双黄牌排序
	private Date create_time;//更新时间
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
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public Integer getShemen_num() {
		return shemen_num;
	}
	public void setShemen_num(Integer shemen_num) {
		this.shemen_num = shemen_num;
	}
	public Integer getShezheng_num() {
		return shezheng_num;
	}
	public void setShezheng_num(Integer shezheng_num) {
		this.shezheng_num = shezheng_num;
	}
	public Integer getShepian_num() {
		return shepian_num;
	}
	public void setShepian_num(Integer shepian_num) {
		this.shepian_num = shepian_num;
	}
	public Integer getJinqiu_num() {
		return jinqiu_num;
	}
	public void setJinqiu_num(Integer jinqiu_num) {
		this.jinqiu_num = jinqiu_num;
	}
	public Integer getZhugong_num() {
		return zhugong_num;
	}
	public void setZhugong_num(Integer zhugong_num) {
		this.zhugong_num = zhugong_num;
	}
	public Integer getPujiu_num() {
		return pujiu_num;
	}
	public void setPujiu_num(Integer pujiu_num) {
		this.pujiu_num = pujiu_num;
	}
	public Integer getLanjie_num() {
		return lanjie_num;
	}
	public void setLanjie_num(Integer lanjie_num) {
		this.lanjie_num = lanjie_num;
	}
	public Integer getQiangduan_num() {
		return qiangduan_num;
	}
	public void setQiangduan_num(Integer qiangduan_num) {
		this.qiangduan_num = qiangduan_num;
	}
	public Integer getJiewei_num() {
		return jiewei_num;
	}
	public void setJiewei_num(Integer jiewei_num) {
		this.jiewei_num = jiewei_num;
	}
	public Integer getFangui_num() {
		return fangui_num;
	}
	public void setFangui_num(Integer fangui_num) {
		this.fangui_num = fangui_num;
	}
	public Integer getHongpai_num() {
		return hongpai_num;
	}
	public void setHongpai_num(Integer hongpai_num) {
		this.hongpai_num = hongpai_num;
	}
	public Integer getHuangpai_num() {
		return huangpai_num;
	}
	public void setHuangpai_num(Integer huangpai_num) {
		this.huangpai_num = huangpai_num;
	}
	public Integer getShuanghuang_num() {
		return shuanghuang_num;
	}
	public void setShuanghuang_num(Integer shuanghuang_num) {
		this.shuanghuang_num = shuanghuang_num;
	}
	public Integer getWulong_num() {
		return wulong_num;
	}
	public void setWulong_num(Integer wulong_num) {
		this.wulong_num = wulong_num;
	}
	public Integer getZg_sort() {
		return zg_sort;
	}
	public void setZg_sort(Integer zg_sort) {
		this.zg_sort = zg_sort;
	}
	public Integer getHop_sort() {
		return hop_sort;
	}
	public void setHop_sort(Integer hop_sort) {
		this.hop_sort = hop_sort;
	}
	public Integer getHup_sort() {
		return hup_sort;
	}
	public void setHup_sort(Integer hup_sort) {
		this.hup_sort = hup_sort;
	}
	public Integer getShup_sort() {
		return shup_sort;
	}
	public void setShup_sort(Integer shup_sort) {
		this.shup_sort = shup_sort;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

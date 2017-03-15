package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *俱乐部基本信息
 *@autor bo.xie
 *@date2015-8-3下午2:47:25
 */
public class TeamInfo implements Serializable{
	
	private static final long serialVersionUID = 7053555028078322711L;

	private String id;
	private String user_id;
	/**
	 * 球队名称
	 */
	private String name;
	/**
	 * 简称
	 */
	private String sim_name;
	/**
	 * 是否开启对战邀请 0：不开启 1：开启
	 */
	private Integer is_pk;
	/**
	 * 球队logo
	 */
	private String logo;
	
	private Date create_time; 
	/**
	 * 平局场数
	 */
	private Integer draw_count;
	/**
	 * 胜利场数
	 */
	private Integer win_count;
	/**
	 * 战败场数数
	 */
	private Integer loss_count;
	/**
	 * 常踢球时间 1:周末 2：非周末
	 */
	private Integer play_time;
	/**
	 * 球队是否存在0：解散 1：存在
	 */
	private Integer is_exist;
	/**
	 * 球队赛制
	 */
	private Integer ball_format;
	/**
	 * 是否允许所有人加入0：不允许1：允许
	 */
	private Integer allow;
	/**
	 * 常踢球地点
	 */
	private String play_position;
	
	/**
	 * 积分
	 */
	private Integer score;
	
	/**
	 * 进球总数
	 */
	private Integer sumballs;
	
	/**
	 * 省份
	 */
	private String province;
	
	/**
	 * 城市
	 */
	private String city;
	
	/**
	 * 上传视频个数（默认0个）
	 */
	private Integer video_count;
	/**
	 * 上传图片张数(默认0张)
	 */
	private Integer image_count;
	
	/**
	 * 俱乐部能力值
	 */
	private int abilityValue;
	
	/**
	 * 剩余天数
	 */
	private int re_days;
	
	/**
	 * 宝贝代言俱乐部表ID
	 */
	private String baby_team_id;
	
	/**
	 * 代言状态
	 */
	private Integer bt_status;
	
	private String remark;// 简介
	private String remark_images;//简介图片
	
	private String notice;//公告
	
	private int combat;//战斗力
	
	private Integer p_status;//是否允许带人进入下届联赛0否1是
	
	
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public Integer getBt_status() {
		return bt_status;
	}

	public void setBt_status(Integer bt_status) {
		this.bt_status = bt_status;
	}

	public String getBaby_team_id() {
		return baby_team_id;
	}

	public void setBaby_team_id(String baby_team_id) {
		this.baby_team_id = baby_team_id;
	}

	public int getRe_days() {
		return re_days;
	}

	public void setRe_days(int re_days) {
		this.re_days = re_days;
	}

	public int getAbilityValue() {
		return abilityValue;
	}

	public void setAbilityValue(int abilityValue) {
		this.abilityValue = abilityValue;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getIs_pk() {
		return is_pk;
	}

	public void setIs_pk(Integer is_pk) {
		this.is_pk = is_pk;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getDraw_count() {
		return draw_count;
	}

	public void setDraw_count(Integer draw_count) {
		this.draw_count = draw_count;
	}

	public Integer getWin_count() {
		return win_count;
	}

	public void setWin_count(Integer win_count) {
		this.win_count = win_count;
	}

	public Integer getLoss_count() {
		return loss_count;
	}

	public void setLoss_count(Integer loss_count) {
		this.loss_count = loss_count;
	}

	public Integer getPlay_time() {
		return play_time;
	}

	public void setPlay_time(Integer play_time) {
		this.play_time = play_time;
	}

	public Integer getIs_exist() {
		return is_exist;
	}

	public void setIs_exist(Integer is_exist) {
		this.is_exist = is_exist;
	}

	public Integer getBall_format() {
		return ball_format;
	}

	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}

	public Integer getAllow() {
		return allow;
	}

	public void setAllow(Integer allow) {
		this.allow = allow;
	}

	public String getPlay_position() {
		return play_position;
	}

	public void setPlay_position(String play_position) {
		this.play_position = play_position;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getSumballs() {
		return sumballs;
	}

	public void setSumballs(Integer sumballs) {
		this.sumballs = sumballs;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Integer getVideo_count() {
		return video_count;
	}

	public void setVideo_count(Integer video_count) {
		this.video_count = video_count;
	}

	public Integer getImage_count() {
		return image_count;
	}

	public void setImage_count(Integer image_count) {
		this.image_count = image_count;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public int getCombat() {
		return combat;
	}

	public void setCombat(int combat) {
		this.combat = combat;
	}

	public String getRemark_images() {
		return remark_images;
	}

	public void setRemark_images(String remark_images) {
		this.remark_images = remark_images;
	}

	public String getSim_name() {
		return sim_name;
	}

	public void setSim_name(String sim_name) {
		this.sim_name = sim_name;
	}

	public Integer getP_status() {
		return p_status;
	}

	public void setP_status(Integer p_status) {
		this.p_status = p_status;
	}
	
}

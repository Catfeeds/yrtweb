package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 *俱乐部对战信息
 *@autor ylt
 *@date2015-8-13 下午2:47:25
 */
public class TeamInvite implements Serializable{
	
	private static final long serialVersionUID = 6462707187116480478L;
	private String id;
	private String teaminfo_id; //发起邀请球队表ID
	private String t_name; //发起邀请球队名称
	private String t_logo;
	private String respond_teaminfo_id; //被邀请球队ID
	private String r_name; //被邀请球队名称
	private String r_logo;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date invite_time; //邀请比赛时间
	private String position; //约战地址
	private Date create_time; //创建时间
	private int status;  //约战状态0：失败 1：成功 2:约战中
	private int ball_format;  //约战球赛赛制 5：5人制,7：7人制,11:11人制)、
	private String declar;//挑战宣言
	
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
	public String getRespond_teaminfo_id() {
		return respond_teaminfo_id;
	}
	public void setRespond_teaminfo_id(String respond_teaminfo_id) {
		this.respond_teaminfo_id = respond_teaminfo_id;
	}
	public Date getInvite_time() {
		return invite_time;
	}
	public void setInvite_time(Date invite_time) {
		this.invite_time = invite_time;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getBall_format() {
		return ball_format;
	}
	public void setBall_format(int ball_format) {
		this.ball_format = ball_format;
	}
	public String getDeclar() {
		return declar;
	}
	public void setDeclar(String declar) {
		this.declar = declar;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getT_logo() {
		return t_logo;
	}
	public void setT_logo(String t_logo) {
		this.t_logo = t_logo;
	}
	public String getR_logo() {
		return r_logo;
	}
	public void setR_logo(String r_logo) {
		this.r_logo = r_logo;
	}
	
	
}

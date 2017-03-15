package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 *俱乐部对战信息
 *@autor ylt
 *@date2015-8-14 下午3:47:25
 */
public class TeamGame implements Serializable{
	
	private static final long serialVersionUID = 3400481509700074858L;
	private String id;
	private String initiate_teaminfo_id; //发起球队
	private String t_name; //发起球队名称
	private String t_logo; //发起球队logo
	private String respond_teaminfo_id; //响应球队
	private String r_name; //响应球队名称
	private String r_logo;//响应球队logo
	private Integer initiate_score; //发起球队得分
	private Integer respond_score;//响应球队得分
	private String position; //约战地址
	private Integer initiate_win; //发起球队是否胜利 0：未胜利 1：胜利
	private Date create_time;  //创建时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date game_time;//比赛时间
	private Integer ball_format;  //约战球赛赛制 5：5人制,7：7人制,11:11人制)
	private Integer initiate_sure; //邀请方确认  0:未确认 1:已确认
	private Integer respond_sure; //受邀方确认 0:未确认 1:已确认
	private Integer status;//状态 0：比赛预告 1；比赛结果;2:比赛作废;3：比分确认中；4：联赛比赛
	private Integer rownum;//序列号
	
	public Integer getRownum() {
		return rownum;
	}
	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getInitiate_teaminfo_id() {
		return initiate_teaminfo_id;
	}
	public void setInitiate_teaminfo_id(String initiate_teaminfo_id) {
		this.initiate_teaminfo_id = initiate_teaminfo_id;
	}
	public String getRespond_teaminfo_id() {
		return respond_teaminfo_id;
	}
	public void setRespond_teaminfo_id(String respond_teaminfo_id) {
		this.respond_teaminfo_id = respond_teaminfo_id;
	}
	public Integer getInitiate_score() {
		return initiate_score;
	}
	public void setInitiate_score(Integer initiate_score) {
		this.initiate_score = initiate_score;
	}
	public Integer getRespond_score() {
		return respond_score;
	}
	public void setRespond_score(Integer respond_score) {
		this.respond_score = respond_score;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Integer getInitiate_win() {
		return initiate_win;
	}
	public void setInitiate_win(Integer initiate_win) {
		this.initiate_win = initiate_win;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getGame_time() {
		return game_time;
	}
	public void setGame_time(Date game_time) {
		this.game_time = game_time;
	}
	public Integer getBall_format() {
		return ball_format;
	}
	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}
	public Integer getInitiate_sure() {
		return initiate_sure;
	}
	public void setInitiate_sure(Integer initiate_sure) {
		this.initiate_sure = initiate_sure;
	}
	public Integer getRespond_sure() {
		return respond_sure;
	}
	public void setRespond_sure(Integer respond_sure) {
		this.respond_sure = respond_sure;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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

package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 发送信息发送记录
 * @author bo.xie
 * @Date 2016年2月29日16:24:30
 */
public class SalaryMsg {

	private String id ;
	private String teaminfo_id;//俱乐部ID
	private String league_id;//联赛ID
	private String event_id;//赛程ID
	private String turn_num;//轮次
	private int status;//是否已处理 1：处理 0：未处理
	private int is_send;//是否发送 0：未发送 1：已发送
	private Date send_time;//俱乐部工资发放时间
	private Date create_time;
	
	public Date getSend_time() {
		return send_time;
	}
	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}
	public int getIs_send() {
		return is_send;
	}
	public void setIs_send(int is_send) {
		this.is_send = is_send;
	}
	public String getEvent_id() {
		return event_id;
	}
	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}

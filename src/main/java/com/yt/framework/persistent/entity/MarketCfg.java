package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 球员跳蚤市场表配置表
 * @author bo.xie
 * @date 2015年11月20日17:16:38
 */
public class MarketCfg implements Serializable {

	private static  final long serialVersionUID = 839599643829554015L;
	private String id;
	private String league_id;//联赛ID
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date create_time;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date start_time; //开放时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date end_time;//结束时间
	private Integer if_open;//是否开放 0:否 1：是
	private String s_id;//赛季ID
	private float team_percent;//俱乐部分成百分比
	private float user_percent;//球员分成百分比
	private BigDecimal per_price;//每次加价配置
	/**
	 * 转会轮数 1、2、3 。。
	 */
	private Integer turn_num; 
	
	/**
	 * 下一轮转会轮数 1、2、3 。。
	 */
	private Integer next_num; 
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
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public Integer getIf_open() {
		return if_open;
	}
	public void setIf_open(Integer if_open) {
		this.if_open = if_open;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public float getTeam_percent() {
		return team_percent;
	}
	public void setTeam_percent(float team_percent) {
		this.team_percent = team_percent;
	}
	public float getUser_percent() {
		return user_percent;
	}
	public void setUser_percent(float user_percent) {
		this.user_percent = user_percent;
	}
	public BigDecimal getPer_price() {
		return per_price;
	}
	public void setPer_price(BigDecimal per_price) {
		this.per_price = per_price;
	}
	public Integer getTurn_num() {
		return turn_num;
	}
	public void setTurn_num(Integer turn_num) {
		this.turn_num = turn_num;
	}
	public Integer getNext_num() {
		return next_num;
	}
	public void setNext_num(Integer next_num) {
		this.next_num = next_num;
	}
	
	
}

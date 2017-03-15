package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 球员跳蚤市场表
 * @author bo.xie
 * @date 2015年11月20日17:16:38
 */
public class LeagueMarket {

	private String id;
	private String user_id;//球员用户id
	private int status;//是否成交 0：否 1：是
	private String buyer;//购买者
	private Date end_time;
	private BigDecimal price;//竞拍价
	private int if_up;//是否上架  0：下架 1：上架
	private int if_sold;//是否流拍 0：否 1：是
	private Date buy_time;//成交日期
	private String team_id;//出售俱乐部ID
	private Date create_time;
	private String s_id;//赛季id
	private String league_id ;//联赛id
	private int version;//乐观锁版本号
	private int turn_num; //转会轮数 
	private String r_id;//成交纪录表id
	private int if_one;//是否一口价
	
	public int getIf_sold() {
		return if_sold;
	}
	public void setIf_sold(int if_sold) {
		this.if_sold = if_sold;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public int getTurn_num() {
		return turn_num;
	}
	public void setTurn_num(int turn_num) {
		this.turn_num = turn_num;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getIf_up() {
		return if_up;
	}
	public void setIf_up(int if_up) {
		this.if_up = if_up;
	}
	public Date getBuy_time() {
		return buy_time;
	}
	public void setBuy_time(Date buy_time) {
		this.buy_time = buy_time;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public int getIf_one() {
		return if_one;
	}
	public void setIf_one(int if_one) {
		this.if_one = if_one;
	}
	
}

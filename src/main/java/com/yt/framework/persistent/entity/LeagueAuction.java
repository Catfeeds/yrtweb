package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 球员竞拍市场表
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class LeagueAuction implements Serializable{
	private static final long serialVersionUID = 1758953515444437514L;
	private String id;//
	private String user_id ;//	球员用户id
	private int status;//是否选中 0：否 1：是
	private String bidder ;//得拍者
	private Date end_time;//到期时间
	private BigDecimal bid_price;//得拍价
	private String r_id;//成交纪录表id
	private int if_sold;//是否流拍 0：否 1：是
	private BigDecimal init_price;//初始竞拍价
	private int if_up;//是否上架 0：下架 1：上架
	private String league_id ;//联赛id
	private String s_id;//赛季分类id
	private int turn_num; //竞拍轮数 
	private int version;//乐观锁版本号
	
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
	public String getBidder() {
		return bidder;
	}
	public void setBidder(String bidder) {
		this.bidder = bidder;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public BigDecimal getBid_price() {
		return bid_price;
	}
	public void setBid_price(BigDecimal bid_price) {
		this.bid_price = bid_price;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public int getIf_sold() {
		return if_sold;
	}
	public void setIf_sold(int if_sold) {
		this.if_sold = if_sold;
	}
	public BigDecimal getInit_price() {
		return init_price;
	}
	public void setInit_price(BigDecimal init_price) {
		this.init_price = init_price;
	}
	public int getIf_up() {
		return if_up;
	}
	public void setIf_up(int if_up) {
		this.if_up = if_up;
	}
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
	public int getTurn_num() {
		return turn_num;
	}
	public void setTurn_num(int turn_num) {
		this.turn_num = turn_num;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	
	
}
